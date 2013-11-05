Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Add Android Makefile for btmon
Date: Tue,  5 Nov 2013 11:46:52 +0200
Message-Id: <1383644812-24537-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Build btmon for Android image. btmon requires fresh bionic to build.
---
 android/Android.mk |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 77fd5a0..86af7b6 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -145,3 +145,58 @@ LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE := haltest
 
 include $(BUILD_EXECUTABLE)
+
+#
+# btmon
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	../monitor/main.c \
+	../monitor/bt.h \
+	../monitor/mainloop.h \
+	../monitor/mainloop.c \
+	../monitor/display.h \
+	../monitor/display.c \
+	../monitor/hcidump.h \
+	../monitor/hcidump.c \
+	../monitor/btsnoop.h \
+	../monitor/btsnoop.c \
+	../monitor/control.h \
+	../monitor/control.c \
+	../monitor/packet.h \
+	../monitor/packet.c \
+	../monitor/l2cap.h \
+	../monitor/l2cap.c \
+	../monitor/uuid.h \
+	../monitor/uuid.c \
+	../monitor/sdp.h \
+	../monitor/sdp.c \
+	../monitor/vendor.h \
+	../monitor/vendor.c \
+	../monitor/lmp.h \
+	../monitor/lmp.c \
+	../monitor/crc.h \
+	../monitor/crc.c \
+	../monitor/ll.h \
+	../monitor/ll.c \
+	../lib/hci.c \
+	../lib/bluetooth.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/.. \
+	$(LOCAL_PATH)/../lib \
+	$(LOCAL_PATH)/../src/shared \
+
+LOCAL_C_INCLUDES += \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := eng
+LOCAL_MODULE := btmon
+
+include $(BUILD_EXECUTABLE)
-- 
1.7.10.4

