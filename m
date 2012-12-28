Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/11] gdbus: Introduce G_DBUS_METHOD_FLAG_EXPERIMENTAL
Date: Fri, 28 Dec 2012 14:50:59 +0200
Message-Id: <1356699069-5469-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This flag can be used to mark methods as experimental, marked
methods are disable by default and can be enabled by setting
G_DBUS_FLAG_ENABLE_EXPERIMENTAL using g_dbus_set_flags.
---
 gdbus/gdbus.h  | 27 ++++++++++++++++++++++++---
 gdbus/object.c | 21 +++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 0e5c012..01ff9d4 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -88,10 +88,15 @@ typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
 						gboolean interaction,
 						GDBusPendingReply pending);
 
+enum GDBusFlags {
+	G_DBUS_FLAG_ENABLE_EXPERIMENTAL = (1 << 0),
+};
+
 enum GDBusMethodFlags {
-	G_DBUS_METHOD_FLAG_DEPRECATED = (1 << 0),
-	G_DBUS_METHOD_FLAG_NOREPLY    = (1 << 1),
-	G_DBUS_METHOD_FLAG_ASYNC      = (1 << 2),
+	G_DBUS_METHOD_FLAG_DEPRECATED   = (1 << 0),
+	G_DBUS_METHOD_FLAG_NOREPLY      = (1 << 1),
+	G_DBUS_METHOD_FLAG_ASYNC        = (1 << 2),
+	G_DBUS_METHOD_FLAG_EXPERIMENTAL = (1 << 3),
 };
 
 enum GDBusSignalFlags {
@@ -173,6 +178,20 @@ struct GDBusSecurityTable {
 	.function = _function, \
 	.flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_DEPRECATED
 
+#define GDBUS_EXPERIMENTAL_METHOD(_name, _in_args, _out_args, _function) \
+	.name = _name, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_EXPERIMENTAL
+
+#define GDBUS_EXPERIMENTAL_ASYNC_METHOD(_name, _in_args, _out_args, _function) \
+	.name = _name, \
+	.in_args = _in_args, \
+	.out_args = _out_args, \
+	.function = _function, \
+	.flags = G_DBUS_METHOD_FLAG_ASYNC | G_DBUS_METHOD_FLAG_EXPERIMENTAL
+
 #define GDBUS_NOREPLY_METHOD(_name, _in_args, _out_args, _function) \
 	.name = _name, \
 	.in_args = _in_args, \
@@ -189,6 +208,8 @@ struct GDBusSecurityTable {
 	.args = _args, \
 	.flags = G_DBUS_SIGNAL_FLAG_DEPRECATED
 
+void g_dbus_set_flags(int flags);
+
 gboolean g_dbus_register_interface(DBusConnection *connection,
 					const char *path, const char *name,
 					const GDBusMethodTable *methods,
diff --git a/gdbus/object.c b/gdbus/object.c
index 776d35e..89e2a75 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -84,6 +84,7 @@ struct property_data {
 	DBusMessage *message;
 };
 
+static int global_flags = 0;
 static struct generic_data *root;
 
 static gboolean process_changes(gpointer user_data);
@@ -129,6 +130,12 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 						G_DBUS_METHOD_FLAG_DEPRECATED;
 		gboolean noreply = method->flags &
 						G_DBUS_METHOD_FLAG_NOREPLY;
+		gboolean experimental = method->flags &
+					G_DBUS_METHOD_FLAG_EXPERIMENTAL;
+
+		if (!(global_flags & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) &&
+							experimental)
+			continue;
 
 		if (!deprecated && !noreply &&
 				!(method->in_args && method->in_args->name) &&
@@ -1022,10 +1029,19 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 
 	for (method = iface->methods; method &&
 			method->name && method->function; method++) {
+		gboolean experimental = method->flags &
+					G_DBUS_METHOD_FLAG_EXPERIMENTAL;
+
 		if (dbus_message_is_method_call(message, iface->name,
 							method->name) == FALSE)
 			continue;
 
+		if (experimental) {
+			const char *env = g_getenv("GDBUS_EXPERIMENTAL");
+			if (g_strcmp0(env, "1") != 0)
+				return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+		}
+
 		if (g_dbus_args_have_signature(method->in_args,
 							message) == FALSE)
 			continue;
@@ -1689,3 +1705,8 @@ gboolean g_dbus_detach_object_manager(DBusConnection *connection)
 
 	return TRUE;
 }
+
+void g_dbus_set_flags(int flags)
+{
+	global_flags = flags;
+}
-- 
1.8.0.1

