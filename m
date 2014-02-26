Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 19/23] android/hal-gatt-api: Add Client Deregister for Notification
Date: Wed, 26 Feb 2014 09:41:17 +0100
Message-Id: <1393404081-1401-20-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 9 +++++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 3c9319d..026ed03 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1605,6 +1605,15 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x12 - Deregister For Notification command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Remote address (6 octets)
+		                    Service ID (18 octets)
+		                    GATT ID (17 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x13 - Read Remote RSSI command/response
 	Opcode 0x14 - Get Device Type command/response
 	Opcode 0x15 - Set Advertising data command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ce26319..36d5a79 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -654,6 +654,14 @@ struct hal_cmd_gatt_client_register_for_notification {
 	struct hal_gatt_gatt_id char_id;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION	0x12
+struct hal_cmd_gatt_client_deregister_for_notification {
+	int32_t client_if;
+	uint8_t bdaddr[6];
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_gatt_id char_id;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

