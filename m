Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/14] android/hal-avrcp: Add .get_player_app_value_text_rsp implementation
Date: Wed, 19 Feb 2014 18:58:53 +0200
Message-Id: <1392829138-10346-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 5d1bb94..df32e2f 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -231,6 +231,31 @@ static bt_status_t get_player_app_attr_text_rsp(int num_attr,
 					len, cmd, 0, NULL, NULL);
 }
 
+static bt_status_t get_player_app_value_text_rsp(int num_val,
+					btrc_player_setting_text_t *p_vals)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_get_player_values_text *cmd = (void *) buf;
+	uint8_t *ptr;
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
+	len = sizeof(*cmd);
+	ptr = (uint8_t *) &cmd->values[0];
+	cmd->number = write_player_setting_text(ptr, num_val, p_vals, &len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT,
+					len, cmd, 0, NULL, NULL);
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -258,6 +283,7 @@ static btrc_interface_t iface = {
 	.list_player_app_value_rsp = list_player_app_value_rsp,
 	.get_player_app_value_rsp = get_player_app_value_rsp,
 	.get_player_app_attr_text_rsp = get_player_app_attr_text_rsp,
+	.get_player_app_value_text_rsp = get_player_app_value_text_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

