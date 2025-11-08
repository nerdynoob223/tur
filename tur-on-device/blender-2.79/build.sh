# build.sh — Blender 2.79 for TUR Build API (git source)

TERMUX_PKG_HOMEPAGE=https://www.blender.org/
TERMUX_PKG_DESCRIPTION="Blender 2.79 - 3D creation suite (legacy minimal build)"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@yourname"
TERMUX_PKG_VERSION=2.79b
TERMUX_PKG_SRCURL=https://github.com/blender/blender.git
TERMUX_PKG_GIT_BRANCH=blender-v2.79b-release
TERMUX_PKG_DEPENDS="libjpeg-turbo, libpng, freetype, libtiff, zlib, openjpeg, libxml2, libffi"
TERMUX_PKG_BUILD_DEPENDS="cmake, make, clang, python, libxi, xorgproto, libx11, libxext"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
    export CFLAGS="${CFLAGS} -fPIC"
    export CXXFLAGS="${CXXFLAGS} -fPIC"
    export LDFLAGS="${LDFLAGS} -lm -ldl"
}

termux_step_configure() {
    mkdir -p build && cd build
    cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DWITH_CYCLES=OFF \
        -DWITH_GAMEENGINE=OFF \
        -DWITH_PLAYER=OFF \
        -DWITH_OPENCOLORIO=OFF \
        -DWITH_OPENVDB=OFF \
        -DWITH_MOD_OCEANSIM=OFF \
        -DWITH_INSTALL_PORTABLE=OFF \
        -DWITH_PYTHON_INSTALL=OFF \
        -DWITH_PYTHON_MODULE=OFF \
        -DWITH_X11=ON \
        -DWITH_GL_EGL=OFF \
        -DWITH_SYSTEM_GLEW=ON \
        -DWITH_SYSTEM_OPENJPEG=ON \
        -DWITH_SYSTEM_FREETYPE=ON \
        -DWITH_SYSTEM_LIBPNG=ON \
        -DWITH_SYSTEM_LIBTIFF=ON \
        -DWITH_SYSTEM_ZLIB=ON \
        -DWITH_SYSTEM_LIBXML=ON \
        -DCMAKE_INSTALL_PREFIX=${TERMUX_PREFIX}
}

termux_step_make() {
    cd build
    make -j$(nproc)
}

termux_step_make_install() {
    cd build
    make install
}

