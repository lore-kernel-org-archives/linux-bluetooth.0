Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 03/13] android/hal-gatt-api: Add Unregister Client
Date: Tue, 25 Feb 2014 12:08:22 +0100
Message-Id: <1393326512-16373-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393326512-16373-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 70c451d..53fa5b9 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1428,6 +1428,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x02 - Unregister Client command/response
+
+		Command parameters: Client Interface (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x03 - Scan command/response
 	Opcode 0x04 - Connect Device command/response
 	Opcode 0x05 - Disconnect Device command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 6032aea..4587142 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -964,3 +964,8 @@ struct hal_ev_avrcp_passthrough_cmd {
 struct hal_cmd_gatt_client_register {
 	uint8_t uuid[16];
 } __attribute__((packed));
+
+#define HAL_OP_GATT_CLIENT_UNREGISTER		0x02
+struct hal_cmd_gatt_client_unregister {
+	int32_t client_if;
+} __attribute__((packed));
-- 
1.9.0

