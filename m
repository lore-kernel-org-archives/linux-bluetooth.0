Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/2] android: Add "eSCO transparent data is mSBC" mode
Date: Thu, 13 Mar 2014 23:52:14 +0100
Message-Id: <1394751135-2747-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is usefull for platforms that assume transparent eSCO data is
mSBC e.g. Nexus 4.
---
 android/hal-ipc-api.txt | 1 +
 android/hal-msg.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index e4a4e9c..acfb8a0 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -757,6 +757,7 @@ Bluetooth Handsfree HAL (ID 5)
 Android HAL name: "handsfree" (BT_PROFILE_HANDSFREE_ID)
 
 	Service modes:               0x01 = Headset Profile only mode
+	                             0x02 = eSCO transparent data is mSBC mode
 
 Commands and responses:
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0abbbe6..c3a96d5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -386,6 +386,7 @@ struct hal_cmd_pan_disconnect {
 /* Handsfree HAL API */
 
 #define HAL_MODE_HANDSFREE_HSP_ONLY		0x01
+#define HAL_MODE_HANDSFREE_ESCO_MSBC		0x02
 
 #define HAL_OP_HANDSFREE_CONNECT		0x01
 struct hal_cmd_handsfree_connect {
-- 
1.9.0

