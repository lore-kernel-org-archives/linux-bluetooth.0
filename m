Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/13] android/hal-gatt-api: Add Server Service
Date: Thu, 27 Feb 2014 14:28:43 +0100
Message-Id: <1393507731-1974-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393507731-1974-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 14 ++++++++++++++
 android/hal-msg.h       |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 7c89e9c..9b1f8a6 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1693,6 +1693,20 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x1b - Add Service command/response
+
+		Command parameters: Server (4 octets)
+		                    GATT Service ID (18 octets)
+		                    Number of Handles (4 octet)
+
+		Valid GATT Service ID: GATT ID (17 octets)
+		                       Is Primary (1 octet)
+
+		Valid GATT ID: UUID (16 octets)
+		               Instance ID (1 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x1c - Add Included Service command/response
 	Opcode 0x1d - Add Characteristic command/response
 	Opcode 0x1e - Add Descriptor command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 983a017..cb93514 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -726,6 +726,13 @@ struct hal_cmd_gatt_server_disconnect {
 	int32_t conn_id;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_SERVER_ADD_SERVICE		0x1b
+struct hal_cmd_gatt_server_add_service {
+	int32_t server_if;
+	struct hal_gatt_srvc_id srvc_id;
+	int32_t num_handles;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.8.5.2

