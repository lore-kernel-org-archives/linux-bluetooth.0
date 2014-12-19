Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 13/17] core: gatt: Implement GattDescriptor1.WriteValue.
Date: Fri, 19 Dec 2014 13:36:01 -0800
Message-Id: <1419024965-10375-14-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the WriteValue method of org.bluez.GattDescriptor1
---
 src/gatt-client.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index d350b1b..ee0a9c9 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -97,6 +97,7 @@ struct descriptor {
 	char *path;
 
 	bool in_read;
+	bool in_write;
 	bool value_known;
 	uint8_t *value;
 	size_t value_len;
@@ -317,9 +318,12 @@ static bool parse_value_arg(DBusMessage *msg, uint8_t **value,
 	return true;
 }
 
+typedef bool (*async_dbus_op_complete_t)(void *data);
+
 struct async_dbus_op {
 	DBusMessage *msg;
 	void *data;
+	async_dbus_op_complete_t complete;
 };
 
 static void async_dbus_op_free(void *data)
@@ -543,11 +547,9 @@ static void write_result_cb(bool success, bool reliable_error,
 	struct async_dbus_op *op = user_data;
 	DBusMessage *reply;
 
-	if (op->data) {
-		struct characteristic *chrc;
-
-		chrc = op->data;
-		chrc->in_write = false;
+	if (op->complete && !op->complete(op->data)) {
+		reply = btd_error_failed(op->msg, "Operation failed");
+		goto done;
 	}
 
 	if (!success) {
@@ -576,11 +578,11 @@ static void write_cb(bool success, uint8_t att_ecode, void *user_data)
 	write_result_cb(success, false, att_ecode, user_data);
 }
 
-
 static bool start_long_write(DBusMessage *msg, uint16_t handle,
 					struct bt_gatt_client *gatt,
 					bool reliable, const uint8_t *value,
-					size_t value_len, void *data)
+					size_t value_len, void *data,
+					async_dbus_op_complete_t complete)
 {
 	struct async_dbus_op *op;
 
@@ -590,6 +592,7 @@ static bool start_long_write(DBusMessage *msg, uint16_t handle,
 
 	op->msg = dbus_message_ref(msg);
 	op->data = data;
+	op->complete = complete;
 
 	if (bt_gatt_client_write_long_value(gatt, reliable, handle,
 							0, value, value_len,
@@ -605,7 +608,8 @@ static bool start_long_write(DBusMessage *msg, uint16_t handle,
 static bool start_write_request(DBusMessage *msg, uint16_t handle,
 					struct bt_gatt_client *gatt,
 					const uint8_t *value, size_t value_len,
-					void *data)
+					void *data,
+					async_dbus_op_complete_t complete)
 {
 	struct async_dbus_op *op;
 
@@ -615,6 +619,7 @@ static bool start_write_request(DBusMessage *msg, uint16_t handle,
 
 	op->msg = dbus_message_ref(msg);
 	op->data = data;
+	op->complete = complete;
 
 	if (bt_gatt_client_write_value(gatt, handle, value, value_len,
 							write_cb, op,
@@ -626,11 +631,61 @@ static bool start_write_request(DBusMessage *msg, uint16_t handle,
 	return false;
 }
 
+static bool desc_write_complete(void *data)
+{
+	struct descriptor *desc = data;
+
+	desc->in_write = false;
+
+	/*
+	 * The descriptor might have been unregistered during the read. Return
+	 * failure.
+	 */
+	return !!desc->chrc;
+}
+
 static DBusMessage *descriptor_write_value(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	/* TODO: Implement */
-	return btd_error_failed(msg, "Not implemented");
+	struct descriptor *desc = user_data;
+	struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
+	uint8_t *value = NULL;
+	size_t value_len = 0;
+	bool result;
+
+	if (desc->in_write)
+		return btd_error_in_progress(msg);
+
+	if (!parse_value_arg(msg, &value, &value_len))
+		return btd_error_invalid_args(msg);
+
+	/*
+	 * Don't allow writing to Client Characteristic Configuration
+	 * descriptors. We achieve this through the StartNotify and StopNotify
+	 * methods on GattCharacteristic1.
+	 */
+	if (uuid_cmp(&desc->uuid, GATT_CLIENT_CHARAC_CFG_UUID))
+		return gatt_error_write_not_permitted(msg);
+
+	/*
+	 * Based on the value length and the MTU, either use a write or a long
+	 * write.
+	 */
+	if (value_len <= (unsigned) bt_gatt_client_get_mtu(gatt) - 3)
+		result = start_write_request(msg, desc->handle, gatt, value,
+							value_len, desc,
+							desc_write_complete);
+	else
+		result = start_long_write(msg, desc->handle, gatt, false, value,
+							value_len, desc,
+							desc_write_complete);
+
+	if (!result)
+		return btd_error_failed(msg, "Failed to initiate write");
+
+	desc->in_write = true;
+
+	return NULL;
 }
 
 static const GDBusPropertyTable descriptor_properties[] = {
@@ -876,6 +931,19 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 	return btd_error_failed(msg, "Failed to send read request");
 }
 
+static bool chrc_write_complete(void *data)
+{
+	struct characteristic *chrc = data;
+
+	chrc->in_write = false;
+
+	/*
+	 * The characteristic might have been unregistered during the read.
+	 * Return failure.
+	 */
+	return !!chrc->service;
+}
+
 static DBusMessage *characteristic_write_value(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -908,7 +976,8 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	 */
 	if ((chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) &&
 			start_long_write(msg, chrc->value_handle, gatt, true,
-							value, value_len, chrc))
+							value, value_len, chrc,
+							chrc_write_complete))
 		goto done_async;
 
 	if (chrc->props & BT_GATT_CHRC_PROP_WRITE) {
@@ -922,10 +991,12 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 		if (value_len <= (unsigned) mtu - 3)
 			result = start_write_request(msg, chrc->value_handle,
 							gatt, value,
-							value_len, chrc);
+							value_len, chrc,
+							chrc_write_complete);
 		else
 			result = start_long_write(msg, chrc->value_handle, gatt,
-						false, value, value_len, chrc);
+						false, value, value_len, chrc,
+						chrc_write_complete);
 
 		if (result)
 			goto done_async;
@@ -942,6 +1013,7 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 
 done_async:
 	chrc->in_write = true;
+
 	return NULL;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

