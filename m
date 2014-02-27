Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/13] android/hal-gatt-api: Add Server Send Response
Date: Thu, 27 Feb 2014 14:28:51 +0100
Message-Id: <1393507731-1974-14-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 17 +++++++++++++++++
 android/hal-msg.h       |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 18bf7ed..f3d5fd1 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1776,6 +1776,23 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 	Opcode 0x23 - Send Response command/response
 
+		Command parameters: Connection ID (4 octets)
+		                    Transaction ID (4 octets)
+		                    Status (4 octets)
+		                    GATT Response (4 octets)
+
+		Valid GATT Response: GATT Value (607 octets)
+		                     Handle (2 octets)
+
+		Valid GATT Value: Value (600 octets)
+		                  Handle (2 octets)
+		                  Offset (2 octets)
+		                  Length (2 octets)
+		                  Authentication Request (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x81 - Register Client notification
 	Opcode 0x82 - Scan Result notification
 	Opcode 0x83 - Connect Device notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index fd67fa1..100ba96 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -786,6 +786,15 @@ struct hal_cmd_gatt_server_send_indication {
 	uint8_t value[0];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_SEND_RESPONSE	0x23
+struct hal_cmd_gatt_server_send_response {
+	int32_t conn_id;
+	int32_t trans_id;
+	int32_t status;
+	uint8_t len;
+	uint8_t data[0];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

