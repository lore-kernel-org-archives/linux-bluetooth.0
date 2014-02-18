Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/13] android/hal-avrcp: Add .list_player_app_value_rsp implementation
Date: Tue, 18 Feb 2014 16:24:22 +0200
Message-Id: <1392733470-22736-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
References: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 244f77a..4bc8073 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -105,6 +105,35 @@ static bt_status_t list_player_app_attr_rsp(int num_attr,
 	return status;
 }
 
+static bt_status_t list_player_app_value_rsp(int num_val, uint8_t *p_vals)
+{
+	struct hal_cmd_avrcp_list_player_values *cmd;
+	bt_status_t status;
+	size_t len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (num_val < 0)
+		return BT_STATUS_PARM_INVALID;
+
+	len = sizeof(*cmd) + num_val;
+	cmd = malloc(len);
+
+	cmd->number = num_val;
+	memcpy(cmd->values, p_vals, num_val);
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_LIST_PLAYER_VALUES,
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
@@ -129,6 +158,7 @@ static btrc_interface_t iface = {
 	.init = init,
 	.get_play_status_rsp = get_play_status_rsp,
 	.list_player_app_attr_rsp = list_player_app_attr_rsp,
+	.list_player_app_value_rsp = list_player_app_value_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

