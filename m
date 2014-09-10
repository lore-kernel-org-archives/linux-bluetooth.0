Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/avrcp: Clean up command order
Date: Wed, 10 Sep 2014 12:01:35 +0200
Message-Id: <1410343295-32452-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Idea about order in this file is that commands goes first and
notifications in the end of file.

This patch moves AVRCP commands up in the file
---
Previously it was a part of hf-client patch set, not it is taken out 
of that set.

 android/hal-msg.h | 208 +++++++++++++++++++++++++++---------------------------
 1 file changed, 104 insertions(+), 104 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8adb9f1..3d95e10 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -566,6 +566,110 @@ struct hal_cmd_handsfree_phone_state_change {
 	uint8_t number[0];
 } __attribute__((packed));
 
+/* AVRCP HAL API */
+
+#define HAL_AVRCP_PLAY_STATUS_STOPPED	0x00
+#define HAL_AVRCP_PLAY_STATUS_PLAYING	0x01
+#define HAL_AVRCP_PLAY_STATUS_PAUSED	0x02
+#define HAL_AVRCP_PLAY_STATUS_FWD_SEEK	0x03
+#define HAL_AVRCP_PLAY_STATUS_REV_SEEK	0x04
+#define HAL_AVRCP_PLAY_STATUS_ERROR	0xff
+
+#define HAL_OP_AVRCP_GET_PLAY_STATUS	0x01
+struct hal_cmd_avrcp_get_play_status {
+	uint8_t status;
+	uint32_t duration;
+	uint32_t position;
+} __attribute__((packed));
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
+
+#define HAL_OP_AVRCP_LIST_PLAYER_VALUES	0x03
+struct hal_cmd_avrcp_list_player_values {
+	uint8_t number;
+	uint8_t values[0];
+} __attribute__((packed));
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
+
+struct hal_avrcp_player_setting_text {
+	uint8_t id;
+	uint8_t len;
+	uint8_t text[0];
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT	0x05
+struct hal_cmd_avrcp_get_player_attrs_text {
+	uint8_t number;
+	struct hal_avrcp_player_setting_text attrs[0];
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT	0x06
+struct hal_cmd_avrcp_get_player_values_text {
+	uint8_t number;
+	struct hal_avrcp_player_setting_text values[0];
+} __attribute__((packed));
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
+
+#define HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE	0x08
+struct hal_cmd_avrcp_set_player_attrs_value {
+	uint8_t status;
+} __attribute__((packed));
+
+#define HAL_AVRCP_EVENT_STATUS_CHANGED		0x01
+#define HAL_AVRCP_EVENT_TRACK_CHANGED		0x02
+#define HAL_AVRCP_EVENT_TRACK_REACHED_END	0x03
+#define HAL_AVRCP_EVENT_TRACK_REACHED_START	0x04
+#define HAL_AVRCP_EVENT_POSITION_CHANGED	0x05
+#define HAL_AVRCP_EVENT_SETTING_CHANGED		0x08
+
+#define HAL_AVRCP_EVENT_TYPE_INTERIM		0x00
+#define HAL_AVRCP_EVENT_TYPE_CHANGED		0x01
+
+#define HAL_OP_AVRCP_REGISTER_NOTIFICATION	0x09
+struct hal_cmd_avrcp_register_notification {
+	uint8_t event;
+	uint8_t type;
+	uint8_t len;
+	uint8_t data[0];
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_SET_VOLUME			0x0a
+struct hal_cmd_avrcp_set_volume {
+	uint8_t value;
+} __attribute__((packed));
+
 /* GATT HAL API */
 
 #define HAL_OP_GATT_CLIENT_REGISTER		0x01
@@ -1174,110 +1278,6 @@ struct hal_ev_handsfree_unknown_at {
 
 #define HAL_EV_HANDSFREE_HSP_KEY_PRESS	0x90
 
-/* AVRCP HAL API */
-
-#define HAL_AVRCP_PLAY_STATUS_STOPPED	0x00
-#define HAL_AVRCP_PLAY_STATUS_PLAYING	0x01
-#define HAL_AVRCP_PLAY_STATUS_PAUSED	0x02
-#define HAL_AVRCP_PLAY_STATUS_FWD_SEEK	0x03
-#define HAL_AVRCP_PLAY_STATUS_REV_SEEK	0x04
-#define HAL_AVRCP_PLAY_STATUS_ERROR	0xff
-
-#define HAL_OP_AVRCP_GET_PLAY_STATUS	0x01
-struct hal_cmd_avrcp_get_play_status {
-	uint8_t status;
-	uint32_t duration;
-	uint32_t position;
-} __attribute__((packed));
-
-#define HAL_AVRCP_PLAYER_ATTR_EQUALIZER	0x01
-#define HAL_AVRCP_PLAYER_ATTR_REPEAT	0x02
-#define HAL_AVRCP_PLAYER_ATTR_SHUFFLE	0x03
-#define HAL_AVRCP_PLAYER_ATTR_SCAN	0x04
-
-#define HAL_OP_AVRCP_LIST_PLAYER_ATTRS	0x02
-struct hal_cmd_avrcp_list_player_attrs {
-	uint8_t number;
-	uint8_t attrs[0];
-} __attribute__((packed));
-
-#define HAL_OP_AVRCP_LIST_PLAYER_VALUES	0x03
-struct hal_cmd_avrcp_list_player_values {
-	uint8_t number;
-	uint8_t values[0];
-} __attribute__((packed));
-
-struct hal_avrcp_player_attr_value {
-	uint8_t attr;
-	uint8_t value;
-} __attribute__((packed));
-
-#define HAL_OP_AVRCP_GET_PLAYER_ATTRS	0x04
-struct hal_cmd_avrcp_get_player_attrs {
-	uint8_t number;
-	struct hal_avrcp_player_attr_value attrs[0];
-} __attribute__((packed));
-
-struct hal_avrcp_player_setting_text {
-	uint8_t id;
-	uint8_t len;
-	uint8_t text[0];
-} __attribute__((packed));
-
-#define HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT	0x05
-struct hal_cmd_avrcp_get_player_attrs_text {
-	uint8_t number;
-	struct hal_avrcp_player_setting_text attrs[0];
-} __attribute__((packed));
-
-#define HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT	0x06
-struct hal_cmd_avrcp_get_player_values_text {
-	uint8_t number;
-	struct hal_avrcp_player_setting_text values[0];
-} __attribute__((packed));
-
-#define HAL_AVRCP_MEDIA_ATTR_TITLE		0x01
-#define HAL_AVRCP_MEDIA_ATTR_ARTIST		0x02
-#define HAL_AVRCP_MEDIA_ATTR_ALBUM		0x03
-#define HAL_AVRCP_MEDIA_ATTR_TRACK_NUM		0x04
-#define HAL_AVRCP_MEDIA_ATTR_NUM_TRACKS		0x05
-#define HAL_AVRCP_MEDIA_ATTR_GENRE		0x06
-#define HAL_AVRCP_MEDIA_ATTR_DURATION		0x07
-
-#define HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT	0x07
-struct hal_cmd_avrcp_get_element_attrs_text {
-	uint8_t number;
-	struct hal_avrcp_player_setting_text values[0];
-} __attribute__((packed));
-
-#define HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE	0x08
-struct hal_cmd_avrcp_set_player_attrs_value {
-	uint8_t status;
-} __attribute__((packed));
-
-#define HAL_AVRCP_EVENT_STATUS_CHANGED		0x01
-#define HAL_AVRCP_EVENT_TRACK_CHANGED		0x02
-#define HAL_AVRCP_EVENT_TRACK_REACHED_END	0x03
-#define HAL_AVRCP_EVENT_TRACK_REACHED_START	0x04
-#define HAL_AVRCP_EVENT_POSITION_CHANGED	0x05
-#define HAL_AVRCP_EVENT_SETTING_CHANGED		0x08
-
-#define HAL_AVRCP_EVENT_TYPE_INTERIM		0x00
-#define HAL_AVRCP_EVENT_TYPE_CHANGED		0x01
-
-#define HAL_OP_AVRCP_REGISTER_NOTIFICATION	0x09
-struct hal_cmd_avrcp_register_notification {
-	uint8_t event;
-	uint8_t type;
-	uint8_t len;
-	uint8_t data[0];
-} __attribute__((packed));
-
-#define HAL_OP_AVRCP_SET_VOLUME			0x0a
-struct hal_cmd_avrcp_set_volume {
-	uint8_t value;
-} __attribute__((packed));
-
 #define HAL_AVRCP_FEATURE_NONE			0x00
 #define HAL_AVRCP_FEATURE_METADATA		0x01
 #define HAL_AVRCP_FEATURE_ABSOLUTE_VOLUME	0x02
-- 
1.8.4

