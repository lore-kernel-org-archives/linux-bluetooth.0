Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 09/13] android/hal-gatt-api: Add Client Search Service
Date: Tue, 25 Feb 2014 12:08:28 +0100
Message-Id: <1393326512-16373-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
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
index 3a7ccd6..0f2b011 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1001,3 +1001,10 @@ struct hal_cmd_gatt_client_refresh {
 	int32_t client_if;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+#define HAL_OP_GATT_CLIENT_SEARCH_SERVICE	0x08
+struct hal_cmd_gatt_client_search_service {
+	int32_t conn_id;
+	uint8_t number;
+	uint8_t  uuid[0];
+} __attribute__((packed));
-- 
1.9.0

