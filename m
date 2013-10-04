Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 3/7] android-build: Add BlueZ Android daemon
Date: Fri,  4 Oct 2013 13:54:12 +0300
Message-Id: <1380884056-27808-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380884056-27808-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380884056-27808-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Danis <frederic.danis@linux.intel.com>

Define local mapping to glib path, otherwise this has to be inside central
place in the build repository.
---
 android/Android.mk |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 183f7e2..fc3d6c2 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -2,3 +2,28 @@ LOCAL_PATH := $(call my-dir)
 
 # Retrieve BlueZ version from configure.ac file
 BLUEZ_VERSION := $(shell grep ^AC_INIT $(LOCAL_PATH)/../configure.ac | cpp -P -D'AC_INIT(_,v)=v')
+
+# Specify pathmap for glib
+pathmap_INCL += glib:external/bluetooth/glib
+
+#
+# Android BlueZ daemon (bluetoothd)
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	main.c \
+
+LOCAL_C_INCLUDES := \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
+
+LOCAL_SHARED_LIBRARIES := \
+	libglib \
+
+LOCAL_MODULE := bluetoothd
+
+include $(BUILD_EXECUTABLE)
-- 
1.7.10.4

