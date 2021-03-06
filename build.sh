#!/bin/bash
# Set these variables to suit your needs
NDK_PATH=/home/jiengfei/android/android-ndk-r10b
BUILD_PLATFORM=linux-x86_64
TOOLCHAIN_VERSION=4.8
ANDROID_VERSION=14

HOST=arm-linux-androideabi
TOOLCHAIN=${NDK_PATH}/toolchains/${HOST}-${TOOLCHAIN_VERSION}/prebuilt/${BUILD_PLATFORM}
SYSROOT=${NDK_PATH}/platforms/android-${ANDROID_VERSION}/arch-arm
ANDROID_INCLUDES="-I${SYSROOT}/usr/include -I${TOOLCHAIN}/include"
ANDROID_CFLAGS="-march=armv7-a -mfloat-abi=softfp -fprefetch-loop-arrays \
  -fstrict-aliasing --sysroot=${SYSROOT}"
export CPP=${TOOLCHAIN}/bin/${HOST}-cpp
export AR=${TOOLCHAIN}/bin/${HOST}-ar
export AS=${TOOLCHAIN}/bin/${HOST}-as
export NM=${TOOLCHAIN}/bin/${HOST}-nm
export CC=${TOOLCHAIN}/bin/${HOST}-gcc
export LD=${TOOLCHAIN}/bin/${HOST}-ld
export RANLIB=${TOOLCHAIN}/bin/${HOST}-ranlib
export OBJDUMP=${TOOLCHAIN}/bin/${HOST}-objdump
export STRIP=${TOOLCHAIN}/bin/${HOST}-strip
cd build-android
../configure --host=${HOST} \
  CFLAGS="${ANDROID_INCLUDES} ${ANDROID_CFLAGS} -O3" \
  CPPFLAGS="${ANDROID_INCLUDES} ${ANDROID_CFLAGS}" \
  LDFLAGS="${ANDROID_CFLAGS}" --with-simd ${1+"$@"}
make
