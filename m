Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 2/4] android: Fix build dependency of bluetooth.default.so HAL on target
Date: Wed, 23 Oct 2013 11:50:38 +0300
Message-Id: <1382518240-31896-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382518240-31896-1-git-send-email-luiz.dentz@gmail.com>
References: <1382518240-31896-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing headers necessary to build bluetooth.default.so
---
 android/Android.mk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index d67a62d..6d707c2 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -66,7 +66,8 @@ include $(BUILD_EXECUTABLE)
 include $(CLEAR_VARS)
 
 LOCAL_SRC_FILES := \
-	hal-ipc.c \
+	hal.h hal-msg.h hal-log.h \
+	hal-ipc.c hal-ipc.h \
 	hal-bluetooth.c \
 	hal-sock.c \
 	hal-hidhost.c \
-- 
1.8.3.1

