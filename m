Return-Path: <cyrus@holtmann.org>
From: Ian Coolidge <icoolidge@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ian Coolidge <icoolidge@google.com>
Subject: [PATCH] android/build: Create a target for hciconfig.
Date: Sun,  1 Feb 2015 23:19:24 -0800
Message-Id: <1422861564-30169-1-git-send-email-icoolidge@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index c1a9eff..bf7e510 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -539,6 +539,39 @@ LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
 include $(BUILD_EXECUTABLE)
 
 #
+# hciconfig
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES:= \
+	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
+	bluez/tools/csr.c \
+	bluez/tools/csr_h4.c \
+	bluez/tools/hciconfig.c
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/bluez \
+	$(LOCAL_PATH)/bluez/lib \
+	$(LOCAL_PATH)/bluez/tools \
+	$(LOCAL_PATH)/bluez/src \
+	$(LOCAL_PATH)/bluez/src/shared \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := debug
+LOCAL_MODULE := hciconfig
+
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
+include $(BUILD_EXECUTABLE)
+
+#
 # l2ping
 #
 
-- 
2.2.0.rc0.207.ga3a616c

