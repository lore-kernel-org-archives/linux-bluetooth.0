Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/13 v2] tools: Update mpris-player to register using MPRIS interface
Date: Thu, 10 Jan 2013 15:37:18 +0200
Message-Id: <1357825038-21970-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In addition fix not supporting new APIs for getting the adapter.
---
 Makefile.tools       |   1 +
 tools/mpris-player.c | 517 ++++++++++++++++++++++++++-------------------------
 2 files changed, 261 insertions(+), 257 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index be70f51..bda4465 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -174,6 +174,7 @@ tools_btmgmt_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
 tools_btiotest_SOURCES = tools/btiotest.c btio/btio.h btio/btio.c
 tools_btiotest_LDADD = lib/libbluetooth-private.la @GLIB_LIBS@
 
+tools_mpris_player_SOURCES = $(gdbus_sources) tools/mpris-player.c
 tools_mpris_player_LDADD = @GLIB_LIBS@ @DBUS_LIBS@
 
 EXTRA_DIST += tools/bdaddr.1
diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index fd26101..de66f97 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -35,25 +35,35 @@
 
 #include <dbus/dbus.h>
 #include <glib.h>
+#include <gdbus/gdbus.h>
 
-static volatile sig_atomic_t __io_canceled = 0;
-static volatile sig_atomic_t __io_terminated = 0;
-static char *adapter = "/org/bluez/hci0";
+#define BLUEZ_BUS_NAME "org.bluez"
+#define BLUEZ_PATH "/org/bluez"
+#define BLUEZ_ADAPTER_INTERFACE "org.bluez.Adapter1"
+#define BLUEZ_MEDIA_INTERFACE "org.bluez.Media1"
+#define MPRIS_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
+#define MPRIS_PLAYER_PATH "/org/mpris/MediaPlayer2"
+
+static GMainLoop *main_loop;
+static GDBusProxy *adapter = NULL;
 static DBusConnection *sys = NULL;
 static DBusConnection *session = NULL;
 
