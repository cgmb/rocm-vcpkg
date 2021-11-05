SET(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

set(rocm_ver 4.5.0)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO  "RadeonOpenCompute/rocm-cmake"
    REF "rocm-${rocm_ver}"
    SHA512 0af0d33e0e23a5d6e9b7deb4dcfc3038bb64e6e9239b3aefeea4c865e618fa2f6cfc280adaedf3db5b3d054e9b135d47f3af2d9256aef5d8b880983584e9e3df
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
