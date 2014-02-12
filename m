Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/9] android/hal-ipc-api: Add Get Player Values Text Response
Date: Wed, 12 Feb 2014 16:48:11 +0200
Message-Id: <1392216494-30885-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
References: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 10 +++++++++-
 android/hal-msg.h       |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 496851c..c8f5557 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1247,7 +1247,15 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid attributes: Same as in List Player Attributes
 
-	Opcode 0x06 - Get Player Application Values Text command/response
+	Opcode 0x06 - Get Player Values Text Response command/response
+
+		Command parameters: Number of values (1 octet)
+		                    Value # (1 octet)
+		                    Value # text (255 octets)
+		                    ...
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x07 - Get Element Attributes Text command/response
 	Opcode 0x08 - Set Player Attributes Value command/response
 	Opcode 0x09 - Register Notification command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2891a3a..280c28c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -838,3 +838,9 @@ struct hal_cmd_avrcp_get_player_attrs_text {
 	uint8_t number;
 	struct hal_avrcp_player_setting_text attrs[0];
 } __attribute__((packed));
+
+#define HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT	0x06
+struct hal_cmd_avrcp_get_player_values_text {
+	uint8_t number;
+	struct hal_avrcp_player_setting_text values[0];
+} __attribute__((packed));
-- 
1.8.5.3

