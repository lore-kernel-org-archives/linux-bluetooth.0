Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/13] android/hal-gatt-api: Add Server Register
Date: Thu, 27 Feb 2014 14:28:39 +0100
Message-Id: <1393507731-1974-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 9b2c8ae..25428f0 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1661,6 +1661,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x17 - Register Server command/response
+
+		Command parameters: UUID (16 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x18 - Unregister Server command/response
 	Opcode 0x19 - Connect Peripheral command/response
 	Opcode 0x1a - Disconnect Peripheral command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e128553..e0bfd87 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -702,6 +702,11 @@ struct hal_cmd_gatt_client_test_command {
 	struct hal_gatt_test_params params;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_REGISTER		0x17
+struct hal_cmd_gatt_server_register {
+	uint8_t uuid[16];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

