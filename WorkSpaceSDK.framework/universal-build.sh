
#!/bin/bash

# Adapted from http://stackoverflow.com/questions/24039470/xcode-6-ios-creating-a-cocoa-touch-framework-architectures-issues/26691080#26691080
# and https://gist.github.com/cromandini/1a9c4aeab27ca84f5d79

# Create a new aggregate target.
# For the automatically generated scheme, change its build config to "release".
# Ensure this target's "product name" build setting matches the framework's.
# Add a run script with `source "${PROJECT_DIR}/path_to_this_script`

#UNIVERSAL_OUTPUT_DIR=${BUILD_DIR}/${CONFIGURATION}-universal
#RELEASE_DIR=${PROJECT_DIR}/build
#
## make sure the output directory exists
#mkdir -p "${UNIVERSAL_OUTPUT_DIR}"
#
## Step 1. Build Device and Simulator versions
#xcodebuild -target "${PROJECT_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build -sdk iphoneos
#xcodebuild -target "${PROJECT_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build -sdk iphonesimulator -arch x86_64
#
## Step 2. Copy the framework structure (from iphoneos build) to the universal folder
#cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PRODUCT_NAME}.framework" "${UNIVERSAL_OUTPUT_DIR}/"
#
## Step 3. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory
#SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/."
#if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then
#    cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUT_DIR}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"
#fi
#
## Step 4. Create universal binary file using lipo and place the combined executable in the copied framework directory
#lipo -create -output "${UNIVERSAL_OUTPUT_DIR}/${PRODUCT_NAME}.framework/${PRODUCT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PRODUCT_NAME}.framework/${PRODUCT_NAME}" "${UNIVERSAL_OUTPUT_DIR}/${PRODUCT_NAME}.framework/${PRODUCT_NAME}"
#
## Step 5. Combine PRODUCT_NAME-Swift.h from device and simulator architectures (Xcode 10.2 issue: 48635615)
#UNIVERSAL_SWIFT_HEADER=${UNIVERSAL_OUTPUT_DIR}/${PRODUCT_NAME}.framework/Headers/${PRODUCT_NAME}-Swift.h
#
#> ${UNIVERSAL_SWIFT_HEADER}
#echo "#include <TargetConditionals.h>" >> ${UNIVERSAL_SWIFT_HEADER}
#echo "#if TARGET_OS_SIMULATOR" >> ${UNIVERSAL_SWIFT_HEADER}
#cat ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PRODUCT_NAME}.framework/Headers/${PRODUCT_NAME}-Swift.h >> ${UNIVERSAL_SWIFT_HEADER}
#echo "#else" >> ${UNIVERSAL_SWIFT_HEADER}
#cat ${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PRODUCT_NAME}.framework/Headers/${PRODUCT_NAME}-Swift.h >> ${UNIVERSAL_SWIFT_HEADER}
#echo "#endif" >> ${UNIVERSAL_SWIFT_HEADER}
#
## Step 6. Convenience step to copy the framework to the project's directory
#cp -R "${UNIVERSAL_OUTPUT_DIR}/${PRODUCT_NAME}.framework" "${RELEASE_DIR}"
#
## Step 7. Convenience step to open the project's directory in Finder
#open "${RELEASE_DIR}"

#!/bin/sh

UNIVERSAL_OUTPUT_DIR=${BUILD_DIR}/${CONFIGURATION}-universal
RELEASE_DIR=${PROJECT_DIR}/build

# make sure the output directory exists
mkdir -p "${UNIVERSAL_OUTPUT_DIR}"

# Step 1. Build Device and Simulator versions
xcodebuild -target "${PROJECT_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos  BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build
xcodebuild -target "${PROJECT_NAME}" -configuration ${CONFIGURATION} -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

# Step 2. Copy the framework structure (from iphoneos build) to the universal folder
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUT_DIR}/"

# Step 3. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory
SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/."
if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then
cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUT_DIR}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"
fi

# Step 4. Create universal binary file using lipo and place the combined executable in the copied framework directory
lipo -create -output "${UNIVERSAL_OUTPUT_DIR}/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}"

