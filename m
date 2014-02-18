Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/13] android/hal-avrcp: Add .get_player_app_value_rsp implementation
Date: Tue, 18 Feb 2014 16:24:23 +0200
Message-Id: <1392733470-22736-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
References: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 4bc8073..4110388 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -134,6 +134,42 @@ static bt_status_t list_player_app_value_rsp(int num_val, uint8_t *p_vals)
 	return status;
 }
 
+static bt_status_t get_player_app_value_rsp(btrc_player_settings_t *p_vals)
+{
+	struct hal_cmd_avrcp_get_player_attrs *cmd;
+	bt_status_t status;
+	size_t len, attrs_len;
+	int i;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!p_vals)
+		return BT_STATUS_PARM_INVALID;
+
+	attrs_len = p_vals->num_attr *
+				sizeof(struct hal_avrcp_player_attr_value);
+	len = sizeof(*cmd) + attrs_len;
+	cmd = malloc(len);
+
+	cmd->number = p_vals->num_attr;
+
+	for (i = 0; i < p_vals->num_attr; i++) {
+		cmd->attrs[i].attr = p_vals->attr_ids[i];
+		cmd->attrs[i].value = p_vals->attr_values[i];
+	}
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_GET_PLAYER_ATTRS,
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
@@ -159,6 +195,7 @@ static btrc_interface_t iface = {
 	.get_play_status_rsp = get_play_status_rsp,
 	.list_player_app_attr_rsp = list_player_app_attr_rsp,
 	.list_player_app_value_rsp = list_player_app_value_rsp,
+	.get_player_app_value_rsp = get_player_app_value_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

