Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 4/4] android: Add variable ROOT_PATH to Android.mk
Date: Wed, 23 Oct 2013 11:50:40 +0300
Message-Id: <1382518240-31896-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382518240-31896-1-git-send-email-luiz.dentz@gmail.com>
References: <1382518240-31896-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it simpler to include files from other parts of the code.
---
 android/Android.mk | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 93dcc23..2dffe71 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -1,7 +1,8 @@
 LOCAL_PATH := $(call my-dir)
+ROOT_PATH := $(LOCAL_PATH)/..
 
 # Retrieve BlueZ version from configure.ac file
-BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac | cpp -P -D'AC_INIT(_,v)=v')
+BLUEZ_VERSION := $(shell grep ^AC_INIT $(ROOT_PATH)/configure.ac | cpp -P -D'AC_INIT(_,v)=v')
 
 # Specify pathmap for glib
 pathmap_INCL += glib:external/bluetooth/glib
@@ -34,9 +35,9 @@ LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib)/glib \
 
 LOCAL_C_INCLUDES += \
-	$(LOCAL_PATH)/../ \
-	$(LOCAL_PATH)/../src \
-	$(LOCAL_PATH)/../lib \
+	$(ROOT_PATH)/ \
+	$(ROOT_PATH)/src \
+	$(ROOT_PATH)/lib \
 
 LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
 
@@ -51,9 +52,9 @@ lib_headers := \
 	sdp_lib.h \
 	sdp.h \
 
-$(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
+$(shell mkdir -p $(ROOT_PATH)/lib/bluetooth)
 
-$(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/../lib/bluetooth/$(file)))
+$(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(ROOT_PATH)/lib/bluetooth/$(file)))
 
 LOCAL_MODULE := bluetoothd
 
-- 
1.8.3.1

