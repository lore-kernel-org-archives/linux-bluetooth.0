Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/13] android/hal-avrcp: Add .get_element_attr_rsp implementation
Date: Tue, 18 Feb 2014 16:24:26 +0200
Message-Id: <1392733470-22736-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
References: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index d7d47f8..2b8b58a 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -232,6 +232,41 @@ static bt_status_t get_player_app_value_text_rsp(int num_val,
 	return status;
 }
 
+static bt_status_t get_element_attr_rsp(uint8_t num_attr,
+					btrc_element_attr_val_t *p_attrs)
+{
+	struct hal_cmd_avrcp_get_element_attrs_text *cmd;
+	bt_status_t status;
+	size_t len, attrs_len;
+	int i;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	attrs_len = num_attr * sizeof(struct hal_avrcp_player_setting_text);
+	len = sizeof(*cmd) + attrs_len;
+	cmd = malloc(len);
+
+	cmd->number = num_attr;
+
+	for (i = 0; i < num_attr; i++) {
+		/* We are unable to memcpy the id since it is uint32_t */
+		cmd->values[i].id = p_attrs[i].attr_id;
+		memcpy(cmd->values[i].text, p_attrs[i].text,
+						sizeof(cmd->values[i].text));
+	}
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT,
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
@@ -260,6 +295,7 @@ static btrc_interface_t iface = {
 	.get_player_app_value_rsp = get_player_app_value_rsp,
 	.get_player_app_attr_text_rsp = get_player_app_attr_text_rsp,
 	.get_player_app_value_text_rsp = get_player_app_value_text_rsp,
+	.get_element_attr_rsp = get_element_attr_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

