Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/13] android/hal-avrcp: Add .register_notification_rsp implementation
Date: Tue, 18 Feb 2014 16:24:28 +0200
Message-Id: <1392733470-22736-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
References: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index d32cdff..41349f2 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -283,6 +283,147 @@ static bt_status_t set_player_app_value_rsp(btrc_status_t rsp_status)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
+static void *play_status_changed_rsp(btrc_notification_type_t type,
+						btrc_play_status_t *play_status)
+{
+	struct hal_cmd_avrcp_register_notification *cmd;
+	size_t param_len;
+
+	param_len = 1;
+	cmd = malloc(sizeof(*cmd) + param_len);
+	cmd->event = BTRC_EVT_PLAY_STATUS_CHANGED;
+	cmd->type = type;
+	cmd->len = param_len;
+	memcpy(cmd->data, play_status, cmd->len);
+
+	return cmd;
+}
+
+static void *track_change_rsp(btrc_notification_type_t type, btrc_uid_t *track)
+{
+	struct hal_cmd_avrcp_register_notification *cmd;
+	size_t param_len;
+
+	param_len = sizeof(*track);
+	cmd = malloc(sizeof(*cmd) + param_len);
+	cmd->event = BTRC_EVT_TRACK_CHANGE;
+	cmd->type = type;
+	cmd->len = param_len;
+	memcpy(cmd->data, track, cmd->len);
+
+	return cmd;
+}
+
+static void *track_reached_end_rsp(btrc_notification_type_t type)
+{
+	struct hal_cmd_avrcp_register_notification *cmd;
+
+	cmd = malloc(sizeof(*cmd));
+	cmd->event = BTRC_EVT_TRACK_REACHED_END;
+	cmd->type = type;
+	cmd->len = 0;
+
+	return cmd;
+}
+
+static void *track_reached_start_rsp(btrc_notification_type_t type)
+{
+	struct hal_cmd_avrcp_register_notification *cmd;
+
+	cmd = malloc(sizeof(*cmd));
+	cmd->event = BTRC_EVT_TRACK_REACHED_START;
+	cmd->type = type;
+	cmd->len = 0;
+
+	return cmd;
+}
+
+static void *play_pos_changed_rsp(btrc_notification_type_t type,
+							uint32_t *song_pos)
+{
+	struct hal_cmd_avrcp_register_notification *cmd;
+	size_t param_len;
+
+	param_len = sizeof(*song_pos);
+	cmd = malloc(sizeof(*cmd) + param_len);
+	cmd->event = BTRC_EVT_PLAY_POS_CHANGED;
+	cmd->type = type;
+	cmd->len = param_len;
+	memcpy(cmd->data, song_pos, cmd->len);
+
+	return cmd;
+}
+
+static void *settings_changed_rsp(btrc_notification_type_t type,
+					btrc_player_settings_t *player_setting)
+{
+	struct hal_cmd_avrcp_register_notification *cmd;
+	struct hal_avrcp_player_attr_value *attrs;
+	size_t param_len;
+	int i;
+
+	param_len = player_setting->num_attr * sizeof(*attrs);
+	cmd = malloc(sizeof(*cmd) + param_len);
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
+	return cmd;
+}
+
+static bt_status_t register_notification_rsp(btrc_event_id_t event_id,
+					btrc_notification_type_t type,
+					btrc_register_notification_t *p_param)
+{
+	struct hal_cmd_avrcp_register_notification *cmd;
+	bt_status_t status;
+	size_t len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	switch (event_id) {
+	case BTRC_EVT_PLAY_STATUS_CHANGED:
+		cmd = play_status_changed_rsp(type, &p_param->play_status);
+		break;
+	case BTRC_EVT_TRACK_CHANGE:
+		cmd = track_change_rsp(type, &p_param->track);
+		break;
+	case BTRC_EVT_TRACK_REACHED_END:
+		cmd = track_reached_end_rsp(type);
+		break;
+	case BTRC_EVT_TRACK_REACHED_START:
+		cmd = track_reached_start_rsp(type);
+		break;
+	case BTRC_EVT_PLAY_POS_CHANGED:
+		cmd = play_pos_changed_rsp(type, &p_param->song_pos);
+		break;
+	case BTRC_EVT_APP_SETTINGS_CHANGED:
+		cmd = settings_changed_rsp(type, &p_param->player_setting);
+		break;
+	default:
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	len = sizeof(*cmd) + cmd->len;
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_REGISTER_NOTIFICATION,
+					len, cmd, 0, NULL, NULL);
+
+	free(cmd);
+
+	return status;
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -313,6 +454,7 @@ static btrc_interface_t iface = {
 	.get_player_app_value_text_rsp = get_player_app_value_text_rsp,
 	.get_element_attr_rsp = get_element_attr_rsp,
 	.set_player_app_value_rsp = set_player_app_value_rsp,
+	.register_notification_rsp = register_notification_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

