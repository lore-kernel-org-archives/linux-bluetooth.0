Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/13] android/hal-avrcp: Add .get_player_app_attr_text_rsp implementation
Date: Tue, 18 Feb 2014 16:24:24 +0200
Message-Id: <1392733470-22736-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
References: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 4110388..36513c6 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -170,6 +170,37 @@ static bt_status_t get_player_app_value_rsp(btrc_player_settings_t *p_vals)
 	return status;
 }
 
+static bt_status_t get_player_app_attr_text_rsp(int num_attr,
+					btrc_player_setting_text_t *p_attrs)
+{
+	struct hal_cmd_avrcp_get_player_attrs_text *cmd;
+	bt_status_t status;
+	size_t len, attrs_len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (num_attr < 0)
+		return BT_STATUS_PARM_INVALID;
+
+	attrs_len = num_attr * sizeof(*p_attrs);
+	len = sizeof(*cmd) + attrs_len;
+	cmd = malloc(len);
+
+	cmd->number = num_attr;
+	memcpy(cmd->attrs, p_attrs, attrs_len);
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT,
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
@@ -196,6 +227,7 @@ static btrc_interface_t iface = {
 	.list_player_app_attr_rsp = list_player_app_attr_rsp,
 	.list_player_app_value_rsp = list_player_app_value_rsp,
 	.get_player_app_value_rsp = get_player_app_value_rsp,
+	.get_player_app_attr_text_rsp = get_player_app_attr_text_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

