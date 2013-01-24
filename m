Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6 v2] tools: Make mpris-player to export players using MPRIS interface
Date: Thu, 24 Jan 2013 11:57:59 +0200
Message-Id: <1359021484-6958-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Players found are exported in private connections using
org.mpris.MediaPlayer2.<device name> on the session bus.
---
v2: Fix generating invalid player bus name if device name contains invalid
chars.

 tools/mpris-player.c | 644 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 623 insertions(+), 21 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 246791a..d58e53f 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -32,6 +32,7 @@
 #include <signal.h>
 #include <getopt.h>
 #include <string.h>
+#include <inttypes.h>
 
 #include <dbus/dbus.h>
 #include <glib.h>
@@ -41,13 +42,29 @@
 #define BLUEZ_PATH "/org/bluez"
 #define BLUEZ_ADAPTER_INTERFACE "org.bluez.Adapter1"
 #define BLUEZ_MEDIA_INTERFACE "org.bluez.Media1"
+#define BLUEZ_MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
+#define MPRIS_BUS_NAME "org.mpris.MediaPlayer2."
 #define MPRIS_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
 #define MPRIS_PLAYER_PATH "/org/mpris/MediaPlayer2"
+#define ERROR_INTERFACE "org.mpris.MediaPlayer2.Error"
 
 static GMainLoop *main_loop;
 static GDBusProxy *adapter = NULL;
 static DBusConnection *sys = NULL;
 static DBusConnection *session = NULL;
+static GDBusClient *client = NULL;
+static GSList *players = NULL;
+
+struct player {
+	char *name;
+	char *bus_name;
+	DBusConnection *conn;
+	GDBusProxy *proxy;
+	GDBusProxy *device;
+};
+
+typedef int (* parse_metadata_func) (DBusMessageIter *iter, const char *key,
+						DBusMessageIter *metadata);
 
 static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
 								void *val);
@@ -190,7 +207,8 @@ static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 	return 0;
 }
 
-static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metadata)
+static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metadata,
+						parse_metadata_func func)
 {
 	DBusMessageIter dict;
 	int ctype;
@@ -216,7 +234,7 @@ static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metadata)
 		dbus_message_iter_get_basic(&entry, &key);
 		dbus_message_iter_next(&entry);
 
-		if (parse_metadata_entry(&entry, key, metadata) < 0)
+		if (func(&entry, key, metadata) < 0)
 			return -EINVAL;
 
 		dbus_message_iter_next(&dict);
@@ -225,7 +243,8 @@ static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metadata)
 	return 0;
 }
 
-static void append_metadata(DBusMessageIter *iter, DBusMessageIter *dict)
+static void append_metadata(DBusMessageIter *iter, DBusMessageIter *dict,
+						parse_metadata_func func)
 {
 	DBusMessageIter value, metadata;
 
@@ -237,7 +256,7 @@ static void append_metadata(DBusMessageIter *iter, DBusMessageIter *dict)
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
 
-	parse_metadata(dict, &metadata);
+	parse_metadata(dict, &metadata, func);
 
 	dbus_message_iter_close_container(&value, &metadata);
 	dbus_message_iter_close_container(iter, &value);
@@ -260,7 +279,7 @@ static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
 
 	if (strcasecmp(key, "Metadata") == 0)
-		append_metadata(&entry, val);
+		append_metadata(&entry, val, parse_metadata_entry);
 	else
 		append_variant(&entry, type, val);
 
@@ -509,21 +528,29 @@ done:
 static void remove_player(DBusConnection *conn, const char *sender)
 {
 	DBusMessage *msg;
-	char *path;
+	char *path, *owner;
 
 	if (!adapter)
 		return;
 
+	path = sender2path(sender);
+	dbus_connection_get_object_path_data(sys, path, (void **) &owner);
+
+	if (owner == NULL) {
+		g_free(path);
+		return;
+	}
+
 	msg = dbus_message_new_method_call(BLUEZ_BUS_NAME,
 					g_dbus_proxy_get_path(adapter),
 					BLUEZ_MEDIA_INTERFACE,
 					"UnregisterPlayer");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
+		g_free(path);
 		return;
 	}
 
-	path = sender2path(sender);
 	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &path,
 					DBUS_TYPE_INVALID);
 
