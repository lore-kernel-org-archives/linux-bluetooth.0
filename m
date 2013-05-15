Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/14] tools: Use playlist proxy instead of object path in mpris-player
Date: Wed, 15 May 2013 18:31:45 +0300
Message-Id: <1368631906-15951-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is more convenient as it gives access to all properties including
the Name of the playlist.
---
 tools/mpris-player.c | 130 +++++++++++++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 61 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index cdff267..df0ac7c 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -77,7 +77,7 @@ struct player {
 	GDBusProxy *folder;
 	GDBusProxy *device;
 	GDBusProxy *transport;
-	char *playlist;
+	GDBusProxy *playlist;
 	struct tracklist *tracklist;
 };
 
@@ -896,7 +896,9 @@ static void player_free(void *data)
 	if (player->transport)
 		g_dbus_proxy_unref(player->transport);
 
-	g_free(player->playlist);
+	if (player->playlist)
+		g_dbus_proxy_unref(player->playlist);
+
 	g_free(player->bus_name);
 	g_free(player);
 }
@@ -1800,9 +1802,11 @@ static void change_folder_reply(DBusMessage *message, void *user_data)
 static void change_folder_setup(DBusMessageIter *iter, void *user_data)
 {
 	struct player *player = user_data;
+	const char *path;
+
+	path = g_dbus_proxy_get_path(player->playlist);
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
-							&player->playlist);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 }
 
 static DBusMessage *playlist_activate(DBusConnection *conn,
@@ -1812,7 +1816,7 @@ static DBusMessage *playlist_activate(DBusConnection *conn,
 	struct tracklist *tracklist = player->tracklist;
 	const char *path;
 
-	if (tracklist == NULL)
+	if (player->playlist == NULL || tracklist == NULL)
 		return g_dbus_create_error(msg,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid Arguments");
@@ -1824,7 +1828,7 @@ static DBusMessage *playlist_activate(DBusConnection *conn,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid Arguments");
 
-	if (!g_str_equal(path, player->playlist))
+	if (!g_str_equal(path, g_dbus_proxy_get_path(player->playlist)))
 		return g_dbus_create_error(msg,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid Arguments");
@@ -1840,16 +1844,15 @@ static DBusMessage *playlist_get(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct player *player = data;
-	struct tracklist *tracklist = player->tracklist;
 	uint32_t index, count;
 	const char *order;
 	dbus_bool_t reverse;
 	DBusMessage *reply;
 	DBusMessageIter iter, entry, value, name;
-	const char *string;
+	const char *string, *path;
 	const char *empty = "";
 
-	if (tracklist == NULL)
+	if (player->playlist == NULL)
 		return g_dbus_create_error(msg,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid Arguments");
@@ -1864,6 +1867,8 @@ static DBusMessage *playlist_get(DBusConnection *conn, DBusMessage *msg,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid Arguments");
 
+	path = g_dbus_proxy_get_path(player->playlist);
+
 	reply = dbus_message_new_method_return(msg);
 
 	dbus_message_iter_init_append(reply, &iter);
@@ -1872,15 +1877,14 @@ static DBusMessage *playlist_get(DBusConnection *conn, DBusMessage *msg,
 								&entry);
 	dbus_message_iter_open_container(&entry, DBUS_TYPE_STRUCT, NULL,
 								&value);
-	dbus_message_iter_append_basic(&value, DBUS_TYPE_OBJECT_PATH,
-						&player->playlist);
-	if (g_dbus_proxy_get_property(tracklist->proxy, "Name", &name)) {
+	dbus_message_iter_append_basic(&value, DBUS_TYPE_OBJECT_PATH, &path);
+	if (g_dbus_proxy_get_property(player->playlist, "Name", &name)) {
 		dbus_message_iter_get_basic(&name, &string);
 		dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING,
 								&string);
 	} else {
 		dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING,
-							&player->playlist);
+								&path);
 	}
 	dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING, &empty);
 	dbus_message_iter_close_container(&entry, &value);
@@ -1901,13 +1905,20 @@ static const GDBusMethodTable playlist_methods[] = {
 	{ },
 };
 
+static gboolean playlist_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct player *player = data;
+
+	return player->playlist != NULL;
+}
+
 static gboolean get_playlist_count(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct player *player = data;
 	uint32_t count = 1;
 
-	if (player->tracklist == NULL)
+	if (player->playlist == NULL)
 		return FALSE;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &count);
@@ -1934,23 +1945,22 @@ static gboolean get_active_playlist(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct player *player = data;
-	struct tracklist *tracklist = player->tracklist;
 	DBusMessageIter value, entry;
 	dbus_bool_t enabled = TRUE;
-	const char *empty = "";
+	const char *path, *empty = "";
 
-	if (tracklist == NULL)
+	if (player->playlist == NULL)
 		return FALSE;
 
+	path = g_dbus_proxy_get_path(player->playlist);
+
 	dbus_message_iter_open_container(iter, DBUS_TYPE_STRUCT,
 							NULL, &value);
 	dbus_message_iter_append_basic(&value, DBUS_TYPE_BOOLEAN, &enabled);
 	dbus_message_iter_open_container(&value, DBUS_TYPE_STRUCT, NULL,
 								&entry);
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
-						&player->playlist);
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
-						&player->playlist);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH, &path);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &path);
 	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &empty);
 	dbus_message_iter_close_container(&value, &entry);
 	dbus_message_iter_close_container(iter, &value);
