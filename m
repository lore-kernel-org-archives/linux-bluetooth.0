Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 13/14] android: Add makefile for hciconfig
Date: Thu,  3 Oct 2013 17:38:19 +0300
Message-Id: <1380811100-30144-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380811100-30144-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380811100-30144-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/Android.mk |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 5ac68ba..38f8f33 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -120,3 +120,37 @@ $(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/../lib/bl
 LOCAL_MODULE := libbluetooth
 
 include $(BUILD_SHARED_LIBRARY)
+
+#
+# hciconfig
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	../tools/csr.c \
+	../tools/csr_h4.c \
+	../tools/hciconfig.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/../lib \
+	$(LOCAL_PATH)/../src \
+
+LOCAL_C_INCLUDES += \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_SHARED_LIBRARIES := \
+	libbluetooth
+
+# to suppress the "pointer of type 'void *' used in arithmetic" warning
+LOCAL_CFLAGS := -Wno-pointer-arith
+
+# to suppress the "warning: missing initializer near initialization.." warning
+LOCAL_CFLAGS += -Wno-missing-field-initializers
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := eng
+LOCAL_MODULE := hciconfig
+
+include $(BUILD_EXECUTABLE)
-- 
1.7.10.4

