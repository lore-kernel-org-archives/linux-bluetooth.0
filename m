Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 09/17] core/gatt: Support WriteValue for characteristics
Date: Wed, 25 Feb 2015 21:13:22 -0800
Message-Id: <1424927610-26226-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1424927610-26226-1-git-send-email-armansito@chromium.org>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for writing to a characteristic from an external
application during a write procedure.
---
 src/gatt-manager.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 5 deletions(-)

diff --git a/src/gatt-manager.c b/src/gatt-manager.c
index e11d36d..9e09894 100644
--- a/src/gatt-manager.c
+++ b/src/gatt-manager.c
@@ -559,10 +559,116 @@ error:
 	gatt_db_attribute_read_result(attrib, id, ecode, NULL, 0);
 }
 
+static void write_setup_cb(DBusMessageIter *iter, void *user_data)
+{
+	struct pending_dbus_op *op = user_data;
+	struct iovec *iov = op->user_data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&iov->iov_base, iov->iov_len);
+	dbus_message_iter_close_container(iter, &array);
+}
+
+static void write_reply_cb(DBusMessage *message, void *user_data)
+{
+	struct pending_dbus_op *op = user_data;
+	DBusError err;
+	DBusMessageIter iter;
+	uint8_t ecode = 0;
+
+	if (!op->chrc) {
+		DBG("Pending write was canceled when object got removed");
+		return;
+	}
+
+	dbus_error_init(&err);
+
+	if (dbus_set_error_from_message(&err, message) == TRUE) {
+		DBG("Failed to write value: %s: %s", err.name, err.message);
+		ecode = dbus_error_to_att_ecode(err.name);
+		ecode = ecode ? ecode : BT_ATT_ERROR_WRITE_NOT_PERMITTED;
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	dbus_message_iter_init(message, &iter);
+	if (dbus_message_iter_has_next(&iter)) {
+		/*
+		 * Return not supported for this, as the external app basically
+		 * doesn't properly support the "WriteValue" API.
+		 */
+		ecode = BT_ATT_ERROR_REQUEST_NOT_SUPPORTED;
+		error("Invalid return value received for \"WriteValue\"");
+	}
+
+done:
+	gatt_db_attribute_write_result(op->chrc->attrib, op->id, ecode);
+}
+
+static void chrc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct external_chrc *chrc = user_data;
+	struct pending_dbus_op *op;
+	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
+	struct iovec iov;
+
+	if (chrc->attrib != attrib) {
+		error("Write callback called with incorrect attribute");
+		goto error;
+	}
+
+	op = new0(struct pending_dbus_op, 1);
+	if (!op) {
+		error("Failed to allocate memory for pending read call");
+		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
+	}
+
+	iov.iov_base = (uint8_t *) value;
+	iov.iov_len = len;
+
+	op->chrc = chrc;
+	op->id = id;
+	op->user_data = &iov;
+	queue_push_tail(chrc->pending_ops, op);
+
+	if (g_dbus_proxy_method_call(chrc->proxy, "WriteValue", write_setup_cb,
+						write_reply_cb, op,
+						pending_dbus_op_free) == TRUE)
+		return;
+
+	pending_dbus_op_free(op);
+
+error:
+	gatt_db_attribute_write_result(attrib, id, ecode);
+}
+
+static uint32_t permissions_from_props(uint8_t props, uint8_t ext_props)
+{
+	uint32_t perm = 0;
+
+	if (props & BT_GATT_CHRC_PROP_WRITE ||
+			props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP ||
+			ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE)
+		perm |= BT_ATT_PERM_WRITE;
+
+	if (props & BT_GATT_CHRC_PROP_READ)
+		perm |= BT_ATT_PERM_READ;
+
+	return perm;
+}
+
 static bool create_chrc_entry(struct external_service *service,
 						struct external_chrc *chrc)
 {
 	bt_uuid_t uuid;
+	uint32_t perm;
 
 	if (!parse_uuid(chrc->proxy, &uuid)) {
 		error("Failed to read \"UUID\" property of characteristic");
@@ -571,15 +677,19 @@ static bool create_chrc_entry(struct external_service *service,
 
 	if (!parse_service(chrc->proxy, service)) {
 		error("Invalid service path for characteristic");
-		service->failed = true;
 		return false;
 	}
 
-	/* TODO: Assign permissions and write callback */
+	/*
+	 * TODO: Once shared/gatt-server properly supports permission checks,
+	 * set the permissions based on a D-Bus property of the external
+	 * characteristic.
+	 */
+	perm = permissions_from_props(chrc->props, chrc->ext_props);
 	chrc->attrib = gatt_db_service_add_characteristic(service->attrib,
-							&uuid, 0, chrc->props,
-							chrc_read_cb,
-							NULL, chrc);
+						&uuid, perm,
+						chrc->props, chrc_read_cb,
+						chrc_write_cb, chrc);
 
 	/* TODO: Create descriptor entries */
 
-- 
2.2.0.rc0.207.ga3a616c

