Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 06/14] android/hal-avrcp: Add .list_player_app_value_rsp implementation
Date: Wed, 19 Feb 2014 18:58:50 +0200
Message-Id: <1392829138-10346-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 9735c22..42b1dad 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -102,6 +102,33 @@ static bt_status_t list_player_app_attr_rsp(int num_attr,
 					len, cmd, 0, NULL, NULL);
 }
 
+static bt_status_t list_player_app_value_rsp(int num_val, uint8_t *p_vals)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_list_player_values *cmd = (void *) buf;
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
+
+	if (len > BLUEZ_HAL_MTU)
+		return BT_STATUS_PARM_INVALID;
+
+	cmd->number = num_val;
+	memcpy(cmd->values, p_vals, num_val);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_LIST_PLAYER_VALUES,
+					len, cmd, 0, NULL, NULL);
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -126,6 +153,7 @@ static btrc_interface_t iface = {
 	.init = init,
 	.get_play_status_rsp = get_play_status_rsp,
 	.list_player_app_attr_rsp = list_player_app_attr_rsp,
+	.list_player_app_value_rsp = list_player_app_value_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

