Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 2/5] Add SetProperty method and Debug read/write property
Date: Sat,  5 Jun 2010 04:25:33 -0300
Message-Id: <1275722736-28895-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275722736-28895-1-git-send-email-gustavo@padovan.org>
References: <1275722736-28895-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/manager.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index eab7e80..66e1511 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -80,6 +80,22 @@ static inline DBusMessage *no_such_adapter(DBusMessage *msg)
 			"No such adapter");
 }
 
+static DBusMessage *set_debug(DBusConnection *conn, DBusMessage *msg,
+				gboolean debug, void *data)
+{
+	gboolean old_debug = __btd_debug_enabled();
+
+	if (debug == old_debug)
+		return dbus_message_new_method_return(msg);
+
+	__btd_toggle_debug(debug);
+
+	emit_property_changed(connection, "/" , MANAGER_INTERFACE, "Debug",
+				DBUS_TYPE_BOOLEAN, &debug);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *default_adapter(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -217,8 +233,44 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	return reply;
 }
 
+static DBusMessage *set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter;
+	DBusMessageIter sub;
+	const char *property;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return invalid_args(msg);
+	dbus_message_iter_recurse(&iter, &sub);
+
+	if (g_str_equal("Debug", property)) {
+		gboolean debug;
+
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
+			return invalid_args(msg);
+
+		dbus_message_iter_get_basic(&sub, &debug);
+
+		return set_debug(conn, msg, debug, data);
+	}
+
+	return invalid_args(msg);
+}
+
 static GDBusMethodTable manager_methods[] = {
 	{ "GetProperties",	"",	"a{sv}",get_properties	},
+	{ "SetProperty",	"sv",	"",	set_property,
+						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "DefaultAdapter",	"",	"o",	default_adapter	},
 	{ "FindAdapter",	"s",	"o",	find_adapter	},
 	{ "ListAdapters",	"",	"ao",	list_adapters,
-- 
1.7.1

