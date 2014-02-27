Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/13] android/hal-gatt-api: Add Server Connect
Date: Thu, 27 Feb 2014 14:28:41 +0100
Message-Id: <1393507731-1974-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 8 ++++++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 176f325..f28ff8a 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1675,6 +1675,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x19 - Connect Peripheral command/response
+
+		Command parameters: Server (4 octets)
+		                    Remote address (6 octes)
+		                    Is Direct (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x1a - Disconnect Peripheral command/response
 	Opcode 0x1b - Add Service command/response
 	Opcode 0x1c - Add Included Service command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index f0fae01..b423a94 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -712,6 +712,13 @@ struct hal_cmd_gatt_server_unregister {
 	int32_t server_if;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_CONNECT		0x19
+struct hal_cmd_gatt_server_connect {
+	int32_t server_if;
+	uint8_t bdaddr[6];
+	uint8_t is_direct;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

