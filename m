Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 08/14] android: Add Android Makefile for libbluetooth
Date: Tue,  1 Oct 2013 18:03:13 +0300
Message-Id: <1380639799-25790-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380639799-25790-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Build libbluetooth library for Android.
---
 android/Android.mk |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 99c497a..11ac204 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -54,3 +54,58 @@ LOCAL_MODULE_TAGS := optional
 LOCAL_MODULE_CLASS := SHARED_LIBRARIES
 
 include $(BUILD_SHARED_LIBRARY)
+
+#
+# libbluetooth library
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	../lib/bluetooth.c \
+	../lib/sdp.c \
+	../lib/hci.c \
+	../lib/uuid.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/../lib/ \
+	$(LOCAL_PATH)/../src/shared \
+
+LOCAL_C_INCLUDES += \
+	$(call include-path-for, glib) \
+	$(call include-path-for, glib)/glib \
+
+LOCAL_CFLAGS += -O3
+
+# to suppress the "pointer of type 'void *' used in arithmetic" warning
+LOCAL_CFLAGS += -Wno-pointer-arith
+
+# to suppress the "missing initializer near initialization" warning
+LOCAL_CFLAGS += -Wno-missing-field-initializers
+
+# to suppress the "may be used uninitialized in this function" warning
+LOCAL_CFLAGS += -Wno-maybe-uninitialized
+
+# Define missing flags for Android 4.2
+LOCAL_CFLAGS += -DSOCK_CLOEXEC=02000000 -DSOCK_NONBLOCK=04000
+
+lib_headers := \
+	bluetooth.h \
+	hci.h \
+	hci_lib.h \
+	sco.h \
+	l2cap.h \
+	sdp.h \
+	sdp_lib.h \
+	rfcomm.h \
+	bnep.h \
+	cmtp.h \
+	hidp.h \
+
+$(shell mkdir -p $(LOCAL_PATH)/bluetooth)
+
+$(foreach file,$(lib_headers), $(shell ln -sf ../$(file) $(LOCAL_PATH)/bluetooth/$(file)))
+
+LOCAL_MODULE := libbluetooth
+
+include $(BUILD_SHARED_LIBRARY)
-- 
1.7.10.4

