Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] obex-client: Port MAP module to use D-Bus properties interface
Date: Fri, 14 Dec 2012 23:31:57 +0200
Message-Id: <1355520720-11731-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 obexd/client/map.c | 315 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 178 insertions(+), 137 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index dcbcc8b..9cae20e 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -107,7 +107,7 @@ struct map_msg {
 	uint64_t size;
 	char *status;
 	uint8_t flags;
-	DBusMessage *msg;
+	GDBusPendingPropertySet pending;
 };
 
 struct map_parser {
@@ -421,176 +421,205 @@ static void set_message_status_cb(struct obc_session *session,
 						GError *err, void *user_data)
 {
 	struct map_msg *msg = user_data;
-	DBusMessage *reply;
 
 	if (err != NULL) {
-		reply = g_dbus_create_error(msg->msg,
+		g_dbus_pending_property_error(msg->pending,
 						ERROR_INTERFACE ".Failed",
 						"%s", err->message);
 		goto done;
 	}
 
-	reply = dbus_message_new_method_return(msg->msg);
-	if (reply == NULL) {
-		reply = g_dbus_create_error(msg->msg,
-						ERROR_INTERFACE ".Failed",
-						"%s", err->message);
-	}
+	g_dbus_pending_property_success(msg->pending);
 
 done:
-	g_dbus_send_message(conn, reply);
-	dbus_message_unref(msg->msg);
-	msg->msg = NULL;
+	msg->pending = 0;
 }
 
-static DBusMessage *map_msg_set_property(DBusConnection *connection,
-						DBusMessage *message,
-						void *user_data)
+static gboolean get_subject(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	struct map_msg *msg = user_data;
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &msg->subject);
+
+	return TRUE;
+}
+
+static gboolean get_timestamp(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &msg->timestamp);
+
+	return TRUE;
+}
+
+static gboolean get_sender(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &msg->sender);
+
+	return TRUE;
+}
+
+static gboolean get_sender_address(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&msg->sender_address);
+
+	return TRUE;
+}
+
+static gboolean get_replyto(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &msg->replyto);
+
+	return TRUE;
+}
+
+static gboolean get_recipient(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &msg->recipient);
+
+	return TRUE;
+}
+
+static gboolean get_recipient_address(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+						&msg->recipient_address);
+
+	return TRUE;
+}
+
+static gboolean get_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &msg->type);
+
+	return TRUE;
+}
+
+static gboolean get_size(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct map_msg *msg = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64, &msg->size);
+
+	return TRUE;
+}
+
+static gboolean get_flag(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, uint8_t flag,
+					void *data)
+{
+	struct map_msg *msg = data;
+	dbus_bool_t value = (msg->flags & flag) != 0;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean get_priority(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	return get_flag(property, iter, MAP_MSG_FLAG_PRIORITY, data);
+}
+
+static gboolean get_read(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	return get_flag(property, iter, MAP_MSG_FLAG_READ, data);
+}
+
+static gboolean get_sent(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	return get_flag(property, iter, MAP_MSG_FLAG_SENT, data);
+}
+
+static gboolean get_protected(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	return get_flag(property, iter, MAP_MSG_FLAG_PROTECTED, data);
+}
+
+static void set_status(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			uint8_t status, void *data)
+{
+	struct map_msg *msg = data;
 	struct obc_transfer *transfer;
-	char *property;
-	gboolean status;
+	gboolean value;
 	GError *err = NULL;
-	DBusMessage *reply;
 	GObexApparam *apparam;
 	char contents[2];
-	int op;
-	DBusMessageIter args, variant;
 
-	dbus_message_iter_init(message, &args);
-	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".InvalidArguments", NULL);
-
-	dbus_message_iter_get_basic(&args, &property);
-	dbus_message_iter_next(&args);
-	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_VARIANT)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".InvalidArguments", NULL);
-
-	dbus_message_iter_recurse(&args, &variant);
-	if (dbus_message_iter_get_arg_type(&variant) != DBUS_TYPE_BOOLEAN)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".InvalidArguments", NULL);
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
-	dbus_message_iter_get_basic(&variant, &status);
-
-	/* MAP supports modifying only these two properties. */
-	if (property && strcasecmp(property, "Read") == 0) {
-		op = STATUS_READ;
-		if (status)
-			msg->flags |= MAP_MSG_FLAG_READ;
-		else
-			msg->flags &= ~MAP_MSG_FLAG_READ;
-	} else if (property && strcasecmp(property, "Deleted") == 0)
-		op = STATUS_DELETE;
-	else {
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".InvalidArguments", NULL);
-	}
+	dbus_message_iter_get_basic(iter, &value);
 
 	contents[0] = FILLER_BYTE;
 	contents[1] = '\0';
 
 	transfer = obc_transfer_put("x-bt/messageStatus", msg->handle, NULL,
-							contents,
-							sizeof(contents), &err);
+					contents, sizeof(contents), &err);
 	if (transfer == NULL)
 		goto fail;
 
 	apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_STATUSINDICATOR,
-								op);
-	apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_STATUSVALUE,
 								status);
+	apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_STATUSVALUE,
+								value);
 	obc_transfer_set_apparam(transfer, apparam);
 
 	if (!obc_session_queue(msg->data->session, transfer,
 				set_message_status_cb, msg, &err))
 		goto fail;
 
