Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/build: Add rctest tool to Android build
Date: Thu, 17 Jul 2014 13:04:32 +0200
Message-Id: <1405595072-7749-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 51a792f..afbe804 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -661,3 +661,31 @@ LOCAL_MODULE := avinfo
 LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
 
 include $(BUILD_EXECUTABLE)
+
+#
+# rctest
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	bluez/tools/rctest.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
+	bluez/lib/sdp.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/bluez \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := debug
+LOCAL_MODULE := rctest
+
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
+include $(BUILD_EXECUTABLE)
-- 
1.8.5.3

