Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] android: Rebuild executables on version change
Date: Fri, 4 Apr 2014 12:48:55 +0200
Message-ID: <1396608535-13182-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1396608535-13182-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1396608535-13182-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds additional dependency to configure.ac file for all
executables to make sure they are rebuilt every time BlueZ version is
chaned. Otherwise, it's possible to have BlueZ built from most recent
commit but with old version number since this information is extracted
from configure.ac and then passed via -D preprocessor option which does
not trigger rebuild when value changes.
---
 android/Android.mk | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index c31b57e..e5723cc 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -94,6 +94,8 @@ else
 LOCAL_MODULE := bluetoothd
 endif
 
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
 include $(BUILD_EXECUTABLE)
 
 #
@@ -212,6 +214,8 @@ LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := btmon
 
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
 include $(BUILD_EXECUTABLE)
 
 #
@@ -234,6 +238,8 @@ LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := btproxy
 
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
 include $(BUILD_EXECUTABLE)
 
 #
@@ -284,6 +290,8 @@ LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := l2test
 
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
 include $(BUILD_EXECUTABLE)
 
 #
@@ -306,6 +314,8 @@ LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := bluetoothd-snoop
 
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
 include $(BUILD_EXECUTABLE)
 
 #
@@ -351,6 +361,8 @@ LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := btmgmt
 
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
 include $(BUILD_EXECUTABLE)
 
 #
@@ -377,6 +389,8 @@ LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := hcitool
 
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
 include $(BUILD_EXECUTABLE)
 
 #
@@ -399,6 +413,8 @@ LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := l2ping
 
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
 include $(BUILD_EXECUTABLE)
 
 #
@@ -421,6 +437,8 @@ LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
 LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := avtest
 
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
 include $(BUILD_EXECUTABLE)
 
 #
-- 
1.9.1

