Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/13] android/hal-avrcp: Add .get_player_app_value_text_rsp implementation
Date: Tue, 18 Feb 2014 16:24:25 +0200
Message-Id: <1392733470-22736-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
References: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 36513c6..d7d47f8 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -201,6 +201,37 @@ static bt_status_t get_player_app_attr_text_rsp(int num_attr,
 	return status;
 }
 
+static bt_status_t get_player_app_value_text_rsp(int num_val,
+					btrc_player_setting_text_t *p_vals)
+{
+	struct hal_cmd_avrcp_get_player_values_text *cmd;
+	bt_status_t status;
+	size_t len, values_len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (num_val < 0)
+		return BT_STATUS_PARM_INVALID;
+
+	values_len = num_val * sizeof(*p_vals);
+	len = sizeof(*cmd) + values_len;
+	cmd = malloc(len);
+
+	cmd->number = num_val;
+	memcpy(cmd->values, p_vals, values_len);
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT,
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
@@ -228,6 +259,7 @@ static btrc_interface_t iface = {
 	.list_player_app_value_rsp = list_player_app_value_rsp,
 	.get_player_app_value_rsp = get_player_app_value_rsp,
 	.get_player_app_attr_text_rsp = get_player_app_attr_text_rsp,
+	.get_player_app_value_text_rsp = get_player_app_value_text_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

