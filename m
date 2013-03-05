Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] obexd: Move Message.Get parameter attachment into dictionary
Date: Tue,  5 Mar 2013 12:12:59 +0100
Message-Id: <1362481981-7813-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1362481981-7813-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1362481981-7813-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This is a preparation for adding additional parameters to Message.Get.
The parsing of the args dictionary is done in parse_get_options.

The Attachment parameter has been moved into the args dictionary.
The parameter is now optional defaulting to true.
---
 doc/obex-api.txt   | 11 ++++++--
 obexd/client/map.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/doc/obex-api.txt b/doc/obex-api.txt
index 759c4d8..9a78284 100644
--- a/doc/obex-api.txt
+++ b/doc/obex-api.txt
@@ -714,10 +714,10 @@ Message hierarchy
 =================
 
 Service		org.bluez.obex
-Interface	org.bluez.obex.Message1
+Interface	org.bluez.obex.Message2
 Object path	[variable prefix]/{session0,session1,...}/{message0,...}
 
-Methods		object, dict Get(string targetfile, boolean attachment)
+Methods		object, dict Get(string targetfile, dict args)
 
 			Download message and store it in the target file.
 
@@ -731,6 +731,13 @@ Methods		object, dict Get(string targetfile, boolean attachment)
 			The properties of this transfer are also returned along
 			with the object path, to avoid a call to GetProperties.
 
+			Possible args:
+
+				boolean Attachment
+
+					Request message attachment,
+					defaults to True
+
 			Possible errors: org.bluez.obex.Error.InvalidArguments
 					 org.bluez.obex.Error.Failed
 
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 2b665ec..cd4a361 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -45,7 +45,7 @@
 #define OBEX_MAS_UUID_LEN 16
 
 #define MAP_INTERFACE "org.bluez.obex.MessageAccess1"
-#define MAP_MSG_INTERFACE "org.bluez.obex.Message1"
+#define MAP_MSG_INTERFACE "org.bluez.obex.Message2"
 #define ERROR_INTERFACE "org.bluez.obex.Error"
 #define MAS_UUID "00001132-0000-1000-8000-00805f9b34fb"
 
@@ -385,34 +385,91 @@ static void map_msg_free(void *data)
 	g_free(msg);
 }
 
+static GObexApparam *parse_attachment(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	dbus_bool_t attachment;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &attachment);
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_ATTACHMENT,
+						attachment ? TRUE : FALSE);
+}
+
+static GObexApparam *parse_get_options(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+
+	DBG("");
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
+		if (strcasecmp(key, "Attachment") == 0) {
+			if (parse_attachment(apparam, &value) == NULL)
+				return NULL;
+		}
+
+		dbus_message_iter_next(&array);
+	}
+
+	return apparam;
+}
+
 static DBusMessage *map_msg_get(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct map_msg *msg = user_data;
 	struct obc_transfer *transfer;
 	const char *target_file;
-	gboolean attachment;
 	GError *err = NULL;
 	DBusMessage *reply;
 	GObexApparam *apparam;
+	DBusMessageIter args;
+
+	dbus_message_iter_init(message, &args);
 
-	if (dbus_message_get_args(message, NULL,
-				DBUS_TYPE_STRING, &target_file,
-				DBUS_TYPE_BOOLEAN, &attachment,
-				DBUS_TYPE_INVALID) == FALSE)
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
 
-	transfer = obc_transfer_get("x-bt/message", msg->handle, target_file,
-									&err);
-	if (transfer == NULL)
-		goto fail;
+	dbus_message_iter_get_basic(&args, &target_file);
+
+	dbus_message_iter_next(&args);
 
 	apparam = g_obex_apparam_set_uint8(NULL, MAP_AP_ATTACHMENT,
-								attachment);
+								TRUE);
+
 	apparam = g_obex_apparam_set_uint8(apparam, MAP_AP_CHARSET,
 								CHARSET_UTF8);
 
+	if (parse_get_options(apparam, &args) == NULL) {
+		g_obex_apparam_free(apparam);
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
+
+	transfer = obc_transfer_get("x-bt/message", msg->handle, target_file,
+									&err);
+	if (transfer == NULL)
+		goto fail;
+
 	obc_transfer_set_apparam(transfer, apparam);
 
 	if (!obc_session_queue(msg->data->session, transfer, NULL, NULL, &err))
@@ -731,7 +788,7 @@ static void set_deleted(const GDBusPropertyTable *property,
 static const GDBusMethodTable map_msg_methods[] = {
 	{ GDBUS_METHOD("Get",
 			GDBUS_ARGS({ "targetfile", "s" },
-						{ "attachment", "b" }),
+						{ "args", "a{sv}" }),
 			GDBUS_ARGS({ "transfer", "o" },
 						{ "properties", "a{sv}" }),
 			map_msg_get) },
-- 
1.8.1.4

