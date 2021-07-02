FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
    wget parted dosfstools binutils p7zip-full openssl\
    sudo xz-utils jq u-boot-tools

# see https://github.com/raspberrypi/firmware/releases
ENV RASPBERRY_PI_FIRMWARE=1.20210527
# see https://github.com/rancher/k3os/releases
ENV K3OS_VERSION=v0.20.6-k3s1r0

# The repository should be mounted at /app.
WORKDIR /app

CMD ./build-image.sh $TARGET
