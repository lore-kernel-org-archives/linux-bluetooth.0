Return-Path: <cyrus@holtmann.org>
From: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <1421313753-3696-1-git-send-email-s.nageshmurt@samsung.com>
In-reply-to: <1421313753-3696-1-git-send-email-s.nageshmurt@samsung.com>
Subject: RE: [PATCH 1/1] media: Add properties watch for MPRIS TrackList and
 Playlist interfaces
Date: Thu, 15 Jan 2015 15:31:00 +0530
Message-id: <00b401d030aa$2d017c30$87047490$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, 

We have started with the implementation of MPRIS TrackList and Playlists
interfaces. Please review the approach followed and let us know your
comments. 

Regards,
Sagar N

-----Original Message-----
From: Sagar Nageshmurthy [mailto:s.nageshmurt@samsung.com] 
Sent: Thursday, January 15, 2015 2:53 PM
To: linux-bluetooth@vger.kernel.org
Cc: Sagar Nageshmurthy
Subject: [PATCH 1/1] media: Add properties watch for MPRIS TrackList and
Playlist interfaces

Parse TrackList properties (Tracks, CanEditTracks) and Playlists properties
(PlaylistCount, Orderings, ActivePlaylist) according to MPRIS spec.
---
 profiles/audio/media.c |  323
+++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 318 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c index
ef7b910..73698ca 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -53,6 +53,8 @@
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
+#define MEDIA_PLAYER_TRACKLIST_INTERFACE "org.mpris.MediaPlayer2.TrackList"
+#define MEDIA_PLAYER_PLAYLISTS_INTERFACE "org.mpris.MediaPlayer2.Playlists"
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
@@ -95,7 +97,9 @@ struct media_player {
 	GHashTable		*settings;	/* Player settings */
 	GHashTable		*track;		/* Player current track */
 	guint			watch;
-	guint			properties_watch;
+	guint			player_properties_watch;
+	guint			tracklist_properties_watch;
+	guint			playlists_properties_watch;
 	guint			seek_watch;
 	char			*status;
 	uint32_t		position;
@@ -948,7 +952,9 @@ static void media_player_free(gpointer data)
 	}
 
 	g_dbus_remove_watch(conn, mp->watch);
-	g_dbus_remove_watch(conn, mp->properties_watch);
+	g_dbus_remove_watch(conn, mp->player_properties_watch);
+	g_dbus_remove_watch(conn, mp->tracklist_properties_watch);
+	g_dbus_remove_watch(conn, mp->playlists_properties_watch);
 	g_dbus_remove_watch(conn, mp->seek_watch);
 
 	if (mp->track)
@@ -1685,7 +1691,268 @@ static gboolean parse_player_properties(struct
media_player *mp,
 	return TRUE;
 }
 
