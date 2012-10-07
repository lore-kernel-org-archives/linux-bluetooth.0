Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Travis Reitter <travis.reitter@collabora.co.uk>
Subject: [PATCH -v2 2/6] bt tool: add cmd 'discover'
Date: Mon,  8 Oct 2012 06:49:53 +0800
Message-Id: <1349650197-18751-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
References: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Travis Reitter <travis.reitter@collabora.co.uk>

 $ bt discover

will start a discovery for devices nearby and display them. We display
the device when we receive its first Device Found signal. If the
DeviceFound signal doesn't contains the device's name it will not be
displayed.

Steal bluetooth_parse_properties() from oFono code.
---
 client/main.c | 242 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 241 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 4edc255..48521fd 100644
--- a/client/main.c
+++ b/client/main.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2011 Bruno Dilly <bdilly@profusion.mobi>
  *  Copyright (C) 2011 Gustavo Padovan <gustavo@padovan.org>
+ *  Copyright (C) 2011 Intel Corporation. All rights reserved.
  *  Copyright (C) 2012 Collabora Limited.
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -84,6 +85,8 @@ static gchar *program_name = NULL;
 static bdaddr_t bdaddr;
 static DBusConnection *conn;
 
+static GHashTable *device_addrs = NULL;
+
 static void show_help()
 {
 	printf("usage: %s [-i interface] <command> [<args>]\n"
@@ -115,6 +118,127 @@ static struct find_adapter_cb_data *find_adapter_cb_data_new(GSourceFunc fn,
 	return cb_data;
 }
 
+static void parse_bool(DBusMessageIter *iter, gpointer user_data)
+{
+	gboolean *boolean = user_data;
+	int arg_type = dbus_message_iter_get_arg_type(iter);
+
+	if (arg_type != DBUS_TYPE_BOOLEAN)
+		return;
+
+	dbus_message_iter_get_basic(iter, boolean);
+}
+
+static void parse_string(DBusMessageIter *iter, gpointer user_data)
+{
+	char **str = user_data;
+	int arg_type = dbus_message_iter_get_arg_type(iter);
+
+	if (arg_type != DBUS_TYPE_OBJECT_PATH && arg_type != DBUS_TYPE_STRING)
+		return;
+
+	dbus_message_iter_get_basic(iter, str);
+}
+
+typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer user_data);
+
+struct property_handler {
+	const char *property;
+	PropertyHandler callback;
+	gpointer user_data;
+};
+
+static gint property_handler_compare(gconstpointer a, gconstpointer b)
+{
+	const struct property_handler *handler = a;
+	const char *property = b;
+
+	return strcmp(handler->property, property);
+}
+
+/* Demarshall the content of a D-Bus message reply for a given property.
+ *
+ * After the first argument, all arguments must be triplets of:
+ *
+ *   const char* property_name,
+ *   void (parse_func*) (DBusMessageIter *iter, gpointer user_data),
+ *   void** result,
+ *
+ * result must be large enough to store the type of data corresponding to
+ * property_name.
+ *
+ * Finally, a NULL must be appended as the last argument.
+ */
+static void bluetooth_parse_properties(DBusMessage *reply,
+						const char *property, ...)
+{
+	va_list args;
+	GSList *prop_handlers = NULL;
+	DBusMessageIter array, dict;
+
+	va_start(args, property);
+
+	while (property != NULL) {
+		struct property_handler *handler = g_new0(struct property_handler, 1);
+
+		handler->property = property;
+		handler->callback = va_arg(args, PropertyHandler);
+		handler->user_data = va_arg(args, gpointer);
+
+		property = va_arg(args, const char *);
+
+		prop_handlers = g_slist_prepend(prop_handlers, handler);
+	}
+
+	va_end(args);
+
+	if (dbus_message_iter_init(reply, &array) == FALSE)
+		goto done;
+
+	if (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING)
+		dbus_message_iter_next(&array);
+
+	if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_ARRAY)
+		goto done;
+
+	dbus_message_iter_recurse(&array, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry, value;
+		const char *key;
+		GSList *l;
+
+		dbus_message_iter_recurse(&dict, &entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+			goto done;
+
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
+			goto done;
+
+		dbus_message_iter_recurse(&entry, &value);
+
+		l = g_slist_find_custom(prop_handlers, key,
+					property_handler_compare);
+
+		if (l) {
+			struct property_handler *handler = l->data;
+
+			handler->callback(&value, handler->user_data);
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+done:
+	g_slist_foreach(prop_handlers, (GFunc) g_free, NULL);
+	g_slist_free(prop_handlers);
+}
+
 static DBusMessage* create_method_call(const char *adapter_path,
 							const char *interface,
 							const char *method_name)
@@ -156,6 +280,122 @@ static gboolean send_with_reply_and_set_notify(DBusMessage *msg,
 	return TRUE;
 }
 
+/* Handle BlueZ's DeviceFound signal */
+static gboolean device_found(DBusConnection *conn, DBusMessage *message,
+							void *user_data)
+{
+	const char *alias = NULL;
+	const char *address = NULL;
+	gboolean paired, trusted;
+	DBusMessageIter array;
+
+	if (dbus_message_iter_init(message, &array) == FALSE)
+		return TRUE;
+
+	if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_STRING)
+		return TRUE;
+
+	bluetooth_parse_properties(message, "Alias", parse_string, &alias,
+				"Address", parse_string, &address,
+				"Paired", parse_bool, &paired,
+				"Trusted", parse_bool, &trusted,
+				NULL);
+
+	/* Only list new devices if we have not yet listed them. BlueZ will emit
+	 * this signal multiple times for the same device because it may receive
+	 * additional information from the device in subsequent transmissions */
+	if (!g_hash_table_contains(device_addrs, address)) {
+		gint alias_len;
+		const char *alias_status_gap = " ";
+
+		/* Make sure everything aligns under each header; this assumes
+		 * 8-character tabs and 17-character BT address */
+		alias_len = (alias == NULL ? 0 : strlen(alias));
+		if (FALSE) { }
+		else if (alias_len < 3)
+			alias_status_gap = "\t\t\t\t";
+		else if (alias_len < 11)
+			alias_status_gap = "\t\t\t";
+		else if (alias_len < 19)
+			alias_status_gap = "\t\t";
+		else
+			alias_status_gap = "\t";
+
+		g_hash_table_insert(device_addrs, g_strdup (address), NULL);
+		printf("%s    %s%s%s%s\n", address, alias, alias_status_gap,
+						paired ? "paired": "unpaired",
+						trusted ? ", trusted" : "");
+	}
+
+	return TRUE;
+}
+
+static void stop_discovery_reply(DBusPendingCall *pending, void *user_data)
+{
+	/* Once we're done discovering and displaying devices, exit gracefully
+	 */
+	g_main_loop_quit(mainloop);
+}
+
+static gboolean stop_discovery_cb(gpointer data)
+{
+	const char *path = data;
+	DBusMessage *msg;
+
+	if (!(msg = create_method_call(path, BLUEZ_ADAPTER, "StopDiscovery")))
+		return FALSE;
+	send_with_reply_and_set_notify(msg, stop_discovery_reply, NULL, NULL);
+
+	dbus_message_unref(msg);
+
+	return FALSE;
+}
+
+/* Listen for Bluetooth devices broadcasting their availability, then display
+ * the results */
+static gboolean cmd_discover(gpointer data)
+{
+	struct cmd_param *param = data;
+	dbus_bool_t success;
+	DBusMessage *msg;
+
+	/* We may recieve multiple messages for each device, because BlueZ
+	 * notifies us any time it gets additional information for a given
+	 * device, we need to prevent printing duplicate information.
+	 *
+	 * So, we use this hash table as a (unique) set to avoid displaying
+	 * information about a single device more than once. */
+	device_addrs = g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
+									NULL);
+
+	g_dbus_add_signal_watch(conn, BLUEZ_SERVICE, NULL, BLUEZ_ADAPTER,
+				"DeviceFound", device_found, NULL, NULL);
+
+	if (!(msg = create_method_call(param->path, BLUEZ_ADAPTER,
+							"StartDiscovery")))
+		return FALSE;
+
+	printf("Device Address       Name\t\t\tStatus\n");
+	printf("--------------       ----\t\t\t------\n");
+
+	/* Send the message without registering a notify function. This means we
+	 * won't recieve indication of any errors (which may be acceptable in
+	 * certain instances, such as when discovering visible devices) */
+	success = dbus_connection_send(conn, msg, NULL);
+
+	/* We can't know for sure when we've heard back from all Bluetooth
+	 * devices within range, so we need to wait some number of seconds and
+	 * print details as they come in */
+	if (success)
+		g_timeout_add_seconds(12, stop_discovery_cb, param->path);
+	else
+		ERR("Not enough memory to send message");
+
+	dbus_message_unref(msg);
+
+	return FALSE;
+}
+
 static void run_func(const char *adapter_path, GSourceFunc fn,
 							struct cmd_param *param)
 {
@@ -284,7 +524,7 @@ static void bluetoothd_disconnect(DBusConnection *conn, void *user_data)
 }
 
 static struct cmd_struct commands[] = {
-	{ NULL, NULL},
+	{ "discover", cmd_discover},
 };
 
 /* Returns FALSE in case the command could not be parsed. Any failures during
-- 
1.7.11.4

