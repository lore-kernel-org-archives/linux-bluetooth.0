Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 1/2] android: Add btmgmt to debug builds
Date: Tue, 21 Jan 2014 20:46:09 +0100
Message-Id: <1390333570-13196-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index e66d70a..e3a31c1 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -296,3 +296,33 @@ LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
 
 include $(BUILD_PREBUILT)
+
+#
+# btmgmt
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	../tools/btmgmt.c \
+	../lib/bluetooth.c \
+	../lib/sdp.c \
+	../monitor/mainloop.c \
+	../src/shared/io-mainloop.c \
+	../src/shared/mgmt.c \
+	../src/shared/queue.c \
+	../src/shared/util.c \
+	../src/uuid-helper.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/.. \
+	$(LOCAL_PATH)/../src \
+	$(LOCAL_PATH)/../lib \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := debug
+LOCAL_MODULE := btmgmt
+
+include $(BUILD_EXECUTABLE)
-- 
1.8.5.2

