Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 4/5] Add DebugString Property to Manager
Date: Sat,  5 Jun 2010 04:25:35 -0300
Message-Id: <1275722736-28895-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275722736-28895-3-git-send-email-gustavo@padovan.org>
References: <1275722736-28895-1-git-send-email-gustavo@padovan.org>
 <1275722736-28895-2-git-send-email-gustavo@padovan.org>
 <1275722736-28895-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/manager.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index 66e1511..220a8fe 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -96,6 +96,31 @@ static DBusMessage *set_debug(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *set_debug_string(DBusConnection *conn, DBusMessage *msg,
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
+	old_string = __btd_get_debug_string();
+
+	if (strcmp((char *)debug_string, old_string) == 0)
+		return dbus_message_new_method_return(msg);
+
+	if (!__btd_set_debug_string((char *)debug_string))
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+							strerror(ENOMEM));
+	emit_property_changed(connection, "/", MANAGER_INTERFACE,
+				"DebugString", DBUS_TYPE_STRING, &debug_string);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *default_adapter(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -200,6 +225,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	GSList *list;
 	char **array;
 	gboolean debug_value;
+	char *debug_string;
 	int i;
 
 	reply = dbus_message_new_method_return(msg);
@@ -228,6 +254,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	debug_value = __btd_debug_enabled();
 	dict_append_entry(&dict, "Debug", DBUS_TYPE_BOOLEAN, &debug_value);
 
+	debug_string = __btd_get_debug_string();
+	dict_append_entry(&dict, "DebugString", DBUS_TYPE_STRING,
+							&debug_string);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
@@ -262,6 +292,14 @@ static DBusMessage *set_property(DBusConnection *conn,
 		dbus_message_iter_get_basic(&sub, &debug);
 
 		return set_debug(conn, msg, debug, data);
+	} else if (g_str_equal("DebugString", property)) {
+		const char *string;
+
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
+			return invalid_args(msg);
+		dbus_message_iter_get_basic(&sub, &string);
+
+		return set_debug_string(conn, msg, string, data);
 	}
 
 	return invalid_args(msg);
-- 
1.7.1

