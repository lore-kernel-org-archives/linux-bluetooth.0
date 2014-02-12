Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9] android/hal-ipc-api: Add Get Element Attributes Text Response
Date: Wed, 12 Feb 2014 16:48:12 +0200
Message-Id: <1392216494-30885-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
References: <1392216494-30885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 19 +++++++++++++++++--
 android/hal-msg.h       | 14 ++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index c8f5557..7c90928 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1256,8 +1256,23 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x07 - Get Element Attributes Text command/response
-	Opcode 0x08 - Set Player Attributes Value command/response
+	Opcode 0x07 - Get Element Attributes Text Response command/response
+
+		Command parameters: Number of elements (1 octet)
+		                    Element # (1 octet)
+		                    Element # text (255 octets)
+		                    ...
+
+		In case of an error, the error response will be returned.
+
+		Valid elements: 0x01 = Title
+		                0x02 = Artist
+		                0x03 = Album
+		                0x04 = Track Number
+		                0x05 = Number of Tracks
+		                0x06 = Genre
+		                0x06 = Duration
+
 	Opcode 0x09 - Register Notification command/response
 
 	Opcode 0x81 - Get Play Status notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 280c28c..9f3c2a1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -844,3 +844,17 @@ struct hal_cmd_avrcp_get_player_values_text {
 	uint8_t number;
 	struct hal_avrcp_player_setting_text values[0];
 } __attribute__((packed));
+
+#define HAL_AVRCP_MEDIA_ATTR_TITLE		0x01
+#define HAL_AVRCP_MEDIA_ATTR_ARTIST		0x02
+#define HAL_AVRCP_MEDIA_ATTR_ALBUM		0x03
+#define HAL_AVRCP_MEDIA_ATTR_TRACK_NUM		0x04
+#define HAL_AVRCP_MEDIA_ATTR_NUM_TRACKS		0x05
+#define HAL_AVRCP_MEDIA_ATTR_GENRE		0x06
+#define HAL_AVRCP_MEDIA_ATTR_DURATION		0x07
+
+#define HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT	0x07
+struct hal_cmd_avrcp_get_element_attrs_text {
+	uint8_t number;
+	struct hal_avrcp_player_setting_text values[0];
+} __attribute__((packed));
-- 
1.8.5.3