+static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
+								void *val);
+
 static void sig_term(int sig)
 {
-	__io_canceled = 1;
+	g_main_loop_quit(main_loop);
 }
 
 static DBusMessage *get_all(DBusConnection *conn, const char *name)
 {
 	DBusMessage *msg, *reply;
 	DBusError err;
-	const char *iface = "org.mpris.MediaPlayer2.Player";
+	const char *iface = MPRIS_PLAYER_INTERFACE;
 
-	msg = dbus_message_new_method_call(name, "/org/mpris/MediaPlayer2",
+	msg = dbus_message_new_method_call(name, MPRIS_PLAYER_PATH,
 					DBUS_INTERFACE_PROPERTIES, "GetAll");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
@@ -70,7 +80,6 @@ static DBusMessage *get_all(DBusConnection *conn, const char *name)
 	dbus_message_unref(msg);
 
 	if (!reply) {
-		fprintf(stderr, "Can't get default adapter\n");
 		if (dbus_error_is_set(&err)) {
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
@@ -93,23 +102,47 @@ static void append_variant(DBusMessageIter *iter, int type, void *val)
 	dbus_message_iter_close_container(iter, &value);
 }
 
-static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
-								void *val)
+static void append_array_variant(DBusMessageIter *iter, int type, void *val,
+							int n_elements)
 {
-	DBusMessageIter entry;
-
-	if (type == DBUS_TYPE_STRING) {
-		const char *str = *((const char **) val);
-		if (str == NULL)
-			return;
+	DBusMessageIter variant, array;
+	char type_sig[2] = { type, '\0' };
+	char array_sig[3] = { DBUS_TYPE_ARRAY, type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						array_sig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						type_sig, &array);
+
+	if (dbus_type_is_fixed(type) == TRUE) {
+		dbus_message_iter_append_fixed_array(&array, type, val,
+							n_elements);
+	} else if (type == DBUS_TYPE_STRING || type == DBUS_TYPE_OBJECT_PATH) {
+		const char ***str_array = val;
+		int i;
+
+		for (i = 0; i < n_elements; i++)
+			dbus_message_iter_append_basic(&array, type,
+							&((*str_array)[i]));
 	}
 
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void dict_append_array(DBusMessageIter *dict, const char *key, int type,
+			void *val, int n_elements)
+{
+	DBusMessageIter entry;
+
 	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-							NULL, &entry);
+						NULL, &entry);
 
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
 
-	append_variant(&entry, type, val);
+	append_array_variant(&entry, type, val, n_elements);
 
 	dbus_message_iter_close_container(dict, &entry);
 }
@@ -118,6 +151,8 @@ static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 						DBusMessageIter *metadata)
 {
 	DBusMessageIter var;
+	DBusBasicValue value;
+	int type;
 
 	printf("metadata %s found\n", key);
 
@@ -126,89 +161,35 @@ static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 
 	dbus_message_iter_recurse(entry, &var);
 
-	if (strcasecmp(key, "xesam:title") == 0) {
-		const char *value;
-
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_STRING)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&var, &value);
-		dict_append_entry(metadata, "Title", DBUS_TYPE_STRING,
-								&value);
-	} else if (strcasecmp(key, "xesam:artist") == 0) {
-		const char *value;
-		DBusMessageIter array;
-
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_ARRAY)
-			return -EINVAL;
-
-		dbus_message_iter_recurse(&var, &array);
-
-		if (dbus_message_iter_get_arg_type(&array) !=
-							DBUS_TYPE_STRING)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&array, &value);
-		dict_append_entry(metadata, "Artist", DBUS_TYPE_STRING,
-								&value);
-	} else if (strcasecmp(key, "xesam:album") == 0) {
-		const char *value;
-
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_STRING)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&var, &value);
-		dict_append_entry(metadata, "Album", DBUS_TYPE_STRING,
-								&value);
-	} else if (strcasecmp(key, "xesam:genre") == 0) {
-		const char *value;
+	type = dbus_message_iter_get_arg_type(&var);
+	if (type == DBUS_TYPE_ARRAY) {
+		char **values;
+		int i;
 		DBusMessageIter array;
 
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_ARRAY)
-			return -EINVAL;
-
 		dbus_message_iter_recurse(&var, &array);
 
-		if (dbus_message_iter_get_arg_type(&array) !=
-							DBUS_TYPE_STRING)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&array, &value);
-		dict_append_entry(metadata, "Genre", DBUS_TYPE_STRING,
-								&value);
-	} else if (strcasecmp(key, "mpris:length") == 0) {
-		int64_t usec, msec;
-
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_INT64)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&var, &usec);
-		msec = usec / 1000;
-
-		dict_append_entry(metadata, "Duration", DBUS_TYPE_UINT32,
-								&msec);
-	} else if (strcasecmp(key, "xesam:trackNumber") == 0) {
-		int32_t value;
+		values = dbus_malloc0(sizeof(char *) * 8);
 
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_INT32)
-			return -EINVAL;
+		i = 0;
+		while (dbus_message_iter_get_arg_type(&array) !=
+							DBUS_TYPE_INVALID) {
+			dbus_message_iter_get_basic(&array, &(values[i++]));
+			dbus_message_iter_next(&array);
+		}
 
+		dict_append_array(metadata, key, DBUS_TYPE_STRING, &values, i);
+		dbus_free(values);
+	} else if (dbus_type_is_basic(type)) {
 		dbus_message_iter_get_basic(&var, &value);
-
-		dict_append_entry(metadata, "TrackNumber", DBUS_TYPE_UINT32,
-								&value);
-	}
+		dict_append_entry(metadata, key, type, &value);
+	} else
+		return -EINVAL;
 
 	return 0;
 }
 
-static int parse_track(DBusMessageIter *args, DBusMessageIter *metadata)
+static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metadata)
 {
 	DBusMessageIter dict;
 	int ctype;
@@ -243,7 +224,7 @@ static int parse_track(DBusMessageIter *args, DBusMessageIter *metadata)
 	return 0;
 }
 
