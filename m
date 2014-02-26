Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 17/23] android/hal-gatt-api: Add Client Execute Write
Date: Wed, 26 Feb 2014 09:41:15 +0100
Message-Id: <1393404081-1401-18-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index fb7a180..885a920 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1587,6 +1587,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x10 - Execute Write command/response
+
+		Command parameters: Connection ID (4 octets)
+		                    Execute (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x11 - Register For Notification command/response
 	Opcode 0x12 - Deregister For Notification command/response
 	Opcode 0x13 - Read Remote RSSI command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 294a3d0..5e63713 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -640,6 +640,12 @@ struct hal_cmd_gatt_client_write_descriptor {
 	uint8_t value[0];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_EXECUTE_WRITE	0x10
+struct hal_cmd_gatt_client_execute_write {
+	int32_t conn_id;
+	int32_t execute;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

