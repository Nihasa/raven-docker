# Base image
FROM rockylinux/rockylinux:latest

# Install dependencies
RUN dnf update -y && \
    dnf install -y git make cmake gcc-c++ boost boost-devel zlib-devel && \
    dnf clean all

# Clone Raven repository
RUN git clone https://github.com/lbcb-sci/raven.git /raven

# Build Raven
WORKDIR /raven
RUN cmake -S ./ -B./build -DRAVEN_BUILD_EXE=1 -DCMAKE_BUILD_TYPE=Release
RUN cmake --build build

# Set PATH environment variable
ENV PATH="/raven/bin:${PATH}"

# Basic installation verification
RUN raven --version

# Set default command to run Raven
ENTRYPOINT ["raven"]
