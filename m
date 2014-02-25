Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 05/13] android/hal-gatt-api: Add Client Connect Remote
Date: Tue, 25 Feb 2014 12:08:24 +0100
Message-Id: <1393326512-16373-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 8 ++++++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 51aaba1..bbb94a9 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1443,6 +1443,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x04 - Connect Device command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Remote address (6 octets)
+		                    Is Direct (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x05 - Disconnect Device command/response
 	Opcode 0x06 - Listen command/response
 	Opcode 0x07 - Refresh command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0c6df68..032c6f1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -975,3 +975,10 @@ struct hal_cmd_gatt_client_scan {
 	int32_t client_if;
 	uint8_t start;
 } __attribute__((packed));
+
+#define HAL_OP_GATT_CLIENT_CONNECT		0x04
+struct hal_cmd_gatt_client_connect {
+	int32_t client_if;
+	uint8_t bdaddr[6];
+	uint8_t is_direct;
+} __attribute__((packed));
-- 
1.9.0

