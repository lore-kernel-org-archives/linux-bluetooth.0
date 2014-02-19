Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 14/14] android/hal-avrcp: Add notification handlers
Date: Wed, 19 Feb 2014 18:58:58 +0200
Message-Id: <1392829138-10346-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
References: <1392829138-10346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index f982f48..a11aaa3 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -32,6 +32,177 @@ static bool interface_ready(void)
 	return cbs != NULL;
 }
 
+static void handle_remote_features(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_remote_features *ev = buf;
+
+	if (cbs->remote_features_cb)
+		cbs->remote_features_cb((bt_bdaddr_t *) (ev->bdaddr),
+								ev->features);
+}
+
+static void handle_get_play_status(void *buf, uint16_t len)
+{
+	if (cbs->get_play_status_cb)
+		cbs->get_play_status_cb();
+}
+
+static void handle_list_player_attrs(void *buf, uint16_t len)
+{
+	if (cbs->list_player_app_attr_cb)
+		cbs->list_player_app_attr_cb();
+}
+
+static void handle_list_player_values(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_list_player_values *ev = buf;
+
+	if (cbs->list_player_app_values_cb)
+		cbs->list_player_app_values_cb(ev->attr);
+}
+
+static void handle_get_player_values(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_get_player_values *ev = buf;
+	btrc_player_attr_t attrs[4];
+	int i;
+
+	if (!cbs->get_player_app_value_cb)
+		return;
+
+	/* Convert uint8_t array to btrc_player_attr_t array */
+	for (i = 0; i < ev->number; i++)
+		attrs[i] = ev->attrs[i];
+
+	cbs->get_player_app_value_cb(ev->number, attrs);
+}
+
+static void handle_get_player_attrs_text(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_get_player_attrs_text *ev = buf;
+	btrc_player_attr_t attrs[4];
+	int i;
+
+	if (!cbs->get_player_app_attrs_text_cb)
+		return;
+
+	/* Convert uint8_t array to btrc_player_attr_t array */
+	for (i = 0; i < ev->number; i++)
+		attrs[i] = ev->attrs[i];
+
+	cbs->get_player_app_attrs_text_cb(ev->number, attrs);
+}
+
+static void handle_get_player_values_text(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_get_player_values_text *ev = buf;
+
+	if (cbs->get_player_app_values_text_cb)
+		cbs->get_player_app_values_text_cb(ev->attr, ev->number,
+								ev->values);
+}
+
+static void handle_set_player_value(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_set_player_values *ev = buf;
+	struct hal_avrcp_player_attr_value *attrs;
+	btrc_player_settings_t values;
+	int i;
+
+	if (!cbs->set_player_app_value_cb)
+		return;
+
+	attrs = (struct hal_avrcp_player_attr_value *) ev->attrs;
+
+	/* Convert to btrc_player_settings_t */
+	values.num_attr = ev->number;
+	for (i = 0; i < ev->number; i++) {
+		values.attr_ids[i] = attrs[i].attr;
+		values.attr_values[i] = attrs[i].value;
+	}
+
+	cbs->set_player_app_value_cb(&values);
+}
+
+static void handle_get_element_attrs(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_get_element_attrs *ev = buf;
+	btrc_media_attr_t attrs[BTRC_MAX_APP_SETTINGS];
+	int i;
+
+	if (!cbs->get_element_attr_cb)
+		return;
+
+	/* Convert uint8_t array to btrc_media_attr_t array */
+	for (i = 0; i < ev->number; i++)
+		attrs[i] = ev->attrs[i];
+
+	cbs->get_element_attr_cb(ev->number, attrs);
+}
+
+static void handle_register_notification(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_register_notification *ev = buf;
+
+	if (cbs->register_notification_cb)
+		cbs->register_notification_cb(ev->event, ev->param);
+}
+
+static void handle_volume_changed(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_volume_changed *ev = buf;
+
+	if (cbs->volume_change_cb)
+		cbs->volume_change_cb(ev->volume, ev->type);
+}
+
+static void handle_passthrough_cmd(void *buf, uint16_t len)
+{
+	struct hal_ev_avrcp_passthrough_cmd *ev = buf;
+
+	if (cbs->passthrough_cmd_cb)
+		cbs->passthrough_cmd_cb(ev->id, ev->state);
+}
+
+/* handlers will be called from notification thread context,
+ * index in table equals to 'opcode - HAL_MINIMUM_EVENT' */
+static const struct hal_ipc_handler ev_handlers[] = {
+	/* HAL_EV_AVRCP_REMOTE_FEATURES */
+	{ handle_remote_features, false,
+			sizeof(struct hal_ev_avrcp_remote_features) },
+	/* HAL_EV_AVRCP_GET_PLAY_STATUS */
+	{ handle_get_play_status, false, 0 },
+	/* HAL_EV_AVRCP_LIST_PLAYER_ATTRS */
+	{ handle_list_player_attrs, false, 0 },
+	/* HAL_EV_AVRCP_LIST_PLAYER_VALUES */
+	{ handle_list_player_values, false,
+			sizeof(struct hal_ev_avrcp_list_player_values) },
+	/* HAL_EV_AVRCP_GET_PLAYER_VALUES */
+	{ handle_get_player_values, true,
+			sizeof(struct hal_ev_avrcp_get_player_values) },
+	/* HAL_EV_AVRCP_GET_PLAYER_ATTRS_TEXT */
+	{ handle_get_player_attrs_text, true,
+			sizeof(struct hal_ev_avrcp_get_player_attrs_text) },
+	/* HAL_EV_AVRCP_GET_PLAYER_VALUES_TEXT */
+	{ handle_get_player_values_text, true,
+			sizeof(struct hal_ev_avrcp_get_player_values_text) },
+	/* HAL_EV_AVRCP_SET_PLAYER_VALUES */
+	{ handle_set_player_value, true,
+			sizeof(struct hal_ev_avrcp_set_player_values) },
+	/* HAL_EV_AVRCP_GET_ELEMENT_ATTRS */
+	{ handle_get_element_attrs, true,
+			sizeof(struct hal_ev_avrcp_get_element_attrs) },
+	/* HAL_EV_AVRCP_REGISTER_NOTIFICATION */
+	{ handle_register_notification, false,
+			sizeof(struct hal_ev_avrcp_register_notification) },
+	/* HAL_EV_AVRCP_VOLUME_CHANGED */
+	{ handle_volume_changed, false,
+			sizeof(struct hal_ev_avrcp_volume_changed) },
+	/* HAL_EV_AVRCP_PASSTHROUGH_CMD */
+	{ handle_passthrough_cmd, false,
+			sizeof(struct hal_ev_avrcp_passthrough_cmd) },
+};
+
 static bt_status_t init(btrc_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -44,6 +215,9 @@ static bt_status_t init(btrc_callbacks_t *callbacks)
 
 	cbs = callbacks;
 
+	hal_ipc_register(HAL_SERVICE_ID_AVRCP, ev_handlers,
+				sizeof(ev_handlers) / sizeof(ev_handlers[0]));
+
 	cmd.service_id = HAL_SERVICE_ID_AVRCP;
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-- 
1.8.5.3

