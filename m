Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] doc/gatt-api: Add options dictionary to ReadValue/WriteValue
Date: Fri,  6 May 2016 22:10:59 +0300
Message-Id: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the possibility to pass an offset to these operations, and
also in the server case to give the device object.
---
 doc/gatt-api.txt    |  20 ++++--
 src/gatt-client.c   | 135 +++++++++++++++++++++++++++++----------
 src/gatt-database.c | 177 +++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 245 insertions(+), 87 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index ad2ab16..683b1b7 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -61,23 +61,29 @@ Service		org.bluez
 Interface	org.bluez.GattCharacteristic1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
 
-Methods		array{byte} ReadValue()
+Methods		array{byte} ReadValue(dict options)
 
 			Issues a request to read the value of the
 			characteristic and returns the value if the
 			operation was successful.
 
+			Possible options: "offset": uint16 offset
+					  "device": Object Device (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.NotAuthorized
 					 org.bluez.Error.NotSupported
 
-		void WriteValue(array{byte} value)
+		void WriteValue(array{byte} value, dict options)
 
 			Issues a request to write the value of the
 			characteristic.
 
+			Possible options: "offset": Start offset
+					  "device": Device path (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
@@ -154,23 +160,29 @@ Service		org.bluez
 Interface	org.bluez.GattDescriptor1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY/descriptorZZZ
 
-Methods		array{byte} ReadValue()
+Methods		array{byte} ReadValue(dict flags)
 
 			Issues a request to read the value of the
 			characteristic and returns the value if the
 			operation was successful.
 
+			Possible options: "offset": Start offset
+					  "device": Device path (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.NotAuthorized
 					 org.bluez.Error.NotSupported
 
-		void WriteValue(array{byte} value)
+		void WriteValue(array{byte} value, dict flags)
 
 			Issues a request to write the value of the
 			characteristic.
 
+			Possible options: "offset": Start offset
+					  "device": Device path (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
diff --git a/src/gatt-client.c b/src/gatt-client.c
index 16a1f6c..c51cdc8 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -23,6 +23,7 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#include <errno.h>
 
 #include <dbus/dbus.h>
 
@@ -390,12 +391,67 @@ fail:
 	return;
 }
 
+static int parse_options(DBusMessage *msg, uint16_t *offset)
+{
+	DBusMessageIter args, flags;
+
+	if (!dbus_message_iter_init(msg, &args))
+		return -EINVAL;
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(&args, &flags);
+	if (dbus_message_iter_get_arg_type(&flags) != DBUS_TYPE_DICT_ENTRY)
+		return -EINVAL;
+
+	while (dbus_message_iter_get_arg_type(&flags) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(&flags, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "offset") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, offset);
+		}
+	}
+
+	return 0;
+}
+
+static unsigned int read_value(struct bt_gatt_client *gatt, uint16_t handle,
+				bt_gatt_client_read_callback_t callback,
+				struct async_dbus_op *op)
+{
+	if (op->offset)
+		return bt_gatt_client_read_long_value(gatt, handle, op->offset,
+							callback,
+							async_dbus_op_ref(op),
+							async_dbus_op_unref);
+	else
+		return bt_gatt_client_read_value(gatt, handle, callback,
+							async_dbus_op_ref(op),
+							async_dbus_op_unref);
+}
+
 static DBusMessage *descriptor_read_value(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct descriptor *desc = user_data;
 	struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
 	struct async_dbus_op *op;
+	uint16_t offset = 0;
+
+	if (parse_options(msg, &offset))
+		return btd_error_invalid_args(msg);
 
 	if (!gatt)
 		return btd_error_failed(msg, "Not connected");
@@ -406,17 +462,16 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
 	op = new0(struct async_dbus_op, 1);
 	op->msg = dbus_message_ref(msg);
 	op->data = desc;
+	op->offset = offset;
 
-	desc->read_id = bt_gatt_client_read_value(gatt, desc->handle,
-							desc_read_cb,
-							async_dbus_op_ref(op),
-							async_dbus_op_unref);
+	desc->read_id = read_value(gatt, desc->handle, desc_read_cb, op);
 	if (desc->read_id)
 		return NULL;
 
 	async_dbus_op_free(op);
 
 	return btd_error_failed(msg, "Failed to send read request");
+
 }
 
 static void write_result_cb(bool success, bool reliable_error,
@@ -459,7 +514,8 @@ static void write_cb(bool success, uint8_t att_ecode, void *user_data)
 static unsigned int start_long_write(DBusMessage *msg, uint16_t handle,
 					struct bt_gatt_client *gatt,
 					bool reliable, const uint8_t *value,
-					size_t value_len, void *data,
+					size_t value_len, uint16_t offset,
+					void *data,
 					async_dbus_op_complete_t complete)
 {
 	struct async_dbus_op *op;
@@ -469,9 +525,10 @@ static unsigned int start_long_write(DBusMessage *msg, uint16_t handle,
 	op->msg = dbus_message_ref(msg);
 	op->data = data;
 	op->complete = complete;
+	op->offset = offset;
 
-	id = bt_gatt_client_write_long_value(gatt, reliable, handle,
-							0, value, value_len,
+	id = bt_gatt_client_write_long_value(gatt, reliable, handle, offset,
+							value, value_len,
 							write_result_cb, op,
 							async_dbus_op_free);
 
@@ -524,6 +581,10 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 	struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
 	uint8_t *value = NULL;
 	size_t value_len = 0;
+	uint16_t offset = 0;
+
+	if (parse_options(msg, &offset))
+		return btd_error_invalid_args(msg);
 
 	if (!gatt)
 		return btd_error_failed(msg, "Not connected");
@@ -546,15 +607,15 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 	 * Based on the value length and the MTU, either use a write or a long
 	 * write.
 	 */
-	if (value_len <= (unsigned) bt_gatt_client_get_mtu(gatt) - 3)
+	if (value_len <= (unsigned) bt_gatt_client_get_mtu(gatt) - 3 && !offset)
 		desc->write_id = start_write_request(msg, desc->handle,
 							gatt, value,
 							value_len, desc,
 							desc_write_complete);
 	else
-		desc->write_id = start_long_write(msg, desc->handle,
-							gatt, false, value,
-							value_len, desc,
+		desc->write_id = start_long_write(msg, desc->handle, gatt,
+							false, value,
+							value_len, offset, desc,
 							desc_write_complete);
 
 	if (!desc->write_id)
@@ -574,13 +635,15 @@ static const GDBusPropertyTable descriptor_properties[] = {
 };
 
 static const GDBusMethodTable descriptor_methods[] = {
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ReadValue", NULL,
-						GDBUS_ARGS({ "value", "ay" }),
-						descriptor_read_value) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ReadValue",
+					GDBUS_ARGS({ "options", "a{sv}" }),
+					GDBUS_ARGS({ "value", "ay" }),
+					descriptor_read_value) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("WriteValue",
-						GDBUS_ARGS({ "value", "ay" }),
-						NULL,
-						descriptor_write_value) },
+					GDBUS_ARGS({ "value", "ay" },
+						{ "options", "a{sv}" }),
+					NULL,
+					descriptor_write_value) },
 	{ }
 };
 
@@ -838,6 +901,10 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 	struct characteristic *chrc = user_data;
 	struct bt_gatt_client *gatt = chrc->service->client->gatt;
 	struct async_dbus_op *op;
+	uint16_t offset = 0;
+
+	if (parse_options(msg, &offset))
+		return btd_error_invalid_args(msg);
 
 	if (!gatt)
 		return btd_error_failed(msg, "Not connected");
@@ -848,11 +915,9 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 	op = new0(struct async_dbus_op, 1);
 	op->msg = dbus_message_ref(msg);
 	op->data = chrc;
+	op->offset = offset;
 
-	chrc->read_id = bt_gatt_client_read_value(gatt, chrc->value_handle,
-							chrc_read_cb,
-							async_dbus_op_ref(op),
-							async_dbus_op_unref);
+	chrc->read_id = read_value(gatt, chrc->value_handle, chrc_read_cb, op);
 	if (chrc->read_id)
 		return NULL;
 
@@ -882,6 +947,10 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	uint8_t *value = NULL;
 	size_t value_len = 0;
 	bool supported = false;
+	uint16_t offset = 0;
+
+	if (parse_options(msg, &offset))
+		return btd_error_invalid_args(msg);
 
 	if (!gatt)
 		return btd_error_failed(msg, "Not connected");
@@ -906,7 +975,7 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	if ((chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE)) {
 		supported = true;
 		chrc->write_id = start_long_write(msg, chrc->value_handle, gatt,
-						true, value, value_len,
+						true, value, value_len, offset,
 						chrc, chrc_write_complete);
 		if (chrc->write_id)
 			return NULL;
@@ -920,7 +989,7 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 		if (!mtu)
 			return btd_error_failed(msg, "No ATT transport");
 
-		if (value_len <= (unsigned) mtu - 3)
+		if (value_len <= (unsigned) mtu - 3 && !offset)
 			chrc->write_id = start_write_request(msg,
 						chrc->value_handle,
 						gatt, value, value_len,
@@ -928,7 +997,7 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 		else
 			chrc->write_id = start_long_write(msg,
 						chrc->value_handle, gatt,
-						false, value, value_len,
+						false, value, value_len, offset,
 						chrc, chrc_write_complete);
 
 		if (chrc->write_id)
@@ -1242,17 +1311,19 @@ static const GDBusPropertyTable characteristic_properties[] = {
 };
 
 static const GDBusMethodTable characteristic_methods[] = {
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ReadValue", NULL,
-						GDBUS_ARGS({ "value", "ay" }),
-						characteristic_read_value) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ReadValue",
+					GDBUS_ARGS({ "options", "a{sv}" }),
+					GDBUS_ARGS({ "value", "ay" }),
+					characteristic_read_value) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("WriteValue",
-						GDBUS_ARGS({ "value", "ay" }),
-						NULL,
-						characteristic_write_value) },
+					GDBUS_ARGS({ "value", "ay" },
+						{ "options", "a{sv}" }),
+					NULL,
+					characteristic_write_value) },
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("StartNotify", NULL, NULL,
-						characteristic_start_notify) },
+					characteristic_start_notify) },
 	{ GDBUS_EXPERIMENTAL_METHOD("StopNotify", NULL, NULL,
-						characteristic_stop_notify) },
+					characteristic_stop_notify) },
 	{ }
 };
 
