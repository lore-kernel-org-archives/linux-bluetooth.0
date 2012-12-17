Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] obexd: Port session interface to use D-Bus Properties
Date: Mon, 17 Dec 2012 13:50:03 +0200
Message-Id: <1355745007-1493-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/obexd-api.txt   | 12 ++++--------
 obexd/src/manager.c | 50 ++++++++++++++++++--------------------------------
 2 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/doc/obexd-api.txt b/doc/obexd-api.txt
index 680febe..53e61f5 100644
--- a/doc/obexd-api.txt
+++ b/doc/obexd-api.txt
@@ -74,14 +74,10 @@ Service		org.bluez.obex
 Interface	org.bluez.obex.Session
 Object path	/session{0, 1, 2, ...}
 
-Methods
-		dict GetProperties()
-
-
-Signals		TBD
+Properties	string Target [readonly]
 
+			Target UUID
 
-Properties
-		string Address [readonly]
+		string Root [readonly]
 
-			Bluetooth device address or USB
+			Root path
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 02dc999..85aa965 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -255,42 +255,29 @@ static char *target2str(const uint8_t *t)
 				t[8], t[9], t[10], t[11], t[12], t[13], t[14], t[15]);
 }
 
-static DBusMessage *get_properties(DBusConnection *conn,
-				DBusMessage *msg, void *data)
+static gboolean get_target(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
 	struct obex_session *os = data;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
 	char *uuid;
-	const char *root;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
 
-	dbus_message_iter_init_append(reply, &iter);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	/* Target */
 	uuid = target2str(os->service->target);
-	dbus_message_iter_append_dict_entry(&dict, "Target",
-					DBUS_TYPE_STRING, &uuid);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
 	g_free(uuid);
 
-	/* Root folder */
-	root = obex_option_root_folder();
-	dbus_message_iter_append_dict_entry(&dict, "Root",
-					DBUS_TYPE_STRING, &root);
+	return TRUE;
+}
 
-	/* FIXME: Added Remote Address or USB */
+static gboolean get_root(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obex_session *os = data;
+	const char *root;
 
-	dbus_message_iter_close_container(&iter, &dict);
+	root = obex_option_root_folder();
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &root);
 
-	return reply;
+	return TRUE;
 }
 
 static DBusMessage *transfer_cancel(DBusConnection *connection,
@@ -339,10 +326,9 @@ static const GDBusSignalTable transfer_signals[] = {
 	{ }
 };
 
-static const GDBusMethodTable session_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				get_properties) },
+static const GDBusPropertyTable session_properties[] = {
+	{ "Target", "s", get_target },
+	{ "Root", "s", get_root },
 	{ }
 };
 
@@ -610,8 +596,8 @@ void manager_register_session(struct obex_session *os)
 
 	if (!g_dbus_register_interface(connection, path,
 				SESSION_INTERFACE,
-				session_methods, NULL,
-				NULL, os, NULL)) {
+				NULL, NULL,
+				session_properties, os, NULL)) {
 		error("Cannot register Session interface.");
 		goto done;
 	}
-- 
1.7.11.7

