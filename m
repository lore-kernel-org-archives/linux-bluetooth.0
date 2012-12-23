Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] gdbus: Introduce G_DBUS_METHOD_FLAG_EXPERIMENTAL
Date: Sun, 23 Dec 2012 17:24:53 +0200
Message-Id: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This flag can be used to mark methods as experimental, the marked
methods with this flag can be enabled by setting the environment variable
GDBUS_EXPERIMENTAL=1
---
 gdbus/gdbus.h  | 21 ++++++++++++++++++---
 gdbus/object.c | 17 +++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 0e5c012..64f5d62 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -89,9 +89,10 @@ typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
 						GDBusPendingReply pending);
 
 enum GDBusMethodFlags {
-	G_DBUS_METHOD_FLAG_DEPRECATED = (1 << 0),
-	G_DBUS_METHOD_FLAG_NOREPLY    = (1 << 1),
-	G_DBUS_METHOD_FLAG_ASYNC      = (1 << 2),
+	G_DBUS_METHOD_FLAG_DEPRECATED	= (1 << 0),
+	G_DBUS_METHOD_FLAG_NOREPLY	= (1 << 1),
+	G_DBUS_METHOD_FLAG_ASYNC	= (1 << 2),
+	G_DBUS_METHOD_FLAG_EXPERIMENTAL	= (1 << 3),
 };
 
 enum GDBusSignalFlags {
@@ -173,6 +174,20 @@ struct GDBusSecurityTable {
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
diff --git a/gdbus/object.c b/gdbus/object.c
index 776d35e..180d48c 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -129,6 +129,14 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 						G_DBUS_METHOD_FLAG_DEPRECATED;
 		gboolean noreply = method->flags &
 						G_DBUS_METHOD_FLAG_NOREPLY;
+		gboolean experimental = method->flags &
+					G_DBUS_METHOD_FLAG_EXPERIMENTAL;
+
+		if (experimental) {
+			const char *env = g_getenv("GDBUS_EXPERIMENTAL");
+			if (g_strcmp0(env, "1") != 0)
+				return;
+		}
 
 		if (!deprecated && !noreply &&
 				!(method->in_args && method->in_args->name) &&
@@ -1022,10 +1030,19 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 
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
-- 
1.7.11.7

