Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 05/16] android: Add Android Makefile for mgmt library
Date: Fri, 27 Sep 2013 17:12:30 +0300
Message-Id: <1380291161-10232-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Build libbluez shared library for Android.
---
 android/Android.mk |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 93de803..40cff9a 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -43,3 +43,33 @@ LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_CLASS := SHARED_LIBRARIES
 
 include $(BUILD_SHARED_LIBRARY)
+
+#
+# mgmt library libbluez
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	../src/shared/mgmt.c \
+	../src/shared/util.c \
+
+LOCAL_C_INCLUDES := \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_C_INCLUDES += \
+	$(LOCAL_PATH)/../ \
+
+LOCAL_SHARED_LIBRARIES := \
+	libglib \
+
+# to suppress the "pointer of type 'void *' used in arithmetic" warning
+LOCAL_CFLAGS := -Wno-pointer-arith
+
+# Define missing flags for Android 4.2
+LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000
+
+LOCAL_MODULE    := libbluez
+
+include $(BUILD_SHARED_LIBRARY)
-- 
1.7.10.4

