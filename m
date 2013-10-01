Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/7] android-build: Add BlueZ Android daemon
Date: Tue,  1 Oct 2013 14:58:35 +0200
Message-Id: <1380632319-7701-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
References: <1380632319-7701-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
1.7.9.5

