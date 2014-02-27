Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/13] android/hal-gatt-api: Add Server Disconnect
Date: Thu, 27 Feb 2014 14:28:42 +0100
Message-Id: <1393507731-1974-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 8 ++++++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index f28ff8a..7c89e9c 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1684,6 +1684,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x1a - Disconnect Peripheral command/response
+
+		Command parameters: Server (4 octets)
+		                    Remote address (6 octes)
+		                    Connection ID (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x1b - Add Service command/response
 	Opcode 0x1c - Add Included Service command/response
 	Opcode 0x1d - Add Characteristic command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index b423a94..983a017 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -719,6 +719,13 @@ struct hal_cmd_gatt_server_connect {
 	uint8_t is_direct;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_DISCONNECT		0x1a
+struct hal_cmd_gatt_server_disconnect {
+	int32_t server_if;
+	uint8_t bdaddr[6];
+	int32_t conn_id;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

