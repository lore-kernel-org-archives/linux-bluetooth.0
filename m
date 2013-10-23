Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android: Fix build dependency of bluetooth.default.so HAL on target
Date: Wed, 23 Oct 2013 10:58:16 +0300
Message-Id: <1382515098-28782-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382515098-28782-1-git-send-email-luiz.dentz@gmail.com>
References: <1382515098-28782-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing headers necessary to build bluetooth.default.so
---
 android/Android.mk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index a00b658..cdc99a8 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -54,7 +54,8 @@ include $(BUILD_EXECUTABLE)
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

