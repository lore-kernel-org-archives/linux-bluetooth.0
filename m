Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 15/15] android: Add makefile for hcitool
Date: Mon,  7 Oct 2013 10:38:16 +0300
Message-Id: <1381131496-9417-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/Android.mk |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 09c4579..5798749 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -157,3 +157,41 @@ LOCAL_MODULE_TAGS := eng
 LOCAL_MODULE := hciconfig
 
 include $(BUILD_EXECUTABLE)
+
+#
+# hcitool
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	../tools/hcitool.c \
+	../src/oui.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/../lib \
+	$(LOCAL_PATH)/../src \
+
+LOCAL_C_INCLUDES += \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_CFLAGS := \
+	-DSTORAGEDIR=\"/tmp\" \
+	-DVERSION=\"$(BLUEZ_VERSION)\"
+
+# to suppress the "pointer of type 'void *' used in arithmetic" warning
+LOCAL_CFLAGS += -Wno-pointer-arith
+
+# to suppress the "warning: missing initializer near initialization.." warning
+LOCAL_CFLAGS += -Wno-missing-field-initializers
+
+LOCAL_SHARED_LIBRARIES := \
+	libbluetooth \
+	libglib \
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := eng
+LOCAL_MODULE := hcitool
+
+include $(BUILD_EXECUTABLE)
-- 
1.7.10.4

