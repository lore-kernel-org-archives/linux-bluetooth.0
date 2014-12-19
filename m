Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 11/17] core: gatt: Implement GattCharacteristic1.WriteValue.
Date: Fri, 19 Dec 2014 13:35:59 -0800
Message-Id: <1419024965-10375-12-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the WriteValue method of
org.bluez.GattCharacteristic1. The GATT write procedure that should be
used is decided based on characteristic properties.
---
 src/gatt-client.c | 185 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 183 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index e00f432..4c0900b 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -79,6 +79,7 @@ struct characteristic {
 	char *path;
 
 	bool in_read;
+	bool in_write;
 	bool value_known;
 	uint8_t *value;
 	size_t value_len;
@@ -287,6 +288,35 @@ notify:
 								"Value");
 }
 
+static bool parse_value_arg(DBusMessage *msg, uint8_t **value,
+							size_t *value_len)
+{
+	DBusMessageIter iter, array;
+	uint8_t *val;
+	int len;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return false;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+		return false;
+
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &val, &len);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INVALID)
+		return false;
+
+	if (len < 0)
+		return false;
+
+	*value = val;
+	*value_len = len;
+
+	return true;
+}
+
 struct async_dbus_op {
 	DBusMessage *msg;
 	void *data;
@@ -378,6 +408,95 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
 	return btd_error_failed(msg, "Failed to send read request");
 }
 
+static void write_result_cb(bool success, bool reliable_error,
+					uint8_t att_ecode, void *user_data)
+{
+	struct async_dbus_op *op = user_data;
+	DBusMessage *reply;
+
+	if (op->data) {
+		struct characteristic *chrc;
+
+		chrc = op->data;
+		chrc->in_write = false;
+	}
+
+	if (!success) {
+		if (reliable_error)
+			reply = btd_error_failed(op->msg,
+						"Reliable write failed");
+		else
+			reply = create_gatt_dbus_error(op->msg, att_ecode);
+
+		goto done;
+	}
+
+	reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
+	if (!reply) {
+		error("Failed to allocate D-Bus message reply");
+		return;
+	}
+
+done:
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+}
+
+
+static void write_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	write_result_cb(success, false, att_ecode, user_data);
+}
+
+
+static bool start_long_write(DBusMessage *msg, uint16_t handle,
+					struct bt_gatt_client *gatt,
+					bool reliable, const uint8_t *value,
+					size_t value_len, void *data)
+{
+	struct async_dbus_op *op;
+
+	op = new0(struct async_dbus_op, 1);
+	if (!op)
+		return false;
+
+	op->msg = dbus_message_ref(msg);
+	op->data = data;
+
+	if (bt_gatt_client_write_long_value(gatt, reliable, handle,
+							0, value, value_len,
+							write_result_cb, op,
+							async_dbus_op_free))
+		return true;
+
+	async_dbus_op_free(op);
+
+	return false;
+}
+
+static bool start_write_request(DBusMessage *msg, uint16_t handle,
+					struct bt_gatt_client *gatt,
+					const uint8_t *value, size_t value_len,
+					void *data)
+{
+	struct async_dbus_op *op;
+
+	op = new0(struct async_dbus_op, 1);
+	if (!op)
+		return false;
+
+	op->msg = dbus_message_ref(msg);
+	op->data = data;
+
+	if (bt_gatt_client_write_value(gatt, handle, value, value_len,
+							write_cb, op,
+							async_dbus_op_free))
+		return true;
+
+	async_dbus_op_free(op);
+
+	return false;
+}
+
 static DBusMessage *descriptor_write_value(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -631,8 +750,70 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 static DBusMessage *characteristic_write_value(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	/* TODO: Implement */
-	return btd_error_failed(msg, "Not implemented");
+	struct characteristic *chrc = user_data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	uint8_t *value = NULL;
+	size_t value_len = 0;
+
+	if (chrc->in_write)
+		return btd_error_in_progress(msg);
+
+	if (!parse_value_arg(msg, &value, &value_len))
+		return btd_error_invalid_args(msg);
+
+	if (!(chrc->props & (BT_GATT_CHRC_PROP_WRITE |
+					BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)))
+		if (!(chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE))
+			return btd_error_not_supported(msg);
+
+	/*
+	 * Decide which write to use based on characteristic properties. For now
+	 * we don't perform signed writes since gatt-client doesn't support them
+	 * and the user can always encrypt the through pairing. The procedure to
+	 * use is determined based on the following priority:
+	 *
+	 *   * "reliable-write" property set -> reliable long-write.
+	 *   * "write" property set -> write request.
+	 *     - If value is larger than MTU - 3: long-write
+	 *   * "write-without-response" property set -> write command.
+	 */
+	if ((chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) &&
+			start_long_write(msg, chrc->value_handle, gatt, true,
+							value, value_len, chrc))
+		goto done_async;
+
+	if (chrc->props & BT_GATT_CHRC_PROP_WRITE) {
+		uint16_t mtu;
+		bool result;
+
+		mtu = bt_gatt_client_get_mtu(gatt);
+		if (!mtu)
+			return btd_error_failed(msg, "No ATT transport");
+
+		if (value_len <= (unsigned) mtu - 3)
+			result = start_write_request(msg, chrc->value_handle,
+							gatt, value,
+							value_len, chrc);
+		else
+			result = start_long_write(msg, chrc->value_handle, gatt,
+						false, value, value_len, chrc);
+
+		if (result)
+			goto done_async;
+	}
+
+	if ((chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP) &&
+			bt_gatt_client_write_without_response(gatt,
+							chrc->value_handle,
+							false, value,
+							value_len))
+		return dbus_message_new_method_return(msg);
+
+	return btd_error_failed(msg, "Failed to initiate write");
+
+done_async:
+	chrc->in_write = true;
+	return NULL;
 }
 
 struct notify_client {
-- 
2.2.0.rc0.207.ga3a616c

