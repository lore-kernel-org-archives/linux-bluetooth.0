Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/13 v2] tools: Adapt mpris-player to new API of MediaPlayer1
Date: Thu, 10 Jan 2013 15:37:14 +0200
Message-Id: <1357825038-21970-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In addition fix using Manager1 interface which no longer exists
---
 tools/mpris-player.c | 482 +++++++++++++++++----------------------------------
 1 file changed, 157 insertions(+), 325 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 90c87aa..fd26101 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -38,7 +38,7 @@
 
 static volatile sig_atomic_t __io_canceled = 0;
 static volatile sig_atomic_t __io_terminated = 0;
-static char *adapter = NULL;
+static char *adapter = "/org/bluez/hci0";
 static DBusConnection *sys = NULL;
 static DBusConnection *session = NULL;
 
@@ -114,157 +114,6 @@ static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
 	dbus_message_iter_close_container(dict, &entry);
 }
 
-static dbus_bool_t emit_properties_changed(DBusConnection *conn,
-					const char *path,
-					const char *interface,
-					const char *name,
-					int type, void *value)
-{
-	DBusMessage *signal;
-	DBusMessageIter iter, dict, entry, array;
-	dbus_bool_t result;
-
-	signal = dbus_message_new_signal(path, DBUS_INTERFACE_PROPERTIES,
-							"PropertiesChanged");
-
-	if (!signal) {
-		fprintf(stderr, "Unable to allocate new %s.PropertyChanged"
-							" signal", interface);
-		return FALSE;
-	}
-
-	dbus_message_iter_init_append(signal, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &interface);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY, NULL,
-								&entry);
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &name);
-	append_variant(&entry, type, value);
-	dbus_message_iter_close_container(&dict, &entry);
-
-	dbus_message_iter_close_container(&iter, &dict);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_STRING_AS_STRING, &array);
-	dbus_message_iter_close_container(&iter, &array);
-
-	result = dbus_connection_send(conn, signal, NULL);
-	dbus_message_unref(signal);
-
-	return result;
-}
-
-static int parse_property(DBusConnection *conn, const char *path,
-						const char *key,
-						DBusMessageIter *entry,
-						DBusMessageIter *properties)
-{
-	DBusMessageIter var;
-
-	printf("property %s found\n", key);
-
-	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
-		return -EINVAL;
-
-	dbus_message_iter_recurse(entry, &var);
-
-	if (strcasecmp(key, "PlaybackStatus") == 0) {
-		const char *value;
-
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_STRING)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&var, &value);
-
-		if (properties)
-			dict_append_entry(properties, "Status",
-						DBUS_TYPE_STRING, &value);
-		else
-			emit_properties_changed(sys, path,
-					"org.bluez.MediaPlayer1", "Status",
-					DBUS_TYPE_STRING, &value);
-	} else if (strcasecmp(key, "Position") == 0) {
-		int64_t usec, msec;
-
-		if (dbus_message_iter_get_arg_type(&var) !=
-							DBUS_TYPE_INT64)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&var, &usec);
-		msec = usec / 1000;
-
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
-
-		dbus_message_iter_get_basic(&var, &value);
-
-		str = value ? "on" : "off";
-		if (properties)
-			dict_append_entry(properties, "Shuffle",
-						DBUS_TYPE_STRING, &str);
-		else
-			emit_properties_changed(sys, path,
-					"org.bluez.MediaPlayer1", "Shuffle",
-					DBUS_TYPE_STRING, &str);
-	}
-
-	return 0;
-}
-
-static int parse_properties(DBusConnection *conn, const char *path,
-						DBusMessageIter *args,
-						DBusMessageIter *properties)
-{
-	DBusMessageIter dict;
-	int ctype;
-
-	ctype = dbus_message_iter_get_arg_type(args);
-	if (ctype != DBUS_TYPE_ARRAY)
-		return -EINVAL;
-
-	dbus_message_iter_recurse(args, &dict);
-
-	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
-							DBUS_TYPE_INVALID) {
-		DBusMessageIter entry;
-		const char *key;
-
-		if (ctype != DBUS_TYPE_DICT_ENTRY)
-			return -EINVAL;
-
-		dbus_message_iter_recurse(&dict, &entry);
-		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
-			return -EINVAL;
-
-		dbus_message_iter_get_basic(&entry, &key);
-		dbus_message_iter_next(&entry);
-
-		if (parse_property(conn, path, key, &entry, properties) < 0)
-			return -EINVAL;
-
-		dbus_message_iter_next(&dict);
-	}
-
-	return 0;
-}
-
 static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 						DBusMessageIter *metadata)
 {
@@ -352,7 +201,7 @@ static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 
 		dbus_message_iter_get_basic(&var, &value);
 
-		dict_append_entry(metadata, "Track", DBUS_TYPE_UINT32,
+		dict_append_entry(metadata, "TrackNumber", DBUS_TYPE_UINT32,
 								&value);
 	}
 
@@ -361,20 +210,14 @@ static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 
 static int parse_track(DBusMessageIter *args, DBusMessageIter *metadata)
 {
-	DBusMessageIter var, dict;
+	DBusMessageIter dict;
 	int ctype;
 
 	ctype = dbus_message_iter_get_arg_type(args);
-	if (ctype != DBUS_TYPE_VARIANT)
-		return -EINVAL;
-
-	dbus_message_iter_recurse(args, &var);
-
-	ctype = dbus_message_iter_get_arg_type(&var);
 	if (ctype != DBUS_TYPE_ARRAY)
 		return -EINVAL;
 
-	dbus_message_iter_recurse(&var, &dict);
+	dbus_message_iter_recurse(args, &dict);
 
 	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
 							DBUS_TYPE_INVALID) {
@@ -400,7 +243,153 @@ static int parse_track(DBusMessageIter *args, DBusMessageIter *metadata)
 	return 0;
 }
 
-static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metadata)
+static void append_track(DBusMessageIter *iter, DBusMessageIter *dict)
+{
+	DBusMessageIter value, metadata;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, "a{sv}",
+								&value);
+
+	dbus_message_iter_open_container(&value, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
+
+	parse_track(dict, &metadata);
+
+	dbus_message_iter_close_container(&value, &metadata);
+	dbus_message_iter_close_container(iter, &value);
+}
+
+static dbus_bool_t emit_properties_changed(DBusConnection *conn,
+					const char *path,
+					const char *interface,
+					const char *name,
+					int type, void *value)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter, dict, entry, array;
+	dbus_bool_t result;
+
+	signal = dbus_message_new_signal(path, DBUS_INTERFACE_PROPERTIES,
+							"PropertiesChanged");
+
+	if (!signal) {
+		fprintf(stderr, "Unable to allocate new %s.PropertyChanged"
+							" signal", interface);
+		return FALSE;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &interface);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY, NULL,
+								&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &name);
+
+	if (strcasecmp(name, "Track") == 0)
+		append_track(&entry, value);
+	else
+		append_variant(&entry, type, value);
+
+	dbus_message_iter_close_container(&dict, &entry);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &array);
+	dbus_message_iter_close_container(&iter, &array);
+
+	result = dbus_connection_send(conn, signal, NULL);
+	dbus_message_unref(signal);
+
+	return result;
+}
+
+static int parse_property(DBusConnection *conn, const char *path,
+						const char *key,
+						DBusMessageIter *entry,
+						DBusMessageIter *properties)
+{
+	DBusMessageIter var;
+
+	printf("property %s found\n", key);
+
+	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(entry, &var);
+
+	if (strcasecmp(key, "PlaybackStatus") == 0) {
+		const char *value;
+
+		if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_STRING)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (properties)
+			dict_append_entry(properties, "Status",
+						DBUS_TYPE_STRING, &value);
+		else
+			emit_properties_changed(sys, path,
+					"org.bluez.MediaPlayer1", "Status",
+					DBUS_TYPE_STRING, &value);
+	} else if (strcasecmp(key, "Position") == 0) {
+		int64_t usec, msec;
+
+		if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_INT64)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(&var, &usec);
+		msec = usec / 1000;
+
+		if (properties)
+			dict_append_entry(properties, "Position",
+						DBUS_TYPE_UINT32, &msec);
+		else
+			emit_properties_changed(sys, path,
+					"org.bluez.MediaPlayer1", "Position",
+					DBUS_TYPE_UINT32, &msec);
+	} else if (strcasecmp(key, "Shuffle") == 0) {
+		dbus_bool_t value;
+		const char *str;
+
+		if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_BOOLEAN)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		str = value ? "on" : "off";
+		if (properties)
+			dict_append_entry(properties, "Shuffle",
+						DBUS_TYPE_STRING, &str);
+		else
+			emit_properties_changed(sys, path,
+					"org.bluez.MediaPlayer1", "Shuffle",
+					DBUS_TYPE_STRING, &str);
+	} else if (strcasecmp(key, "Metadata") == 0) {
+		if (properties)
+			parse_track(&var, properties);
+		else
+			emit_properties_changed(sys, path,
+					"org.bluez.MediaPlayer1", "Track",
+					DBUS_TYPE_DICT_ENTRY, &var);
+	}
+
+	return 0;
+}
+
+static int parse_properties(DBusConnection *conn, const char *path,
+						DBusMessageIter *args,
+						DBusMessageIter *properties)
 {
 	DBusMessageIter dict;
 	int ctype;
@@ -426,13 +415,13 @@ static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metadata)
 		dbus_message_iter_get_basic(&entry, &key);
 		dbus_message_iter_next(&entry);
 
