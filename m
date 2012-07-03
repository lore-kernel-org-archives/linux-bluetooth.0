Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 04/10] client: Change MessageAccess.GetMessageListing to not return raw xml
Date: Tue,  3 Jul 2012 21:28:08 +0300
Message-Id: <1341340094-32522-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
References: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the response and return as a list of dictionary where each
entry is a message and its properties,
---
 client/map.c |  406 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 369 insertions(+), 37 deletions(-)

diff --git a/client/map.c b/client/map.c
index 4475ad5..2c52095 100644
--- a/client/map.c
+++ b/client/map.c
@@ -42,12 +42,41 @@
 #define OBEX_MAS_UUID_LEN 16
 
 #define MAP_INTERFACE "org.bluez.obex.MessageAccess"
+#define MAP_MSG_INTERFACE "org.bluez.obex.Message"
 #define ERROR_INTERFACE "org.bluez.obex.Error"
 #define MAS_UUID "00001132-0000-1000-8000-00805f9b34fb"
 
 struct map_data {
 	struct obc_session *session;
 	DBusMessage *msg;
+	GHashTable *messages;
+};
+
+#define MAP_MSG_FLAG_PRIORITY	0x01
+#define MAP_MSG_FLAG_READ	0x02
+#define MAP_MSG_FLAG_SENT	0x04
+#define MAP_MSG_FLAG_PROTECTED	0x08
+
+struct map_msg {
+	struct map_data *data;
+	char *path;
+	char *handle;
+	char *subject;
+	char *timestamp;
+	char *sender;
+	char *sender_address;
+	char *replyto;
+	char *recipient;
+	char *recipient_address;
+	char *type;
+	uint64_t size;
+	char *status;
+	uint8_t flags;
+};
+
+struct map_parser {
+	struct map_data *data;
+	DBusMessageIter *iter;
 };
 
 static DBusConnection *conn = NULL;
@@ -98,41 +127,6 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 	return NULL;
 }
 
-static void buffer_cb(struct obc_session *session,
-						struct obc_transfer *transfer,
-						GError *err, void *user_data)
-{
-	struct map_data *map = user_data;
-	DBusMessage *reply;
-	char *contents;
-	size_t size;
-	int perr;
-
-	if (err != NULL) {
-		reply = g_dbus_create_error(map->msg,
-						ERROR_INTERFACE ".Failed",
-						"%s", err->message);
-		goto done;
-	}
-
-	perr = obc_transfer_get_contents(transfer, &contents, &size);
-	if (perr < 0) {
-		reply = g_dbus_create_error(map->msg,
-						ERROR_INTERFACE ".Failed",
-						"Error reading contents: %s",
-						strerror(-perr));
-		goto done;
-	}
-
-	reply = g_dbus_create_reply(map->msg, DBUS_TYPE_STRING, &contents,
-							DBUS_TYPE_INVALID);
-
-	g_free(contents);
-done:
-	g_dbus_send_message(conn, reply);
-	dbus_message_unref(map->msg);
-}
-
 static void folder_element(GMarkupParseContext *ctxt, const gchar *element,
 				const gchar **names, const gchar **values,
 				gpointer user_data, GError **gerr)
@@ -240,6 +234,329 @@ fail:
 	return reply;
 }
 
