#!/usr/bin/env just --justfile
# vim: set noet:
#DATE := $(shell date +"%Y_%m_%d-%H_%M")

package:
        7z a app/src/embed/assets/game.love ../loveputer/src/*

build: package
        ./gradlew assembleEmbedRecordDebug

build-info: package
        ./gradlew assembleEmbedRecordDebug --info

debug-install: build
        adb install ./app/build/outputs/apk/embedRecord/debug/app-embed-record-debug.apk

build-nr: package
        ./gradlew assembleEmbedNoRecordDebug # assembleEmbedNoRecordRelease

debug-install-nr: build
        adb install ./app/build/outputs/apk/embedNoRecord/debug/app-embed-noRecord-debug.apk

build-prod: package
        ./gradlew assembleEmbedRecordRelease

#
clean:
        ./gradlew clean


###################################
# util
zip-app: build
        7z a /tmp/apk_$(DATE) ./app/build/outputs/apk/embedRecord/debug/app-embed-record-debug.apk

start-app:
        adb shell am start-activity -n com.example.loveputer/org.love2d.android.GameActivity

logcat:
        adb logcat -T 10 APP:I -e LOVE

test-new: debug-install start-app logcat