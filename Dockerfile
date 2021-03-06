FROM ubuntu:trusty

MAINTAINER Benjamin Ward "ward.programm3r@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# Install PPA support
RUN apt-get update > /dev/null 2>&1 \
	&& apt-get install -yq software-properties-common > /dev/null 2>&1

# Installl tools for build script
RUN apt-get install -yq git cmake wget > /dev/null 2>&1

# Add PPA repository for FRC Toolchain
RUN apt-add-repository ppa:wpilib/toolchain > /dev/null 2>&1

# Update APT repositories
RUN apt-get update > /dev/null 2>&1

# Install WPILib/FRC Toolchain
RUN apt-get install -yq frc-toolchain > /dev/null 2>&1

WORKDIR /build

COPY resources/ci.sh /build/ci.sh

COPY resources/wpilib.version /build/wpilib.version

ADD resources/cpp.zip /wpilib

CMD ["/bin/bash", "/build/ci.sh"]
