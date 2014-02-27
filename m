Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/13] android/hal-gatt-api: Add Server Descriptor
Date: Thu, 27 Feb 2014 14:28:46 +0100
Message-Id: <1393507731-1974-9-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 9 +++++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index b5175ca..24ff5de 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1728,6 +1728,15 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x1e - Add Descriptor command/response
+
+		Command parameters: Server (4 octets)
+		                    Service handle (4 octets)
+		                    UUID (16 octets)
+		                    Permissions (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x1f - Start Service command/response
 	Opcode 0x20 - Stop Service command/response
 	Opcode 0x21 - Delete Service command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 88228ad..e42b0a5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -749,6 +749,14 @@ struct hal_cmd_gatt_server_add_characteristic {
 	int32_t permissions;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_ADD_DESCRIPTOR	0x1e
+struct hal_cmd_gatt_server_add_descriptor {
+	int32_t server_if;
+	int32_t service_handle;
+	uint8_t uuid[16];
+	int32_t permissions;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