@@ -540,10 +567,16 @@ static gboolean properties_changed(DBusConnection *conn,
 {
 	DBusMessageIter iter;
 	const char *iface;
-	char *path;
+	char *path, *owner;
 
 	dbus_message_iter_init(msg, &iter);
 
+	path = sender2path(dbus_message_get_sender(msg));
+	dbus_connection_get_object_path_data(sys, path, (void **) &owner);
+
+	if (owner == NULL)
+		goto done;
+
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
@@ -553,14 +586,28 @@ static gboolean properties_changed(DBusConnection *conn,
 
 	dbus_message_iter_next(&iter);
 
-	path = sender2path(dbus_message_get_sender(msg));
 	parse_properties(conn, path, &iter, NULL);
 
+done:
 	g_free(path);
 
 	return TRUE;
 }
 
+static struct player *find_player_by_bus_name(const char *name)
+{
+	GSList *l;
+
+	for (l = players; l; l = l->next) {
+		struct player *player = l->data;
+
+		if (strcmp(player->bus_name, name) == 0)
+			return player;
+	}
+
+	return NULL;
+}
+
 static gboolean name_owner_changed(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -581,7 +628,7 @@ static gboolean name_owner_changed(DBusConnection *conn,
 	if (*new == '\0') {
 		printf("player %s at %s disappear\n", name, old);
 		remove_player(conn, old);
-	} else {
+	} else if (find_player_by_bus_name(name) == NULL) {
 		printf("player %s at %s found\n", name, new);
 		add_player(conn, name, new);
 	}
@@ -733,23 +780,570 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	printf("org.bluez disappeared\n");
 }
 
-static void proxy_added(GDBusProxy *proxy, void *user_data)
+static void player_free(void *data)
 {
-	const char *interface;
+	struct player *player = data;
+
+	if (player->conn) {
+		dbus_connection_close(player->conn);
+		dbus_connection_unref(player->conn);
+	}
+
+	g_dbus_proxy_unref(player->device);
+	g_dbus_proxy_unref(player->proxy);
+
+	g_free(player->name);
+	g_free(player->bus_name);
+	g_free(player);
+}
+
+struct pending_call {
+	struct player *player;
+	DBusMessage *msg;
+};
+
+static void pending_call_free(void *data)
+{
+	struct pending_call *p = data;
+
+	if (p->msg)
+		dbus_message_unref(p->msg);
+
+	g_free(p);
+}
+
+static void player_reply(DBusMessage *message, void *user_data)
+{
+	struct pending_call *p = user_data;
+	struct player *player = p->player;
+	DBusMessage *msg = p->msg;
+	DBusMessage *reply;
+	DBusError err;
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, message)) {
+		fprintf(stderr, "error: %s", err.name);
+		reply = g_dbus_create_error(msg, err.name, err.message);
+		dbus_error_free(&err);
+	} else
+		reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(player->conn, reply);
+}
+
+static void player_control(struct player *player, DBusMessage *msg,
+							const char *name)
+{
+	struct pending_call *p;
+
+	p = g_new0(struct pending_call, 1);
+	p->player = player;
+	p->msg = dbus_message_ref(msg);
+
+	g_dbus_proxy_method_call(player->proxy, name, NULL, player_reply,
+						p, pending_call_free);
+}
+
+static DBusMessage *player_toggle(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct player *player = data;
+	DBusMessageIter value;
+	const char *status;
+
+	if (!g_dbus_proxy_get_property(player->proxy, "Status", &value))
+		return FALSE;
+
+	dbus_message_iter_get_basic(&value, &status);
+
+	if (strcasecmp(status, "Playing") == 0)
+		player_control(player, msg, "Pause");
+	else
+		player_control(player, msg, "Play");
+
+	return NULL;
+}
+
+static DBusMessage *player_play(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct player *player = data;
+
+	player_control(player, msg, "Play");
+
+	return NULL;
+}
+
+static DBusMessage *player_pause(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct player *player = data;
+
+	player_control(player, msg, "Pause");
+
+	return NULL;
+}
+
+static DBusMessage *player_stop(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct player *player = data;
+
+	player_control(player, msg, "Stop");
+
+	return NULL;
+}
+
+static DBusMessage *player_next(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct player *player = data;
+
+	player_control(player, msg, "Next");
+
+	return NULL;
+}
+
+static DBusMessage *player_previous(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct player *player = data;
+
+	player_control(player, msg, "Previous");
+
+	return NULL;
+}
+
+static gboolean status_exists(const GDBusPropertyTable *property, void *data)
+{
+	DBusMessageIter iter;
+	struct player *player = data;
+
+	return g_dbus_proxy_get_property(player->proxy, "Status", &iter);
+}
+
+static const char *status_to_playback(const char *status)
+{
+	if (strcasecmp(status, "playing") == 0)
+		return "Playing";
+	else if (strcasecmp(status, "paused") == 0)
+		return "Paused";
+	else
+		return "Stopped";
+}
+
+static gboolean get_status(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+	DBusMessageIter value;
+	const char *status;
+
+	if (!g_dbus_proxy_get_property(player->proxy, "Status", &value))
+		return FALSE;
+
+	dbus_message_iter_get_basic(&value, &status);
+
+	status = status_to_playback(status);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &status);
+
+	return TRUE;
+}
+
+static gboolean repeat_exists(const GDBusPropertyTable *property, void *data)
+{
+	DBusMessageIter iter;
+	struct player *player = data;
+
+	return g_dbus_proxy_get_property(player->proxy, "Repeat", &iter);
+}
+
+static const char *repeat_to_loopstatus(const char *value)
+{
+	if (strcasecmp(value, "off") == 0)
+		return "None";
+	else if (strcasecmp(value, "singletrack") == 0)
+		return "Track";
+	else if (strcasecmp(value, "alltracks") == 0)
+		return "Playlist";
+
+	return NULL;
+}
+
+static gboolean get_repeat(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+	DBusMessageIter value;
+	const char *status;
+
+	if (!g_dbus_proxy_get_property(player->proxy, "Repeat", &value))
+		return FALSE;
+
+	dbus_message_iter_get_basic(&value, &status);
+
+	status = repeat_to_loopstatus(status);
+	if (status == NULL)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &status);
+
+	return TRUE;
+}
+
+static gboolean get_double(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	double value = 1.0;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_DOUBLE, &value);
+
+	return TRUE;
+}
+
+static gboolean shuffle_exists(const GDBusPropertyTable *property, void *data)
+{
+	DBusMessageIter iter;
+	struct player *player = data;
+
+	return g_dbus_proxy_get_property(player->proxy, "Shuffle", &iter);
+}
+
+static gboolean get_shuffle(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+	DBusMessageIter value;
+	const char *string;
+	dbus_bool_t shuffle;
+
+	if (!g_dbus_proxy_get_property(player->proxy, "Shuffle", &value))
+		return FALSE;
+
+	dbus_message_iter_get_basic(&value, &string);
+
+	shuffle = strcmp(string, "off") != 0;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &shuffle);
+
+	return TRUE;
+}
+
+static gboolean position_exists(const GDBusPropertyTable *property, void *data)
+{
+	DBusMessageIter iter;
+	struct player *player = data;
+
+	return g_dbus_proxy_get_property(player->proxy, "Position", &iter);
+}
 