# Step 4.1. Combine PRODUCT_NAME-Swift.h from device and simulator architectures (Xcode 10.2 issue: 48635615)
UNIVERSAL_SWIFT_HEADER=${UNIVERSAL_OUTPUT_DIR}/${PRODUCT_NAME}.framework/Headers/${PRODUCT_NAME}-Swift.h

> ${UNIVERSAL_SWIFT_HEADER}
echo "#include <TargetConditionals.h>" >> ${UNIVERSAL_SWIFT_HEADER}
echo "#if TARGET_OS_SIMULATOR" >> ${UNIVERSAL_SWIFT_HEADER}
cat ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PRODUCT_NAME}.framework/Headers/${PRODUCT_NAME}-Swift.h >> ${UNIVERSAL_SWIFT_HEADER}
echo "#else" >> ${UNIVERSAL_SWIFT_HEADER}
cat ${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PRODUCT_NAME}.framework/Headers/${PRODUCT_NAME}-Swift.h >> ${UNIVERSAL_SWIFT_HEADER}
echo "#endif" >> ${UNIVERSAL_SWIFT_HEADER}

# Step 5. Convenience step to copy the framework to the project's directory
cp -R "${UNIVERSAL_OUTPUT_DIR}/${PROJECT_NAME}.framework" "${RELEASE_DIR}"

# Step 6. Convenience step to open the project's directory in Finder
open "${RELEASE_DIR}"

#、、、、、、、、、、、、、


#UNIVERSAL_OUTPUT_DIR=${BUILD_DIR}/${CONFIGURATION}-universal
#RELEASE_DIR=${PROJECT_DIR}/build
#
## make sure the output directory exists
#mkdir -p "${UNIVERSAL_OUTPUT_DIR}"
#
## Step 1. Build Device and Simulator versions
#xcodebuild -target "${PROJECT_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build -sdk iphoneos
#xcodebuild -target "${PROJECT_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build -sdk iphonesimulator -arch x86_64
#
## Step 2. Copy the framework structure (from iphoneos build) to the universal folder
#cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PRODUCT_NAME}.framework" "${UNIVERSAL_OUTPUT_DIR}/"
#
## Step 3. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory
#SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/."
#if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then
#    cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUT_DIR}/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"
#fi
#
## Step 4. Create universal binary file using lipo and place the combined executable in the copied framework directory
#lipo -create -output "${UNIVERSAL_OUTPUT_DIR}/${PRODUCT_NAME}.framework/${PRODUCT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PRODUCT_NAME}.framework/${PRODUCT_NAME}" "${UNIVERSAL_OUTPUT_DIR}/${PRODUCT_NAME}.framework/${PRODUCT_NAME}"
#
## Step 5. Combine PRODUCT_NAME-Swift.h from device and simulator architectures (Xcode 10.2 issue: 48635615)
#UNIVERSAL_SWIFT_HEADER=${UNIVERSAL_OUTPUT_DIR}/${PRODUCT_NAME}.framework/Headers/${PRODUCT_NAME}-Swift.h
#
#> ${UNIVERSAL_SWIFT_HEADER}
#echo "#include <TargetConditionals.h>" >> ${UNIVERSAL_SWIFT_HEADER}
#echo "#if TARGET_OS_SIMULATOR" >> ${UNIVERSAL_SWIFT_HEADER}
#cat ${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PRODUCT_NAME}.framework/Headers/${PRODUCT_NAME}-Swift.h >> ${UNIVERSAL_SWIFT_HEADER}
#echo "#else" >> ${UNIVERSAL_SWIFT_HEADER}
#cat ${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PRODUCT_NAME}.framework/Headers/${PRODUCT_NAME}-Swift.h >> ${UNIVERSAL_SWIFT_HEADER}
#echo "#endif" >> ${UNIVERSAL_SWIFT_HEADER}
#
## Step 6. Convenience step to copy the framework to the project's directory
#cp -R "${UNIVERSAL_OUTPUT_DIR}/${PRODUCT_NAME}.framework" "${RELEASE_DIR}"
#
## Step 7. Convenience step to open the project's directory in Finder
#open "${RELEASE_DIR}"
