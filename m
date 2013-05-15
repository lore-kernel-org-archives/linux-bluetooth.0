Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/14] tools: Wait MediaFolder interface appear to enable TrackList in mpris-player
Date: Wed, 15 May 2013 18:31:44 +0300
Message-Id: <1368631906-15951-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoids having to use g_dbus_proxy_new which may create a new proxy
when the interface is no registered yet and might not be ready for use.
---
 tools/mpris-player.c | 90 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 20 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 0307861..cdff267 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -66,7 +66,6 @@ static gboolean option_version = FALSE;
 static gboolean option_export = FALSE;
 
 struct tracklist {
-	char *playlist;
 	GDBusProxy *proxy;
 	GSList *items;
 };
@@ -78,6 +77,7 @@ struct player {
 	GDBusProxy *folder;
 	GDBusProxy *device;
 	GDBusProxy *transport;
+	char *playlist;
 	struct tracklist *tracklist;
 };
 
@@ -873,7 +873,7 @@ static void unregister_tracklist(struct player *player)
 	struct tracklist *tracklist = player->tracklist;
 
 	g_slist_free(tracklist->items);
-	g_free(tracklist->playlist);
+	g_dbus_proxy_unref(tracklist->proxy);
 	g_free(tracklist);
 	player->tracklist = NULL;
 }
@@ -896,6 +896,7 @@ static void player_free(void *data)
 	if (player->transport)
 		g_dbus_proxy_unref(player->transport);
 
+	g_free(player->playlist);
 	g_free(player->bus_name);
 	g_free(player);
 }
@@ -1788,6 +1789,10 @@ static void change_folder_reply(DBusMessage *message, void *user_data)
 		return;
 	}
 
+	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYLISTS_INTERFACE,
+						"ActivePlaylist");
+
 	g_dbus_proxy_method_call(tracklist->proxy, "ListItems",
 					list_items_setup, NULL, NULL, NULL);
 }
@@ -1795,10 +1800,9 @@ static void change_folder_reply(DBusMessage *message, void *user_data)
 static void change_folder_setup(DBusMessageIter *iter, void *user_data)
 {
 	struct player *player = user_data;
-	struct tracklist *tracklist = player->tracklist;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
-							&tracklist->playlist);
+							&player->playlist);
 }
 
 static DBusMessage *playlist_activate(DBusConnection *conn,
@@ -1808,6 +1812,11 @@ static DBusMessage *playlist_activate(DBusConnection *conn,
 	struct tracklist *tracklist = player->tracklist;
 	const char *path;
 
+	if (tracklist == NULL)
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid Arguments");
+
 	if (!dbus_message_get_args(msg, NULL,
 					DBUS_TYPE_OBJECT_PATH, &path,
 					DBUS_TYPE_INVALID))
@@ -1815,7 +1824,7 @@ static DBusMessage *playlist_activate(DBusConnection *conn,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid Arguments");
 
-	if (!g_str_equal(path, tracklist->playlist))
+	if (!g_str_equal(path, player->playlist))
 		return g_dbus_create_error(msg,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid Arguments");
@@ -1840,6 +1849,11 @@ static DBusMessage *playlist_get(DBusConnection *conn, DBusMessage *msg,
 	const char *string;
 	const char *empty = "";
 
+	if (tracklist == NULL)
+		return g_dbus_create_error(msg,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid Arguments");
+
 	if (!dbus_message_get_args(msg, NULL,
 					DBUS_TYPE_UINT32, &index,
 					DBUS_TYPE_UINT32, &count,
@@ -1859,14 +1873,14 @@ static DBusMessage *playlist_get(DBusConnection *conn, DBusMessage *msg,
 	dbus_message_iter_open_container(&entry, DBUS_TYPE_STRUCT, NULL,
 								&value);
 	dbus_message_iter_append_basic(&value, DBUS_TYPE_OBJECT_PATH,
-						&tracklist->playlist);
+						&player->playlist);
 	if (g_dbus_proxy_get_property(tracklist->proxy, "Name", &name)) {
 		dbus_message_iter_get_basic(&name, &string);
 		dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING,
 								&string);
 	} else {
 		dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING,
-							&tracklist->playlist);
+							&player->playlist);
 	}
 	dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING, &empty);
 	dbus_message_iter_close_container(&entry, &value);
@@ -1934,9 +1948,9 @@ static gboolean get_active_playlist(const GDBusPropertyTable *property,
 	dbus_message_iter_open_container(&value, DBUS_TYPE_STRUCT, NULL,
 								&entry);
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
-						&tracklist->playlist);
+						&player->playlist);
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
-						&tracklist->playlist);
+						&player->playlist);
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &empty);
 	dbus_message_iter_close_container(&value, &entry);
 	dbus_message_iter_close_container(iter, &value);
