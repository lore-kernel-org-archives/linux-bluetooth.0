Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 21/23] android/hal-gatt-api: Add Client Get Device Type
Date: Wed, 26 Feb 2014 09:41:19 +0100
Message-Id: <1393404081-1401-22-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 2a40fc1..259aa69 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1623,6 +1623,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x14 - Get Device Type command/response
+
+		Command parameters: Remote address (6 octets)
+
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x15 - Set Advertising data command/response
 	Opcode 0x16 - Test Command command/response
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ec02999..316ca62 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -668,6 +668,11 @@ struct hal_cmd_gatt_client_read_remote_rssi {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_GET_DEVICE_TYPE	0x14
+struct hal_cmd_gatt_client_get_device_type {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

