Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 09/23] android/hal-gatt-api: Add Client Search Service
Date: Wed, 26 Feb 2014 09:41:07 +0100
Message-Id: <1393404081-1401-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 10 ++++++++++
 android/hal-msg.h       |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 9a3c776..b5f302b 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1477,6 +1477,16 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x08 - Search Service command/response
+
+		Command parameters: Connection ID (4 octets)
+		                    Number of UUID Filters (1 octet)
+		                    UUID Filter (variable)
+		Valid Number of UUID Filters: 0x00
+		                              0x01
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x09 - Get Included Service command/response
 	Opcode 0x0a - Get Characteristic command/response
 	Opcode 0x0b - Get Descriptor command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 77155e3..dd799d2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -560,6 +560,13 @@ struct hal_cmd_gatt_client_refresh {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_SEARCH_SERVICE	0x08
+struct hal_cmd_gatt_client_search_service {
+	int32_t conn_id;
+	uint8_t number;
+	uint8_t filter_uuid[0];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

