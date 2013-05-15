Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/14] tools: Add support for MPRIS TrackList interface to mpris-player
Date: Wed, 15 May 2013 18:31:33 +0300
Message-Id: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for TrackList interface as defined in MPRIS:
http://specifications.freedesktop.org/mpris-spec/latest/Track_List_Interface.html
---
 tools/mpris-player.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 286 insertions(+), 13 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index a7a506c..3378227 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -43,10 +43,13 @@
 #define BLUEZ_ADAPTER_INTERFACE "org.bluez.Adapter1"
 #define BLUEZ_MEDIA_INTERFACE "org.bluez.Media1"
 #define BLUEZ_MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
+#define BLUEZ_MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
+#define BLUEZ_MEDIA_ITEM_INTERFACE "org.bluez.MediaItem1"
 #define BLUEZ_MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 #define MPRIS_BUS_NAME "org.mpris.MediaPlayer2."
 #define MPRIS_INTERFACE "org.mpris.MediaPlayer2"
 #define MPRIS_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
+#define MPRIS_TRACKLIST_INTERFACE "org.mpris.MediaPlayer2.TrackList"
 #define MPRIS_PLAYER_PATH "/org/mpris/MediaPlayer2"
 #define ERROR_INTERFACE "org.mpris.MediaPlayer2.Error"
 
@@ -61,12 +64,20 @@ static GSList *transports = NULL;
 static gboolean option_version = FALSE;
 static gboolean option_export = FALSE;
 
+struct tracklist {
+	char *playlist;
+	GDBusProxy *proxy;
+	GSList *items;
+};
+
 struct player {
 	char *bus_name;
 	DBusConnection *conn;
 	GDBusProxy *proxy;
+	GDBusProxy *folder;
 	GDBusProxy *device;
 	GDBusProxy *transport;
+	struct tracklist *tracklist;
 };
 
 typedef int (* parse_metadata_func) (DBusMessageIter *iter, const char *key,
@@ -856,10 +867,23 @@ static void disconnect_handler(DBusConnection *connection, void *user_data)
 	printf("org.bluez disappeared\n");
 }
 
+static void unregister_tracklist(struct player *player)
+{
+	struct tracklist *tracklist = player->tracklist;
+
+	g_slist_free(tracklist->items);
+	g_free(tracklist->playlist);
+	g_free(tracklist);
+	player->tracklist = NULL;
+}
+
 static void player_free(void *data)
 {
 	struct player *player = data;
 
+	if (player->tracklist != NULL)
+		unregister_tracklist(player);
+
 	if (player->conn) {
 		dbus_connection_close(player->conn);
 		dbus_connection_unref(player->conn);
@@ -1464,16 +1488,106 @@ static const GDBusMethodTable mpris_methods[] = {
 	{ }
 };
 
+static gboolean get_tracklist(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+	dbus_bool_t value;
+
+	value = player->tracklist != NULL ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable mpris_properties[] = {
 	{ "CanQuit", "b", get_disable, NULL, NULL },
 	{ "Fullscreen", "b", get_disable, NULL, NULL },
 	{ "CanSetFullscreen", "b", get_disable, NULL, NULL },
 	{ "CanRaise", "b", get_disable, NULL, NULL },
-	{ "HasTrackList", "b", get_disable, NULL, NULL },
+	{ "HasTrackList", "b", get_tracklist, NULL, NULL },
 	{ "Identity", "s", get_name, NULL, NULL },
 	{ }
 };
 
+static DBusMessage *tracklist_get_metadata(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
+					"Not implemented");
+}
+
+static DBusMessage *tracklist_goto(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
+					"Not implemented");
+}
+
+static DBusMessage *tracklist_add_track(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
+					"Not implemented");
+}
+
+static DBusMessage *tracklist_remove_track(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
+					"Not implemented");
+}
+
+static const GDBusMethodTable tracklist_methods[] = {
+	{ GDBUS_METHOD("GetTracksMetadata",
+			GDBUS_ARGS({ "tracks", "ao" }),
+			GDBUS_ARGS({ "metadata", "aa{sv}" }),
+			tracklist_get_metadata) },
+	{ GDBUS_METHOD("AddTrack",
+			GDBUS_ARGS({ "uri", "s" }, { "after", "o" },
+						{ "current", "b" }),
+			NULL,
+			tracklist_add_track) },
+	{ GDBUS_METHOD("RemoveTrack",
+			GDBUS_ARGS({ "track", "o" }), NULL,
+			tracklist_remove_track) },
+	{ GDBUS_ASYNC_METHOD("GoTo",
+			GDBUS_ARGS({ "track", "o" }), NULL,
+			tracklist_goto) },
+	{ },
+};
+
+static void append_path(gpointer data, gpointer user_data)
+{
+	GDBusProxy *proxy = data;
+	DBusMessageIter *iter = user_data;
+	const char *path = g_dbus_proxy_get_path(proxy);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static gboolean get_tracks(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+	DBusMessageIter value;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_OBJECT_PATH_AS_STRING,
+					&value);
+	g_slist_foreach(player->tracklist->items, append_path, &value);
+	dbus_message_iter_close_container(iter, &value);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable tracklist_properties[] = {
+	{ "Tracks", "ao", get_tracks, NULL, NULL },
+	{ "CanEditTracks", "b", get_disable, NULL, NULL },
+	{ }
+};
+
 #define a_z "abcdefghijklmnopqrstuvwxyz"
 #define A_Z "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 #define _0_9 "_0123456789"
@@ -1509,6 +1623,79 @@ static GDBusProxy *find_transport_by_path(const char *path)
 	return NULL;
 }
 