-		if (strcasecmp(key, "Metadata") == 0)
-			return parse_track(&entry, metadata);
+		if (parse_property(conn, path, key, &entry, properties) < 0)
+			return -EINVAL;
 
 		dbus_message_iter_next(&dict);
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
 static char *sender2path(const char *sender)
@@ -464,7 +453,7 @@ static void add_player(DBusConnection *conn, const char *name,
 {
 	DBusMessage *reply = get_all(conn, name);
 	DBusMessage *msg;
-	DBusMessageIter iter, args, properties, metadata;
+	DBusMessageIter iter, args, properties;
 	DBusError err;
 	char *path;
 
@@ -496,18 +485,6 @@ static void add_player(DBusConnection *conn, const char *name,
 
 	dbus_message_iter_close_container(&iter, &properties);
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
-
-	dbus_message_iter_init(reply, &args);
-
-	if (parse_metadata(&args, &metadata) < 0)
-		goto done;
-
-	dbus_message_iter_close_container(&iter, &metadata);
-
 	dbus_message_unref(reply);
 
 	dbus_error_init(&err);
@@ -559,8 +536,7 @@ static void remove_player(DBusConnection *conn, const char *sender)
 static DBusHandlerResult properties_changed(DBusConnection *conn,
 							DBusMessage *msg)
 {
-	DBusMessage *signal;
-	DBusMessageIter iter, entry, metadata;
+	DBusMessageIter iter;
 	const char *iface;
 	char *path;
 
@@ -578,40 +554,9 @@ static DBusHandlerResult properties_changed(DBusConnection *conn,
 	path = sender2path(dbus_message_get_sender(msg));
 	parse_properties(conn, path, &iter, NULL);
 
-	signal = dbus_message_new_signal(path, "org.bluez.MediaPlayer1",
-							"TrackChanged");
-	if (!signal) {
-		fprintf(stderr, "Unable to allocate new PropertyChanged"
-							" signal\n");
-		goto err;
-	}
-
-	dbus_message_iter_init_append(signal, &entry);
-
-	dbus_message_iter_open_container(&entry, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
-
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_next(&iter);
-
-	if (parse_metadata(&iter, &metadata) < 0)
-		goto err;
-
-	dbus_message_iter_close_container(&entry, &metadata);
-
-	dbus_connection_send(sys, signal, NULL);
-	dbus_message_unref(signal);
 	g_free(path);
 
 	return DBUS_HANDLER_RESULT_HANDLED;
-
-err:
-	if (signal)
-		dbus_message_unref(signal);
-	g_free(path);
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
 static DBusHandlerResult session_filter(DBusConnection *conn,
@@ -676,114 +621,6 @@ static DBusHandlerResult system_filter(DBusConnection *conn,
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
-static char *get_default_adapter(DBusConnection *conn)
-{
-	DBusMessage *msg, *reply;
-	DBusError err;
-	const char *reply_path;
-	char *path;
-
-	msg = dbus_message_new_method_call("org.bluez", "/",
-					"org.bluez.Manager", "DefaultAdapter");
-
-	if (!msg) {
-		fprintf(stderr, "Can't allocate new method call\n");
-		return NULL;
-	}
-
-	dbus_error_init(&err);
-
-	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
-
-	dbus_message_unref(msg);
-
-	if (!reply) {
-		fprintf(stderr, "Can't get default adapter\n");
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		return NULL;
-	}
-
-	if (!dbus_message_get_args(reply, &err,
-					DBUS_TYPE_OBJECT_PATH, &reply_path,
-					DBUS_TYPE_INVALID)) {
-		fprintf(stderr, "Can't get reply arguments\n");
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		dbus_message_unref(reply);
-		return NULL;
-	}
-
-	path = strdup(reply_path);
-
-	dbus_message_unref(reply);
-
-	dbus_connection_flush(conn);
-
-	return path;
-}
-
-static char *get_adapter(DBusConnection *conn, const char *adapter)
-{
-	DBusMessage *msg, *reply;
-	DBusError err;
-	const char *reply_path;
-	char *path;
-
-	if (!adapter)
-		return get_default_adapter(conn);
-
-	msg = dbus_message_new_method_call("org.bluez", "/",
-					"org.bluez.Manager", "FindAdapter");
-
-	if (!msg) {
-		fprintf(stderr, "Can't allocate new method call\n");
-		return NULL;
-	}
-
-	dbus_message_append_args(msg, DBUS_TYPE_STRING, &adapter,
-					DBUS_TYPE_INVALID);
-
-	dbus_error_init(&err);
-
-	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
-
-	dbus_message_unref(msg);
-
-	if (!reply) {
-		fprintf(stderr, "Can't find adapter %s\n", adapter);
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		return NULL;
-	}
-
-	if (!dbus_message_get_args(reply, &err,
-					DBUS_TYPE_OBJECT_PATH, &reply_path,
-					DBUS_TYPE_INVALID)) {
-		fprintf(stderr, "Can't get reply arguments\n");
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		dbus_message_unref(reply);
-		return NULL;
-	}
-
-	path = strdup(reply_path);
-
-	dbus_message_unref(reply);
-
-	dbus_connection_flush(conn);
-
-	return path;
-}
-
 static char *get_name_owner(DBusConnection *conn, const char *name)
 {
 	DBusMessage *msg, *reply;
@@ -924,14 +761,13 @@ static struct option main_options[] = {
 int main(int argc, char *argv[])
 {
 	struct sigaction sa;
-	char *adapter_id = NULL;
 	char match[128];
 	int opt;
 
 	while ((opt = getopt_long(argc, argv, "+a,h", main_options, NULL)) != EOF) {
 		switch(opt) {
 		case '1':
-			adapter_id = optarg;
+			adapter = optarg;
 			break;
 		case 'h':
 			usage();
@@ -947,10 +783,6 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	adapter = get_adapter(sys, adapter_id);
-	if (!adapter)
-		exit(1);
-
 	if (!dbus_connection_add_filter(sys, system_filter, NULL, NULL)) {
 		fprintf(stderr, "Can't add signal filter");
 		exit(1);
-- 
1.8.0.1

