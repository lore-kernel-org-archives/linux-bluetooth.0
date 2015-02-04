Return-Path: <cyrus@holtmann.org>
From: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <1421822018-24800-1-git-send-email-s.nageshmurt@samsung.com>
In-reply-to: <1421822018-24800-1-git-send-email-s.nageshmurt@samsung.com>
Subject: RE: [PATCH v1 1/1] media: Add properties watch for MPRIS Playlists
 interface
Date: Wed, 04 Feb 2015 15:00:50 +0530
Message-id: <004901d0405d$46fc7230$d4f55690$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.


-----Original Message-----
From: Sagar Nageshmurthy [mailto:s.nageshmurt@samsung.com] 
Sent: Wednesday, January 21, 2015 12:04 PM
To: linux-bluetooth@vger.kernel.org
Cc: Sagar Nageshmurthy
Subject: [PATCH v1 1/1] media: Add properties watch for MPRIS Playlists
interface

Parse below MediaPlayer2.Playlists properties according to MPRIS spec:
- PlaylistCount
- Orderings
- ActivePlaylist
---
v1: Remove compiler warnings

 profiles/audio/media.c |  183
++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c index
ef7b910..92907a9 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -53,6 +53,7 @@
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
+#define MEDIA_PLAYER_PLAYLISTS_INTERFACE "org.mpris.MediaPlayer2.Playlists"
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
@@ -96,6 +97,7 @@ struct media_player {
 	GHashTable		*track;		/* Player current track */
 	guint			watch;
 	guint			properties_watch;
+	guint			playlists_watch;
 	guint			seek_watch;
 	char			*status;
 	uint32_t		position;
@@ -949,6 +951,7 @@ static void media_player_free(gpointer data)
 
 	g_dbus_remove_watch(conn, mp->watch);
 	g_dbus_remove_watch(conn, mp->properties_watch);
+	g_dbus_remove_watch(conn, mp->playlists_watch);
 	g_dbus_remove_watch(conn, mp->seek_watch);
 
 	if (mp->track)
@@ -1717,6 +1720,182 @@ static gboolean position_changed(DBusConnection
*connection, DBusMessage *msg,
 	return TRUE;
 }
 
+static gboolean set_playlistcount(struct media_player *mp,
+							DBusMessageIter
*iter)
+{
+	uint32_t playlist_count;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &playlist_count);
+
+	/* TODO: Add a struct member to hold playlist info */
+	DBG("Playlist Count = %d", playlist_count);
+
+	return TRUE;
+}
+
+static gboolean set_orderings(struct media_player *mp, DBusMessageIter 
+*iter) {
+	DBusMessageIter entry;
+	int ctype;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	if (ctype != DBUS_TYPE_ARRAY)
+		return FALSE;
+
+	dbus_message_iter_recurse(iter, &entry);
+
+	while ((ctype = dbus_message_iter_get_arg_type(&entry)) !=
+							DBUS_TYPE_INVALID) {
+		const char *ordering;
+
+		if (ctype != DBUS_TYPE_STRING)
+			return FALSE;
+
+		dbus_message_iter_get_basic(&entry, &ordering);
+
+		/* TODO: Add a struct member to hold playlist info */
+		DBG("%s", ordering);
+
+		dbus_message_iter_next(&entry);
+	}
+
+	return TRUE;
+}
+
+static gboolean set_activeplaylist(struct media_player *mp,
+							DBusMessageIter
*iter)
+{
+	dbus_bool_t value;
+	char *playlist_id = NULL;
+	char *playlist_name = NULL;
+	char *playlist_icon = NULL;
+	DBusMessageIter playlist_iter;
+	DBusMessageIter entry;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRUCT)
+		return FALSE;
+
+	dbus_message_iter_recurse(iter, &entry);
+
+	dbus_message_iter_get_basic(&entry, &value);
+	DBG("Active %s", value ? "TRUE" : "FALSE");
+
+	if (!value) {
+		/* TODO: Update info regarding no active playlist */
+		return TRUE;
+	}
+
+	dbus_message_iter_next(&entry);
+	if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRUCT)
+		return FALSE;
+
+	dbus_message_iter_recurse(&entry, &playlist_iter);
+	if (dbus_message_iter_get_arg_type(&playlist_iter) !=
+
DBUS_TYPE_OBJECT_PATH)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&playlist_iter, &playlist_id);
+
+	/* TODO: Add a struct member to hold playlist info */
+	DBG("Playlist Id %s", playlist_id);
+
+	dbus_message_iter_next(&playlist_iter);
+	if (dbus_message_iter_get_arg_type(&playlist_iter) !=
DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&playlist_iter, &playlist_name);
+	DBG("Playlist Name %s", playlist_name);
+
+	dbus_message_iter_next(&playlist_iter);
+	if (dbus_message_iter_get_arg_type(&playlist_iter) !=
DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&playlist_iter, &playlist_icon);
+	DBG("Playlist Icon %s", playlist_icon);
+
+	return TRUE;
+}
+
+static gboolean set_playlist_property(struct media_player *mp, const char
*key,
+							DBusMessageIter
*entry)
+{
+	DBusMessageIter var;
+
+	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
+		return FALSE;
+
+	dbus_message_iter_recurse(entry, &var);
+
+	if (strcasecmp(key, "PlaylistCount") == 0)
+		return set_playlistcount(mp, &var);
+
+	if (strcasecmp(key, "Orderings") == 0)
+		return set_orderings(mp, &var);
+
+	if (strcasecmp(key, "ActivePlaylist") == 0)
+		return set_activeplaylist(mp, &var);
+
+	DBG("%s not supported, ignoring", key);
+
+	return TRUE;
+}
+
+static gboolean parse_playlists_properties(struct media_player *mp,
+							DBusMessageIter
*iter)
+{
+	DBusMessageIter dict;
+	int ctype;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	if (ctype != DBUS_TYPE_ARRAY)
+		return FALSE;
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
+							DBUS_TYPE_INVALID) {
+		DBusMessageIter entry;
+		const char *key;
+
+		if (ctype != DBUS_TYPE_DICT_ENTRY)
+			return FALSE;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		if (dbus_message_iter_get_arg_type(&entry) !=
DBUS_TYPE_STRING)
+			return FALSE;
+
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+
+		if (set_playlist_property(mp, key, &entry) == FALSE)
+			return FALSE;
+
+		dbus_message_iter_next(&dict);
+	}
+
+	return TRUE;
+}
+
+static gboolean playlists_properties_changed(DBusConnection *connection,
+					DBusMessage *msg, void *user_data) {
+	struct media_player *mp = user_data;
+	DBusMessageIter iter;
+
+	DBG("sender=%s path=%s", mp->sender, mp->path);
+
+	dbus_message_iter_init(msg, &iter);
+
+	dbus_message_iter_next(&iter);
+
+	parse_playlists_properties(mp, &iter);
+
+	return TRUE;
+}
+
 static struct media_player *media_player_create(struct media_adapter
*adapter,
 						const char *sender,
 						const char *path,
@@ -1738,6 +1917,10 @@ static struct media_player
*media_player_create(struct media_adapter *adapter,
 						path,
MEDIA_PLAYER_INTERFACE,
 						properties_changed,
 						mp, NULL);
+	mp->playlists_watch = g_dbus_add_properties_watch(conn, sender,
path,
+
MEDIA_PLAYER_PLAYLISTS_INTERFACE,
+
playlists_properties_changed,
+						mp, NULL);
 	mp->seek_watch = g_dbus_add_signal_watch(conn, sender,
 						path,
MEDIA_PLAYER_INTERFACE,
 						"Seeked", position_changed,
--
1.7.9.5

