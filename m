Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 07/13] android/hal-gatt-api: Add Client Listen
Date: Tue, 25 Feb 2014 12:08:26 +0100
Message-Id: <1393326512-16373-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index ffc903a..9021154 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1461,6 +1461,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x06 - Listen command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Start (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x07 - Refresh command/response
 	Opcode 0x08 - Search Service command/response
 	Opcode 0x09 - Get Included Service command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 22cfaf4..de714dd 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -989,3 +989,9 @@ struct hal_cmd_gatt_client_disconnect {
 	uint8_t bdaddr[6];
 	int32_t conn_id;
 } __attribute__((packed));
+
+#define HAL_OP_GATT_CLIENT_LISTEN		0x06
+struct hal_cmd_gatt_client_listen {
+	int32_t client_if;
+	uint8_t start;
+} __attribute__((packed));
-- 
1.9.0

