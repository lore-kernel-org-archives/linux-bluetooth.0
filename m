Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 20/23] android/hal-gatt-api: Add Client Read Remote RSSI
Date: Wed, 26 Feb 2014 09:41:18 +0100
Message-Id: <1393404081-1401-21-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 026ed03..2a40fc1 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1615,6 +1615,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x13 - Read Remote RSSI command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Remote address (6 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x14 - Get Device Type command/response
 	Opcode 0x15 - Set Advertising data command/response
 	Opcode 0x16 - Test Command command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 36d5a79..ec02999 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -662,6 +662,12 @@ struct hal_cmd_gatt_client_deregister_for_notification {
 	struct hal_gatt_gatt_id char_id;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_READ_REMOTE_RSSI	0x13
+struct hal_cmd_gatt_client_read_remote_rssi {
+	int32_t client_if;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

