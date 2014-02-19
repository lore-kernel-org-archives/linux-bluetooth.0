Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 07/14] android/hal-avrcp: Add .get_player_app_value_rsp implementation
Date: Wed, 19 Feb 2014 18:58:51 +0200
Message-Id: <1392829138-10346-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 42b1dad..c9e1be2 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -129,6 +129,40 @@ static bt_status_t list_player_app_value_rsp(int num_val, uint8_t *p_vals)
 					len, cmd, 0, NULL, NULL);
 }
 
+static bt_status_t get_player_app_value_rsp(btrc_player_settings_t *p_vals)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_get_player_attrs *cmd = (void *) buf;
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
+
+	if (len > BLUEZ_HAL_MTU)
+		return BT_STATUS_PARM_INVALID;
+
+	cmd->number = p_vals->num_attr;
+
+	for (i = 0; i < p_vals->num_attr; i++) {
+		cmd->attrs[i].attr = p_vals->attr_ids[i];
+		cmd->attrs[i].value = p_vals->attr_values[i];
+	}
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_GET_PLAYER_ATTRS,
+					len, cmd, 0, NULL, NULL);
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -154,6 +188,7 @@ static btrc_interface_t iface = {
 	.get_play_status_rsp = get_play_status_rsp,
 	.list_player_app_attr_rsp = list_player_app_attr_rsp,
 	.list_player_app_value_rsp = list_player_app_value_rsp,
+	.get_player_app_value_rsp = get_player_app_value_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

