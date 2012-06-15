Return-Path: <cyrus@holtmann.org>
From: Henrique Dante de Almeida <hdante@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Henrique Dante de Almeida <hdante@profusion.mobi>
Subject: [PATCH RFC] gdbus: Rename variables named "signal" (so that it can be compiled with -Wshadow)
Date: Fri, 15 Jun 2012 09:04:08 -0300
Message-Id: <1339761848-7472-1-git-send-email-hdante@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |   39 +++++++++++++++++++++------------------
 gdbus/watch.c  |    4 ++--
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 900e7ab..ff52ead 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -79,7 +79,7 @@ static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 {
 	const GDBusMethodTable *method;
-	const GDBusSignalTable *signal;
+	const GDBusSignalTable *signal_entry;
 
 	for (method = iface->methods; method && method->name; method++) {
 		gboolean deprecated = method->flags &
@@ -108,17 +108,19 @@ static void generate_interface_xml(GString *gstr, struct interface_data *iface)
 		}
 	}
 
-	for (signal = iface->signals; signal && signal->name; signal++) {
-		gboolean deprecated = signal->flags &
+	for (signal_entry = iface->signals; signal_entry && signal_entry->name;
+							signal_entry++) {
+		gboolean deprecated = signal_entry->flags &
 						G_DBUS_SIGNAL_FLAG_DEPRECATED;
 
-		if (!deprecated && !(signal->args && signal->args->name))
+		if (!deprecated && !(signal_entry->args &&
+						signal_entry->args->name))
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\"/>\n",
-								signal->name);
+							signal_entry->name);
 		else {
 			g_string_append_printf(gstr, "\t\t<signal name=\"%s\">\n",
-								signal->name);
-			print_arguments(gstr, signal->args, NULL);
+							signal_entry->name);
+			print_arguments(gstr, signal_entry->args, NULL);
 
 			if (deprecated)
 				g_string_append_printf(gstr, "\t\t\t<annotation name=\"org.freedesktop.DBus.Deprecated\" value=\"true\"/>\n");
@@ -592,7 +594,7 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
 {
 	struct generic_data *data = NULL;
 	struct interface_data *iface;
-	const GDBusSignalTable *signal;
+	const GDBusSignalTable *signal_entry;
 
 	*args = NULL;
 	if (!dbus_connection_get_object_path_data(conn, path,
@@ -609,9 +611,10 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
 		return FALSE;
 	}
 
-	for (signal = iface->signals; signal && signal->name; signal++) {
-		if (!strcmp(signal->name, name)) {
-			*args = signal->args;
+	for (signal_entry = iface->signals; signal_entry && signal_entry->name;
+							signal_entry++) {
+		if (!strcmp(signal_entry->name, name)) {
+			*args = signal_entry->args;
 			return TRUE;
 		}
 	}
@@ -627,34 +630,34 @@ static dbus_bool_t emit_signal_valist(DBusConnection *conn,
 						int first,
 						va_list var_args)
 {
-	DBusMessage *signal;
+	DBusMessage *message;
 	dbus_bool_t ret;
 	const GDBusArgInfo *args;
 
 	if (!check_signal(conn, path, interface, name, &args))
 		return FALSE;
 
-	signal = dbus_message_new_signal(path, interface, name);
-	if (signal == NULL) {
+	message = dbus_message_new_signal(path, interface, name);
+	if (message == NULL) {
 		error("Unable to allocate new %s.%s signal", interface,  name);
 		return FALSE;
 	}
 
-	ret = dbus_message_append_args_valist(signal, first, var_args);
+	ret = dbus_message_append_args_valist(message, first, var_args);
 	if (!ret)
 		goto fail;
 
-	if (g_dbus_args_have_signature(args, signal) == FALSE) {
+	if (g_dbus_args_have_signature(args, message) == FALSE) {
 		error("%s.%s: expected signature'%s' but got '%s'",
 				interface, name, args, signature);
 		ret = FALSE;
 		goto fail;
 	}
 
-	ret = dbus_connection_send(conn, signal, NULL);
+	ret = dbus_connection_send(conn, message, NULL);
 
 fail:
-	dbus_message_unref(signal);
+	dbus_message_unref(message);
 
 	return ret;
 }
diff --git a/gdbus/watch.c b/gdbus/watch.c
index 9a716b0..4be412c 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -305,7 +305,7 @@ static struct filter_callback *filter_data_add_callback(
 						struct filter_data *data,
 						GDBusWatchFunction connect,
 						GDBusWatchFunction disconnect,
-						GDBusSignalFunction signal,
+						GDBusSignalFunction signal_func,
 						GDBusDestroyFunction destroy,
 						void *user_data)
 {
@@ -315,7 +315,7 @@ static struct filter_callback *filter_data_add_callback(
 
 	cb->conn_func = connect;
 	cb->disc_func = disconnect;
-	cb->signal_func = signal;
+	cb->signal_func = signal_func;
 	cb->destroy_func = destroy;
 	cb->user_data = user_data;
 	cb->id = ++listener_id;
-- 
1.7.9.5

