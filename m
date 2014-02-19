Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/14] android/hal-avrcp: Add .get_player_app_attr_text_rsp implementation
Date: Wed, 19 Feb 2014 18:58:52 +0200
Message-Id: <1392829138-10346-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index c9e1be2..5d1bb94 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -163,6 +163,74 @@ static bt_status_t get_player_app_value_rsp(btrc_player_settings_t *p_vals)
 					len, cmd, 0, NULL, NULL);
 }
 
+static int write_text(uint8_t *ptr, uint8_t id, uint8_t *text, size_t *len)
+{
+	struct hal_avrcp_player_setting_text *value = (void *) ptr;
+	size_t attr_len = sizeof(*value);
+
+	if (attr_len + *len > BLUEZ_HAL_MTU)
+		return 0;
+
+	value->id = id;
+	value->len = strnlen((const char *) text, BTRC_MAX_ATTR_STR_LEN);
+
+	*len += attr_len;
+	ptr += attr_len;
+
+	if (value->len + *len > BLUEZ_HAL_MTU)
+		value->len = BLUEZ_HAL_MTU - *len;
+
+	memcpy(value->text, text, value->len);
+
+	*len += value->len;
+
+	return attr_len + value->len;
+}
+
+static uint8_t write_player_setting_text(uint8_t *ptr, uint8_t num_attr,
+					btrc_player_setting_text_t *p_attrs,
+					size_t *len)
+{
+	int i;
+
+	for (i = 0; i < num_attr && *len < BLUEZ_HAL_MTU; i++) {
+		int ret;
+
+		ret = write_text(ptr, p_attrs[i].id, p_attrs[i].text, len);
+		if (ret == 0)
+			break;
+
+		ptr += ret;
+	}
+
+	return i;
+}
+
+static bt_status_t get_player_app_attr_text_rsp(int num_attr,
+					btrc_player_setting_text_t *p_attrs)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_get_player_attrs_text *cmd = (void *) buf;
+	uint8_t *ptr;
+	size_t len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (num_attr < 0 || num_attr > BTRC_MAX_APP_SETTINGS)
+		return BT_STATUS_PARM_INVALID;
+
+	len = sizeof(*cmd);
+	ptr = (uint8_t *) &cmd->attrs[0];
+	cmd->number = write_player_setting_text(ptr, num_attr, p_attrs, &len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT,
+					len, cmd, 0, NULL, NULL);
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -189,6 +257,7 @@ static btrc_interface_t iface = {
 	.list_player_app_attr_rsp = list_player_app_attr_rsp,
 	.list_player_app_value_rsp = list_player_app_value_rsp,
 	.get_player_app_value_rsp = get_player_app_value_rsp,
+	.get_player_app_attr_text_rsp = get_player_app_attr_text_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

