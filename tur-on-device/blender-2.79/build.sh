# build.sh — Blender 2.79 for TUR Build API (git source)
TERMUX_PKG_HOMEPAGE=https://www.blender.org/
TERMUX_PKG_DESCRIPTION="Blender 2.79 - 3D creation suite (legacy minimal build)"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@nerdynoob223"
TERMUX_PKG_VERSION=2.79b
TERMUX_PKG_SRCURL=git+https://github.com/nerdynoob223/blender/
TERMUX_PKG_GIT_BRANCH=blender-v2.79b-release
TERMUX_PKG_EXCLUDED_ARCHES="arm, i686"
TERMUX_PKG_DEPENDS="libjpeg-turbo, libpng, freetype, libtiff, zlib, openexr, openimageio,  openjpeg, python3.7, libxml2, libffi"
TERMUX_PKG_BUILD_DEPENDS="cmake, make, clang, python, libxi, xorgproto, libx11, libxext"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
export CFLAGS="${CFLAGS} -fPIC"
export CXXFLAGS="${CXXFLAGS} -fPIC"
export LDFLAGS="${LDFLAGS} -lm -ldl"
}

termux_step_configure() {
# check for installed packages
apt list --installed
mkdir -p build && cd build
cmake .. \
-DWITH_CYCLES=OFF \
-DWITH_GAMEENGINE=OFF \
-DWITH_PLAYER=OFF \
-DCMAKE_INSTALL_PREFIX=${TERMUX_PREFIX} \
-DPYTHON_VERSION=3.7
}

termux_step_make() {
cd build
make -j$(nproc)
}

termux_step_make_install() {
cd build
make install
}
