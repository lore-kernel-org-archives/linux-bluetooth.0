Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/build: Adding l2test to Android.mk
Date: Thu, 19 Dec 2013 10:06:22 +0100
Message-Id: <1387443982-1017-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enabling l2test tool for the android target
---
 android/Android.mk | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index ebc3219..c59df7a 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -226,3 +226,31 @@ LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := audio.a2dp.default
 
 include $(BUILD_SHARED_LIBRARY)
+
+#
+# l2cap-test
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	../tools/l2test.c \
+	../lib/bluetooth.c \
+	../lib/hci.c \
+
+lib_headers := \
+	../lib/bluetooth.h \
+	../lib/l2cap.h \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/.. \
+	$(LOCAL_PATH)/../lib \
+	$(LOCAL_PATH)/../src/shared \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := eng
+LOCAL_MODULE := l2test
+
+include $(BUILD_EXECUTABLE)
-- 
1.8.1.2

