Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/13] android/hal-gatt-api: Add Server Stop Service
Date: Thu, 27 Feb 2014 14:28:48 +0100
Message-Id: <1393507731-1974-11-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 812aac2..3104c06 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1747,6 +1747,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x20 - Stop Service command/response
+
+		Command parameters: Server (4 octets)
+		                    Service handle (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x21 - Delete Service command/response
 	Opcode 0x22 - Send Indication command/response
 	Opcode 0x23 - Send Response command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index d632911..0253f3a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -764,6 +764,12 @@ struct hal_cmd_gatt_server_start_service {
 	int32_t transport;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_STOP_SERVICE		0x20
+struct hal_cmd_gatt_server_stop_service {
+	int32_t server_if;
+	int32_t service_handle;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

