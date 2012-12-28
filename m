Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/11] gdbus: Introduce G_DBUS_PROPERTY_FLAG_EXPERIMENTAL
Date: Fri, 28 Dec 2012 14:51:01 +0200
Message-Id: <1356699069-5469-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This flag can be used to mark properties as experimental, marked
properties are disabled by default and can be enabled by setting
G_DBUS_FLAG_ENABLE_EXPERIMENTAL using g_dbus_set_flags.
---
 gdbus/gdbus.h  |  3 ++-
 gdbus/object.c | 48 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index edc1f53..87fd185 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -105,7 +105,8 @@ enum GDBusSignalFlags {
 };
 
 enum GDBusPropertyFlags {
-	G_DBUS_PROPERTY_FLAG_DEPRECATED = (1 << 0),
+	G_DBUS_PROPERTY_FLAG_DEPRECATED   = (1 << 0),
+	G_DBUS_PROPERTY_FLAG_EXPERIMENTAL = (1 << 1),
 };
 
 enum GDBusSecurityFlags {
diff --git a/gdbus/object.c b/gdbus/object.c
index 13a183f..86d1c53 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -119,6 +119,14 @@ static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 #define G_DBUS_ANNOTATE_NOREPLY(prefix_) \
 	G_DBUS_ANNOTATE(prefix_, "Method.NoReply", "true")
 
+static gboolean check_experimental(int flags, int flag)
+{
+	if (!(flags & flag))
+		return FALSE;
+
+	return !(global_flags & G_DBUS_FLAG_ENABLE_EXPERIMENTAL);
+}
+
 static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
@@ -130,11 +138,9 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 						G_DBUS_METHOD_FLAG_DEPRECATED;
 		gboolean noreply = method->flags &
 						G_DBUS_METHOD_FLAG_NOREPLY;
-		gboolean experimental = method->flags &
-					G_DBUS_METHOD_FLAG_EXPERIMENTAL;
 
-		if (!(global_flags & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) &&
-							experimental)
+		if (check_experimental(method->flags,
+					G_DBUS_METHOD_FLAG_EXPERIMENTAL))
 			continue;
 
 		if (!deprecated && !noreply &&
@@ -164,11 +170,9 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 	for (signal = iface->signals; signal && signal->name; signal++) {
 		gboolean deprecated = signal->flags &
 						G_DBUS_SIGNAL_FLAG_DEPRECATED;
-		gboolean experimental = signal->flags &
-					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL;
 
-		if (!(global_flags & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) &&
-							experimental)
+		if (check_experimental(signal->flags,
+					G_DBUS_SIGNAL_FLAG_EXPERIMENTAL))
 			continue;
 
 		if (!deprecated && !(signal->args && signal->args->name))
@@ -194,6 +198,10 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 		gboolean deprecated = property->flags &
 					G_DBUS_PROPERTY_FLAG_DEPRECATED;
 
+		if (check_experimental(property->flags,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
+			continue;
+
 		g_string_append_printf(gstr, "\t\t<property name=\"%s\""
 					" type=\"%s\" access=\"%s%s\"",
 					property->name,	property->type,
@@ -555,6 +563,10 @@ static void append_properties(struct interface_data *data,
 				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
 	for (p = data->properties; p && p->name; p++) {
+		if (check_experimental(p->flags,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL))
+			continue;
+
 		if (p->get == NULL)
 			continue;
 
@@ -756,8 +768,14 @@ static inline const GDBusPropertyTable *find_property(const GDBusPropertyTable *
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
@@ -1035,18 +1053,14 @@ static DBusHandlerResult generic_message(DBusConnection *connection,
 
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
1.8.0.1

