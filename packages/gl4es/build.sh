TERMUX_PKG_HOMEPAGE=https://ptitseb.github.io/gl4es/
TERMUX_PKG_DESCRIPTION="OpenGL driver for GLES devices"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@suhan-paradkar"
TERMUX_PKG_VERSION=1.1.4
TERMUX_PKG_REVISION=3
_COMMIT=baf1c7482ee8dd138324a1f670fc04706723ed83
TERMUX_PKG_SRCURL=https://github.com/ptitSeb/gl4es.git
TERMUX_PKG_GIT_BRANCH=master
TERMUX_PKG_DEPENDS="libx11"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DTERMUX=ON
-DCMAKE_SYSTEM_NAME=Linux
"

termux_step_post_get_source() {
	git fetch --unshallow
	git reset --hard ${_COMMIT}
}

termux_step_pre_configure() {
	# lets go crazy with optimization as we only build one shared library
	# current highest fps output (on my A30s):
	# -O2 -flto > -O3 -flto > -O2 > -Os > -Os -flto > -O3 > -Oz > -Oz -flto
	export CFLAGS="${CFLAGS/-Oz/-O2} -flto"
}

termux_step_post_make_install() {
	ln -fsT "libGL.so.1" "$TERMUX_PREFIX/lib/gl4es/libGL.so"
}
