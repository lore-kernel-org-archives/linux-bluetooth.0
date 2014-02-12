Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/9] android/hal-ipc-api: Add Set Player Attributes Value Response
Date: Wed, 12 Feb 2014 16:48:13 +0200
Message-Id: <1392216494-30885-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
References: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 8 ++++++++
 android/hal-msg.h       | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 7c90928..b977957 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1273,6 +1273,14 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 		                0x06 = Genre
 		                0x06 = Duration
 
+	Opcode 0x08 - Set Player Attributes Value Response command/response
+
+		Command parameters: Status (1 octet)
+
+		In case of an error, the error response will be returned.
+
+		Valid status values: Same as in Get Play Status Response
+
 	Opcode 0x09 - Register Notification command/response
 
 	Opcode 0x81 - Get Play Status notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9f3c2a1..42b08cd 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -858,3 +858,8 @@ struct hal_cmd_avrcp_get_element_attrs_text {
 	uint8_t number;
 	struct hal_avrcp_player_setting_text values[0];
 } __attribute__((packed));
+
+#define HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE	0x08
+struct hal_cmd_avrcp_set_player_attrs_value {
+	uint8_t status;
+} __attribute__((packed));
-- 
1.8.5.3

