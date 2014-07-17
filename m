Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/build: Add rfcomm tool to Android build
Date: Thu, 17 Jul 2014 12:44:59 +0200
Message-Id: <1405593899-2226-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 51a792f..404caf9 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -661,3 +661,30 @@ LOCAL_MODULE := avinfo
 LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
 
 include $(BUILD_EXECUTABLE)
+
+#
+# rfcomm
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	bluez/tools/rfcomm.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
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
+LOCAL_MODULE := rfcomm
+
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
+include $(BUILD_EXECUTABLE)
-- 
1.8.5.3

