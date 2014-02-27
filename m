Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/13] android/hal-gatt-api: Add Server Start Service
Date: Thu, 27 Feb 2014 14:28:47 +0100
Message-Id: <1393507731-1974-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 8 ++++++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 24ff5de..812aac2 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1738,6 +1738,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x1f - Start Service command/response
+
+		Command parameters: Server (4 octets)
+		                    Service handle (4 octets)
+		                    Transport (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x20 - Stop Service command/response
 	Opcode 0x21 - Delete Service command/response
 	Opcode 0x22 - Send Indication command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e42b0a5..d632911 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -757,6 +757,13 @@ struct hal_cmd_gatt_server_add_descriptor {
 	int32_t permissions;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_START_SERVICE	0x1f
+struct hal_cmd_gatt_server_start_service {
+	int32_t server_if;
+	int32_t service_handle;
+	int32_t transport;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

