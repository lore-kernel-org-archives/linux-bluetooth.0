Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/13] android/hal-gatt-api: Add Server Included Service
Date: Thu, 27 Feb 2014 14:28:44 +0100
Message-Id: <1393507731-1974-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 8 ++++++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 9b1f8a6..c6b573a 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1708,6 +1708,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x1c - Add Included Service command/response
+
+		Command parameters: Server (4 octets)
+		                    Service handle (4 octets)
+		                    Included handle (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x1d - Add Characteristic command/response
 	Opcode 0x1e - Add Descriptor command/response
 	Opcode 0x1f - Start Service command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index cb93514..4f0ae30 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -733,6 +733,13 @@ struct hal_cmd_gatt_server_add_service {
 	int32_t num_handles;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_ADD_INC_SERVICE	0x1c
+struct hal_cmd_gatt_server_add_inc_service {
+	int32_t server_if;
+	int32_t service_handle;
+	int32_t included_handle;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

