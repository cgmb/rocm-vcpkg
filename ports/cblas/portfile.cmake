include(vcpkg_find_fortran)
SET(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

set(cblas_ver 3.8.0)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  "Reference-LAPACK/lapack"
    REF "v${cblas_ver}"
    SHA512 17786cb7306fccdc9b4a242de7f64fc261ebe6a10b6ec55f519deb4cb673cb137e8742aa5698fd2dc52f1cd56d3bd116af3f593a01dcf6770c4dcc86c50b2a7f
    HEAD_REF master
)

if(NOT VCPKG_TARGET_IS_WINDOWS)
    set(ENV{FFLAGS} "$ENV{FFLAGS} -fPIC")
endif()

set(VCPKG_CRT_LINKAGE_BACKUP ${VCPKG_CRT_LINKAGE})
vcpkg_find_fortran(FORTRAN_CMAKE)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        "-DUSE_OPTIMIZED_BLAS=OFF"
        "-DCBLAS=ON"
        "-DLAPACKE=OFF"
        "-DBUILD_TESTING=OFF"
        ${FORTRAN_CMAKE}
)

vcpkg_install_cmake()

vcpkg_cmake_config_fixup(PACKAGE_NAME cblas-${cblas_ver} CONFIG_PATH lib/cmake/cblas-${cblas_ver})

set(pcfile "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/cblas.pc")
if(EXISTS "${pcfile}")
    file(READ "${pcfile}" _contents)
    set(_contents "prefix=${CURRENT_INSTALLED_DIR}\n${_contents}")
    file(WRITE "${pcfile}" "${_contents}")
endif()
set(pcfile "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/cblas.pc")
if(EXISTS "${pcfile}")
    file(READ "${pcfile}" _contents)
    set(_contents "prefix=${CURRENT_INSTALLED_DIR}/debug\n${_contents}")
    file(WRITE "${pcfile}" "${_contents}")
endif()
vcpkg_fixup_pkgconfig()

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

# remove debug includes
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# remove lapack and blas files
if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/liblapack.a")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/lib/liblapack.a")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/libblas.a")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/lib/libblas.a")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/liblapack.a")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/liblapack.a")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/libblas.a")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/libblas.a")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/lapack.pc")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/lapack.pc")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/blas.pc")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/blas.pc")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/lapack.pc")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/lapack.pc")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/blas.pc")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/blas.pc")
endif()
# remove lapack and blas files on Windows
if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/liblapack.dll.a")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/lib/liblapack.dll.a")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/libblas.dll.a")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/lib/libblas.dll.a")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/liblapack.dll.a")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/liblapack.dll.a")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/libblas.dll.a")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/lib/libblas.dll.a")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/bin/liblapack.dll")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/bin/liblapack.dll")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/bin/libblas.dll")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/bin/libblas.dll")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/bin/liblapack.dll")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/bin/liblapack.dll")
endif()
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/bin/libblas.dll")
    file(REMOVE "${CURRENT_PACKAGES_DIR}/debug/bin/libblas.dll")
endif()
