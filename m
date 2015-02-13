Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ v2 4/6] client: main: add support for StartFilteredDiscovery
Date: Thu, 12 Feb 2015 19:50:21 -0800
Message-Id: <1423799423-28986-4-git-send-email-jpawlowski@google.com>
In-Reply-To: <1423799423-28986-1-git-send-email-jpawlowski@google.com>
References: <1423799423-28986-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds filtered-scan command to sample DBus client that might
be used to call StartFilteredDiscovery.
---
 client/main.c | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/client/main.c b/client/main.c
index ea80ee7..067b8b1 100644
--- a/client/main.c
+++ b/client/main.c
@@ -527,6 +527,7 @@ static void cmd_show(const char *arg)
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "Discovering");
+	print_property(proxy, "FilteredDiscovery");
 }
 
 static void cmd_select(const char *arg)
@@ -772,6 +773,226 @@ static void cmd_scan(const char *arg)
 	}
 }
 
+static void append_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter value;
+	char sig[2] = { type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
+
+	dbus_message_iter_append_basic(&value, type, val);
+
+	dbus_message_iter_close_container(iter, &value);
+}
+
+static void dict_append_entry(DBusMessageIter *dict, const char *key,
+							int type, void *val)
+{
+	DBusMessageIter entry;
+
+	if (type == DBUS_TYPE_STRING) {
+		const char *str = *((const char **) val);
+
+		if (str == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+#define	DISTNACE_VAL_INVALID	0x7FFF
+
+struct start_filtered_discovery_args {
+	char *discovery_type;
+	dbus_uint16_t RSSI;
+	dbus_int16_t pathloss;
+	GList *UUIDs;
+};
+
+static void start_filtered_discovery_setup(DBusMessageIter *iter,
+					   void *user_data)
+{
+	struct start_filtered_discovery_args *args = user_data;
+	DBusMessageIter dict;
+	char *uuids = g_strdup("UUIDs");
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			 DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			 DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			 DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	if (args->UUIDs != NULL) {
+		DBusMessageIter entry, value, arrayIter;
+		GList *list;
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
+								 NULL, &entry);
+		/* dict key */
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+								       &uuids);
+
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+								 "as", &value);
+
+		dbus_message_iter_open_container(&value, DBUS_TYPE_ARRAY, "s",
+								   &arrayIter);
+
+		for (list = g_list_first(args->UUIDs); list;
+						    list = g_list_next(list)) {
+			char *uuid = g_strdup(list->data);
+
+			dbus_message_iter_append_basic(&arrayIter,
+						      DBUS_TYPE_STRING, &uuid);
+		}
+
+		dbus_message_iter_close_container(&value, &arrayIter);
+
+		/* close vararg*/
+		dbus_message_iter_close_container(&entry, &value);
+
+		/* close entry */
+		dbus_message_iter_close_container(&dict, &entry);
+	}
+
+	if (args->pathloss != DISTNACE_VAL_INVALID)
+		dict_append_entry(&dict, "pathloss", DBUS_TYPE_UINT16,
+							      &args->pathloss);
+
+	if (args->RSSI != DISTNACE_VAL_INVALID)
+		dict_append_entry(&dict, "RSSI", DBUS_TYPE_INT16, &args->RSSI);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+
+static void start_filtered_discovery_reply(DBusMessage *message,
+							       void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message) == TRUE) {
+		rl_printf("Failed to start filtered discovery: %s\n",
+								   error.name);
+		dbus_error_free(&error);
+		return;
+	}
+}
+
+static gint filtered_scan_rssi, filtered_scan_pathloss;
+static char **filtered_scan_uuids;
+static gboolean filtered_scan_help;
+
+static GOptionEntry filtered_discovery_options[] = {
+	{ "rssi", 'r', 0, G_OPTION_ARG_INT, &filtered_scan_rssi,
+				"RSSI filter" },
+	{ "pathloss", 'p', 0, G_OPTION_ARG_INT, &filtered_scan_pathloss,
+				"pathloss filter" },
+	{ "uuids", 'u', 0, G_OPTION_ARG_STRING_ARRAY, &filtered_scan_uuids,
+				"uuid to filter by" },
+	{ "help", 'h', 0, G_OPTION_ARG_NONE, &filtered_scan_help,
+				"show help" },
+	{ NULL },
+};
+
+static void cmd_filtered_scan(const char *arg)
+{
+	struct start_filtered_discovery_args args;
+	GOptionContext *context;
+	GError *error = NULL;
+	int argc, loop;
+	gchar **argv;
+	gchar **arguments = NULL;
+	gchar *cmdline_arg;
+
+	/* add fake prog name at beginning, g_shell_parse_argv expects that */
+	cmdline_arg = g_strconcat("filtered-scan ", arg, NULL);
+	if (g_shell_parse_argv(cmdline_arg, &argc, &arguments, &error)
+								    == FALSE) {
+		if (error != NULL) {
+			g_printerr("error in g_shell_parse_argv: %s\n",
+							       error->message);
+			g_error_free(error);
+		} else
+			g_printerr("An unknown error occurred\n");
+
+		g_strfreev(arguments);
+		g_free(cmdline_arg);
+		return;
+	}
+	g_free(cmdline_arg);
+
+	argc = g_strv_length(arguments);
+	argv = g_new(gchar *, argc);
+	for (loop = 0; loop < argc; loop++)
+		argv[loop] = arguments[loop];
+
+	context = g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, filtered_discovery_options,
+									 NULL);
+	/* set default values for all options */
+	filtered_scan_rssi = DISTNACE_VAL_INVALID;
+	filtered_scan_pathloss = DISTNACE_VAL_INVALID;
+	filtered_scan_uuids = NULL;
+	filtered_scan_help = FALSE;
+
+	g_option_context_set_help_enabled(context, FALSE);
+	if (g_option_context_parse(context, &argc, &argv, &error) == FALSE) {
+		if (error != NULL) {
+			g_printerr("error in g_option_context_parse: %s\n",
+							       error->message);
+			g_error_free(error);
+		} else
+			g_printerr("An unknown error occurred\n");
+
+		g_strfreev(arguments);
+		g_free(argv);
+		return;
+	}
+
+	if (filtered_scan_help) {
+		rl_printf("Filtered scan. Usage:\n");
+		rl_printf("	filtered-scan [-r rssi | -p pathlos] -u <uuid1> [-u <uuid2> ...]\n");
+		rl_printf("\n");
+		rl_printf("Example: filtered-scan -p 65 -u baba -u 1900 -u cafa\n");
+		rl_printf("Use \"scan off\" to disable filtered scan\n");
+		return;
+	}
+
+	args.UUIDs = NULL;
+	args.pathloss = filtered_scan_pathloss;
+	args.RSSI = filtered_scan_rssi;
+
+	if (filtered_scan_uuids != NULL)
+		for (loop = 0; filtered_scan_uuids[loop] != NULL; loop++)
+			args.UUIDs = g_list_append(args.UUIDs,
+					    strdup(filtered_scan_uuids[loop]));
+
+	g_strfreev(arguments);
+	g_free(argv);
+	g_strfreev(filtered_scan_uuids);
+
+	g_option_context_free(context);
+
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	if (g_dbus_proxy_method_call(default_ctrl, "StartFilteredDiscovery",
+		start_filtered_discovery_setup, start_filtered_discovery_reply,
+		&args, NULL /* TODO: proper freeing method here*/) == FALSE) {
+		rl_printf("Failed to start filtered discovery\n");
+		return;
+	}
+}
+
 static void cmd_info(const char *arg)
 {
 	GDBusProxy *proxy;
@@ -1194,6 +1415,8 @@ static const struct {
 							capability_generator},
 	{ "default-agent",NULL,       cmd_default_agent,
 				"Set agent as the default one" },
+	{ "filtered-scan","",         cmd_filtered_scan,
+		"Start filtered scan for devices. filtered-scan -h for help" },
 	{ "scan",         "<on/off>", cmd_scan, "Scan for devices" },
 	{ "info",         "<dev>",    cmd_info, "Device information",
 							dev_generator },
-- 
2.2.0.rc0.207.ga3a616c

