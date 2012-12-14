Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] obex-client: Port session code to use D-Bus properties interface
Date: Fri, 14 Dec 2012 23:31:58 +0200
Message-Id: <1355520720-11731-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355520720-11731-1-git-send-email-luiz.dentz@gmail.com>
References: <1355520720-11731-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/obex-client-api.txt |  6 +---
 obexd/client/session.c  | 86 ++++++++++++++++++++++++++++---------------------
 2 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/doc/obex-client-api.txt b/doc/obex-client-api.txt
index 19c8541..f516760 100644
--- a/doc/obex-client-api.txt
+++ b/doc/obex-client-api.txt
@@ -43,11 +43,7 @@ Service		org.bluez.obex.client
 Interface	org.bluez.obex.Session
 Object path	[variable prefix]/{session0,session1,...}
 
-Methods		dict GetProperties()
-
-			Returns all properties for the session.
-
-		string GetCapabilities()
+Methods		string GetCapabilities()
 
 			Get remote device capabilities.
 
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 2bac229..40d6c9c 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -524,39 +524,6 @@ void obc_session_shutdown(struct obc_session *session)
 	obc_session_unref(session);
 }
 
-static DBusMessage *session_get_properties(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	struct obc_session *session = user_data;
-	DBusMessage *reply;
-	DBusMessageIter iter, dict;
-
-	reply = dbus_message_new_method_return(message);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	if (session->source != NULL)
-		obex_dbus_dict_append(&dict, "Source", DBUS_TYPE_STRING,
-							&session->source);
-
-	obex_dbus_dict_append(&dict, "Destination", DBUS_TYPE_STRING,
-							&session->destination);
-
-	obex_dbus_dict_append(&dict, "Channel", DBUS_TYPE_BYTE,
-							&session->channel);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
-}
-
 static void capabilities_complete_callback(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
@@ -621,16 +588,63 @@ fail:
 
 }
 
+static gboolean get_source(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obc_session *session = data;
+
+	if (session->source == NULL)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&session->source);
+
+	return TRUE;
+}
+
+static gboolean source_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct obc_session *session = data;
+
+	return session->source != NULL;
+}
+
+static gboolean get_destination(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obc_session *session = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&session->destination);
+
+	return TRUE;
+}
+
+static gboolean get_channel(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obc_session *session = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&session->channel);
+
+	return TRUE;
+}
+
 static const GDBusMethodTable session_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				session_get_properties) },
 	{ GDBUS_ASYNC_METHOD("GetCapabilities",
 				NULL, GDBUS_ARGS({ "capabilities", "s" }),
 				get_capabilities) },
 	{ }
 };
 
+static const GDBusPropertyTable session_properties[] = {
+	{ "Source", "s", get_source, NULL, source_exists },
+	{ "Destination", "s", get_destination },
+	{ "Channel", "y", get_channel },
+	{ }
+};
+
 static gboolean session_queue_complete(gpointer data)
 {
 	struct obc_session *session = data;
-- 
1.7.11.7

