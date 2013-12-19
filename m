Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/build: Adding l2test to Android.mk
Date: Thu, 19 Dec 2013 13:53:15 +0100
Message-Id: <1387457595-8020-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enabling l2test tool for the android target
---
 android/Android.mk | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index ebc3219..fee2f6c 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -226,3 +226,27 @@ LOCAL_MODULE_TAGS := optional
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

