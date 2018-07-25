#!/bin/sh

# Check if current directory is the liferay-portal project folder
PORTAL=$PWD

if [ ! -f $PORTAL/gradlew ]; then
	echo "$PORTAL is not a valid liferay project folder..."

	read -p "Please provide the full path where your liferay project folder is located: " PORTAL
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
if [ ! -f $PORTAL/ideactl.py ]; then
	cp ./ideactl.py $PORTAL
fi

$PORTAL/ideactl.py --dwim
