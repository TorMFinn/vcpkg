# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   CURRENT_INSTALLED_DIR     = ${VCPKG_ROOT_DIR}\installed\${TRIPLET}
#   DOWNLOADS                 = ${VCPKG_ROOT_DIR}\downloads
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#   VCPKG_TOOLCHAIN           = ON OFF
#   TRIPLET_SYSTEM_ARCH       = arm x86 x64
#   BUILD_ARCH                = "Win32" "x64" "ARM"
#   MSBUILD_PLATFORM          = "Win32"/"x64"/${TRIPLET_SYSTEM_ARCH}
#   DEBUG_CONFIG              = "Debug Static" "Debug Dll"
#   RELEASE_CONFIG            = "Release Static"" "Release DLL"
#   VCPKG_TARGET_IS_WINDOWS
#   VCPKG_TARGET_IS_UWP
#   VCPKG_TARGET_IS_LINUX
#   VCPKG_TARGET_IS_OSX
#   VCPKG_TARGET_IS_FREEBSD
#   VCPKG_TARGET_IS_ANDROID
#   VCPKG_TARGET_IS_MINGW
#   VCPKG_TARGET_EXECUTABLE_SUFFIX
#   VCPKG_TARGET_STATIC_LIBRARY_SUFFIX
#   VCPKG_TARGET_SHARED_LIBRARY_SUFFIX
#
# 	See additional helpful variables in /docs/maintainers/vcpkg_common_definitions.md

# # Specifies if the port install should fail immediately given a condition
vcpkg_fail_port_install(MESSAGE "libmnl currently only supports Linux" ON_TARGET
  "Windows" "UWP" )

vcpkg_download_distfile(ARCHIVE
    URLS "https://www.netfilter.org/pub/libmnl/libmnl-1.0.4.tar.bz2"
    FILENAME "libmnl104.tar.bz2"
    SHA512 e2bbfb688fe41913d53c74ba7ec95b4e88ee2c52b556b8608185f2fcbd629665423a3b37f877f84426ba257cf6040fa701539d67166b00b8e3e2dfde6831a2f9
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
  list(APPEND OPTIONS --enable-shared=yes)
elseif (VCPKG_LIBRARY_LINKAGE STREQUAL "static")
  list(APPEND OPTIONS --enable-static=yes)
endif()

vcpkg_configure_make(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        ${OPTIONS}
)

vcpkg_build_make(
  SOURCE_PATH ${SOURCE_PATH}
  ENABLE_INSTALL
)

file(
  INSTALL ${SOURCE_PATH}/COPYING
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT}
  RENAME copyright
)
