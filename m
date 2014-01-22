Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/ipc: Add AVRCP HAL message definitions
Date: Wed, 22 Jan 2014 18:06:28 +0200
Message-Id: <1390406788-17152-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-msg.h | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index d46b428..3937f07 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -338,6 +338,77 @@ struct hal_cmd_a2dp_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+/* AVRCP HAL API */
+
+#define HAL_OP_AVRCP_GET_PLAY_STATUS_RSP		0x01
+struct hal_cmd_avrcp_get_play_status_rsp {
+	uint8_t  status;
+	uint32_t len;
+	uint32_t pos;
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_LIST_PLAYER_APP_ATTR_RSP		0x02
+struct hal_cmd_avrcp_list_player_app_attr_rsp {
+	uint16_t len;
+	uint8_t  data[0];
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_LIST_PLAYER_APP_VAL_RSP		0x03
+struct hal_cmd_avrcp_list_player_app_val_rsp {
+	uint16_t len;
+	uint8_t  data[0];
+} __attribute__((packed));
+
+#define MAX_APP_SETTINGS 8
+struct player_setting {
+	uint8_t num_attr;
+	uint8_t attr_ids[MAX_APP_SETTINGS];
+	uint8_t attr_vals[MAX_APP_SETTINGS];
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_GET_PLAYER_APP_VAL_RSP		0x04
+struct hal_cmd_avrcp_get_player_app_val_rsp {
+	struct player_setting settings;
+} __attribute__((packed));
+
+#define MAX_ATTR_STR_LEN 255
+struct player_text {
+	uint32_t id;
+	uint8_t text[MAX_ATTR_STR_LEN];
+}  __attribute__((packed));
+
+#define HAL_OP_AVRCP_GET_PLAYER_APP_ATTR_TEXT_RSP	0x05
+#define HAL_OP_AVRCP_GET_PLAYER_APP_VAL_TEXT_RSP	0x06
+#define HAL_OP_AVRCP_GET_ELEMENT_ATTR_RSP		0x07
+struct hal_cmd_avrcp_get_text_rsp {
+	uint16_t len;
+	struct player_text data[0];
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_SET_PLAYER_APP_VAL_RSP		0x08
+struct hal_cmd_avrcp_set_player_app_val_rsp {
+	uint8_t status;
+} __attribute__((packed));
+
+union notification {
+	uint8_t  status;
+	uint8_t  uid[8];
+	uint32_t pos;
+	struct player_setting player_settings;
+} __attribute__((packed));
+
+#define HAL_OP_AVRCP_REGISTER_NOTIFICATION_RSP		0x09
+struct hal_cmd_avrcp_register_notification_rsp {
+	uint8_t id;
+	uint8_t type;
+	union notification param;
+}  __attribute__((packed));
+
+#define HAL_OP_AVRCP_SET_VOLUME				0x0a
+struct hal_cmd_avrcp_set_volume {
+	uint8_t volume;
+}  __attribute__((packed));
+
 /* PAN HAL API */
 
 /* PAN Roles */
-- 
1.8.3.2

