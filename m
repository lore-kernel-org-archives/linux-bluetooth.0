Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 02/13] android/hal-gatt-api: Add Register Client
Date: Tue, 25 Feb 2014 12:08:21 +0100
Message-Id: <1393326512-16373-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 49d704e..70c451d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1421,6 +1421,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                     0x0a = Remote device down
 
 	Opcode 0x01 - Register Client command/response
+
+		Command parameters: Service UUID (16 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x02 - Unregister Client command/response
 	Opcode 0x03 - Scan command/response
 	Opcode 0x04 - Connect Device command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 836dbbf..6032aea 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -957,3 +957,10 @@ struct hal_ev_avrcp_passthrough_cmd {
 	uint8_t id;
 	uint8_t state;
 } __attribute__((packed));
+
+/* GAT CLIENT HAL API */
+
+#define HAL_OP_GATT_CLIENT_REGISTER		0x01
+struct hal_cmd_gatt_client_register {
+	uint8_t uuid[16];
+} __attribute__((packed));
-- 
1.9.0

