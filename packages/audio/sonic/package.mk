# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="sonic"
PKG_VERSION="d2cdb40fbdc82b464be364a50b34e8dd82b6c80a"
PKG_SHA256="fadf47936df0e1030fe159609d136c095ce3c77bbae19a9f525e26b2de6a8229"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/waywardgeek/sonic"
PKG_URL="https://github.com/waywardgeek/sonic/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Simple library to speed up or slow down speech"

pre_build_host() {
  mkdir -p ${PKG_BUILD}/.${HOST_NAME}
  cp -r ${PKG_BUILD}/* ${PKG_BUILD}/.${HOST_NAME}
}

configure_host() {
  PKG_MAKE_OPTS_HOST="CC=${HOST_CC}"
  cd ${PKG_BUILD}/.${HOST_NAME}
}

makeinstall_host() {
  make install PREFIX="${TOOLCHAIN}"
}

post_makeinstall_host() {
  safe_remove ${TOOLCHAIN}/bin/sonic
  safe_remove ${TOOLCHAIN}/lib/libsonic.so
  safe_remove ${TOOLCHAIN}/lib/libsonic.so.0
  safe_remove ${TOOLCHAIN}/lib/libsonic.so.0.3.0
}

pre_build_target() {
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}
  cp -r ${PKG_BUILD}/* ${PKG_BUILD}/.${TARGET_NAME}
}

configure_target() {
  PKG_MAKE_OPTS_TARGET="CC=${CC}"
  cd ${PKG_BUILD}/.${TARGET_NAME}
}

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/bin/sonic
  safe_remove ${INSTALL}/usr/lib/libsonic.so
  safe_remove ${INSTALL}/usr/lib/libsonic.so.0
  safe_remove ${INSTALL}/usr/lib/libsonic.so.0.3.0
  rm ${SYSROOT_PREFIX}/usr/bin/sonic
  rm ${SYSROOT_PREFIX}/usr/lib/libsonic.so
  rm ${SYSROOT_PREFIX}/usr/lib/libsonic.so.0
  rm ${SYSROOT_PREFIX}/usr/lib/libsonic.so.0.3.0
}
