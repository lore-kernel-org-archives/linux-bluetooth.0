Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 12/13] android/hal-gatt-api: Add Client Get Descriptor
Date: Tue, 25 Feb 2014 12:08:31 +0100
Message-Id: <1393326512-16373-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 13 +++++++++++++
 android/hal-msg.h       |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index e490bd1..a6d23dd 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1517,6 +1517,19 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x0b - Get Descriptor command/response
+
+		Command parameters: Connection ID (4 octets)
+		                    Service ID (18 octets)
+		                    Number of GATT ID Elements (1 octet)
+		                    GATT ID Elements (variable)
+		Valid Service ID: as described in Get Included Service
+		Valid Number of GATT ID Elements: 0x01
+		                                  0x02
+		Valid GATT ID Element: as described in Get Included Service
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x0c - Read Characteristic command/response
 	Opcode 0x0d - Write Characteristic command/response
 	Opcode 0x0e - Read Descriptor command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index d0ebad8..576d4d5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1033,3 +1033,11 @@ struct hal_cmd_gatt_client_get_characteristic {
 	uint8_t number;
 	uint8_t gatt_id[0];
 } __attribute__((packed));
+
+#define HAL_OP_GATT_CLIENT_GET_DESCRIPTOR	0x0b
+struct hal_cmd_gatt_client_get_descroptor {
+	int32_t connection_id;
+	struct hal_gatt_srvc_id srvc_id;
+	uint8_t number;
+	uint8_t gatt_id[0];
+} __attribute__((packed));
-- 
1.9.0

