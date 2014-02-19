Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 01/14] android/hal-ipc-api: Add Set Volume command
Date: Wed, 19 Feb 2014 18:58:45 +0200
Message-Id: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
v2: Use fixed buffers instead of allocating memory for ipc commands, also
change to use variable length for text attributes to avoid having to define a
huge MTU which in most cases would be filled with 0.

 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index ee3bd76..ea26d0d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1300,6 +1300,12 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 		Valid type values : 0x00 = Interim
 		                    0x01 = Changed
 
+	Opcode 0x0a - Set Volume command/response
+
+		Command parameters: Value (1 octet)
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x81 - Remote Features notification
 
 		Notification parameters: Remote address (6 octets)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 6504408..9d396a1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -882,6 +882,11 @@ struct hal_cmd_avrcp_register_notification {
 	uint8_t data[0];
 } __attribute__((packed));
 
+#define HAL_OP_AVRCP_SET_VOLUME			0x0a
+struct hal_cmd_avrcp_set_volume {
+	uint8_t value;
+};
+
 #define HAL_EV_AVRCP_REMOTE_FEATURES		0x81
 struct hal_ev_avrcp_remote_features {
 	uint8_t bdaddr[6];
-- 
1.8.5.3

