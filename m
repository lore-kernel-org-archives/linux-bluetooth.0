Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/14] tools: Add support for MPRIS Playlists interface to mpris-player
Date: Wed, 15 May 2013 18:31:39 +0300
Message-Id: <1368631906-15951-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
References: <1368631906-15951-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Playlists interface as defined in MPRIS:
http://specifications.freedesktop.org/mpris-spec/latest/Playlists_Interface.html
---
 tools/mpris-player.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/tools/mpris-player.c b/tools/mpris-player.c
index 681bb09..9ac59b3 100644
--- a/tools/mpris-player.c
+++ b/tools/mpris-player.c
@@ -50,6 +50,7 @@
 #define MPRIS_INTERFACE "org.mpris.MediaPlayer2"
 #define MPRIS_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
 #define MPRIS_TRACKLIST_INTERFACE "org.mpris.MediaPlayer2.TrackList"
+#define MPRIS_PLAYLISTS_INTERFACE "org.mpris.MediaPlayer2.Playlists"
 #define MPRIS_PLAYER_PATH "/org/mpris/MediaPlayer2"
 #define ERROR_INTERFACE "org.mpris.MediaPlayer2.Error"
 
@@ -1729,6 +1730,89 @@ static const GDBusPropertyTable tracklist_properties[] = {
 	{ }
 };
 
+static DBusMessage *playlist_activate(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
+					"Not implemented");
+}
+
+static DBusMessage *playlist_get(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".NotImplemented",
+					"Not implemented");
+}
+
+static const GDBusMethodTable playlist_methods[] = {
+	{ GDBUS_METHOD("ActivatePlaylist",
+			GDBUS_ARGS({ "playlist", "o" }), NULL,
+			playlist_activate) },
+	{ GDBUS_METHOD("GetPlaylists",
+			GDBUS_ARGS({ "index", "u" }, { "maxcount", "u"},
+					{ "order", "s" }, { "reverse", "b" }),
+			GDBUS_ARGS({ "playlists", "a(oss)"}),
+			playlist_get) },
+	{ },
+};
+
+static gboolean get_playlist_count(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	uint32_t count = 1;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &count);
+
+	return TRUE;
+}
+
+static gboolean get_orderings(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	DBusMessageIter value;
+	const char *order = "User";
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_OBJECT_PATH_AS_STRING,
+					&value);
+	dbus_message_iter_append_basic(&value, DBUS_TYPE_STRING, &order);
+	dbus_message_iter_close_container(iter, &value);
+
+	return TRUE;
+}
+
+static gboolean get_active_playlist(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct player *player = data;
+	struct tracklist *tracklist = player->tracklist;
+	DBusMessageIter value, entry;
+	dbus_bool_t enabled = TRUE;
+	const char *empty = "";
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_STRUCT,
+							NULL, &value);
+	dbus_message_iter_append_basic(&value, DBUS_TYPE_BOOLEAN, &enabled);
+	dbus_message_iter_open_container(&value, DBUS_TYPE_STRUCT, NULL,
+								&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+						&tracklist->playlist);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+						&tracklist->playlist);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &empty);
+	dbus_message_iter_close_container(&value, &entry);
+	dbus_message_iter_close_container(iter, &value);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable playlist_properties[] = {
+	{ "PlaylistCount", "u", get_playlist_count, NULL, NULL },
+	{ "Orderings", "as", get_orderings, NULL, NULL },
+	{ "ActivePlaylist", "(b(oss))", get_active_playlist, NULL, NULL },
+	{ }
+};
+
 #define a_z "abcdefghijklmnopqrstuvwxyz"
 #define A_Z "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 #define _0_9 "_0123456789"
@@ -1831,6 +1915,16 @@ static void register_tracklist(struct player *player, const char *playlist)
 		return;
 	}
 
+	if (!g_dbus_register_interface(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYLISTS_INTERFACE,
+						playlist_methods,
+						NULL,
+						playlist_properties,
+						player, NULL)) {
+		fprintf(stderr, "Could not register interface %s",
+						MPRIS_PLAYLISTS_INTERFACE);
+	}
+
 	player->tracklist = tracklist;
 
 	g_dbus_proxy_method_call(proxy, "ChangeFolder", change_folder_setup,
@@ -2075,8 +2169,12 @@ static void unregister_player(struct player *player)
 {
 	players = g_slist_remove(players, player);
 
-	g_dbus_unregister_interface(player->conn, MPRIS_PLAYER_PATH,
+	if (player->tracklist != NULL) {
+		g_dbus_unregister_interface(player->conn, MPRIS_PLAYER_PATH,
+						MPRIS_PLAYLISTS_INTERFACE);
+		g_dbus_unregister_interface(player->conn, MPRIS_PLAYER_PATH,
 						MPRIS_TRACKLIST_INTERFACE);
+	}
 
 	g_dbus_unregister_interface(player->conn, MPRIS_PLAYER_PATH,
 						MPRIS_INTERFACE);
-- 
1.8.1.4

