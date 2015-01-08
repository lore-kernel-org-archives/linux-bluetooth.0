Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 04/14] core: gatt: Cancel pending reads/writes
Date: Wed,  7 Jan 2015 21:48:18 -0800
Message-Id: <1420696108-29699-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Exported characteristic and descriptor structures now keep track of
pending read/write procedure ids and cancel the operation when they are
free'd.
---
 src/gatt-client.c | 157 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 89 insertions(+), 68 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 8bbb03d..a118870 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -83,8 +83,8 @@ struct characteristic {
 	bt_uuid_t uuid;
 	char *path;
 
-	bool in_read;
-	bool in_write;
+	unsigned int read_id;
+	unsigned int write_id;
 
 	struct queue *descs;
 };
@@ -96,8 +96,8 @@ struct descriptor {
 	bt_uuid_t uuid;
 	char *path;
 
-	bool in_read;
-	bool in_write;
+	unsigned int read_id;
+	unsigned int write_id;
 };
 
 static bool uuid_cmp(const bt_uuid_t *uuid, uint16_t u16)
@@ -339,7 +339,7 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 	if (!success) {
 		DBusMessage *reply = create_gatt_dbus_error(op->msg, att_ecode);
 
-		desc->in_read = false;
+		desc->read_id = 0;
 		g_dbus_send_message(btd_get_dbus_connection(), reply);
 		return;
 	}
@@ -354,16 +354,18 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 	 */
 	if (length == bt_gatt_client_get_mtu(service->client->gatt) - 1) {
 		op->offset += length;
-		if (bt_gatt_client_read_long_value(service->client->gatt,
+		desc->read_id = bt_gatt_client_read_long_value(
+							service->client->gatt,
 							desc->handle,
 							op->offset,
 							desc_read_cb,
 							async_dbus_op_ref(op),
-							async_dbus_op_unref))
+							async_dbus_op_unref);
+		if (desc->read_id)
 			return;
 	}
 
-	desc->in_read = false;
+	desc->read_id = 0;
 
 	/* Read the stored data from db */
 	gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_op_cb, op);
@@ -376,7 +378,7 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
 	struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
 	struct async_dbus_op *op;
 
-	if (desc->in_read)
+	if (desc->read_id)
 		return btd_error_in_progress(msg);
 
 	op = new0(struct async_dbus_op, 1);
@@ -386,12 +388,12 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
 	op->msg = dbus_message_ref(msg);
 	op->data = desc;
 
-	if (bt_gatt_client_read_value(gatt, desc->handle, desc_read_cb,
+	desc->read_id = bt_gatt_client_read_value(gatt, desc->handle,
+							desc_read_cb,
 							async_dbus_op_ref(op),
-							async_dbus_op_unref)) {
-		desc->in_read = true;
+							async_dbus_op_unref);
+	if (desc->read_id)
 		return NULL;
-	}
 
 	async_dbus_op_free(op);
 
@@ -435,13 +437,14 @@ static void write_cb(bool success, uint8_t att_ecode, void *user_data)
 	write_result_cb(success, false, att_ecode, user_data);
 }
 
