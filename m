Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 18/23] android/hal-gatt-api: Add Client Register for Notification
Date: Wed, 26 Feb 2014 09:41:16 +0100
Message-Id: <1393404081-1401-19-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 9 +++++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 885a920..3c9319d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1595,6 +1595,15 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x11 - Register For Notification command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Remote address (6 octets)
+		                    Service ID (18 octets)
+		                    GATT ID (17 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x12 - Deregister For Notification command/response
 	Opcode 0x13 - Read Remote RSSI command/response
 	Opcode 0x14 - Get Device Type command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5e63713..ce26319 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -646,6 +646,14 @@ struct hal_cmd_gatt_client_execute_write {
 	int32_t execute;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION	0x11
+struct hal_cmd_gatt_client_register_for_notification {
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

