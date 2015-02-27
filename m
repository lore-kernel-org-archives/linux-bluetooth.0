Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 07/16] core: gatt: Support ReadValue for characteristics
Date: Fri, 27 Feb 2015 00:16:30 -0800
Message-Id: <1425024999-29789-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1425024999-29789-1-git-send-email-armansito@chromium.org>
References: <1425024999-29789-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for obtaining the characteristic value from an
external application during a read procedure.
---
 src/gatt-manager.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/src/gatt-manager.c b/src/gatt-manager.c
index 7197197..8c92d79 100644
--- a/src/gatt-manager.c
+++ b/src/gatt-manager.c
@@ -48,6 +48,10 @@
 #define UUID_GAP	0x1800
 #define UUID_GATT	0x1801
 
+#ifndef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 struct btd_gatt_manager {
 	struct btd_adapter *adapter;
 	struct gatt_db *db;
@@ -72,8 +76,35 @@ struct external_chrc {
 	uint8_t props;
 	uint8_t ext_props;
 	struct gatt_db_attribute *attrib;
+	struct queue *pending_ops;
+};
+
+struct pending_dbus_op {
+	struct external_chrc *chrc;
+	unsigned int id;
+	void *user_data;
 };
 
+static void cancel_pending_dbus_op(void *data, void *user_data)
+{
+	struct pending_dbus_op *op = data;
+
+	gatt_db_attribute_read_result(op->chrc->attrib, op->id,
+					BT_ATT_ERROR_REQUEST_NOT_SUPPORTED,
+					NULL, 0);
+	op->chrc = NULL;
+}
+
+static void pending_dbus_op_free(void *data)
+{
+	struct pending_dbus_op *op = data;
+
+	if (op->chrc)
+		queue_remove(op->chrc->pending_ops, op);
+
+	free(op);
+}
+
 static bool match_service_path(const void *a, const void *b)
 {
 	const struct external_service *service = a;
@@ -86,6 +117,8 @@ static void chrc_free(void *data)
 {
 	struct external_chrc *chrc = data;
 
+	queue_foreach(chrc->pending_ops, cancel_pending_dbus_op, NULL);
+
 	if (chrc->proxy)
 		g_dbus_proxy_unref(chrc->proxy);
 
@@ -179,6 +212,12 @@ static struct external_chrc *chrc_create(GDBusProxy *proxy)
 	if (!chrc)
 		return NULL;
 
+	chrc->pending_ops = queue_new();
+	if (!chrc->pending_ops) {
+		free(chrc);
+		return NULL;
+	}
+
 	chrc->proxy = g_dbus_proxy_ref(proxy);
 
 	return chrc;
@@ -409,6 +448,117 @@ static bool parse_primary(GDBusProxy *proxy, bool *primary)
 	return true;
 }
 
+static uint8_t dbus_error_to_att_ecode(const char *error_name)
+{
+	/* TODO: Parse error ATT ecode from error_message */
+
+	if (strcmp(error_name, "org.bluez.Error.Failed") == 0)
+		return 0x80;  /* For now return this "application error" */
+
+	if (strcmp(error_name, "org.bluez.Error.NotSupported") == 0)
+		return BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+
+	if (strcmp(error_name, "org.bluez.Error.NotAuthorized") == 0)
+		return BT_ATT_ERROR_AUTHORIZATION;
+
+	if (strcmp(error_name, "org.bluez.Error.InvalidValueLength") == 0)
+		return BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+
+	return 0;
+}
+
+static void read_reply_cb(DBusMessage *message, void *user_data)
+{
+	struct pending_dbus_op *op = user_data;
+	DBusError err;
+	DBusMessageIter iter, array;
+	uint8_t ecode = 0;
+	uint8_t *value = NULL;
+	int len = 0;
+
+	if (!op->chrc) {
+		DBG("Pending read was canceled when object got removed");
+		return;
+	}
+
+	dbus_error_init(&err);
+
+	if (dbus_set_error_from_message(&err, message) == TRUE) {
+		DBG("Failed to read value: %s: %s", err.name, err.message);
+		ecode = dbus_error_to_att_ecode(err.name);
+		ecode = ecode ? ecode : BT_ATT_ERROR_READ_NOT_PERMITTED;
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		/*
+		 * Return not supported for this, as the external app basically
+		 * doesn't properly support reading from this characteristic.
+		 */
+		ecode = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+		error("Invalid return value received for \"ReadValue\"");
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &len);
+
+	if (len < 0) {
+		ecode = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+		value = NULL;
+		len = 0;
+		goto done;
+	}
+
+	/* Truncate the value if it's too large */
+	len = MIN(BT_ATT_MAX_VALUE_LEN, len);
+	value = len ? value : NULL;
+
+done:
+	gatt_db_attribute_read_result(op->chrc->attrib, op->id, ecode,
+								value, len);
+}
+
+static void chrc_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct external_chrc *chrc = user_data;
+	struct pending_dbus_op *op;
+	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
+
+	if (chrc->attrib != attrib) {
+		error("Read callback called with incorrect attribute");
+		goto error;
+
+	}
+
+	op = new0(struct pending_dbus_op, 1);
+	if (!op) {
+		error("Failed to allocate memory for pending read call");
+		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
+	}
+
+	op->chrc = chrc;
+	op->id = id;
+	queue_push_tail(chrc->pending_ops, op);
+
+	if (g_dbus_proxy_method_call(chrc->proxy, "ReadValue", NULL,
+						read_reply_cb, op,
+						pending_dbus_op_free) == TRUE)
+		return;
+
+	pending_dbus_op_free(op);
+
+error:
+	gatt_db_attribute_read_result(attrib, id, ecode, NULL, 0);
+}
+
 static bool create_chrc_entry(struct external_service *service,
 						struct external_chrc *chrc)
 {
@@ -425,10 +575,11 @@ static bool create_chrc_entry(struct external_service *service,
 		return false;
 	}
 
-	/* TODO: Assign permissions and read/write callbacks */
+	/* TODO: Assign permissions and write callback */
 	chrc->attrib = gatt_db_service_add_characteristic(service->attrib,
 							&uuid, 0, chrc->props,
-							NULL, NULL, NULL);
+							chrc_read_cb,
+							NULL, chrc);
 
 	/* TODO: Create descriptor entries */
 
-- 
2.2.0.rc0.207.ga3a616c

