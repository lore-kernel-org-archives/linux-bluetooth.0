Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/6] android/ipc: Add command to enable HFP in handsfree HAL
Date: Fri, 28 Feb 2014 17:19:29 +0100
Message-Id: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command will be used to enable HFP support in handsfree HAL.
---
 android/hal-ipc-api.txt | 2 ++
 android/hal-msg.h       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 1a19c80..54f6783 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -935,6 +935,8 @@ Android HAL name: "handsfree" (BT_PROFILE_HANDSFREE_ID)
 
 		In case of an error, the error response will be returned.
 
+	Opcode 0x0f - Enable Handsfree Profile command/response
+
 Notifications:
 
 	Opcode 0x81 - Connection State notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1e12868..cbb0f14 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -783,6 +783,8 @@ struct hal_cmd_gatt_server_send_response {
 	uint8_t data[0];
 } __attribute__((packed));
 
+#define HAL_OP_HANDSFREE_ENABLE_HFP		0x0F
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.3.2