-	if (adapter != NULL)
+static gboolean get_position(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+	DBusMessageIter var;
+	uint32_t position;
+	int64_t value;
+
+	if (!g_dbus_proxy_get_property(player->proxy, "Position", &var))
+		return FALSE;
+
+	dbus_message_iter_get_basic(&var, &position);
+
+	value = position * 1000;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_INT64, &value);
+
+	return TRUE;
+}
+
+static gboolean track_exists(const GDBusPropertyTable *property, void *data)
+{
+	DBusMessageIter iter;
+	struct player *player = data;
+
+	return g_dbus_proxy_get_property(player->proxy, "Track", &iter);
+}
+
+static gboolean parse_string_metadata(DBusMessageIter *iter, const char *key,
+						DBusMessageIter *metadata)
+{
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	dict_append_entry(metadata, key, DBUS_TYPE_STRING, &value);
+
+	return TRUE;
+}
+
+static gboolean parse_array_metadata(DBusMessageIter *iter, const char *key,
+						DBusMessageIter *metadata)
+{
+	char **value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	value = dbus_malloc0(sizeof(char *));
+
+	dbus_message_iter_get_basic(iter, &(value[0]));
+
+	dict_append_array(metadata, key, DBUS_TYPE_STRING, &value, 1);
+
+	dbus_free(value);
+
+	return TRUE;
+}
+
+static gboolean parse_int64_metadata(DBusMessageIter *iter, const char *key,
+						DBusMessageIter *metadata)
+{
+	uint32_t duration;
+	int64_t value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &duration);
+
+	value = duration * 1000;
+
+	dict_append_entry(metadata, key, DBUS_TYPE_INT64, &value);
+
+	return TRUE;
+}
+
+static gboolean parse_int32_metadata(DBusMessageIter *iter, const char *key,
+						DBusMessageIter *metadata)
+{
+	uint32_t value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	dict_append_entry(metadata, key, DBUS_TYPE_INT32, &value);
+
+	return TRUE;
+}
+
+static int parse_track_entry(DBusMessageIter *entry, const char *key,
+						DBusMessageIter *metadata)
+{
+	DBusMessageIter var;
+
+	printf("metadata %s found\n", key);
+
+	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(entry, &var);
+
+	if (strcasecmp(key, "Title") == 0) {
+		if (!parse_string_metadata(&var, "xesam:title", metadata))
+			return -EINVAL;
+	} else if (strcasecmp(key, "Artist") == 0) {
+		if (!parse_array_metadata(&var, "xesam:artist", metadata))
+			return -EINVAL;
+	} else if (strcasecmp(key, "Album") == 0) {
+		if (!parse_string_metadata(&var, "xesam:album", metadata))
+			return -EINVAL;
+	} else if (strcasecmp(key, "Genre") == 0) {
+		if (!parse_array_metadata(&var, "xesam:genre", metadata))
+			return -EINVAL;
+	} else if (strcasecmp(key, "Duration") == 0) {
+		if (!parse_int64_metadata(&var, "mpris:length", metadata))
+			return -EINVAL;
+	} else if (strcasecmp(key, "TrackNumber") == 0) {
+		if (!parse_int32_metadata(&var, "xesam:trackNumber", metadata))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static gboolean get_track(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+	DBusMessageIter var, metadata;
+
+	if (!g_dbus_proxy_get_property(player->proxy, "Track", &var))
+		return FALSE;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
+
+	parse_metadata(&var, &metadata, parse_track_entry);
+
+	dbus_message_iter_close_container(iter, &metadata);
+
+	return TRUE;
+}
+
+static gboolean get_enable(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	dbus_bool_t value = TRUE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static const GDBusMethodTable player_methods[] = {
+	{ GDBUS_ASYNC_METHOD("PlayPause", NULL, NULL, player_toggle) },
+	{ GDBUS_ASYNC_METHOD("Play", NULL, NULL, player_play) },
+	{ GDBUS_ASYNC_METHOD("Pause", NULL, NULL, player_pause) },
+	{ GDBUS_ASYNC_METHOD("Stop", NULL, NULL, player_stop) },
+	{ GDBUS_ASYNC_METHOD("Next", NULL, NULL, player_next) },
+	{ GDBUS_ASYNC_METHOD("Previous", NULL, NULL, player_previous) },
+	{ }
+};
+
+static const GDBusSignalTable player_signals[] = {
+	{ GDBUS_SIGNAL("Seeked", GDBUS_ARGS({"Position", "x"})) },
+	{ }
+};
+
+static const GDBusPropertyTable player_properties[] = {
+	{ "PlaybackStatus", "s", get_status, NULL, status_exists },
+	{ "LoopStatus", "s", get_repeat, NULL, repeat_exists },
+	{ "Rate", "d", get_double, NULL, NULL },
+	{ "MinimumRate", "d", get_double, NULL, NULL },
+	{ "MaximumRate", "d", get_double, NULL, NULL },
+	{ "Shuffle", "b", get_shuffle, NULL, shuffle_exists },
+	{ "Position", "x", get_position, NULL, position_exists },
+	{ "Metadata", "a{sv}", get_track, NULL, track_exists },
+	{ "Volume", "d", get_double, NULL, NULL },
+	{ "CanGoNext", "b", get_enable, NULL, NULL },
+	{ "CanGoPrevious", "b", get_enable, NULL, NULL },
+	{ "CanPlay", "b", get_enable, NULL, NULL },
+	{ "CanPause", "b", get_enable, NULL, NULL },
+	{ "CanSeek", "b", get_enable, NULL, NULL },
+	{ "CanControl", "b", get_enable, NULL, NULL },
+	{ }
+};
+
+
+#define a_z "abcdefghijklmnopqrstuvwxyz"
+#define A_Z "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define _0_9 "_0123456789"
+
+static char *mpris_busname(char *name)
+{
+	return g_strconcat(MPRIS_BUS_NAME,
+				g_strcanon(name, A_Z a_z _0_9, '_'), NULL);
+}
+
+static void register_player(GDBusProxy *proxy)
+{
+	struct player *player;
+	DBusMessageIter iter;
+	const char *path, *name;
+	GDBusProxy *device;
+
+	if (!g_dbus_proxy_get_property(proxy, "Device", &iter))
+		return;
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	device = g_dbus_proxy_new(client, path, "org.bluez.Device1");
+	if (device == NULL)
+		return;
+
+	if (!g_dbus_proxy_get_property(device, "Name", &iter))
 		return;
 
+	dbus_message_iter_get_basic(&iter, &name);
+
+	player = g_new0(struct player, 1);
+	player->name = g_strdup(name);
+	player->bus_name = mpris_busname(player->name);
+	player->proxy = g_dbus_proxy_ref(proxy);
+	player->device = device;
+
+	players = g_slist_prepend(players, player);
+
+	printf("Player %s created\n", player->bus_name);
+
+	player->conn = g_dbus_setup_private(DBUS_BUS_SESSION, player->bus_name,
+									NULL);
+	if (!session) {
+		fprintf(stderr, "Could not register bus name %s",
+							player->bus_name);
+		goto fail;
+	}
+
+	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYER_INTERFACE,
+						player_methods,
+						player_signals,
+						player_properties,
+						player, player_free)) {
+		fprintf(stderr, "Could not register interface %s",
+						MPRIS_PLAYER_INTERFACE);
+		goto fail;
+	}
+
+	return;
+
+fail:
+	players = g_slist_remove(players, player);
+	player_free(player);
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+
 	interface = g_dbus_proxy_get_interface(proxy);
 
 	if (!strcmp(interface, BLUEZ_ADAPTER_INTERFACE)) {
+		if (adapter != NULL)
+			return;
+
 		printf("Bluetooth Adapter %s found\n",
 						g_dbus_proxy_get_path(proxy));
 		adapter = proxy;
 		list_names(session);
+	} else if (!strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE)) {
+		printf("Bluetooth Player %s found\n",
+						g_dbus_proxy_get_path(proxy));
+		register_player(proxy);
 	}
 }
 