-static bool start_long_write(DBusMessage *msg, uint16_t handle,
+static unsigned int start_long_write(DBusMessage *msg, uint16_t handle,
 					struct bt_gatt_client *gatt,
 					bool reliable, const uint8_t *value,
 					size_t value_len, void *data,
 					async_dbus_op_complete_t complete)
 {
 	struct async_dbus_op *op;
+	unsigned int id;
 
 	op = new0(struct async_dbus_op, 1);
 	if (!op)
@@ -451,24 +454,25 @@ static bool start_long_write(DBusMessage *msg, uint16_t handle,
 	op->data = data;
 	op->complete = complete;
 
-	if (bt_gatt_client_write_long_value(gatt, reliable, handle,
+	id = bt_gatt_client_write_long_value(gatt, reliable, handle,
 							0, value, value_len,
 							write_result_cb, op,
-							async_dbus_op_free))
-		return true;
+							async_dbus_op_free);
 
-	async_dbus_op_free(op);
+	if (!id)
+		async_dbus_op_free(op);
 
-	return false;
+	return id;
 }
 
-static bool start_write_request(DBusMessage *msg, uint16_t handle,
+static unsigned int start_write_request(DBusMessage *msg, uint16_t handle,
 					struct bt_gatt_client *gatt,
 					const uint8_t *value, size_t value_len,
 					void *data,
 					async_dbus_op_complete_t complete)
 {
 	struct async_dbus_op *op;
+	unsigned int id;
 
 	op = new0(struct async_dbus_op, 1);
 	if (!op)
@@ -478,21 +482,20 @@ static bool start_write_request(DBusMessage *msg, uint16_t handle,
 	op->data = data;
 	op->complete = complete;
 
-	if (bt_gatt_client_write_value(gatt, handle, value, value_len,
+	id = bt_gatt_client_write_value(gatt, handle, value, value_len,
 							write_cb, op,
-							async_dbus_op_free))
-		return true;
+							async_dbus_op_free);
+	if (!id)
+		async_dbus_op_free(op);
 
-	async_dbus_op_free(op);
-
-	return false;
+	return id;
 }
 
 static bool desc_write_complete(void *data)
 {
 	struct descriptor *desc = data;
 
-	desc->in_write = false;
+	desc->write_id = false;
 
 	/*
 	 * The descriptor might have been unregistered during the read. Return
@@ -508,9 +511,8 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 	struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
 	uint8_t *value = NULL;
 	size_t value_len = 0;
-	bool result;
 
-	if (desc->in_write)
+	if (desc->write_id)
 		return btd_error_in_progress(msg);
 
 	if (!parse_value_arg(msg, &value, &value_len))
@@ -529,19 +531,19 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 	 * write.
 	 */
 	if (value_len <= (unsigned) bt_gatt_client_get_mtu(gatt) - 3)
-		result = start_write_request(msg, desc->handle, gatt, value,
+		desc->write_id = start_write_request(msg, desc->handle,
+							gatt, value,
 							value_len, desc,
 							desc_write_complete);
 	else
-		result = start_long_write(msg, desc->handle, gatt, false, value,
+		desc->write_id = start_long_write(msg, desc->handle,
+							gatt, false, value,
 							value_len, desc,
 							desc_write_complete);
 
-	if (!result)
+	if (!desc->write_id)
 		return btd_error_failed(msg, "Failed to initiate write");
 
-	desc->in_write = true;
-
 	return NULL;
 }
 
@@ -614,9 +616,18 @@ static struct descriptor *descriptor_create(struct gatt_db_attribute *attr,
 static void unregister_descriptor(void *data)
 {
 	struct descriptor *desc = data;
+	struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
 
 	DBG("Removing GATT descriptor: %s", desc->path);
 
+	if (desc->read_id)
+		bt_gatt_client_cancel(gatt, desc->read_id);
+
+	if (desc->write_id)
+		bt_gatt_client_cancel(gatt, desc->write_id);
+
+	desc->chrc = NULL;
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), desc->path,
 							GATT_DESCRIPTOR_IFACE);
 }
@@ -757,7 +768,7 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 	if (!success) {
 		DBusMessage *reply = create_gatt_dbus_error(op->msg, att_ecode);
 
-		chrc->in_read = false;
+		chrc->read_id = 0;
 		g_dbus_send_message(btd_get_dbus_connection(), reply);
 		return ;
 	}
@@ -772,16 +783,18 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 	 */
 	if (length == bt_gatt_client_get_mtu(service->client->gatt) - 1) {
 		op->offset += length;
-		if (bt_gatt_client_read_long_value(service->client->gatt,
+		chrc->read_id = bt_gatt_client_read_long_value(
+							service->client->gatt,
 							chrc->value_handle,
 							op->offset,
 							chrc_read_cb,
 							async_dbus_op_ref(op),
-							async_dbus_op_unref))
+							async_dbus_op_unref);
+		if (chrc->read_id)
 			return;
 	}
 
-	chrc->in_read = false;
+	chrc->read_id = 0;
 
 	/* Read the stored data from db */
 	gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_op_cb, op);
@@ -794,7 +807,7 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 	struct bt_gatt_client *gatt = chrc->service->client->gatt;
 	struct async_dbus_op *op;
 
-	if (chrc->in_read)
+	if (chrc->read_id)
 		return btd_error_in_progress(msg);
 
 	op = new0(struct async_dbus_op, 1);
@@ -804,12 +817,12 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 	op->msg = dbus_message_ref(msg);
 	op->data = chrc;
 
-	if (bt_gatt_client_read_value(gatt, chrc->value_handle, chrc_read_cb,
-						async_dbus_op_ref(op),
-						async_dbus_op_unref)) {
-		chrc->in_read = true;
+	chrc->read_id = bt_gatt_client_read_value(gatt, chrc->value_handle,
+							chrc_read_cb,
+							async_dbus_op_ref(op),
+							async_dbus_op_unref);
+	if (chrc->read_id)
 		return NULL;
-	}
 
 	async_dbus_op_free(op);
 
@@ -820,7 +833,7 @@ static bool chrc_write_complete(void *data)
 {
 	struct characteristic *chrc = data;
 
-	chrc->in_write = false;
+	chrc->write_id = false;
 
 	/*
 	 * The characteristic might have been unregistered during the read.
@@ -836,17 +849,14 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	struct bt_gatt_client *gatt = chrc->service->client->gatt;
 	uint8_t *value = NULL;
 	size_t value_len = 0;
+	bool supported = false;
 
-	if (chrc->in_write)
+	if (chrc->write_id)
 		return btd_error_in_progress(msg);
 
 	if (!parse_value_arg(msg, &value, &value_len))
 		return btd_error_invalid_args(msg);
 
-	if (!(chrc->props & (BT_GATT_CHRC_PROP_WRITE |
-					BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP)))
-		return btd_error_not_supported(msg);
-
 	/*
 	 * Decide which write to use based on characteristic properties. For now
 	 * we don't perform signed writes since gatt-client doesn't support them
@@ -860,39 +870,43 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	 */
 	if (chrc->props & BT_GATT_CHRC_PROP_WRITE) {
 		uint16_t mtu;
-		bool result;
 
+		supported = true;
 		mtu = bt_gatt_client_get_mtu(gatt);
 		if (!mtu)
 			return btd_error_failed(msg, "No ATT transport");
 
 		if (value_len <= (unsigned) mtu - 3)
-			result = start_write_request(msg, chrc->value_handle,
-							gatt, value,
-							value_len, chrc,
-							chrc_write_complete);
+			chrc->write_id = start_write_request(msg,
+						chrc->value_handle,
+						gatt, value, value_len,
+						chrc, chrc_write_complete);
 		else
-			result = start_long_write(msg, chrc->value_handle, gatt,
-						false, value, value_len, chrc,
-						chrc_write_complete);
+			chrc->write_id = start_long_write(msg,
+						chrc->value_handle, gatt,
+						false, value, value_len,
+						chrc, chrc_write_complete);
 
-		if (result)
-			goto done_async;
+		if (chrc->write_id)
+			return NULL;
 	}
 
-	if ((chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP) &&
-			bt_gatt_client_write_without_response(gatt,
+	if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
+		goto fail;
+
+	supported = true;
+	chrc->write_id = bt_gatt_client_write_without_response(gatt,
 							chrc->value_handle,
 							false, value,
-							value_len))
+							value_len);
+	if (chrc->write_id)
 		return dbus_message_new_method_return(msg);
 
-	return btd_error_failed(msg, "Failed to initiate write");
-
-done_async:
-	chrc->in_write = true;
+fail:
+	if (supported)
+		return btd_error_failed(msg, "Failed to initiate write");
 
-	return NULL;
+	return btd_error_not_supported(msg);
 }
 
 static DBusMessage *characteristic_start_notify(DBusConnection *conn,
@@ -1024,9 +1038,16 @@ static struct characteristic *characteristic_create(
 static void unregister_characteristic(void *data)
 {
 	struct characteristic *chrc = data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
 
 	DBG("Removing GATT characteristic: %s", chrc->path);
 
+	if (chrc->read_id)
+		bt_gatt_client_cancel(gatt, chrc->read_id);
+
+	if (chrc->write_id)
+		bt_gatt_client_cancel(gatt, chrc->write_id);
+
 	queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
-- 
2.2.0.rc0.207.ga3a616c

