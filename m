Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] gdbus: Introduce G_DBUS_PROPERTY_FLAG_EXPERIMENTAL
Date: Sun, 23 Dec 2012 22:15:13 +0200
Message-Id: <1356293718-9348-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356293718-9348-1-git-send-email-luiz.dentz@gmail.com>
References: <1356293718-9348-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This flag can be used to mark properties as experimental, the marked
properties with this flag can be enabled by setting the environment variable
GDBUS_EXPERIMENTAL=1
---
 gdbus/gdbus.h  |  3 ++-
 gdbus/object.c | 60 ++++++++++++++++++++++++++++++++++++----------------------
 2 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index e6b51cd..da3cd53 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -101,7 +101,8 @@ enum GDBusSignalFlags {
 };
 
 enum GDBusPropertyFlags {
-	G_DBUS_PROPERTY_FLAG_DEPRECATED = (1 << 0),
+	G_DBUS_PROPERTY_FLAG_DEPRECATED   = (1 << 0),
+	G_DBUS_PROPERTY_FLAG_EXPERIMENTAL = (1 << 1),
 };
 
 enum GDBusSecurityFlags {
diff --git a/gdbus/object.c b/gdbus/object.c
index 20f7db9..7b58eea 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -118,6 +118,18 @@ static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 #define G_DBUS_ANNOTATE_NOREPLY(prefix_) \
 	G_DBUS_ANNOTATE(prefix_, "Method.NoReply", "true")
 
+static gboolean check_experimental(int flags, int flag)
+{
+	const char *env;
+
+	if (!(flags & flag))
+		return FALSE;
+
+	env = g_getenv("GDBUS_EXPERIMENTAL");
+
+	return g_strcmp0(env, "1") != 0;
+}
+
 static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
@@ -129,14 +141,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 						G_DBUS_METHOD_FLAG_DEPRECATED;
 		gboolean noreply = method->flags &
 						G_DBUS_METHOD_FLAG_NOREPLY;
-		gboolean experimental = method->flags &
-					G_DBUS_METHOD_FLAG_EXPERIMENTAL;
 
-		if (experimental) {
-			const char *env = g_getenv("GDBUS_EXPERIMENTAL");
-			if (g_strcmp0(env, "1") != 0)
-				continue;
-		}
+		if (check_experimental(method->flags,
+					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
+			continue;
 
 		if (!deprecated && !noreply &&
 				!(method->in_args && method->in_args->name) &&
@@ -165,14 +173,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	for (signal = iface->signals; signal && signal->name; signal++) {
 		gboolean deprecated = signal->flags &
 						G_DBUS_SIGNAL_FLAG_DEPRECATED;
-		gboolean experimental = signal->flags &
-					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL;
 
-		if (experimental) {
-			const char *env = g_getenv("GDBUS_EXPERIMENTAL");
-			if (g_strcmp0(env, "1") != 0)
-				continue;
-		}
+		if (check_experimental(signal->flags,
+					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL))
+			continue;
 
 		if (!deprecated && !(signal->args && signal->args->name))
 			g_string_append_printf(gstr,
@@ -197,6 +201,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 		gboolean deprecated = property->flags &
 					G_DBUS_PROPERTY_FLAG_DEPRECATED;
 
+		if (check_experimental(property->flags,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
+			continue;
+
 		g_string_append_printf(gstr, "\t\t<property name=\"%s\""
 					" type=\"%s\" access=\"%s%s\"",
 					property->name,	property->type,
@@ -558,6 +566,10 @@ static void append_properties(struct interface_data *data,
 				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
 	for (p = data->properties; p && p->name; p++) {
+		if (check_experimental(p->flags,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
+			continue;
+
 		if (p->get == NULL)
 			continue;
 
@@ -759,8 +771,14 @@ static inline const GDBusPropertyTable *find_property(const GDBusPropertyTable *
 	const GDBusPropertyTable *p;
 
 	for (p = properties; p && p->name; p++) {
-		if (strcmp(name, p->name) == 0)
-			return p;
+		if (strcmp(name, p->name) != 0)
+			continue;
+
+		if (check_experimental(p->flags,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
+			break;
+
+		return p;
 	}
 
 	return NULL;
@@ -1038,18 +1056,14 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 
 	for (method = iface->methods; method &&
 			method->name && method->function; method++) {
-		gboolean experimental = method->flags &
-					G_DBUS_METHOD_FLAG_EXPERIMENTAL;
 
 		if (dbus_message_is_method_call(message, iface->name,
 							method->name) == FALSE)
 			continue;
 
-		if (experimental) {
-			const char *env = g_getenv("GDBUS_EXPERIMENTAL");
-			if (g_strcmp0(env, "1") != 0)
-				return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-		}
+		if (check_experimental(method->flags,
+					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
+			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 		if (g_dbus_args_have_signature(method->in_args,
 							message) == FALSE)
-- 
1.7.11.7

