Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/14] android/avrcp: Add command handlers stubs
Date: Wed, 19 Feb 2014 18:58:47 +0200
Message-Id: <1392829138-10346-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/android/avrcp.c b/android/avrcp.c
index 65b3417..b1b6dbe 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -57,7 +57,116 @@ struct avrcp_device {
 	GIOChannel	*io;
 };
 
+static void handle_get_play_status(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAY_STATUS,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_list_player_attrs(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_LIST_PLAYER_ATTRS,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_list_player_values(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_LIST_PLAYER_VALUES,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_get_player_attrs(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAYER_ATTRS,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_get_player_attrs_text(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_get_player_values_text(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_get_element_attrs_text(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_set_player_attrs_value(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_register_notification(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_REGISTER_NOTIFICATION,
+							HAL_STATUS_FAILED);
+}
+
+static void handle_set_volume(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	ipc_send_rsp(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_SET_VOLUME,
+							HAL_STATUS_FAILED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_AVRCP_GET_PLAY_STATUS */
+	{ handle_get_play_status, false,
+			sizeof(struct hal_cmd_avrcp_get_play_status) },
+	/* HAL_OP_AVRCP_LIST_PLAYER_ATTRS */
+	{ handle_list_player_attrs, true,
+			sizeof(struct hal_cmd_avrcp_list_player_attrs) },
+	/* HAL_OP_AVRCP_LIST_PLAYER_VALUES */
+	{ handle_list_player_values, true,
+			sizeof(struct hal_cmd_avrcp_list_player_values) },
+	/* HAL_OP_AVRCP_GET_PLAYER_ATTRS */
+	{ handle_get_player_attrs, true,
+			sizeof(struct hal_cmd_avrcp_get_player_attrs) },
+	/* HAL_OP_AVRCP_GET_PLAYER_ATTRS_TEXT */
+	{ handle_get_player_attrs_text, true,
+			sizeof(struct hal_cmd_avrcp_get_player_attrs_text) },
+	/* HAL_OP_AVRCP_GET_PLAYER_VALUES_TEXT */
+	{ handle_get_player_values_text, true,
+			sizeof(struct hal_cmd_avrcp_get_player_values_text) },
+	/* HAL_OP_AVRCP_GET_ELEMENT_ATTRS_TEXT */
+	{ handle_get_element_attrs_text, true,
+			sizeof(struct hal_cmd_avrcp_get_element_attrs_text) },
+	/* HAL_OP_AVRCP_SET_PLAYER_ATTRS_VALUE */
+	{ handle_set_player_attrs_value, true,
+			sizeof(struct hal_cmd_avrcp_set_player_attrs_value) },
+	/* HAL_OP_AVRCP_REGISTER_NOTIFICATION */
+	{ handle_register_notification, true,
+			sizeof(struct hal_cmd_avrcp_register_notification) },
+	/* HAL_OP_AVRCP_SET_VOLUME */
+	{ handle_set_volume, false, sizeof(struct hal_cmd_avrcp_set_volume) },
 };
 
 static sdp_record_t *avrcp_record(void)
-- 
1.8.5.3

