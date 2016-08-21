#!/bin/bash

# Version we are writing a changelog for
VERSION=${1}
# The version number we are starting the changelog from
OLD_VERSION=${2}
# The version number we are ending the changelog at
NEW_VERION=${3}

case "${VERSION}" in
   "m")
      ZIP_MOVE=${HOME}/shared/Kernels/angler/Ninja/M ;;
   "n")
      ZIP_MOVE=${HOME}/shared/Kernels/angler/Ninja/N ;;
   "personal")
      ZIP_MOVE=${HOME}/shared/.me ;;
esac

# Changelog name and location
CHANGELOG=${ZIP_MOVE}/ninja_changelog.txt

# Remove the previous changelog
rm -rf ${CHANGELOG}

# Figure out the old version's commit hash
OLD_VERSION_HASH=$(git log --grep="^NINJA: v${OLD_VERSION}$" --pretty=format:'%H')

# Figure out the old version's commit hash
NEW_VERSION_HASH=$(git log --grep="^NINJA: v${NEW_VERSION}$" --pretty=format:'%H')

# Generate changelog
git log --oneline ${OLD_VERSION_HASH}..${NEW_VERSION_HASH} > ${CHANGELOG}

# Upload changelog
source ${HOME}/upload.sh