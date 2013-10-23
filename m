Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 4/4] android: Add variable ROOT_PATH to Android.mk
Date: Wed, 23 Oct 2013 11:08:19 +0300
Message-Id: <1382515699-30338-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382515699-30338-1-git-send-email-luiz.dentz@gmail.com>
References: <1382515699-30338-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it simpler to include files from other parts of the code.
---
 android/Android.mk | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 4c87a9b..20064fe 100644
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
@@ -18,25 +19,25 @@ LOCAL_SRC_FILES := \
 	adapter.c adapter.h \
 	hid.c hid.h \
 	ipc.c ipc.h \
-	$(LOCAL_PATH)/../src/sdp.h \
-	$(LOCAL_PATH)/../src/shared/mgmt.c \
-	$(LOCAL_PATH)/../src/shared/util.c \
-	$(LOCAL_PATH)/../src/sdpd-database.c \
-	$(LOCAL_PATH)/../src/sdpd-service.c \
-	$(LOCAL_PATH)/../src/sdpd-request.c \
-	$(LOCAL_PATH)/../src/sdpd-server.c \
-	$(LOCAL_PATH)/../lib/sdp.c \
-	$(LOCAL_PATH)/../lib/bluetooth.c \
-	$(LOCAL_PATH)/../lib/hci.c \
+	$(ROOT_PATH)/src/sdp.h \
+	$(ROOT_PATH)/src/shared/mgmt.c \
+	$(ROOT_PATH)/src/shared/util.c \
+	$(ROOT_PATH)/src/sdpd-database.c \
+	$(ROOT_PATH)/src/sdpd-service.c \
+	$(ROOT_PATH)/src/sdpd-request.c \
+	$(ROOT_PATH)/src/sdpd-server.c \
+	$(ROOT_PATH)/lib/sdp.c \
+	$(ROOT_PATH)/lib/bluetooth.c \
+	$(ROOT_PATH)/lib/hci.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
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

