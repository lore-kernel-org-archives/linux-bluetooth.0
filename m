Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 2/2] Add SetProperty method and Debug property
Date: Wed, 16 Jun 2010 04:31:18 -0300
Message-Id: <1276673478-9273-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1276673478-9273-1-git-send-email-gustavo@padovan.org>
References: <1276673478-9273-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/manager-api.txt |   16 ++++++++++++
 src/manager.c       |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/doc/manager-api.txt b/doc/manager-api.txt
index d2c1caf..22ee912 100644
--- a/doc/manager-api.txt
+++ b/doc/manager-api.txt
@@ -22,6 +22,15 @@ Methods		dict GetProperties()
 			Possible Errors: org.bluez.Error.DoesNotExist
 					 org.bluez.Error.InvalidArguments
 
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed a read-write are changeable.
+			On success this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.DoesNotExist
+					 org.bluez.Error.InvalidArguments
+
 		object DefaultAdapter()
 
 			Returns object path for the default adapter.
@@ -72,3 +81,10 @@ Signals		PropertyChanged(string name, variant value)
 Properties	array{object} Adapters [readonly]
 
 			List of adapter object paths.
+
+		string Debug [readwrite]
+
+			Change the dynamic debug match string. Use it to
+			restrict debug to specific files. The default value is
+			"*" to debug all files. The "" string switch debug
+			off.
diff --git a/src/manager.c b/src/manager.c
index cbbca1e..d146e4c 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -80,6 +80,31 @@ static inline DBusMessage *no_such_adapter(DBusMessage *msg)
 			"No such adapter");
 }
 
+static DBusMessage *set_debug(DBusConnection *conn, DBusMessage *msg,
+					const char *debug_string, void *data)
+{
+	char *old_string;
+
+	if (!g_utf8_validate(debug_string, -1, NULL)) {
+		error("DebugString change failed: supplied string "
+							"isn't valid UTF-8");
+		return invalid_args(msg);
+	}
+
+	old_string = __btd_get_debug();
+
+	if (strcmp((char *)debug_string, old_string) == 0)
+		return dbus_message_new_method_return(msg);
+
+	if (!__btd_set_debug((char *)debug_string))
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+							strerror(ENOMEM));
+	emit_property_changed(connection, "/", MANAGER_INTERFACE,
+				"Debug", DBUS_TYPE_STRING, &debug_string);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *default_adapter(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -183,6 +208,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter dict;
 	GSList *list;
 	char **array;
+	char *debug_string;
 	int i;
 
 	reply = dbus_message_new_method_return(msg);
@@ -208,13 +234,52 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	dict_append_array(&dict, "Adapters", DBUS_TYPE_OBJECT_PATH, &array, i);
 	g_free(array);
 
+	debug_string = __btd_get_debug();
+	dict_append_entry(&dict, "Debug", DBUS_TYPE_STRING,
+							&debug_string);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
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
+		const char *string;
+
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
+			return invalid_args(msg);
+		dbus_message_iter_get_basic(&sub, &string);
+
+		return set_debug(conn, msg, string, data);
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

