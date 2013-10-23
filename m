Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android: Add variable ROOT_PATH to Android.mk
Date: Wed, 23 Oct 2013 10:58:18 +0300
Message-Id: <1382515098-28782-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382515098-28782-1-git-send-email-luiz.dentz@gmail.com>
References: <1382515098-28782-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it simpler to include files from other parts of the code.
---
 android/Android.mk | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 9becddc..baa0a49 100644
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
 
-- 
1.8.3.1

