Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 04/10] client: Change MessageAccess.GetMessageListing to not return raw xml
Date: Wed, 27 Jun 2012 15:04:49 +0300
Message-Id: <1340798695-6785-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
References: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the response and return as a list of dictionary where each
entry is a message and its properties,
---
 client/map.c |  175 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 138 insertions(+), 37 deletions(-)

diff --git a/client/map.c b/client/map.c
index e3a6c6c..2fc9b23 100644
--- a/client/map.c
+++ b/client/map.c
@@ -98,41 +98,6 @@ static DBusMessage *map_setpath(DBusConnection *connection,
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
@@ -243,6 +208,141 @@ fail:
 	return reply;
 }
 
+static void msg_element(GMarkupParseContext *ctxt, const gchar *element,
+				const gchar **names, const gchar **values,
+				gpointer user_data, GError **gerr)
+{
+	DBusMessageIter dict, *iter = user_data;
+	gchar *key;
+	gint i;
+
+	if (strcasecmp("msg", element) != 0)
+		return;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	i = 0;
+	for (key = (gchar *) names[i]; key; key = (gchar *) names[++i]) {
+		if (strcasecmp(key, "handle") == 0) {
+			obex_dbus_dict_append(&dict, "Handle",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "subject") == 0) {
+			obex_dbus_dict_append(&dict, "Subject",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "datetime") == 0) {
+			obex_dbus_dict_append(&dict, "Timestamp",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "sender_name") == 0) {
+			obex_dbus_dict_append(&dict, "Sender",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "sender_addressing") == 0) {
+			obex_dbus_dict_append(&dict, "SenderAddress",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "replyto_addressing") == 0) {
+			obex_dbus_dict_append(&dict, "ReplyTo",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "recipient_name") == 0) {
+			obex_dbus_dict_append(&dict, "Recipient",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "recipient_addressing") == 0) {
+			obex_dbus_dict_append(&dict, "RecipientAddress",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "type") == 0) {
+			obex_dbus_dict_append(&dict, "Type",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "reception_status") == 0) {
+			obex_dbus_dict_append(&dict, "Status",
+						DBUS_TYPE_STRING, &values[i]);
+		} else if (strcasecmp(key, "size") == 0) {
+			guint64 value = g_ascii_strtoll(values[i], NULL, 10);
+
+			obex_dbus_dict_append(&dict, "Size",
+						DBUS_TYPE_UINT64, &value);
+		} else if (strcasecmp(key, "priority") == 0) {
+			gboolean value = strcasecmp(values[i], "no");
+
+			obex_dbus_dict_append(&dict, "Priority",
+						DBUS_TYPE_BOOLEAN, &value);
+		} else if (strcasecmp(key, "read") == 0) {
+			gboolean value = strcasecmp(values[i], "no");
+
+			obex_dbus_dict_append(&dict, "Read",
+						DBUS_TYPE_BOOLEAN, &value);
+		} else if (strcasecmp(key, "sent") == 0) {
+			gboolean value = strcasecmp(values[i], "no");
+
+			obex_dbus_dict_append(&dict, "Sent",
+						DBUS_TYPE_BOOLEAN, &value);
+		} else if (strcasecmp(key, "protected") == 0) {
+			gboolean value = strcasecmp(values[i], "no");
+
+			obex_dbus_dict_append(&dict, "Protected",
+						DBUS_TYPE_BOOLEAN, &value);
+		}
+
+	}
+
+	dbus_message_iter_close_container(iter, &dict);
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
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
+	ctxt = g_markup_parse_context_new(&msg_parser, 0, &array, NULL);
+	g_markup_parse_context_parse(ctxt, contents, size, NULL);
+	g_markup_parse_context_free(ctxt);
+	dbus_message_iter_close_container(&iter, &array);
+	g_free(contents);
+
+done:
+	g_dbus_send_message(conn, reply);
+	dbus_message_unref(map->msg);
+}
+
 static DBusMessage *map_get_message_listing(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -265,7 +365,8 @@ static DBusMessage *map_get_message_listing(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(map->session, transfer, buffer_cb, map, &err)) {
+	if (obc_session_queue(map->session, transfer, message_listing_cb, map,
+								&err)) {
 		map->msg = dbus_message_ref(message);
 		return NULL;
 	}
@@ -287,7 +388,7 @@ static const GDBusMethodTable map_methods[] = {
 					map_get_folder_listing) },
 	{ GDBUS_ASYNC_METHOD("GetMessageListing",
 			GDBUS_ARGS({ "folder", "s" }, { "dummy", "a{ss}" }),
-			GDBUS_ARGS({ "messages", "s" }),
+			GDBUS_ARGS({ "messages", "aa{sv}" }),
 			map_get_message_listing) },
 	{ }
 };
-- 
1.7.10.2