-	msg->msg = dbus_message_ref(message);
-	return NULL;
+	msg->pending = id;
+	return;
 
 fail:
-	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+	g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed", "%s",
 								err->message);
 	g_error_free(err);
-	return reply;
 }
 
-static DBusMessage *map_msg_get_properties(DBusConnection *connection,
-						DBusMessage *message,
-						void *user_data)
+static void set_read(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
 {
-	struct map_msg *msg = user_data;
-	GError *err = NULL;
-	DBusMessage *reply;
-	DBusMessageIter iter, data_array;
-	gboolean flag;
-
-	reply = dbus_message_new_method_return(message);
-	if (reply == NULL) {
-		reply = g_dbus_create_error(message,
-						ERROR_INTERFACE ".Failed",
-						NULL);
-		goto done;
-	}
-
-	dbus_message_iter_init_append(reply, &iter);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-					DBUS_TYPE_STRING_AS_STRING
-					DBUS_TYPE_VARIANT_AS_STRING
-					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
-					&data_array);
-
-
-	obex_dbus_dict_append(&data_array, "Subject",
-				DBUS_TYPE_STRING, &msg->subject);
-	obex_dbus_dict_append(&data_array, "Timestamp",
-				DBUS_TYPE_STRING, &msg->timestamp);
-	obex_dbus_dict_append(&data_array, "Sender",
-				DBUS_TYPE_STRING, &msg->sender);
-	obex_dbus_dict_append(&data_array, "SenderAddress",
-				DBUS_TYPE_STRING, &msg->sender_address);
-	obex_dbus_dict_append(&data_array, "ReplyTo",
-				DBUS_TYPE_STRING, &msg->replyto);
-	obex_dbus_dict_append(&data_array, "Recipient",
-				DBUS_TYPE_STRING, &msg->recipient);
-	obex_dbus_dict_append(&data_array, "RecipientAddress",
-				DBUS_TYPE_STRING, &msg->recipient_address);
-	obex_dbus_dict_append(&data_array, "Type",
-				DBUS_TYPE_STRING, &msg->type);
-	obex_dbus_dict_append(&data_array, "Status",
-				DBUS_TYPE_STRING, &msg->status);
-	obex_dbus_dict_append(&data_array, "Size",
-				DBUS_TYPE_UINT64, &msg->size);
-
-	flag = (msg->flags & MAP_MSG_FLAG_PRIORITY) != 0;
-	obex_dbus_dict_append(&data_array, "Priority",
-				DBUS_TYPE_BOOLEAN, &flag);
-
-	flag = (msg->flags & MAP_MSG_FLAG_READ) != 0;
-	obex_dbus_dict_append(&data_array, "Read",
-				DBUS_TYPE_BOOLEAN, &flag);
-
-	flag = (msg->flags & MAP_MSG_FLAG_SENT) != 0;
-	obex_dbus_dict_append(&data_array, "Sent",
-				DBUS_TYPE_BOOLEAN, &flag);
-
-	flag = (msg->flags & MAP_MSG_FLAG_PROTECTED) != 0;
-	obex_dbus_dict_append(&data_array, "Protected",
-				DBUS_TYPE_BOOLEAN, &flag);
-
-	dbus_message_iter_close_container(&iter, &data_array);
-
-
-done:
-	if (err)
-		g_error_free(err);
+	set_status(property, iter, id, STATUS_READ, data);
+}
 
-	return reply;
+static void set_deleted(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	set_status(property, iter, id, STATUS_DELETE, data);
 }
 
 static const GDBusMethodTable map_msg_methods[] = {
@@ -600,13 +629,24 @@ static const GDBusMethodTable map_msg_methods[] = {
 			GDBUS_ARGS({ "transfer", "o" },
 						{ "properties", "a{sv}" }),
 			map_msg_get) },
-	{ GDBUS_METHOD("GetProperties",
-			NULL,
-			GDBUS_ARGS({ "properties", "a{sv}" }),
-			map_msg_get_properties) },
-	{ GDBUS_ASYNC_METHOD("SetProperty",
-			GDBUS_ARGS({ "property", "sv" }), NULL,
-			map_msg_set_property) },
+	{ }
+};
+
+static const GDBusPropertyTable map_msg_properties[] = {
+	{ "Subject", "s", get_subject },
+	{ "Timestamp", "s", get_timestamp },
+	{ "Sender", "s", get_sender },
+	{ "SenderAddress", "s", get_sender_address },
+	{ "ReplyTo", "s", get_replyto },
+	{ "Recipient", "s", get_recipient },
+	{ "RecipientAddress", "s", get_recipient_address },
+	{ "Type", "s", get_type },
+	{ "Size", "t", get_size },
+	{ "Priority", "b", get_priority },
+	{ "Read", "b", get_read, set_read },
+	{ "Sent", "b", get_sent },
+	{ "Protected", "b", get_sent },
+	{ "Deleted", "b", NULL, set_deleted },
 	{ }
 };
 
@@ -621,7 +661,8 @@ static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
 					handle);
 
 	if (!g_dbus_register_interface(conn, msg->path, MAP_MSG_INTERFACE,
-						map_msg_methods, NULL, NULL,
+						map_msg_methods, NULL,
+						map_msg_properties,
 						msg, map_msg_free)) {
 		map_msg_free(msg);
 		return NULL;
-- 
1.7.11.7