diff --git a/src/gatt-database.c b/src/gatt-database.c
index b8da955..7f36ffd 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -135,6 +135,7 @@ struct external_desc {
 };
 
 struct pending_op {
+	struct btd_device *device;
 	unsigned int id;
 	struct gatt_db_attribute *attrib;
 	struct queue *owner_queue;
@@ -1592,7 +1593,8 @@ static void pending_op_free(void *data)
 	free(op);
 }
 
-static struct pending_op *pending_read_new(struct queue *owner_queue,
+static struct pending_op *pending_read_new(struct btd_device *device,
+					struct queue *owner_queue,
 					struct gatt_db_attribute *attrib,
 					unsigned int id)
 {
@@ -1601,6 +1603,7 @@ static struct pending_op *pending_read_new(struct queue *owner_queue,
 	op = new0(struct pending_op, 1);
 
 	op->owner_queue = owner_queue;
+	op->device = device;
 	op->attrib = attrib;
 	op->id = id;
 	queue_push_tail(owner_queue, op);
@@ -1608,17 +1611,44 @@ static struct pending_op *pending_read_new(struct queue *owner_queue,
 	return op;
 }
 
-static void send_read(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
-						struct queue *owner_queue,
-						unsigned int id)
+static void append_options(DBusMessageIter *iter, void *user_data)
+{
+	struct pending_op *op = user_data;
+	const char *path = device_get_path(op->device);
+
+	dict_append_entry(iter, "device", DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static void read_setup_cb(DBusMessageIter *iter, void *user_data)
+{
+	struct pending_op *op = user_data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	append_options(&dict, op);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void send_read(struct btd_device *device,
+					struct gatt_db_attribute *attrib,
+					GDBusProxy *proxy,
+					struct queue *owner_queue,
+					unsigned int id)
 {
 	struct pending_op *op;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 
-	op = pending_read_new(owner_queue, attrib, id);
+	op = pending_read_new(device, owner_queue, attrib, id);
 
-	if (g_dbus_proxy_method_call(proxy, "ReadValue", NULL, read_reply_cb,
-						op, pending_op_free) == TRUE)
+	if (g_dbus_proxy_method_call(proxy, "ReadValue", read_setup_cb,
+				read_reply_cb, op, pending_op_free) == TRUE)
 		return;
 
 	pending_op_free(op);
@@ -1629,12 +1659,28 @@ static void send_read(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
 static void write_setup_cb(DBusMessageIter *iter, void *user_data)
 {
 	struct pending_op *op = user_data;
-	DBusMessageIter array;
+	DBusMessageIter array, dict;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
 	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
 					&op->data.iov_base, op->data.iov_len);
 	dbus_message_iter_close_container(iter, &array);
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	append_options(&dict, op);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	if (!op->owner_queue) {
+		gatt_db_attribute_write_result(op->attrib, op->id, 0);
+		pending_op_free(op);
+	}
 }
 
 static void write_reply_cb(DBusMessage *message, void *user_data)
@@ -1673,7 +1719,8 @@ done:
 	gatt_db_attribute_write_result(op->attrib, op->id, ecode);
 }
 
-static struct pending_op *pending_write_new(struct queue *owner_queue,
+static struct pending_op *pending_write_new(struct btd_device *device,
+					struct queue *owner_queue,
 					struct gatt_db_attribute *attrib,
 					unsigned int id,
 					const uint8_t *value,
@@ -1686,6 +1733,7 @@ static struct pending_op *pending_write_new(struct queue *owner_queue,
 	op->data.iov_base = (uint8_t *) value;
 	op->data.iov_len = len;
 
+	op->device = device;
 	op->owner_queue = owner_queue;
 	op->attrib = attrib;
 	op->id = id;
@@ -1694,7 +1742,9 @@ static struct pending_op *pending_write_new(struct queue *owner_queue,
 	return op;
 }
 
-static void send_write(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
+static void send_write(struct btd_device *device,
+					struct gatt_db_attribute *attrib,
+					GDBusProxy *proxy,
 					struct queue *owner_queue,
 					unsigned int id,
 					const uint8_t *value, size_t len)
@@ -1702,11 +1752,11 @@ static void send_write(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
 	struct pending_op *op;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 
-	op = pending_write_new(owner_queue, attrib, id, value, len);
+	op = pending_write_new(device, owner_queue, attrib, id, value, len);
 
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
-						write_reply_cb, op,
-						pending_op_free) == TRUE)
+					owner_queue ? write_reply_cb : NULL,
+					op, pending_op_free) == TRUE)
 		return;
 
 	pending_op_free(op);
@@ -1895,19 +1945,58 @@ static bool database_add_cep(struct external_service *service,
 	return true;
 }
 
+static struct btd_device *att_get_device(struct bt_att *att)
+{
+	GIOChannel *io = NULL;
+	GError *gerr = NULL;
+	bdaddr_t src, dst;
+	uint8_t dst_type;
+	struct btd_adapter *adapter;
+
+	io = g_io_channel_unix_new(bt_att_get_fd(att));
+	if (!io)
+		return false;
+
+	bt_io_get(io, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_DEST_BDADDR, &dst,
+					BT_IO_OPT_DEST_TYPE, &dst_type,
+					BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_unref(io);
+		return false;
+	}
+
+	g_io_channel_unref(io);
+
+	adapter = adapter_find(&src);
+	if (!adapter) {
+		error("Unable to find adapter object");
+		return false;
+	}
+
+	return btd_adapter_find_device(adapter, &dst, dst_type);
+}
+
 static void desc_read_cb(struct gatt_db_attribute *attrib,
 					unsigned int id, uint16_t offset,
 					uint8_t opcode, struct bt_att *att,
 					void *user_data)
 {
 	struct external_desc *desc = user_data;
+	struct btd_device *device;
 
 	if (desc->attrib != attrib) {
 		error("Read callback called with incorrect attribute");
 		return;
 	}
 
-	send_read(attrib, desc->proxy, desc->pending_reads, id);
+	device = att_get_device(att);
+	if (!device)
+		error("Unable to find device object");
+
+	send_read(device, attrib, desc->proxy, desc->pending_reads, id);
 }
 
 static void desc_write_cb(struct gatt_db_attribute *attrib,
@@ -1917,13 +2006,19 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct external_desc *desc = user_data;
+	struct btd_device *device;
 
 	if (desc->attrib != attrib) {
 		error("Read callback called with incorrect attribute");
 		return;
 	}
 
-	send_write(attrib, desc->proxy, desc->pending_writes, id, value, len);
+	device = att_get_device(att);
+	if (!device)
+		error("Unable to find device object");
+
+	send_write(device, attrib, desc->proxy, desc->pending_writes, id,
+							value, len);
 }
 
 static bool database_add_desc(struct external_service *service,
@@ -1956,43 +2051,18 @@ static void chrc_read_cb(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct external_chrc *chrc = user_data;
+	struct btd_device *device;
 
 	if (chrc->attrib != attrib) {
 		error("Read callback called with incorrect attribute");
 		return;
 	}
 
-	send_read(attrib, chrc->proxy, chrc->pending_reads, id);
-}
-
-static void write_without_response_setup_cb(DBusMessageIter *iter,
-							void *user_data)
-{
-	struct iovec *iov = user_data;
-	DBusMessageIter array;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
-	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
-						&iov->iov_base, iov->iov_len);
-	dbus_message_iter_close_container(iter, &array);
-}
-
-static void send_write_without_response(struct gatt_db_attribute *attrib,
-					GDBusProxy *proxy, unsigned int id,
-					const uint8_t *value, size_t len)
-{
-	struct iovec iov;
-	uint8_t ecode = 0;
-
-	iov.iov_base = (uint8_t *) value;
-	iov.iov_len = len;
-
-	if (!g_dbus_proxy_method_call(proxy, "WriteValue",
-					write_without_response_setup_cb,
-					NULL, &iov, NULL))
-		ecode = BT_ATT_ERROR_UNLIKELY;
+	device = att_get_device(att);
+	if (!device)
+		error("Unable to find device object");
 
-	gatt_db_attribute_write_result(attrib, id, ecode);
+	send_read(device, attrib, chrc->proxy, chrc->pending_reads, id);
 }
 
 static void chrc_write_cb(struct gatt_db_attribute *attrib,
@@ -2002,19 +2072,24 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct external_chrc *chrc = user_data;
+	struct btd_device *device;
+	struct queue *queue;
 
 	if (chrc->attrib != attrib) {
 		error("Write callback called with incorrect attribute");
 		return;
 	}
 
-	if (chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP) {
-		send_write_without_response(attrib, chrc->proxy, id, value,
-									len);
-		return;
-	}
+	if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
+		queue = chrc->pending_writes;
+	else
+		queue = NULL;
+
+	device = att_get_device(att);
+	if (!device)
+		error("Unable to find device object");
 
-	send_write(attrib, chrc->proxy, chrc->pending_writes, id, value, len);
+	send_write(device, attrib, chrc->proxy, queue, id, value, len);
 }
 
 static bool database_add_chrc(struct external_service *service,
-- 
2.5.5

