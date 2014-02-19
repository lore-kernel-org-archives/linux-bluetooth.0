Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/14] android/hal-avrcp: Add .get_element_attr_rsp implementation
Date: Wed, 19 Feb 2014 18:58:54 +0200
Message-Id: <1392829138-10346-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index df32e2f..3a39918 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -256,6 +256,47 @@ static bt_status_t get_player_app_value_text_rsp(int num_val,
 					len, cmd, 0, NULL, NULL);
 }
 
+static uint8_t write_element_attr_text(uint8_t *ptr, uint8_t num_attr,
+					btrc_element_attr_val_t *p_attrs,
+					size_t *len)
+{
+	int i;
+
+	for (i = 0; i < num_attr && *len < BLUEZ_HAL_MTU; i++) {
+		int ret;
+
+		ret = write_text(ptr, p_attrs[i].attr_id, p_attrs[i].text, len);
+		if (ret == 0)
+			break;
+
+		ptr += ret;
+	}
+
+	return i;
+}
+
+static bt_status_t get_element_attr_rsp(uint8_t num_attr,
+					btrc_element_attr_val_t *p_attrs)
+{
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_cmd_avrcp_get_element_attrs_text *cmd = (void *) buf;
+	size_t len;
+	uint8_t *ptr;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	len = sizeof(*cmd);
+	ptr = (uint8_t *) &cmd->values[0];
+	cmd->number = write_element_attr_text(ptr, num_attr, p_attrs, &len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP,
+					HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT,
+					len, cmd, 0, NULL, NULL);
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -284,6 +325,7 @@ static btrc_interface_t iface = {
 	.get_player_app_value_rsp = get_player_app_value_rsp,
 	.get_player_app_attr_text_rsp = get_player_app_attr_text_rsp,
 	.get_player_app_value_text_rsp = get_player_app_value_text_rsp,
+	.get_element_attr_rsp = get_element_attr_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

