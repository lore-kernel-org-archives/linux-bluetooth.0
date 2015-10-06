Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  2/3] audio/avrcp: Handle PlaylistChanged signal
Date: Tue, 06 Oct 2015 17:23:17 +0530
Message-id: <1444132398-3176-2-git-send-email-bharat.panda@samsung.com>
In-reply-to: <1444132398-3176-1-git-send-email-bharat.panda@samsung.com>
References: <1444132398-3176-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added signal handler for "PlaylistChanged" on MediaPlayer2.Playlists
interface.
---
 profiles/audio/media.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index edeb66f..2df0cb2 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -104,6 +104,7 @@ struct media_player {
 	guint			watch;
 	guint			properties_watch;
 	guint			seek_watch;
+	guint			playlist_watch;
 	char			*status;
 	uint32_t		position;
 	uint32_t		duration;
@@ -965,6 +966,7 @@ static void media_player_free(gpointer data)
 	g_dbus_remove_watch(conn, mp->watch);
 	g_dbus_remove_watch(conn, mp->properties_watch);
 	g_dbus_remove_watch(conn, mp->seek_watch);
+	g_dbus_remove_watch(conn, mp->playlist_watch);
 
 	if (mp->track)
 		g_hash_table_unref(mp->track);
@@ -1871,6 +1873,51 @@ static gboolean position_changed(DBusConnection *connection, DBusMessage *msg,
 	return TRUE;
 }
 
+static gboolean playlist_changed(DBusConnection *connection,
+						DBusMessage *msg,
+						void *user_data)
+{
+	struct media_player *mp = user_data;
+	DBusMessageIter iter;
+	DBusMessageIter entry;
+	char *playlist_id;
+	GSList *l;
+
+	dbus_message_iter_init(msg, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRUCT)
+		return FALSE;
+
+	dbus_message_iter_recurse(&iter, &entry);
+
+	if (dbus_message_iter_get_arg_type(&entry) !=
+			DBUS_TYPE_OBJECT_PATH)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&entry, &playlist_id);
+
+	for (l = mp->playlists; l; l = l->next) {
+		struct media_playlist *playlist = l->data;
+
+		if (g_strcmp0(playlist->id, playlist_id) == 0) {
+			dbus_message_iter_next(&entry);
+			if (dbus_message_iter_get_arg_type(&entry) !=
+					DBUS_TYPE_STRING)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&entry, &playlist->name);
+
+			dbus_message_iter_next(&entry);
+			if (dbus_message_iter_get_arg_type(&entry) !=
+					DBUS_TYPE_STRING)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&entry, &playlist->icon);
+		}
+	}
+
+	return TRUE;
+}
+
 static struct media_player *media_player_create(struct media_adapter *adapter,
 						const char *sender,
 						const char *path,
@@ -1950,6 +1997,13 @@ static DBusMessage *register_player(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	mp->playlist_watch = g_dbus_add_signal_watch(conn,
+					sender, path,
+					MEDIA_PLAYER_PLAYLIST_INTERFACE,
+					"PlaylistChanged",
+					playlist_changed,
+					mp, NULL);
+
 	mp->playlist_id = g_idle_add(get_playlists, mp);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-- 
1.9.1

