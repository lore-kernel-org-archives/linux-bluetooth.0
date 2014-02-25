Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 10/13] android/hal-gatt-api: Add Client Get Included Service
Date: Tue, 25 Feb 2014 12:08:29 +0100
Message-Id: <1393326512-16373-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 14 ++++++++++++++
 android/hal-msg.h       | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index b5f302b..13974c7 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1488,6 +1488,20 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x09 - Get Included Service command/response
+
+		Command parameters: Connection ID (4 octets)
+		                    Number of Service ID Elements (1 octet)
+		                    Service ID Elements (variable)
+		Valid Number of Service ID Elements: 0x01
+		                                     0x02
+		Valid Service ID Element: GATT ID (17 octets)
+		                          Is Primary (1 octet)
+		Valid GATT ID: UUID (16 octets)
+		               Instance ID (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x0a - Get Characteristic command/response
 	Opcode 0x0b - Get Descriptor command/response
 	Opcode 0x0c - Read Characteristic command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0f2b011..cd13b0c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1008,3 +1008,20 @@ struct hal_cmd_gatt_client_search_service {
 	uint8_t number;
 	uint8_t  uuid[0];
 } __attribute__((packed));
+
+#define HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE	0x09
+struct hal_gatt_gatt_id {
+	uint8_t uuid[16];
+	uint8_t inst_id;
+} __attribute__((packed));
+
+struct hal_gatt_srvc_id {
+	struct hal_gatt_gatt_id gatt_id;
+	uint8_t is_primary;
+} __attribute__((packed));
+
+struct hal_cmd_gatt_client_get_service {
+	int32_t conn_id;
+	uint8_t number;
+	uint8_t srvc_id[0];
+} __attribute__((packed));
-- 
1.9.0

