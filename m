Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/13] android/hal-avrcp: Add .set_player_app_value_rsp implementation
Date: Tue, 18 Feb 2014 16:24:27 +0200
Message-Id: <1392733470-22736-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
References: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 2b8b58a..d32cdff 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -267,6 +267,22 @@ static bt_status_t get_element_attr_rsp(uint8_t num_attr,
 	return status;
 }
 
+static bt_status_t set_player_app_value_rsp(btrc_status_t rsp_status)
+{
+	struct hal_cmd_avrcp_set_player_attrs_value cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.status = rsp_status;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -296,6 +312,7 @@ static btrc_interface_t iface = {
 	.get_player_app_attr_text_rsp = get_player_app_attr_text_rsp,
 	.get_player_app_value_text_rsp = get_player_app_value_text_rsp,
 	.get_element_attr_rsp = get_element_attr_rsp,
+	.set_player_app_value_rsp = set_player_app_value_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

