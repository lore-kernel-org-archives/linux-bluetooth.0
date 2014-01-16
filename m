Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] android: Add btmgmt to debug builds
Date: Thu, 16 Jan 2014 15:52:24 +0100
Message-ID: <1389883945-10707-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 7e97ec8..b3e6a50 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -282,3 +282,39 @@ LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := bluetoothd-snoop
 
 include $(BUILD_EXECUTABLE)
+
+#
+# btmgmt
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	../tools/btmgmt.c \
+	../monitor/mainloop.c \
+	../lib/bluetooth.c \
+	../lib/sdp.c \
+	../src/eir.c \
+	../src/glib-helper.c \
+	../src/shared/io-mainloop.c \
+	../src/shared/mgmt.c \
+	../src/shared/queue.c \
+	../src/shared/util.c \
+
+LOCAL_C_INCLUDES := \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+	$(LOCAL_PATH)/.. \
+	$(LOCAL_PATH)/../src \
+	$(LOCAL_PATH)/../lib \
+
+LOCAL_SHARED_LIBRARIES := \
+	libglib \
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

