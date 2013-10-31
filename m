Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/haltest: Use Android system headers instead of local
Date: Thu, 31 Oct 2013 10:37:19 +0200
Message-Id: <1383208640-6644-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/Android.mk |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 3c4a825..e47f4a9 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -121,6 +121,10 @@ LOCAL_SRC_FILES := \
 	client/if-pan.c \
 	client/if-sock.c \
 
+LOCAL_C_INCLUDES += \
+	$(call include-path-for, system-core) \
+	$(call include-path-for, libhardware) \
+
 LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
 
 LOCAL_SHARED_LIBRARIES := libhardware
-- 
1.7.10.4

