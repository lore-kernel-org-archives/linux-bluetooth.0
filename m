Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 06/23] android/hal-gatt-api: Add Client Disconnect Remote
Date: Wed, 26 Feb 2014 09:41:04 +0100
Message-Id: <1393404081-1401-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 8 ++++++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index bbb94a9..ffc903a 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1452,6 +1452,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x05 - Disconnect Device command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Remote address (6 octets)
+		                    Connection ID (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x06 - Listen command/response
 	Opcode 0x07 - Refresh command/response
 	Opcode 0x08 - Search Service command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 22b65c2..d8a990d 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -541,6 +541,13 @@ struct hal_cmd_gatt_client_connect {
 	uint8_t is_direct;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_DISCONNECT		0x05
+struct hal_cmd_gatt_client_disconnect {
+	int32_t client_if;
+	uint8_t bdaddr[6];
+	int32_t conn_id;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

