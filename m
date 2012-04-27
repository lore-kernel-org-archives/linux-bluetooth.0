Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH RFC 1/4] manager: implement support for DBus.Properties.Get
Date: Fri, 27 Apr 2012 18:54:03 -0300
Message-Id: <1335563646-9944-2-git-send-email-hdante@profusion.mobi>
In-Reply-To: <1335563646-9944-1-git-send-email-hdante@profusion.mobi>
References: <1335563646-9944-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/manager.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index f43861d..b159f62 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -160,6 +160,27 @@ static DBusMessage *list_adapters(DBusConnection *conn,
 	return reply;
 }
 
+static gboolean get_property_adapters(DBusConnection *connection,
+	DBusMessage *message, const GDBusPropertyTable *property,
+	DBusMessageIter *variant, void *data)
+{
+	DBusMessageIter iter;
+	GSList *list;
+
+	dbus_message_iter_open_container(variant, DBUS_TYPE_ARRAY,
+		DBUS_TYPE_OBJECT_PATH_AS_STRING, &iter);
+
+	for (list = adapters; list; list = list->next) {
+		struct btd_adapter *adapter = list->data;
+		const char *adapter_path = adapter_get_path(adapter);
+		dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+			&adapter_path);
+	}
+
+	dbus_message_iter_close_container(variant, &iter);
+	return TRUE;
+}
+
 static DBusMessage *get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -197,7 +218,8 @@ static DBusMessage *get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ "GetProperties",	"",	"a{sv}[properties]",get_properties	},
+	{ "GetProperties",	"",	"a{sv}[properties]", get_properties,
+						G_DBUS_METHOD_FLAG_DEPRECATED},
 	{ "DefaultAdapter",	"",	"o[adapter]",	default_adapter	},
 	{ "FindAdapter", "s[pattern]", "o[adapter]", find_adapter },
 	{ "ListAdapters",	"",	"ao[adapters]",	list_adapters,
@@ -213,6 +235,11 @@ static const GDBusSignalTable manager_signals[] = {
 	{ }
 };
 
+static const GDBusPropertyTable manager_properties[] = {
+	{ "Adapters", "ao", 0, get_property_adapters, NULL, NULL },
+	{ }
+};
+
 dbus_bool_t manager_init(DBusConnection *conn, const char *path)
 {
 	connection = conn;
@@ -221,7 +248,7 @@ dbus_bool_t manager_init(DBusConnection *conn, const char *path)
 
 	return g_dbus_register_interface(conn, "/", MANAGER_INTERFACE,
 					manager_methods, manager_signals,
-					NULL, NULL, NULL);
+					manager_properties, NULL, NULL);
 }
 
 static void manager_update_adapters(void)
-- 
1.7.5.4

