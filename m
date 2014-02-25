Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 13/13] android/hal-gatt-api: Add Read Characteristic
Date: Tue, 25 Feb 2014 12:08:32 +0100
Message-Id: <1393326512-16373-13-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 11 +++++++++++
 android/hal-msg.h       |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index a6d23dd..5349c53 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1531,6 +1531,17 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x0c - Read Characteristic command/response
+
+		Command parameters: Connection ID (4 octets)
+		                    Service ID (18 octets)
+		                    GATT ID (17 octets)
+		                    Authorization (4 octets)
+		Valid Service ID: as described in Get Included Service
+		Valid GATT ID: as described in Get Included Service
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x0d - Write Characteristic command/response
 	Opcode 0x0e - Read Descriptor command/response
 	Opcode 0x0f - Write Descriptor command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 576d4d5..e7a5b6d 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1041,3 +1041,11 @@ struct hal_cmd_gatt_client_get_descroptor {
 	uint8_t number;
 	uint8_t gatt_id[0];
 } __attribute__((packed));
+
+#define HAL_OP_GATT_CLIENT_READ_CHARACTERISTIC	0x0c
+struct hal_cmd_gatt_client_read_characteristic {
+	int32_t connection_id;
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_gatt_id gatt_id;
+	int32_t authorization;
+} __attribute__((packed));
-- 
1.9.0