-static gboolean properties_changed(DBusConnection *connection, DBusMessage
*msg,
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
+	/* TODO Add a struct member to hold playlist info */
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
+		/* TODO Add a struct member to hold playlist info */
+		DBG("%s", ordering);
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
+	if (value) {
+		char *playlist_id = NULL;
+		char *playlist_name = NULL;
+		char *playlist_icon = NULL;
+		DBusMessageIter playlist_iter;
+
+		dbus_message_iter_next(&entry);
+		if (dbus_message_iter_get_arg_type(&entry) !=
DBUS_TYPE_STRUCT)
+			return FALSE;
+
+		dbus_message_iter_recurse(&entry, &playlist_iter);
+
+		if (dbus_message_iter_get_arg_type(&playlist_iter) !=
+
DBUS_TYPE_OBJECT_PATH)
+			return FALSE;
+
+		/* TODO Add a struct member to hold playlist info */
+		dbus_message_iter_get_basic(&playlist_iter, &playlist_id);
+		DBG("Playlist Id %s", playlist_id);
+
+		dbus_message_iter_next(&playlist_iter);
+
+		if (dbus_message_iter_get_arg_type(&playlist_iter) !=
+							DBUS_TYPE_STRING)
+			return FALSE;
+
+		dbus_message_iter_get_basic(&playlist_iter, &playlist_name);
+		DBG("Playlist Name %s", playlist_name);
+
+		dbus_message_iter_next(&playlist_iter);
+		if (dbus_message_iter_get_arg_type(&playlist_iter) !=
+							DBUS_TYPE_STRING)
+			return FALSE;
+
+		dbus_message_iter_get_basic(&playlist_iter, &playlist_icon);
+		DBG("Playlist Icon %s", playlist_icon);
+	}
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
+
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
+static gboolean set_tracks(struct media_player *mp, DBusMessageIter 
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
+				DBUS_TYPE_INVALID) {
+		const char *track_id;
+
+		if (ctype != DBUS_TYPE_OBJECT_PATH)
+			return FALSE;
+
+		dbus_message_iter_get_basic(&entry, &track_id);
+		/* TODO Add a struct member to hold playlist info */
+		DBG("%s", track_id);
+		dbus_message_iter_next(&entry);
+	}
+
+	return TRUE;
+}
+
+static gboolean set_canedittracks(struct media_player *mp,
+				DBusMessageIter *iter)
+{
+	dbus_bool_t value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	/* TODO Add a struct member to hold info */
+	DBG("Value = %s", value ? "TRUE" : "FALSE");
+
+	return TRUE;
+}
+
+static gboolean set_tracklist_property(struct media_player *mp, const char
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
+	if (strcasecmp(key, "Tracks") == 0)
+		return set_tracks(mp, &var);
+
+	if (strcasecmp(key, "CanEditTracks") == 0)
+		return set_canedittracks(mp, &var);
+
+	DBG("%s not supported, ignoring", key);
+
+	return TRUE;
+}
+
+static gboolean parse_tracklist_properties(struct media_player *mp,
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
+		if (set_tracklist_property(mp, key, &entry) == FALSE)
+			return FALSE;
+
+		dbus_message_iter_next(&dict);
+	}
+
+	return TRUE;
+}
+
+static gboolean player_properties_changed(DBusConnection *connection,
+							DBusMessage *msg,
 							void *user_data)
 {
 	struct media_player *mp = user_data;
@@ -1702,6 +1969,42 @@ static gboolean properties_changed(DBusConnection
*connection, DBusMessage *msg,
 	return TRUE;
 }
 
+static gboolean tracklist_properties_changed(DBusConnection *connection,
+							DBusMessage *msg,
+							void *user_data)
+{
+	struct media_player *mp = user_data;
+	DBusMessageIter iter;
+
+	DBG("sender=%s path=%s", mp->sender, mp->path);
+
+	dbus_message_iter_init(msg, &iter);
+
+	dbus_message_iter_next(&iter);
+
+	parse_tracklist_properties(mp, &iter);
+
+	return TRUE;
+}
+
+static gboolean playlists_properties_changed(DBusConnection *connection,
+							DBusMessage *msg,
+							void *user_data)
+{
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
 static gboolean position_changed(DBusConnection *connection, DBusMessage
*msg,
 							void *user_data)
 {
@@ -1734,9 +2037,19 @@ static struct media_player
*media_player_create(struct media_adapter *adapter,
 	mp->watch = g_dbus_add_disconnect_watch(conn, sender,
 						media_player_exit, mp,
 						NULL);
-	mp->properties_watch = g_dbus_add_properties_watch(conn, sender,
+	mp->player_properties_watch = g_dbus_add_properties_watch(conn, 
+sender,
 						path,
MEDIA_PLAYER_INTERFACE,
-						properties_changed,
+						player_properties_changed,
+						mp, NULL);
+	mp->tracklist_properties_watch = g_dbus_add_properties_watch(conn,
+						sender, path,
+
MEDIA_PLAYER_TRACKLIST_INTERFACE,
+
tracklist_properties_changed,
+						mp, NULL);
+	mp->playlists_properties_watch = g_dbus_add_properties_watch(conn,
+						sender,	path,
+
MEDIA_PLAYER_PLAYLISTS_INTERFACE,
+
playlists_properties_changed,
 						mp, NULL);
 	mp->seek_watch = g_dbus_add_signal_watch(conn, sender,
 						path,
MEDIA_PLAYER_INTERFACE,
--
1.7.9.5

