Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Build btiotest tool
Date: Mon, 16 Jun 2014 16:09:55 +0200
Message-Id: <1402927795-14834-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is useful for testing.
---
 android/Android.mk | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index fc7b59d..ecff9c8 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -620,3 +620,35 @@ LOCAL_MODULE := avinfo
 LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
 
 include $(BUILD_EXECUTABLE)
+
+#
+# btiotest
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	bluez/tools/btiotest.c \
+	bluez/btio/btio.c \
+	bluez/lib/bluetooth.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/bluez \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
+LOCAL_SHARED_LIBRARIES := \
+	libglib \
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := debug
+LOCAL_MODULE := btiotest
+
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
+include $(BUILD_EXECUTABLE)
-- 
1.9.1

