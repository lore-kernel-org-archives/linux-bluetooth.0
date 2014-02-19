Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 12/14] android/hal-avrcp: Add .register_notification_rsp implementation
Date: Wed, 19 Feb 2014 18:58:56 +0200
Message-Id: <1392829138-10346-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index d9069c0..bf3e3dc 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -313,6 +313,146 @@ static bt_status_t set_player_app_value_rsp(btrc_status_t rsp_status)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
+static bt_status_t play_status_changed_rsp(btrc_notification_type_t type,
+						btrc_play_status_t *play_status)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
+	size_t len;
+
+	cmd->event = BTRC_EVT_PLAY_STATUS_CHANGED;
+	cmd->type = type;
+	cmd->len = 1;
+	memcpy(cmd->data, play_status, cmd->len);
+
+	len = sizeof(*cmd) + cmd->len;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
+					len, cmd, 0, NULL, NULL);
+}
+
+static bt_status_t track_change_rsp(btrc_notification_type_t type,
+							btrc_uid_t *track)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
+	size_t len;
+
+	cmd->event = BTRC_EVT_TRACK_CHANGE;
+	cmd->type = type;
+	cmd->len = sizeof(*track);
+	memcpy(cmd->data, track, cmd->len);
+
+	len = sizeof(*cmd) + cmd->len;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
+					len, cmd, 0, NULL, NULL);
+}
+
+static bt_status_t track_reached_end_rsp(btrc_notification_type_t type)
+{
+	struct hal_cmd_avrcp_register_notification cmd;
+
+	cmd.event = BTRC_EVT_TRACK_REACHED_END;
+	cmd.type = type;
+	cmd.len = 0;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
+static bt_status_t track_reached_start_rsp(btrc_notification_type_t type)
+{
+	struct hal_cmd_avrcp_register_notification cmd;
+
+	cmd.event = BTRC_EVT_TRACK_REACHED_START;
+	cmd.type = type;
+	cmd.len = 0;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
+static bt_status_t play_pos_changed_rsp(btrc_notification_type_t type,
+							uint32_t *song_pos)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
+	size_t len;
+
+	cmd->event = BTRC_EVT_PLAY_POS_CHANGED;
+	cmd->type = type;
+	cmd->len = sizeof(*song_pos);
+	memcpy(cmd->data, song_pos, cmd->len);
+
+	len = sizeof(*cmd) + cmd->len;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
+					len, cmd, 0, NULL, NULL);
+}
+
+static bt_status_t settings_changed_rsp(btrc_notification_type_t type,
+					btrc_player_settings_t *player_setting)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_register_notification *cmd = (void *) buf;
+	struct hal_avrcp_player_attr_value *attrs;
+	size_t len, param_len;
+	int i;
+
+	param_len = player_setting->num_attr * sizeof(*attrs);
+	len = sizeof(*cmd) + param_len;
+
+	if (len > BLUEZ_HAL_MTU)
+		return BT_STATUS_PARM_INVALID;
+
+	cmd->event = BTRC_EVT_APP_SETTINGS_CHANGED;
+	cmd->type = type;
+	cmd->len = param_len;
+
+	attrs = (struct hal_avrcp_player_attr_value *) &cmd->data[0];
+	for (i = 0; i < player_setting->num_attr; i++) {
+		attrs[i].attr = player_setting->attr_ids[i];
+		attrs[i].value = player_setting->attr_values[i];
+	}
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
+					len, cmd, 0, NULL, NULL);
+}
+
+static bt_status_t register_notification_rsp(btrc_event_id_t event_id,
+					btrc_notification_type_t type,
+					btrc_register_notification_t *p_param)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	switch (event_id) {
+	case BTRC_EVT_PLAY_STATUS_CHANGED:
+		return play_status_changed_rsp(type, &p_param->play_status);
+	case BTRC_EVT_TRACK_CHANGE:
+		return track_change_rsp(type, &p_param->track);
+	case BTRC_EVT_TRACK_REACHED_END:
+		return track_reached_end_rsp(type);
+	case BTRC_EVT_TRACK_REACHED_START:
+		return track_reached_start_rsp(type);
+	case BTRC_EVT_PLAY_POS_CHANGED:
+		return play_pos_changed_rsp(type, &p_param->song_pos);
+	case BTRC_EVT_APP_SETTINGS_CHANGED:
+		return settings_changed_rsp(type, &p_param->player_setting);
+	default:
+		return BT_STATUS_PARM_INVALID;
+	}
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -343,6 +483,7 @@ static btrc_interface_t iface = {
 	.get_player_app_value_text_rsp = get_player_app_value_text_rsp,
 	.get_element_attr_rsp = get_element_attr_rsp,
 	.set_player_app_value_rsp = set_player_app_value_rsp,
+	.register_notification_rsp = register_notification_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

