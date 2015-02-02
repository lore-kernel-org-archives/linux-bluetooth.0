Return-Path: <cyrus@holtmann.org>
From: Ian Coolidge <icoolidge@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ian Coolidge <icoolidge@google.com>
Subject: [PATCH] android/build: Create a target for hciconfig.
Date: Mon,  2 Feb 2015 00:25:29 -0800
Message-Id: <1422865529-9857-2-git-send-email-icoolidge@google.com>
In-Reply-To: <1422865529-9857-1-git-send-email-icoolidge@google.com>
References: <D620962F-0B39-4DF2-B9B1-CC5918193C9F@holtmann.org>
 <1422865529-9857-1-git-send-email-icoolidge@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index c1a9eff..ff71089 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -539,6 +539,34 @@ LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
 include $(BUILD_EXECUTABLE)
 
 #
+# hciconfig
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES:= \
+	bluez/tools/hciconfig.c \
+	bluez/tools/csr.c \
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

