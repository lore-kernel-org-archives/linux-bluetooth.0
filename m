Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/14] tools: Always register Playlists and TrackList in mpris-player
Date: Wed, 15 May 2013 18:31:43 +0300
Message-Id: <1368631906-15951-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MPRIS spec does not make use of ObjectManager so the interfaces need
to be registered all together otherwise clients may get errors and
assume the interfaces will never be registered.
---
 tools/mpris-player.c | 115 +++++++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index cdda3ec..0307861 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -1722,6 +1722,13 @@ static const GDBusSignalTable tracklist_signals[] = {
 	{ }
 };
 
+static gboolean tracklist_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct player *player = data;
+
+	return player->tracklist != NULL;
+}
+
 static void append_path(gpointer data, gpointer user_data)
 {
 	GDBusProxy *proxy = data;
@@ -1735,8 +1742,12 @@ static gboolean get_tracks(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct player *player = data;
+	struct tracklist *tracklist = player->tracklist;
 	DBusMessageIter value;
 
+	if (tracklist == NULL)
+		return FALSE;
+
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_TYPE_OBJECT_PATH_AS_STRING,
 					&value);
@@ -1747,7 +1758,7 @@ static gboolean get_tracks(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable tracklist_properties[] = {
-	{ "Tracks", "ao", get_tracks, NULL, NULL },
+	{ "Tracks", "ao", get_tracks, NULL, tracklist_exists },
 	{ "CanEditTracks", "b", get_disable, NULL, NULL },
 	{ }
 };
@@ -1879,8 +1890,12 @@ static const GDBusMethodTable playlist_methods[] = {
 static gboolean get_playlist_count(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
+	struct player *player = data;
 	uint32_t count = 1;
 
+	if (player->tracklist == NULL)
+		return FALSE;
+
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &count);
 
 	return TRUE;
@@ -1910,6 +1925,9 @@ static gboolean get_active_playlist(const GDBusPropertyTable *property,
 	dbus_bool_t enabled = TRUE;
 	const char *empty = "";
 
+	if (tracklist == NULL)
+		return FALSE;
+
 	dbus_message_iter_open_container(iter, DBUS_TYPE_STRUCT,
 							NULL, &value);
 	dbus_message_iter_append_basic(&value, DBUS_TYPE_BOOLEAN, &enabled);
@@ -1927,9 +1945,10 @@ static gboolean get_active_playlist(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable playlist_properties[] = {
-	{ "PlaylistCount", "u", get_playlist_count, NULL, NULL },
+	{ "PlaylistCount", "u", get_playlist_count, NULL, tracklist_exists },
 	{ "Orderings", "as", get_orderings, NULL, NULL },
-	{ "ActivePlaylist", "(b(oss))", get_active_playlist, NULL, NULL },
+	{ "ActivePlaylist", "(b(oss))", get_active_playlist, NULL,
+							tracklist_exists },
 	{ }
 };
 
@@ -1968,7 +1987,27 @@ static GDBusProxy *find_transport_by_path(const char *path)
 	return NULL;
 }
 
-static void register_tracklist(struct player *player, const char *playlist)
+static struct player *find_player(GDBusProxy *proxy)
+{
+	GSList *l;
+
+	for (l = players; l; l = l->next) {
+		struct player *player = l->data;
+		const char *path, *p;
+
+		if (player->proxy == proxy)
+			return player;
+
+		path = g_dbus_proxy_get_path(proxy);
+		p = g_dbus_proxy_get_path(player->proxy);
+		if (g_str_equal(path, p))
+			return player;
+	}
+
+	return NULL;
+}
+
+static void register_tracklist(struct player *player, const char *path)
 {
 	struct tracklist *tracklist;
 	GDBusProxy *proxy;
@@ -1983,34 +2022,9 @@ static void register_tracklist(struct player *player, const char *playlist)
 
 	tracklist = g_new0(struct tracklist, 1);
 	tracklist->proxy = proxy;
-	tracklist->playlist = g_strdup(playlist);
-
-	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
-						MPRIS_TRACKLIST_INTERFACE,
-						tracklist_methods,
-						tracklist_signals,
-						tracklist_properties,
-						player, NULL)) {
-		fprintf(stderr, "Could not register interface %s",
-						MPRIS_TRACKLIST_INTERFACE);
-		g_free(tracklist);
-		return;
-	}
-
-	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
-						MPRIS_PLAYLISTS_INTERFACE,
-						playlist_methods,
-						NULL,
-						playlist_properties,
-						player, NULL)) {
-		fprintf(stderr, "Could not register interface %s",
-						MPRIS_PLAYLISTS_INTERFACE);
-	}
+	tracklist->playlist = g_strdup(path);
 
 	player->tracklist = tracklist;
-
-	g_dbus_proxy_method_call(proxy, "ChangeFolder", change_folder_setup,
-					change_folder_reply, player, NULL);
 }
 
 static void register_player(GDBusProxy *proxy)
@@ -2082,15 +2096,32 @@ static void register_player(GDBusProxy *proxy)
 		goto fail;
 	}
 
+	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_TRACKLIST_INTERFACE,
+						tracklist_methods,
+						tracklist_signals,
+						tracklist_properties,
+						player, NULL)) {
+		fprintf(stderr, "Could not register interface %s",
+						MPRIS_TRACKLIST_INTERFACE);
+		goto fail;
+	}
+
+	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYLISTS_INTERFACE,
+						playlist_methods,
+						NULL,
+						playlist_properties,
+						player, NULL)) {
+		fprintf(stderr, "Could not register interface %s",
+						MPRIS_PLAYLISTS_INTERFACE);
+		goto fail;
+	}
+
 	transport = find_transport_by_path(path);
 	if (transport)
 		player->transport = g_dbus_proxy_ref(transport);
 
-	if (g_dbus_proxy_get_property(proxy, "Playlist", &iter)) {
-		dbus_message_iter_get_basic(&iter, &path);
-		register_tracklist(player, path);
-	}
-
 	return;
 
 fail:
@@ -2265,20 +2296,6 @@ static void unregister_player(struct player *player)
 						MPRIS_PLAYER_INTERFACE);
 }
 
-static struct player *find_player(GDBusProxy *proxy)
-{
-	GSList *l;
-
-	for (l = players; l; l = l->next) {
-		struct player *player = l->data;
-
-		if (player->proxy == proxy)
-			return player;
-	}
-
-	return NULL;
-}
-
 static struct player *find_player_by_transport(GDBusProxy *proxy)
 {
 	GSList *l;
-- 
1.8.1.4