+static void list_items_setup(DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void change_folder_reply(DBusMessage *message, void *user_data)
+{
+	struct player *player = user_data;
+	struct tracklist *tracklist = player->tracklist;
+	DBusError err;
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, message)) {
+		fprintf(stderr, "error: %s", err.name);
+		return;
+	}
+
+	g_dbus_proxy_method_call(tracklist->proxy, "ListItems",
+					list_items_setup, NULL, NULL, NULL);
+}
+
+static void change_folder_setup(DBusMessageIter *iter, void *user_data)
+{
+	struct player *player = user_data;
+	struct tracklist *tracklist = player->tracklist;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+							&tracklist->playlist);
+}
+
+static void register_tracklist(struct player *player, const char *playlist)
+{
+	struct tracklist *tracklist;
+	GDBusProxy *proxy;
+
+	if (player->tracklist != NULL)
+		return;
+
+	proxy = g_dbus_proxy_new(client, g_dbus_proxy_get_path(player->proxy),
+						BLUEZ_MEDIA_FOLDER_INTERFACE);
+	if (proxy == NULL)
+		return;
+
+	tracklist = g_new0(struct tracklist, 1);
+	tracklist->proxy = proxy;
+	tracklist->playlist = g_strdup(playlist);
+
+	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_TRACKLIST_INTERFACE,
+						tracklist_methods,
+						NULL,
+						tracklist_properties,
+						player, NULL)) {
+		fprintf(stderr, "Could not register interface %s",
+						MPRIS_TRACKLIST_INTERFACE);
+		g_free(tracklist);
+		return;
+	}
+
+	player->tracklist = tracklist;
+
+	g_dbus_proxy_method_call(proxy, "ChangeFolder", change_folder_setup,
+					change_folder_reply, player, NULL);
+}
+
 static void register_player(GDBusProxy *proxy)
 {
 	struct player *player;
@@ -1582,6 +1769,11 @@ static void register_player(GDBusProxy *proxy)
 	if (transport)
 		player->transport = g_dbus_proxy_ref(transport);
 
+	if (g_dbus_proxy_get_property(proxy, "Playlist", &iter)) {
+		dbus_message_iter_get_basic(&iter, &path);
+		register_tracklist(player, path);
+	}
+
 	return;
 
 fail:
@@ -1630,28 +1822,72 @@ static void register_transport(GDBusProxy *proxy)
 	player->transport = g_dbus_proxy_ref(proxy);
 }
 
+static struct player *find_player_by_item(const char *item)
+{
+	GSList *l;
+
+	for (l = players; l; l = l->next) {
+		struct player *player = l->data;
+		const char *path = g_dbus_proxy_get_path(player->proxy);
+
+		if (g_str_has_prefix(item, path))
+			return player;
+	}
+
+	return NULL;
+}
+
+static void register_item(struct player *player, GDBusProxy *proxy)
+{
+	struct tracklist *tracklist;
+	const char *path;
+
+	tracklist = player->tracklist;
+	if (tracklist == NULL)
+		return;
+
+	path = g_dbus_proxy_get_path(proxy);
+	if (g_str_equal(path, tracklist->playlist) ||
+				!g_str_has_prefix(path, tracklist->playlist))
+		return;
+
+	tracklist->items = g_slist_append(tracklist->items, proxy);
+
+	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_TRACKLIST_INTERFACE,
+						"Tracks");
+}
+
 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
