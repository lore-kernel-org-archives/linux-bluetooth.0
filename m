Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/13] android/hal-gatt-api: Add Server Unregister
Date: Thu, 27 Feb 2014 14:28:40 +0100
Message-Id: <1393507731-1974-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 25428f0..176f325 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1668,6 +1668,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x18 - Unregister Server command/response
+
+		Command parameters: Server (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x19 - Connect Peripheral command/response
 	Opcode 0x1a - Disconnect Peripheral command/response
 	Opcode 0x1b - Add Service command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e0bfd87..f0fae01 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -707,6 +707,11 @@ struct hal_cmd_gatt_server_register {
 	uint8_t uuid[16];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_UNREGISTER		0x18
+struct hal_cmd_gatt_server_unregister {
+	int32_t server_if;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

