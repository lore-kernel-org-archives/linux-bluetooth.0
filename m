Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android: Add common place for adding compiler flags in Android.mk
Date: Tue, 29 Oct 2013 16:23:37 +0100
Message-ID: <1383060218-25693-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will contain CFLAGS common for all BlueZ code.
---
 android/Android.mk | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index d8f9d0d..c88b27e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -6,6 +6,9 @@ BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac | cpp -P -D
 # Specify pathmap for glib
 pathmap_INCL += glib:external/bluetooth/glib
 
+# Specify common compiler flags
+BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
+
 #
 # Android BlueZ daemon (bluetoothd)
 #
@@ -39,7 +42,7 @@ LOCAL_C_INCLUDES += \
 	$(LOCAL_PATH)/../src \
 	$(LOCAL_PATH)/../lib \
 
-LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) \
 	-DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
 
 LOCAL_SHARED_LIBRARIES := \
@@ -84,6 +87,8 @@ LOCAL_C_INCLUDES += \
 LOCAL_SHARED_LIBRARIES := \
 	libcutils \
 
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) \
+
 LOCAL_MODULE := bluetooth.default
 LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
 LOCAL_MODULE_TAGS := optional
@@ -112,7 +117,7 @@ LOCAL_SRC_FILES := \
 	client/if-pan.c \
 	client/if-sock.c \
 
-LOCAL_CFLAGS := -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_SHARED_LIBRARIES := libhardware
 
-- 
1.8.4.1

