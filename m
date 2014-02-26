Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 15/23] android/hal-gatt-api: Add Client Read Descriptor
Date: Wed, 26 Feb 2014 09:41:13 +0100
Message-Id: <1393404081-1401-16-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 12 ++++++++++++
 android/hal-msg.h       |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 0a06e5e..7064bb7 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1558,6 +1558,18 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x0e - Read Descriptor command/response
+
+		Command parameters: Connection ID (4 octets)
+		                    Service ID (18 octets)
+		                    GATT ID (17 octets)
+		                    Descr. GATT ID (17 octets)
+		                    Authorization Req. (4 octets)
+		Valid Service ID: as described in Get Included Service
+		Valid GATT ID: as described in Get Included Service
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x0f - Write Descriptor command/response
 	Opcode 0x10 - Execute Write command/response
 	Opcode 0x11 - Register For Notification command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 51e2fd9..f6d8abd 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -619,6 +619,15 @@ struct hal_cmd_gatt_client_write_characteristic {
 	uint8_t value[0];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_READ_DESCRIPTOR	0x0e
+struct hal_cmd_gatt_client_read_descriptor {
+	int32_t conn_id;
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_gatt_id char_id;
+	struct hal_gatt_gatt_id descr_id;
+	int32_t auth_req;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

