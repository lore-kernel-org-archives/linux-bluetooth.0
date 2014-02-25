Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 08/13] android/hal-gatt-api: Add Client Refresh Remote Cache
Date: Tue, 25 Feb 2014 12:08:27 +0100
Message-Id: <1393326512-16373-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 9021154..9a3c776 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1469,6 +1469,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x07 - Refresh command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Remote address (6 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x08 - Search Service command/response
 	Opcode 0x09 - Get Included Service command/response
 	Opcode 0x0a - Get Characteristic command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index de714dd..3a7ccd6 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -995,3 +995,9 @@ struct hal_cmd_gatt_client_listen {
 	int32_t client_if;
 	uint8_t start;
 } __attribute__((packed));
+
+#define HAL_OP_GATT_CLIENT_REFRESH		0x07
+struct hal_cmd_gatt_client_refresh {
+	int32_t client_if;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
-- 
1.9.0

