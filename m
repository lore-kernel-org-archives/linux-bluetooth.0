Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 04/23] android/hal-gatt-api: Add Client Scan
Date: Wed, 26 Feb 2014 09:41:02 +0100
Message-Id: <1393404081-1401-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
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
index 856d694..089c950 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -528,6 +528,12 @@ struct hal_cmd_gatt_client_unregister {
 	int32_t client_if;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_SCAN			0x03
+struct hal_cmd_gatt_client_scan {
+	int32_t client_if;
+	uint8_t start;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

