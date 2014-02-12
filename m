Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/9] android/hal-ipc-api: Add Get Player Attributes Text Response
Date: Wed, 12 Feb 2014 16:48:10 +0200
Message-Id: <1392216494-30885-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
References: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 13 ++++++++++++-
 android/hal-msg.h       | 11 +++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 27060d5..496851c 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1235,7 +1235,18 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid attributes: Same as in List Player Attributes
 
-	Opcode 0x05 - Get Player Application Attributes Text command/response
+	Opcode 0x05 - Get Player Attributes Text Response command/response
+
+		Command parameters: Number of attributes (1 octet)
+		                    Attribute # (1 octet)
+		                    Attribute # text length (1 octet)
+		                    Attribute # text (variable)
+		                    ...
+
+		In case of an error, the error response will be returned.
+
+		Valid attributes: Same as in List Player Attributes
+
 	Opcode 0x06 - Get Player Application Values Text command/response
 	Opcode 0x07 - Get Element Attributes Text command/response
 	Opcode 0x08 - Set Player Attributes Value command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 753f5a3..2891a3a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -827,3 +827,14 @@ struct hal_cmd_avrcp_get_player_attrs {
 	uint8_t number;
 	struct hal_avrcp_player_attr_value attrs[0];
 } __attribute__((packed));
+
+struct hal_avrcp_player_setting_text {
+	uint8_t id;
+	uint8_t text[255];
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT	0x05
+struct hal_cmd_avrcp_get_player_attrs_text {
+	uint8_t number;
+	struct hal_avrcp_player_setting_text attrs[0];
+} __attribute__((packed));
-- 
1.8.5.3

