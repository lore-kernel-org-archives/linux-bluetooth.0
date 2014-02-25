Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 04/13] android/hal-gatt-api: Add Client Scan
Date: Tue, 25 Feb 2014 12:08:23 +0100
Message-Id: <1393326512-16373-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 53fa5b9..51aaba1 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1435,6 +1435,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x03 - Scan command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Start (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x04 - Connect Device command/response
 	Opcode 0x05 - Disconnect Device command/response
 	Opcode 0x06 - Listen command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4587142..0c6df68 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -969,3 +969,9 @@ struct hal_cmd_gatt_client_register {
 struct hal_cmd_gatt_client_unregister {
 	int32_t client_if;
 } __attribute__((packed));
+
+#define HAL_OP_GATT_CLIENT_SCAN			0x03
+struct hal_cmd_gatt_client_scan {
+	int32_t client_if;
+	uint8_t start;
+} __attribute__((packed));
-- 
1.9.0

