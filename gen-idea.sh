#!/bin/sh

# Check if current directory is the liferay-portal project folder
PORTAL=$PWD
PORTAL_DEFAULT=$HOME/projects/liferay-portal

if [ ! -f $PORTAL/gradlew ]; then
    echo "$PORTAL is not a valid liferay project folder, falling back to $PORTAL_DEFAULT..."

    PORTAL=$PORTAL_DEFAULT
    if [ ! -f $PORTAL/gradlew ]; then
        echo "$PORTAL is also not a valid liferay project folder"
        exit 1;
    fi
fi

MODULES=(
    "core/petra/petra-concurrent"
    "core/petra/petra-executor"
    "core/petra/petra-function"
    "core/petra/petra-io"
    "core/petra/petra-lang"
    "core/petra/petra-memory"
    "core/petra/petra-nio"
    "core/petra/petra-process"
    "core/petra/petra-reflect"
    "core/petra/petra-string"
    "apps/foundation/frontend-taglib/frontend-taglib-clay"
    "apps/dynamic-data-mapping"
    "apps/dynamic-data-lists"
)

for m in ${MODULES[@]}; do
  cd $PORTAL/modules/$m
  $PORTAL/gradlew idea
done

# Run ./ideactl.py --dwim
cd $PORTAL
$(dirname "$0")/ideactl.py --dwim
