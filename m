Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/13] android/hal-gatt-api: Add Server Send Indication
Date: Thu, 27 Feb 2014 14:28:50 +0100
Message-Id: <1393507731-1974-13-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 11 +++++++++++
 android/hal-msg.h       | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index fac614e..18bf7ed 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1763,6 +1763,17 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x22 - Send Indication command/response
+
+		Command parameters: Server (4 octets)
+		                    Attribute handle (4 octets)
+		                    Connection ID (4 octets)
+		                    Length (4 octets)
+		                    Confirmation (4 octets)
+		                    Value (variable)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x23 - Send Response command/response
 
 	Opcode 0x81 - Register Client notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 6598996..fd67fa1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -776,6 +776,16 @@ struct hal_cmd_gatt_server_delete_service {
 	int32_t service_handle;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_SEND_INDICATION	0x22
+struct hal_cmd_gatt_server_send_indication {
+	int32_t server_if;
+	int32_t attribute_handle;
+	int32_t conn_id;
+	int32_t len;
+	int32_t confirm;
+	uint8_t value[0];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

