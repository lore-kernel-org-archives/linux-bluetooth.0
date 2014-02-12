Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/9] android/hal-ipc-api: Add List Player Attributes Response
Date: Wed, 12 Feb 2014 16:48:07 +0200
Message-Id: <1392216494-30885-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
References: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 14 +++++++++++++-
 android/hal-msg.h       | 11 +++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 01c2e81..ae58fda 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1203,7 +1203,19 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 		                     0x04 = Rev seek
 		                     0xff = Error
 
-	Opcode 0x02 - List Player Application Attributes command/response
+	Opcode 0x02 - List Player Attributes Response command/response
+
+		Command parameters: Number of attributes (1 octet)
+		                    Attribute # (1 octet)
+		                    ...
+
+		In case of an error, the error response will be returned.
+
+		Valid attributes: 0x01 = Equalizer
+		                  0x02 = Repead
+		                  0x03 = Shuffle
+		                  0x04 = Scan
+
 	Opcode 0x03 - List Player Application Values command/response
 	Opcode 0x04 - Get Player Application Values command/response
 	Opcode 0x05 - Get Player Application Attributes Text command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 82cd3f5..4a438d1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -799,3 +799,14 @@ struct hal_cmd_avrcp_get_play_status {
 	uint32_t duration;
 	uint32_t position;
 } __attribute__((packed));
+
+#define HAL_AVRCP_PLAYER_ATTR_EQUALIZER	0x01
+#define HAL_AVRCP_PLAYER_ATTR_REPEAT	0x02
+#define HAL_AVRCP_PLAYER_ATTR_SHUFFLE	0x03
+#define HAL_AVRCP_PLAYER_ATTR_SCAN	0x04
+
+#define HAL_OP_AVRCP_LIST_PLAYER_ATTRS	0x02
+struct hal_cmd_avrcp_list_player_attrs {
+	uint8_t number;
+	uint8_t attrs[0];
+} __attribute__((packed));
-- 
1.8.5.3