+	const char *path;
 
 	interface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
 
 	if (!strcmp(interface, BLUEZ_ADAPTER_INTERFACE)) {
 		if (adapter != NULL)
 			return;
 
-		printf("Bluetooth Adapter %s found\n",
-						g_dbus_proxy_get_path(proxy));
+		printf("Bluetooth Adapter %s found\n", path);
 		adapter = proxy;
 		list_names(session);
 	} else if (!strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE)) {
-		printf("Bluetooth Player %s found\n",
-						g_dbus_proxy_get_path(proxy));
+		printf("Bluetooth Player %s found\n", path);
 		register_player(proxy);
 	} else if (!strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE)) {
-		printf("Bluetooth Transport %s found\n",
-						g_dbus_proxy_get_path(proxy));
+		printf("Bluetooth Transport %s found\n", path);
 		register_transport(proxy);
+	} else if (!strcmp(interface, BLUEZ_MEDIA_ITEM_INTERFACE)) {
+		struct player *player;
+
+		player = find_player_by_item(path);
+		if (player == NULL)
+			return;
+
+		printf("Bluetooth Item %s found\n", path);
+		register_item(player, proxy);
 	}
 }
 
@@ -1660,6 +1896,9 @@ static void unregister_player(struct player *player)
 	players = g_slist_remove(players, player);
 
 	g_dbus_unregister_interface(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_TRACKLIST_INTERFACE);
+
+	g_dbus_unregister_interface(player->conn, MPRIS_PLAYER_PATH,
 						MPRIS_INTERFACE);
 
 	g_dbus_unregister_interface(player->conn, MPRIS_PLAYER_PATH,
@@ -1711,20 +1950,41 @@ static void unregister_transport(GDBusProxy *proxy)
 	player->transport = NULL;
 }
 
+static void unregister_item(struct player *player, GDBusProxy *proxy)
+{
+	struct tracklist *tracklist = player->tracklist;
+	const char *path;
+
+	if (tracklist == NULL)
+		return;
+
+	path = g_dbus_proxy_get_path(proxy);
+	if (g_str_equal(path, tracklist->playlist) ||
+				!g_str_has_prefix(path, tracklist->playlist))
+		return;
+
+	tracklist->items = g_slist_remove(tracklist->items, proxy);
+
+	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_TRACKLIST_INTERFACE,
+						"Tracks");
+}
+
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
 {
 	const char *interface;
+	const char *path;
 
 	if (adapter == NULL)
 		return;
 
 	interface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
 
 	if (strcmp(interface, BLUEZ_ADAPTER_INTERFACE) == 0) {
 		if (adapter != proxy)
 			return;
-		printf("Bluetooth Adapter %s removed\n",
-						g_dbus_proxy_get_path(proxy));
+		printf("Bluetooth Adapter %s removed\n", path);
 		adapter = NULL;
 	} else if (strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE) == 0) {
 		struct player *player;
@@ -1733,13 +1993,20 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 		if (player == NULL)
 			return;
 
-		printf("Bluetooth Player %s removed\n",
-						g_dbus_proxy_get_path(proxy));
+		printf("Bluetooth Player %s removed\n", path);
 		unregister_player(player);
 	} else if (strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE) == 0) {
-		printf("Bluetooth Transport %s removed\n",
-						g_dbus_proxy_get_path(proxy));
+		printf("Bluetooth Transport %s removed\n", path);
 		unregister_transport(proxy);
+	} else if (strcmp(interface, BLUEZ_MEDIA_ITEM_INTERFACE) == 0) {
+		struct player *player;
+
+		player = find_player_by_item(path);
+		if (player == NULL)
+			return;
+
+		printf("Bluetooth Item %s removed\n", path);
+		unregister_item(player, proxy);
 	}
 }
 
@@ -1771,6 +2038,12 @@ static void player_property_changed(GDBusProxy *proxy, const char *name,
 	if (player == NULL)
 		return;
 
+	if (strcasecmp(name, "Playlist") == 0) {
+		const char *path;
+		dbus_message_iter_get_basic(iter, &path);
+		return register_tracklist(player, path);
+	}
+
 	property = property_to_mpris(name);
 	if (property == NULL)
 		return;
-- 
1.8.1.4