+static void map_msg_free(void *data)
+{
+	struct map_msg *msg = data;
+
+	g_free(msg->path);
+	g_free(msg->subject);
+	g_free(msg->handle);
+	g_free(msg->timestamp);
+	g_free(msg->sender);
+	g_free(msg->sender_address);
+	g_free(msg->replyto);
+	g_free(msg->recipient);
+	g_free(msg->recipient_address);
+	g_free(msg->type);
+	g_free(msg->status);
+	g_free(msg);
+}
+
+static const GDBusMethodTable map_msg_methods[] = {
+	{ }
+};
+
+static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
+{
+	struct map_msg *msg;
+
+	msg = g_new0(struct map_msg, 1);
+	msg->data = data;
+	msg->path = g_strdup_printf("%s/message%s",
+					obc_session_get_path(data->session),
+					handle);
+
+	if (!g_dbus_register_interface(conn, msg->path, MAP_MSG_INTERFACE,
+						map_msg_methods, NULL, NULL,
+						msg, map_msg_free)) {
+		map_msg_free(msg);
+		return NULL;
+	}
+
+	msg->handle = g_strdup(handle);
+	g_hash_table_insert(data->messages, msg->handle, msg);
+
+	return msg;
+}
+
+static void parse_subject(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	g_free(msg->subject);
+	msg->subject = g_strdup(value);
+	obex_dbus_dict_append(iter, "Subject", DBUS_TYPE_STRING, &value);
+}
+
+static void parse_datetime(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	g_free(msg->timestamp);
+	msg->timestamp = g_strdup(value);
+	obex_dbus_dict_append(iter, "Timestamp", DBUS_TYPE_STRING, &value);
+}
+
+static void parse_sender(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	g_free(msg->sender);
+	msg->sender = g_strdup(value);
+	obex_dbus_dict_append(iter, "Sender", DBUS_TYPE_STRING, &value);
+}
+
+static void parse_sender_address(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	g_free(msg->sender_address);
+	msg->sender_address = g_strdup(value);
+	obex_dbus_dict_append(iter, "SenderAddress", DBUS_TYPE_STRING,
+								&value);
+}
+
+static void parse_replyto(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	g_free(msg->replyto);
+	msg->replyto = g_strdup(value);
+	obex_dbus_dict_append(iter, "ReplyTo", DBUS_TYPE_STRING, &value);
+}
+
+static void parse_recipient(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	g_free(msg->recipient);
+	msg->recipient = g_strdup(value);
+	obex_dbus_dict_append(iter, "Recipient", DBUS_TYPE_STRING, &value);
+}
+
+static void parse_recipient_address(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	g_free(msg->recipient_address);
+	msg->recipient_address = g_strdup(value);
+	obex_dbus_dict_append(iter, "RecipientAddress", DBUS_TYPE_STRING,
+								&value);
+}
+
+static void parse_type(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	g_free(msg->type);
+	msg->type = g_strdup(value);
+	obex_dbus_dict_append(iter, "Type", DBUS_TYPE_STRING, &value);
+}
+
+static void parse_status(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	g_free(msg->status);
+	msg->status = g_strdup(value);
+	obex_dbus_dict_append(iter, "Status", DBUS_TYPE_STRING, &value);
+}
+
+static void parse_size(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	msg->size = g_ascii_strtoll(value, NULL, 10);
+	obex_dbus_dict_append(iter, "Size", DBUS_TYPE_UINT64, &msg->size);
+}
+
+static void parse_priority(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	gboolean flag = strcasecmp(value, "no");
+
+	if (flag)
+		msg->flags |= MAP_MSG_FLAG_PRIORITY;
+	else
+		msg->flags &= ~MAP_MSG_FLAG_PRIORITY;
+
+	obex_dbus_dict_append(iter, "Priority", DBUS_TYPE_BOOLEAN, &flag);
+}
+
+static void parse_read(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	gboolean flag = strcasecmp(value, "no");
+
+	if (flag)
+		msg->flags |= MAP_MSG_FLAG_READ;
+	else
+		msg->flags &= ~MAP_MSG_FLAG_READ;
+
+	obex_dbus_dict_append(iter, "Read", DBUS_TYPE_BOOLEAN, &flag);
+}
+
+static void parse_sent(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	gboolean flag = strcasecmp(value, "no");
+
+	if (flag)
+		msg->flags |= MAP_MSG_FLAG_SENT;
+	else
+		msg->flags &= ~MAP_MSG_FLAG_SENT;
+
+	obex_dbus_dict_append(iter, "Sent", DBUS_TYPE_BOOLEAN, &flag);
+}
+
+static void parse_protected(struct map_msg *msg, const char *value,
+							DBusMessageIter *iter)
+{
+	gboolean flag = strcasecmp(value, "no");
+
+	if (flag)
+		msg->flags |= MAP_MSG_FLAG_PROTECTED;
+	else
+		msg->flags &= ~MAP_MSG_FLAG_PROTECTED;
+
+	obex_dbus_dict_append(iter, "Protected", DBUS_TYPE_BOOLEAN, &flag);
+}
+
+static struct map_msg_parser {
+	const char *name;
+	void (*func) (struct map_msg *msg, const char *value,
+							DBusMessageIter *iter);
+} msg_parsers[] = {
+		{ "subject", parse_subject },
+		{ "datetime", parse_datetime },
+		{ "sender_name", parse_sender },
+		{ "sender_addressing", parse_sender_address },
+		{ "replyto_addressing", parse_replyto },
+		{ "recipient_name", parse_recipient },
+		{ "recipient_addressing", parse_recipient_address },
+		{ "type", parse_type },
+		{ "reception_status", parse_status },
+		{ "size", parse_size },
+		{ "priority", parse_priority },
+		{ "read", parse_read },
+		{ "sent", parse_sent },
+		{ "protected", parse_protected },
+		{ }
+};
+
+static void msg_element(GMarkupParseContext *ctxt, const gchar *element,
+				const gchar **names, const gchar **values,
+				gpointer user_data, GError **gerr)
+{
+	struct map_parser *parser = user_data;
+	struct map_data *data = parser->data;
+	DBusMessageIter entry, dict, *iter = parser->iter;
+	struct map_msg *msg;
+	const gchar *key;
+	gint i;
+
+	if (strcasecmp("msg", element) != 0)
+		return;
+
+	for (i = 0, key = names[i]; key; key = names[++i]) {
+		if (strcasecmp(key, "handle") == 0)
+			break;
+	}
+
+	msg = g_hash_table_lookup(data->messages, key);
+	if (msg == NULL) {
+		msg = map_msg_create(data, values[i]);
+		if (msg == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_DICT_ENTRY, NULL,
+								&entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+								&msg->path);
+
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	for (i = 0, key = names[i]; key; key = names[++i]) {
+		struct map_msg_parser *parser;
+
+		for (parser = msg_parsers; parser && parser->name; parser++) {
+			if (strcasecmp(key, parser->name) == 0) {
+				parser->func(msg, values[i], &dict);
+				break;
+			}
+		}
+	}
+
+	dbus_message_iter_close_container(&entry, &dict);
+	dbus_message_iter_close_container(iter, &entry);
+}
+
+static const GMarkupParser msg_parser = {
+	msg_element,
+	NULL,
+	NULL,
+	NULL,
+	NULL
+};
+
+static void message_listing_cb(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
+{
+	struct map_data *map = user_data;
+	struct map_parser *parser;
+	GMarkupParseContext *ctxt;
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+	char *contents;
+	size_t size;
+	int perr;
+
+	if (err != NULL) {
+		reply = g_dbus_create_error(map->msg,
+						ERROR_INTERFACE ".Failed",
+						"%s", err->message);
+		goto done;
+	}
+
+	perr = obc_transfer_get_contents(transfer, &contents, &size);
+	if (perr < 0) {
+		reply = g_dbus_create_error(map->msg,
+						ERROR_INTERFACE ".Failed",
+						"Error reading contents: %s",
+						strerror(-perr));
+		goto done;
+	}
+
+	reply = dbus_message_new_method_return(map->msg);
+	if (reply == NULL)
+		return;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&array);
+
+	parser = g_new(struct map_parser, 1);
+	parser->data = map;
+	parser->iter = &array;
+
+	ctxt = g_markup_parse_context_new(&msg_parser, 0, parser, NULL);
+	g_markup_parse_context_parse(ctxt, contents, size, NULL);
+	g_markup_parse_context_free(ctxt);
+	dbus_message_iter_close_container(&iter, &array);
+	g_free(contents);
+	g_free(parser);
+
+done:
+	g_dbus_send_message(conn, reply);
+	dbus_message_unref(map->msg);
+}
+
 static DBusMessage *map_get_message_listing(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -262,7 +579,8 @@ static DBusMessage *map_get_message_listing(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(map->session, transfer, buffer_cb, map, &err)) {
+	if (obc_session_queue(map->session, transfer, message_listing_cb, map,
+								&err)) {
 		map->msg = dbus_message_ref(message);
 		return NULL;
 	}
@@ -284,16 +602,28 @@ static const GDBusMethodTable map_methods[] = {
 					map_get_folder_listing) },
 	{ GDBUS_ASYNC_METHOD("GetMessageListing",
 			GDBUS_ARGS({ "folder", "s" }, { "dummy", "a{ss}" }),
-			GDBUS_ARGS({ "messages", "s" }),
+			GDBUS_ARGS({ "messages", "a{oa{sv}}" }),
 			map_get_message_listing) },
 	{ }
 };
 
+static void map_msg_remove(void *data)
+{
+	struct map_msg *msg = data;
+	char *path;
+
+	path = msg->path;
+	msg->path = NULL;
+	g_dbus_unregister_interface(conn, path, MAP_MSG_INTERFACE);
+	g_free(path);
+}
+
 static void map_free(void *data)
 {
 	struct map_data *map = data;
 
 	obc_session_unref(map->session);
+	g_hash_table_unref(map->messages);
 	g_free(map);
 }
 
@@ -311,6 +641,8 @@ static int map_probe(struct obc_session *session)
 		return -ENOMEM;
 
 	map->session = obc_session_ref(session);
+	map->messages = g_hash_table_new_full(g_str_hash, g_str_equal, NULL,
+								map_msg_remove);
 
 	if (!g_dbus_register_interface(conn, path, MAP_INTERFACE, map_methods,
 					NULL, NULL, map, map_free)) {
-- 
1.7.10.4

