#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

if [ -z "${NAME}" ]; then
    echo "NAME must be set"
    exit 1
fi
if [ -z "${PKG}" ]; then
    echo "PKG must be set"
    exit 1
fi
if [ -z "${ARCH}" ]; then
    echo "ARCH must be set"
    exit 1
fi
if [ -z "${VERSION}" ]; then
    echo "VERSION must be set"
    exit 1
fi

export CGO_ENABLED=0
export GOARCH="${ARCH}"

go build                                                        \
    -installsuffix "static"                                     \
    -ldflags "-X ${PKG}/pkg/version.VERSION=${VERSION} -s -w"   \
    -o bin/${ARCH}/${NAME}                                      \
    ./$@/...
