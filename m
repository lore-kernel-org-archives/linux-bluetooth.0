Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/9] android/hal-ipc-api: Add Get Player Attributes Response
Date: Wed, 12 Feb 2014 16:48:09 +0200
Message-Id: <1392216494-30885-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
References: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 12 +++++++++++-
 android/hal-msg.h       | 11 +++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 2e4ecbe..27060d5 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1224,7 +1224,17 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x04 - Get Player Application Values command/response
+	Opcode 0x04 - Get Player Values Response command/response
+
+		Command parameters: Number of attributes (1 octet)
+		                    Attribute # (1 octet)
+		                    Value # (1 octet)
+		                    ...
+
+		In case of an error, the error response will be returned.
+
+		Valid attributes: Same as in List Player Attributes
+
 	Opcode 0x05 - Get Player Application Attributes Text command/response
 	Opcode 0x06 - Get Player Application Values Text command/response
 	Opcode 0x07 - Get Element Attributes Text command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2dcdafc..753f5a3 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -816,3 +816,14 @@ struct hal_cmd_avrcp_list_player_values {
 	uint8_t number;
 	uint8_t values[0];
 } __attribute__((packed));
+
+struct hal_avrcp_player_attr_value {
+	uint8_t attr;
+	uint8_t value;
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_GET_PLAYER_ATTRS	0x04
+struct hal_cmd_avrcp_get_player_attrs {
+	uint8_t number;
+	struct hal_avrcp_player_attr_value attrs[0];
+} __attribute__((packed));
-- 
1.8.5.3