-static void append_track(DBusMessageIter *iter, DBusMessageIter *dict)
+static void append_metadata(DBusMessageIter *iter, DBusMessageIter *dict)
 {
 	DBusMessageIter value, metadata;
 
@@ -255,12 +236,36 @@ static void append_track(DBusMessageIter *iter, DBusMessageIter *dict)
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
 
-	parse_track(dict, &metadata);
+	parse_metadata(dict, &metadata);
 
 	dbus_message_iter_close_container(&value, &metadata);
 	dbus_message_iter_close_container(iter, &value);
 }
 
+static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
+								void *val)
+{
+	DBusMessageIter entry;
+
+	if (type == DBUS_TYPE_STRING) {
+		const char *str = *((const char **) val);
+		if (str == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	if (strcasecmp(key, "Metadata") == 0)
+		append_metadata(&entry, val);
+	else
+		append_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
 static dbus_bool_t emit_properties_changed(DBusConnection *conn,
 					const char *path,
 					const char *interface,
@@ -268,7 +273,7 @@ static dbus_bool_t emit_properties_changed(DBusConnection *conn,
 					int type, void *value)
 {
 	DBusMessage *signal;
-	DBusMessageIter iter, dict, entry, array;
+	DBusMessageIter iter, dict, array;
 	dbus_bool_t result;
 
 	signal = dbus_message_new_signal(path, DBUS_INTERFACE_PROPERTIES,
@@ -287,16 +292,7 @@ static dbus_bool_t emit_properties_changed(DBusConnection *conn,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY, NULL,
-								&entry);
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &name);
-
-	if (strcasecmp(name, "Track") == 0)
-		append_track(&entry, value);
-	else
-		append_variant(&entry, type, value);
-
-	dbus_message_iter_close_container(&dict, &entry);
+	dict_append_entry(&dict, name, type, value);
 
 	dbus_message_iter_close_container(&iter, &dict);
 
@@ -316,6 +312,8 @@ static int parse_property(DBusConnection *conn, const char *path,
 						DBusMessageIter *properties)
 {
 	DBusMessageIter var;
+	DBusBasicValue value;
+	int type;
 
 	printf("property %s found\n", key);
 
@@ -324,65 +322,30 @@ static int parse_property(DBusConnection *conn, const char *path,
 
 	dbus_message_iter_recurse(entry, &var);
 
-	if (strcasecmp(key, "PlaybackStatus") == 0) {
-		const char *value;
-
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_STRING)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&var, &value);
-
+	if (strcasecmp(key, "Metadata") == 0) {
 		if (properties)
-			dict_append_entry(properties, "Status",
-						DBUS_TYPE_STRING, &value);
+			dict_append_entry(properties, key,
+						DBUS_TYPE_DICT_ENTRY, &var);
 		else
 			emit_properties_changed(sys, path,
-					"org.bluez.MediaPlayer1", "Status",
-					DBUS_TYPE_STRING, &value);
-	} else if (strcasecmp(key, "Position") == 0) {
-		int64_t usec, msec;
-
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_INT64)
-			return -EINVAL;
+					MPRIS_PLAYER_INTERFACE, key,
+					DBUS_TYPE_DICT_ENTRY, &var);
 
-		dbus_message_iter_get_basic(&var, &usec);
-		msec = usec / 1000;
+		return 0;
+	}
 
-		if (properties)
-			dict_append_entry(properties, "Position",
-						DBUS_TYPE_UINT32, &msec);
-		else
-			emit_properties_changed(sys, path,
-					"org.bluez.MediaPlayer1", "Position",
-					DBUS_TYPE_UINT32, &msec);
-	} else if (strcasecmp(key, "Shuffle") == 0) {
-		dbus_bool_t value;
-		const char *str;
-
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_BOOLEAN)
-			return -EINVAL;
+	type = dbus_message_iter_get_arg_type(&var);
+	if (!dbus_type_is_basic(type))
+		return -EINVAL;
 
-		dbus_message_iter_get_basic(&var, &value);
+	dbus_message_iter_get_basic(&var, &value);
 
-		str = value ? "on" : "off";
-		if (properties)
-			dict_append_entry(properties, "Shuffle",
-						DBUS_TYPE_STRING, &str);
-		else
-			emit_properties_changed(sys, path,
-					"org.bluez.MediaPlayer1", "Shuffle",
-					DBUS_TYPE_STRING, &str);
-	} else if (strcasecmp(key, "Metadata") == 0) {
-		if (properties)
-			parse_track(&var, properties);
-		else
-			emit_properties_changed(sys, path,
-					"org.bluez.MediaPlayer1", "Track",
-					DBUS_TYPE_DICT_ENTRY, &var);
-	}
+	if (properties)
+		dict_append_entry(properties, key, type, &value);
+	else
+		emit_properties_changed(sys, path,
+					MPRIS_PLAYER_INTERFACE, key,
+					type, &value);
 
 	return 0;
 }
@@ -435,12 +398,33 @@ static char *sender2path(const char *sender)
 static DBusHandlerResult player_message(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	if (dbus_message_is_method_call(msg, "org.bluez.MediaPlayer1",
-								"Release")) {
-		printf("Release\n");
-		exit(1);
+	char *owner = data;
+	dbus_uint32_t serial;
+	DBusMessage *copy, *reply;
+	DBusError err;
+
+	copy = dbus_message_copy(msg);
+	dbus_message_set_destination(copy, owner);
+	reply = dbus_connection_send_with_reply_and_block(session, copy, -1,
+									&err);
+	if (!reply) {
+		if (dbus_error_is_set(&err)) {
+			fprintf(stderr, "%s\n", err.message);
+			dbus_error_free(&err);
+		}
+		dbus_message_unref(copy);
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}
 
+	dbus_message_unref(copy);
+
+	copy = dbus_message_copy(reply);
+	serial = dbus_message_get_serial(msg);
+	dbus_message_set_serial(copy, serial);
+
+	dbus_message_unref(copy);
+	dbus_message_unref(reply);
+
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
@@ -455,22 +439,28 @@ static void add_player(DBusConnection *conn, const char *name,
 	DBusMessage *msg;
 	DBusMessageIter iter, args, properties;
 	DBusError err;
-	char *path;
+	char *path, *owner;
 
-	if (!reply)
+	if (!reply || !adapter)
 		return;
 
-	msg = dbus_message_new_method_call("org.bluez", adapter,
-					"org.bluez.Media1",
+	msg = dbus_message_new_method_call(BLUEZ_BUS_NAME,
+					g_dbus_proxy_get_path(adapter),
+					BLUEZ_MEDIA_INTERFACE,
 					"RegisterPlayer");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
 		return;
 	}
 
+	path = sender2path(sender);
+	dbus_connection_get_object_path_data(sys, path, (void **) &owner);
+
+	if (owner != NULL)
+		goto done;
+
 	dbus_message_iter_init_append(msg, &iter);
 
-	path = sender2path(sender);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
 
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
@@ -489,20 +479,25 @@ static void add_player(DBusConnection *conn, const char *name,
 
 	dbus_error_init(&err);
 
+	owner = strdup(sender);
+
+	if (!dbus_connection_register_object_path(sys, path, &player_table,
+								owner)) {
+		fprintf(stderr, "Can't register object path for player\n");
+		free(owner);
+		goto done;
+	}
+
 	reply = dbus_connection_send_with_reply_and_block(sys, msg, -1, &err);
 	if (!reply) {
 		fprintf(stderr, "Can't register player\n");
+		free(owner);
 		if (dbus_error_is_set(&err)) {
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
 		}
-		goto done;
 	}
 
-	if (!dbus_connection_register_object_path(sys, path, &player_table,
-								NULL))
-		fprintf(stderr, "Can't register object path for agent\n");
-
 done:
 	if (reply)
 		dbus_message_unref(reply);
@@ -515,8 +510,12 @@ static void remove_player(DBusConnection *conn, const char *sender)
 	DBusMessage *msg;
 	char *path;
 
-	msg = dbus_message_new_method_call("org.bluez", adapter,
-					"org.bluez.Media1",
+	if (!adapter)
+		return;
+
+	msg = dbus_message_new_method_call(BLUEZ_BUS_NAME,
+					g_dbus_proxy_get_path(adapter),
+					BLUEZ_MEDIA_INTERFACE,
 					"UnregisterPlayer");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
@@ -529,12 +528,14 @@ static void remove_player(DBusConnection *conn, const char *sender)
 
 	dbus_connection_send(sys, msg, NULL);
 
+	dbus_connection_unregister_object_path(sys, path);
+
 	dbus_message_unref(msg);
 	g_free(path);
 }
 
-static DBusHandlerResult properties_changed(DBusConnection *conn,
-							DBusMessage *msg)
+static gboolean properties_changed(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
 {
 	DBusMessageIter iter;
 	const char *iface;
@@ -556,22 +557,14 @@ static DBusHandlerResult properties_changed(DBusConnection *conn,
 
 	g_free(path);
 
-	return DBUS_HANDLER_RESULT_HANDLED;
+	return TRUE;
 }
 
-static DBusHandlerResult session_filter(DBusConnection *conn,
+static gboolean name_owner_changed(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	const char *name, *old, *new;
 
-	if (dbus_message_is_signal(msg, DBUS_INTERFACE_PROPERTIES,
-						"PropertiesChanged"))
-		return properties_changed(conn, msg);
-
-	if (!dbus_message_is_signal(msg, DBUS_INTERFACE_DBUS,
-						"NameOwnerChanged"))
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
 	if (!dbus_message_get_args(msg, NULL,
 					DBUS_TYPE_STRING, &name,
 					DBUS_TYPE_STRING, &old,
@@ -592,33 +585,7 @@ static DBusHandlerResult session_filter(DBusConnection *conn,
 		add_player(conn, name, new);
 	}
 
-	return DBUS_HANDLER_RESULT_HANDLED;
-}
-
-static DBusHandlerResult system_filter(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	const char *name, *old, *new;
-
-	if (!dbus_message_is_signal(msg, DBUS_INTERFACE_DBUS,
-						"NameOwnerChanged"))
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
-	if (!dbus_message_get_args(msg, NULL,
-					DBUS_TYPE_STRING, &name,
-					DBUS_TYPE_STRING, &old,
-					DBUS_TYPE_STRING, &new,
-					DBUS_TYPE_INVALID)) {
-		fprintf(stderr, "Invalid arguments for NameOwnerChanged signal");
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-	}
-
-	if (!strcmp(name, "org.bluez") && *new == '\0') {
-		fprintf(stderr, "bluetoothd disconnected\n");
-		__io_terminated = 1;
-	}
-
-	return DBUS_HANDLER_RESULT_HANDLED;
+	return TRUE;
 }
 
 static char *get_name_owner(DBusConnection *conn, const char *name)
@@ -645,7 +612,6 @@ static char *get_name_owner(DBusConnection *conn, const char *name)
 	dbus_message_unref(msg);
 
 	if (!reply) {
-		fprintf(stderr, "Can't find adapter %s\n", adapter);
 		if (dbus_error_is_set(&err)) {
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
@@ -698,6 +664,8 @@ static void parse_list_names(DBusConnection *conn, DBusMessageIter *args)
 		if (owner == NULL)
 			goto next;
 
+		printf("player %s at %s found\n", name, owner);
+
 		add_player(conn, name, owner);
 
 		g_free(owner);
@@ -727,7 +695,6 @@ static void list_names(DBusConnection *conn)
 	dbus_message_unref(msg);
 
 	if (!reply) {
-		fprintf(stderr, "Can't find adapter %s\n", adapter);
 		if (dbus_error_is_set(&err)) {
 			fprintf(stderr, "%s\n", err.message);
 			dbus_error_free(&err);
@@ -746,29 +713,71 @@ static void list_names(DBusConnection *conn)
 
 static void usage(void)
 {
-	printf("Bluetooth player ver %s\n\n", VERSION);
+	printf("Bluetooth mpris-player ver %s\n\n", VERSION);
 
-	printf("Usage:\n"
-		"\tplayer [--adapter adapter id]\n"
-		"\n");
+	printf("Usage:\n");
 }
 
 static struct option main_options[] = {
-	{ "adapter",	1, 0, 'a' },
 	{ 0, 0, 0, 0 }
 };
 
+static void connect_handler(DBusConnection *connection, void *user_data)
+{
+	printf("org.bluez appeared\n");
+}
+
+static void disconnect_handler(DBusConnection *connection, void *user_data)
+{
+	printf("org.bluez disappeared\n");
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	if (adapter != NULL)
+		return;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, BLUEZ_ADAPTER_INTERFACE)) {
+		printf("Bluetooth Adapter %s found\n",
+						g_dbus_proxy_get_path(proxy));
+		adapter = proxy;
+		list_names(session);
+	}
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
+	if (adapter == NULL)
+		return;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+
+	if (strcmp(interface, BLUEZ_ADAPTER_INTERFACE))
+		return;
+
+	if (adapter != proxy)
+		return;
+
+	printf("Bluetooth Adapter %s removed\n", g_dbus_proxy_get_path(proxy));
+	adapter = NULL;
+}
+
 int main(int argc, char *argv[])
 {
+	GDBusClient *client;
+	guint owner_watch, properties_watch;
 	struct sigaction sa;
-	char match[128];
 	int opt;
 
-	while ((opt = getopt_long(argc, argv, "+a,h", main_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "h", main_options,
+							NULL)) != EOF) {
 		switch(opt) {
-		case '1':
-			adapter = optarg;
-			break;
 		case 'h':
 			usage();
 			exit(0);
@@ -777,48 +786,31 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	sys = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	main_loop = g_main_loop_new(NULL, FALSE);
+
+	sys = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
 	if (!sys) {
 		fprintf(stderr, "Can't get on system bus");
 		exit(1);
 	}
 
-	if (!dbus_connection_add_filter(sys, system_filter, NULL, NULL)) {
-		fprintf(stderr, "Can't add signal filter");
-		exit(1);
-	}
-
-	snprintf(match, sizeof(match),
-			"interface=%s,member=NameOwnerChanged,arg0=%s",
-			DBUS_INTERFACE_DBUS, "org.bluez");
-
-	dbus_bus_add_match(sys, match, NULL);
-
-	session = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	session = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
 	if (!session) {
 		fprintf(stderr, "Can't get on session bus");
 		exit(1);
 	}
 
-	if (!dbus_connection_add_filter(session, session_filter, NULL, NULL)) {
-		fprintf(stderr, "Can't add signal filter");
-		exit(1);
-	}
-
-	snprintf(match, sizeof(match),
-			"interface=%s,member=NameOwnerChanged",
-			DBUS_INTERFACE_DBUS);
+	owner_watch = g_dbus_add_signal_watch(session, NULL, NULL,
+						DBUS_INTERFACE_DBUS,
+						"NameOwnerChanged",
+						name_owner_changed,
+						NULL, NULL);
 
-	dbus_bus_add_match(session, match, NULL);
 
-	snprintf(match, sizeof(match),
-			"interface=%s,member=PropertiesChanged,arg0=%s",
-			DBUS_INTERFACE_PROPERTIES,
-			"org.mpris.MediaPlayer2.Player");
-
-	list_names(session);
-
-	dbus_bus_add_match(session, match, NULL);
+	properties_watch = g_dbus_add_properties_watch(session, NULL, NULL,
+							MPRIS_PLAYER_INTERFACE,
+							properties_changed,
+							NULL, NULL);
 
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags   = SA_NOCLDSTOP;
@@ -826,14 +818,25 @@ int main(int argc, char *argv[])
 	sigaction(SIGTERM, &sa, NULL);
 	sigaction(SIGINT,  &sa, NULL);
 
-	while (!__io_canceled && !__io_terminated) {
-		if (dbus_connection_read_write_dispatch(sys, 500) != TRUE)
-			break;
-		if (dbus_connection_read_write_dispatch(session, 500) != TRUE)
-			break;
-	}
+	client = g_dbus_client_new(sys, BLUEZ_BUS_NAME, BLUEZ_PATH);
 
+	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
+	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
+
+	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+							NULL, NULL);
+
+	g_main_loop_run(main_loop);
+
+	g_dbus_remove_watch(session, owner_watch);
+	g_dbus_remove_watch(session, properties_watch);
+
+	g_dbus_client_unref(client);
+
+	dbus_connection_unref(session);
 	dbus_connection_unref(sys);
 
+	g_main_loop_unref(main_loop);
+
 	return 0;
 }
-- 
1.8.0.1

