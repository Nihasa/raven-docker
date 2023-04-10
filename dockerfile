# Base image
FROM rockylinux/rockylinux:latest

# Install dependencies
RUN yum update -y && \
    yum install -y wget unzip make gcc gcc-c++ zlib-devel bzip2-devel xz-devel

# Download and extract Raven
RUN wget https://github.com/lbcb-sci/raven/releases/download/v1.0.1/raven-1.0.1.zip && \
    unzip raven-1.0.1.zip && \
    rm raven-1.0.1.zip

# Set working directory
WORKDIR /raven-1.0.1

# Build Raven
RUN make

# Add Raven to PATH
ENV PATH="/raven-1.0.1/bin:${PATH}"

# Set entry point
ENTRYPOINT ["raven"]