@@ -1959,10 +1969,10 @@ static gboolean get_active_playlist(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable playlist_properties[] = {
-	{ "PlaylistCount", "u", get_playlist_count, NULL, tracklist_exists },
+	{ "PlaylistCount", "u", get_playlist_count, NULL, playlist_exists },
 	{ "Orderings", "as", get_orderings, NULL, NULL },
 	{ "ActivePlaylist", "(b(oss))", get_active_playlist, NULL,
-							tracklist_exists },
+							playlist_exists },
 	{ }
 };
 
@@ -2041,30 +2051,7 @@ static void register_tracklist(GDBusProxy *proxy)
 	if (player->playlist == NULL)
 		return;
 
-	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
-						MPRIS_PLAYLISTS_INTERFACE,
-						"PlaylistCount");
-
-	g_dbus_proxy_method_call(tracklist->proxy, "ChangeFolder",
-				change_folder_setup, change_folder_reply,
-				player, NULL);
-}
-
-static void player_set_playlist(struct player *player, const char *path)
-{
-	struct tracklist *tracklist = player->tracklist;
-
-	g_free(player->playlist);
-	player->playlist = g_strdup(path);
-
-	if (player->tracklist == NULL)
-		return;
-
-	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
-						MPRIS_PLAYLISTS_INTERFACE,
-						"PlaylistCount");
-
-	g_dbus_proxy_method_call(tracklist->proxy, "ChangeFolder",
+	g_dbus_proxy_method_call(player->tracklist->proxy, "ChangeFolder",
 				change_folder_setup, change_folder_reply,
 				player, NULL);
 }
@@ -2164,11 +2151,6 @@ static void register_player(GDBusProxy *proxy)
 	if (transport)
 		player->transport = g_dbus_proxy_ref(transport);
 
-	if (g_dbus_proxy_get_property(proxy, "Playlist", &iter)) {
-		dbus_message_iter_get_basic(&iter, &path);
-		player_set_playlist(player, path);
-	}
-
 	return;
 
 fail:
@@ -2232,22 +2214,54 @@ static struct player *find_player_by_item(const char *item)
 	return NULL;
 }
 
+static void register_playlist(struct player *player, GDBusProxy *proxy)
+{
+	const char *path;
+	DBusMessageIter iter;
+
+	if (!g_dbus_proxy_get_property(player->proxy, "Playlist", &iter))
+		return;
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	if (!g_str_equal(path, g_dbus_proxy_get_path(proxy)))
+		return;
+
+	player->playlist = g_dbus_proxy_ref(proxy);
+
+	g_dbus_emit_property_changed(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYLISTS_INTERFACE,
+						"PlaylistCount");
+
+	if (player->tracklist == NULL)
+		return;
+
+	g_dbus_proxy_method_call(player->tracklist->proxy, "ChangeFolder",
+				change_folder_setup, change_folder_reply,
+				player, NULL);
+}
+
 static void register_item(struct player *player, GDBusProxy *proxy)
 {
 	struct tracklist *tracklist;
-	const char *path;
+	const char *path, *playlist;
 	DBusMessage *signal;
 	DBusMessageIter iter, args, metadata;
 	GSList *l;
 	GDBusProxy *after;
 
+	if (player->playlist == NULL) {
+		register_playlist(player, proxy);
+		return;
+	}
+
 	tracklist = player->tracklist;
 	if (tracklist == NULL)
 		return;
 
 	path = g_dbus_proxy_get_path(proxy);
-	if (g_str_equal(path, player->playlist) ||
-				!g_str_has_prefix(path, player->playlist))
+	playlist = g_dbus_proxy_get_path(player->playlist);
+	if (!g_str_has_prefix(path, playlist))
 		return;
 
 	l = g_slist_last(tracklist->items);
@@ -2470,12 +2484,6 @@ static void player_property_changed(GDBusProxy *proxy, const char *name,
 	if (player == NULL)
 		return;
 
-	if (strcasecmp(name, "Playlist") == 0) {
-		const char *path;
-		dbus_message_iter_get_basic(iter, &path);
-		return player_set_playlist(player, path);
-	}
-
 	property = property_to_mpris(name);
 	if (property == NULL)
 		return;
-- 
1.8.1.4

