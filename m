Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 2/2] android: Add l2ping to debug builds
Date: Tue, 21 Jan 2014 20:46:10 +0100
Message-Id: <1390333570-13196-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1390333570-13196-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390333570-13196-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Android.mk | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index e3a31c1..3b8d471 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -326,3 +326,25 @@ LOCAL_MODULE_TAGS := debug
 LOCAL_MODULE := btmgmt
 
 include $(BUILD_EXECUTABLE)
+
+#
+# l2ping
+#
+
+include $(CLEAR_VARS)
+
+LOCAL_SRC_FILES := \
+	../tools/l2ping.c \
+	../lib/bluetooth.c \
+	../lib/hci.c \
+
+LOCAL_C_INCLUDES := \
+	$(LOCAL_PATH)/../lib \
+
+LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
+
+LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
+LOCAL_MODULE_TAGS := debug
+LOCAL_MODULE := l2ping
+
+include $(BUILD_EXECUTABLE)
-- 
1.8.5.2

