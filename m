Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android: Add gatttool to debug builds
Date: Fri, 23 May 2014 12:50:09 +0200
Message-Id: <1400842209-4473-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400842209-4473-1-git-send-email-szymon.janc@tieto.com>
References: <1400842209-4473-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index f59352a..2a1052f 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -247,6 +247,48 @@ LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
 include $(BUILD_EXECUTABLE)
 
 #
+# gatttool
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	bluez/attrib/gatttool.c \
+	bluez/attrib/att.c \
+	bluez/attrib/gatt.c \
+	bluez/attrib/gattrib.c \
+	bluez/attrib/utils.c \
+	bluez/btio/btio.c \
+	bluez/src/log.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/uuid.c \
+	bluez/lib/hci.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/bluez \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS) -DGATTTOOL_NO_INTERACTIVE
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/bluez \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_SHARED_LIBRARIES := \
+	libglib \
+
+LOCAL_STATIC_LIBRARIES := \
+	bluetooth-headers \
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := debug
+LOCAL_MODULE := gatttool
+
+LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
+
+include $(BUILD_EXECUTABLE)
+
+#
 # A2DP audio
 #
 
-- 
1.9.1

