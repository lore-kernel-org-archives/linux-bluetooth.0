Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android: Add avtest to debug builds
Date: Wed, 29 Jan 2014 14:40:19 +0200
Message-Id: <1390999219-15012-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 1d12da5..238bb7c 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -354,6 +354,34 @@ LOCAL_MODULE := l2ping
 include $(BUILD_EXECUTABLE)
 
 #
+# avtest
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	bluez/tools/avtest.c \
+	bluez/lib/bluetooth.c \
+	bluez/lib/hci.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/bluez/lib \
+
+lib_headers := \
+	bluetooth.h \
+	hci.h \
+
+$(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/bluez/lib/bluetooth/$(file)))
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := debug
+LOCAL_MODULE := avtest
+
+include $(BUILD_EXECUTABLE)
+
+#
 # libsbc
 #
 
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

