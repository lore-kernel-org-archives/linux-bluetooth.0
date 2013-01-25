Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] obexd: Add PushMessage
Date: Fri, 25 Jan 2013 17:44:47 +0100
Message-Id: <1359132287-9714-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Push message has been implemented similar to send file (OPP),
the message to send (in bMessage format) is read from a file.
---
 doc/obex-api.txt   |  22 ++++++++
 obexd/client/map.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 6246933..759c4d8 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -630,6 +630,28 @@ Methods		void SetFolder(string name)
 
 			Possible errors: org.bluez.obex.Error.Failed
 
+		object, dict
+		PushMessage(string sourcefile, string folder, dict args)
+
+			Transfer a message (in bMessage format) to the
+			remote device.
+
+			The message is transferred either to the given folder,
+			or to the current folder if folder is omitted.
+
+			Possible args: Transparent, Retry, Charset
+
+			The returned path represents the newly created transfer,
+			which should be used to find out if the content has been
+			successfully transferred or if the operation fails.
+
+			The properties of this transfer are also returned along
+			with the object path, to avoid a call to GetAll.
+
+			Possible errors: org.bluez.obex.Error.InvalidArguments
+					 org.bluez.obex.Error.Failed
+
+
 Filter:		uint16 Offset:
 
 			Offset of the first item, default is 0
diff --git a/obexd/client/map.c b/obexd/client/map.c
index ea5681a..2b665ec 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -52,6 +52,7 @@
 #define DEFAULT_COUNT 1024
 #define DEFAULT_OFFSET 0
 
+#define CHARSET_NATIVE 0
 #define CHARSET_UTF8 1
 
 static const char * const filter_list[] = {
@@ -1495,6 +1496,160 @@ fail:
 	return reply;
 }
 
+static DBusMessage *push_message(struct map_data *map,
+							DBusMessage *message,
+							const char *filename,
+							const char *folder,
+							GObexApparam *apparam)
+{
+	struct obc_transfer *transfer;
+	GError *err = NULL;
+	DBusMessage *reply;
+
+	transfer = obc_transfer_put("x-bt/message", folder, filename,
+								NULL, 0, &err);
+	if (transfer == NULL) {
+		g_obex_apparam_free(apparam);
+		goto fail;
+	}
+
+	obc_transfer_set_apparam(transfer, apparam);
+
+	if (!obc_session_queue(map->session, transfer, NULL, NULL, &err))
+		goto fail;
+
+	return obc_transfer_create_dbus_reply(transfer, message);
+
+fail:
+	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
+								err->message);
+	g_error_free(err);
+	return reply;
+}
+
+static GObexApparam *parse_transparent(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	dbus_bool_t transparent;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &transparent);
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_TRANSPARENT,
+						transparent ? TRUE : FALSE);
+}
+
+static GObexApparam *parse_retry(GObexApparam *apparam, DBusMessageIter *iter)
+{
+	dbus_bool_t retry;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &retry);
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_RETRY,
+							retry ? TRUE : FALSE);
+}
+
+static GObexApparam *parse_charset(GObexApparam *apparam, DBusMessageIter *iter)
+{
+	guint8 charset = 0;
+	const char *string;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &string);
+
+	if (strcasecmp(string, "native") == 0)
+		charset = CHARSET_NATIVE;
+	else if (strcasecmp(string, "utf8") == 0)
+		charset = CHARSET_UTF8;
+	else
+		return NULL;
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_CHARSET, charset);
+}
+
+static GObexApparam *parse_push_options(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return NULL;
+
+	dbus_message_iter_recurse(iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+
+		dbus_message_iter_recurse(&array, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (strcasecmp(key, "Transparent") == 0) {
+			if (parse_transparent(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Retry") == 0) {
+			if (parse_retry(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Charset") == 0) {
+			if (parse_charset(apparam, &value) == NULL)
+				return NULL;
+		}
+
+		dbus_message_iter_next(&array);
+	}
+
+	return apparam;
+}
+
+static DBusMessage *map_push_message(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	char *filename;
+	char *folder;
+	GObexApparam *apparam;
+	DBusMessageIter args;
+
+	dbus_message_iter_init(message, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&args, &filename);
+
+	dbus_message_iter_next(&args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING) {
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
+
+	dbus_message_iter_get_basic(&args, &folder);
+
+	dbus_message_iter_next(&args);
+
+	apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_CHARSET, CHARSET_UTF8);
+
+	if (parse_push_options(apparam, &args) == NULL) {
+		g_obex_apparam_free(apparam);
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
+
+	return push_message(map, message, filename, folder, apparam);
+}
+
 static const GDBusMethodTable map_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetFolder",
 				GDBUS_ARGS({ "name", "s" }), NULL,
@@ -1515,6 +1670,12 @@ static const GDBusMethodTable map_methods[] = {
 			NULL,
 			NULL,
 			map_update_inbox) },
+	{ GDBUS_ASYNC_METHOD("PushMessage",
+			GDBUS_ARGS({ "file", "s" }, { "folder", "s" },
+						{ "args", "a{sv}" }),
+			GDBUS_ARGS({ "transfer", "o" },
+						{ "properties", "a{sv}" }),
+			map_push_message) },
 	{ }
 };
 
-- 
1.8.1