@@ -2007,24 +2021,52 @@ static struct player *find_player(GDBusProxy *proxy)
 	return NULL;
 }
 
-static void register_tracklist(struct player *player, const char *path)
+static void register_tracklist(GDBusProxy *proxy)
 {
+	struct player *player;
 	struct tracklist *tracklist;
-	GDBusProxy *proxy;
 
-	if (player->tracklist != NULL)
+	player = find_player(proxy);
+	if (player == NULL)
 		return;
 
-	proxy = g_dbus_proxy_new(client, g_dbus_proxy_get_path(player->proxy),
-						BLUEZ_MEDIA_FOLDER_INTERFACE);
-	if (proxy == NULL)
+	if (player->tracklist != NULL)
 		return;
 
 	tracklist = g_new0(struct tracklist, 1);
-	tracklist->proxy = proxy;
-	tracklist->playlist = g_strdup(path);
+	tracklist->proxy = g_dbus_proxy_ref(proxy);
 
 	player->tracklist = tracklist;
+
+	if (player->playlist == NULL)
+		return;
+
+	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYLISTS_INTERFACE,
+						"PlaylistCount");
+
+	g_dbus_proxy_method_call(tracklist->proxy, "ChangeFolder",
+				change_folder_setup, change_folder_reply,
+				player, NULL);
+}
+
+static void player_set_playlist(struct player *player, const char *path)
+{
+	struct tracklist *tracklist = player->tracklist;
+
+	g_free(player->playlist);
+	player->playlist = g_strdup(path);
+
+	if (player->tracklist == NULL)
+		return;
+
+	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYLISTS_INTERFACE,
+						"PlaylistCount");
+
+	g_dbus_proxy_method_call(tracklist->proxy, "ChangeFolder",
+				change_folder_setup, change_folder_reply,
+				player, NULL);
 }
 
 static void register_player(GDBusProxy *proxy)
@@ -2122,6 +2164,11 @@ static void register_player(GDBusProxy *proxy)
 	if (transport)
 		player->transport = g_dbus_proxy_ref(transport);
 
+	if (g_dbus_proxy_get_property(proxy, "Playlist", &iter)) {
+		dbus_message_iter_get_basic(&iter, &path);
+		player_set_playlist(player, path);
+	}
+
 	return;
 
 fail:
@@ -2199,8 +2246,8 @@ static void register_item(struct player *player, GDBusProxy *proxy)
 		return;
 
 	path = g_dbus_proxy_get_path(proxy);
-	if (g_str_equal(path, tracklist->playlist) ||
-				!g_str_has_prefix(path, tracklist->playlist))
+	if (g_str_equal(path, player->playlist) ||
+				!g_str_has_prefix(path, player->playlist))
 		return;
 
 	l = g_slist_last(tracklist->items);
@@ -2266,6 +2313,9 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface, BLUEZ_MEDIA_TRANSPORT_INTERFACE)) {
 		printf("Bluetooth Transport %s found\n", path);
 		register_transport(proxy);
+	} else if (!strcmp(interface, BLUEZ_MEDIA_FOLDER_INTERFACE)) {
+		printf("Bluetooth Folder %s found\n", path);
+		register_tracklist(proxy);
 	} else if (!strcmp(interface, BLUEZ_MEDIA_ITEM_INTERFACE)) {
 		struct player *player;
 
@@ -2423,7 +2473,7 @@ static void player_property_changed(GDBusProxy *proxy, const char *name,
 	if (strcasecmp(name, "Playlist") == 0) {
 		const char *path;
 		dbus_message_iter_get_basic(iter, &path);
-		return register_tracklist(player, path);
+		return player_set_playlist(player, path);
 	}
 
 	property = property_to_mpris(name);
-- 
1.8.1.4

