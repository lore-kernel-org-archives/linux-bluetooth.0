Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 01/10] client: Change MessageAccess.GetFolderListing to not return raw xml
Date: Wed, 27 Jun 2012 15:04:46 +0300
Message-Id: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This parses the response and return as a list of dictionary where each
entry is a folder and its properties, similar to what
FileTransfer.ListFolder does.
---
 client/map.c |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/client/map.c b/client/map.c
index 5242cb3..e3a6c6c 100644
--- a/client/map.c
+++ b/client/map.c
@@ -29,6 +29,7 @@
 #include <glib.h>
 #include <gdbus.h>
 
+#include "dbus.h"
 #include "log.h"
 
 #include "map.h"
@@ -132,6 +133,91 @@ done:
 	dbus_message_unref(map->msg);
 }
 
+static void folder_element(GMarkupParseContext *ctxt, const gchar *element,
+				const gchar **names, const gchar **values,
+				gpointer user_data, GError **gerr)
+{
+	DBusMessageIter dict, *iter = user_data;
+	gchar *key;
+	gint i;
+
+	if (strcasecmp("folder", element) != 0)
+		return;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	i = 0;
+	for (key = (gchar *) names[i]; key; key = (gchar *) names[++i]) {
+		key[0] = g_ascii_toupper(key[0]);
+
+		if (!g_str_equal("Name", key))
+			continue;
+
+		obex_dbus_dict_append(&dict, key, DBUS_TYPE_STRING,
+								&values[i]);
+	}
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static const GMarkupParser folder_parser = {
+	folder_element,
+	NULL,
+	NULL,
+	NULL,
+	NULL
+};
+
+static void folder_listing_cb(struct obc_session *session,
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
+	ctxt = g_markup_parse_context_new(&folder_parser, 0, &array, NULL);
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
 static DBusMessage *map_get_folder_listing(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -144,7 +230,8 @@ static DBusMessage *map_get_folder_listing(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(map->session, transfer, buffer_cb, map, &err)) {
+	if (obc_session_queue(map->session, transfer, folder_listing_cb, map,
+								&err)) {
 		map->msg = dbus_message_ref(message);
 		return NULL;
 	}
@@ -196,7 +283,7 @@ static const GDBusMethodTable map_methods[] = {
 				map_setpath) },
 	{ GDBUS_ASYNC_METHOD("GetFolderListing",
 					GDBUS_ARGS({ "dummy", "a{ss}" }),
-					GDBUS_ARGS({ "content", "s" }),
+					GDBUS_ARGS({ "content", "aa{sv}" }),
 					map_get_folder_listing) },
 	{ GDBUS_ASYNC_METHOD("GetMessageListing",
 			GDBUS_ARGS({ "folder", "s" }, { "dummy", "a{ss}" }),
-- 
1.7.10.2