+static void unregister_player(struct player *player)
+{
+	players = g_slist_remove(players, player);
+
+	g_dbus_unregister_interface(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYER_INTERFACE);
+}
+
+static struct player *find_player(GDBusProxy *proxy)
+{
+	GSList *l;
+
+	for (l = players; l; l = l->next) {
+		struct player *player = l->data;
+
+		if (player->proxy == proxy)
+			return player;
+	}
+
+	return NULL;
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
@@ -759,19 +1353,27 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 
 	interface = g_dbus_proxy_get_interface(proxy);
 
-	if (strcmp(interface, BLUEZ_ADAPTER_INTERFACE))
-		return;
+	if (strcmp(interface, BLUEZ_ADAPTER_INTERFACE) == 0) {
+		if (adapter != proxy)
+			return;
+		printf("Bluetooth Adapter %s removed\n",
+						g_dbus_proxy_get_path(proxy));
+		adapter = NULL;
+	} else if (strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE) == 0) {
+		struct player *player;
 
-	if (adapter != proxy)
-		return;
+		player = find_player(proxy);
+		if (player == NULL)
+			return;
 
-	printf("Bluetooth Adapter %s removed\n", g_dbus_proxy_get_path(proxy));
-	adapter = NULL;
+		printf("Bluetooth Player %s removed\n",
+						g_dbus_proxy_get_path(proxy));
+		unregister_player(player);
+	}
 }
 
 int main(int argc, char *argv[])
 {
-	GDBusClient *client;
 	guint owner_watch, properties_watch;
 	struct sigaction sa;
 	int opt;
@@ -825,7 +1427,7 @@ int main(int argc, char *argv[])
 	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
 
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
-							NULL, NULL);
+								NULL, NULL);
 
 	g_main_loop_run(main_loop);
 
-- 
1.8.1

