ARG UBUNTU_VERSION=22.04
ARG JAVA_VERSION=21.0.2-tem
ARG CLANG_VERSION=17.0.6

FROM ubuntu:${UBUNTU_VERSION}

LABEL description="Docker image for building Sourcetrail"
LABEL maintainer="Markus Karileet <markus.karileet@codehouse.ee>"

WORKDIR /builder

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake libboost-all-dev maven imagemagick qt5-qmake libfmt-dev qtbase5-dev qtdeclarative5-dev qt5-image-formats-plugins libqt5svg5-dev zstd terminfo git \
    curl zip unzip xz-utils

# Install Clang
RUN curl -L https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.6/clang+llvm-17.0.6-x86_64-linux-gnu-ubuntu-22.04.tar.xz | tar -xJ -C /builder
RUN cp -r /builder/clang+llvm-17.0.6-x86_64-linux-gnu-ubuntu-22.04/* /usr
RUN clang --version

# Install SDKMAN
RUN curl -s "https://get.sdkman.io" | bash
RUN source /root/.sdkman/bin/sdkman-init.sh && sdk install java 21.0.2-tem
RUN java -version
