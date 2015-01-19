Return-Path: <cyrus@holtmann.org>
From: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Subject: [PATCH 1/1] media: Add properties watch for MPRIS TrackList interface
Date: Mon, 19 Jan 2015 19:17:40 +0530
Message-id: <1421675260-21180-1-git-send-email-s.nageshmurt@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parse below MediaPlayer2.TrackList properties according to MPRIS spec:
- Tracks
- CanEditTracks
---
 profiles/audio/media.c |  128 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index ef7b910..6053c7a 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -53,6 +53,7 @@
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
+#define MEDIA_PLAYER_TRACKLIST_INTERFACE "org.mpris.MediaPlayer2.TrackList"
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
@@ -96,6 +97,7 @@ struct media_player {
 	GHashTable		*track;		/* Player current track */
 	guint			watch;
 	guint			properties_watch;
+	guint			tracklist_watch;
 	guint			seek_watch;
 	char			*status;
 	uint32_t		position;
@@ -949,6 +951,7 @@ static void media_player_free(gpointer data)
 
 	g_dbus_remove_watch(conn, mp->watch);
 	g_dbus_remove_watch(conn, mp->properties_watch);
+	g_dbus_remove_watch(conn, mp->tracklist_watch);
 	g_dbus_remove_watch(conn, mp->seek_watch);
 
 	if (mp->track)
@@ -1685,6 +1688,108 @@ static gboolean parse_player_properties(struct media_player *mp,
 	return TRUE;
 }
 
+static gboolean set_tracks(struct media_player *mp, DBusMessageIter *iter)
+{
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
+
+		/* TODO: Add a struct member to hold tracklist info */
+		DBG("%s", track_id);
+
+		dbus_message_iter_next(&entry);
+	}
+
+	return TRUE;
+}
+
+static gboolean set_canedittracks(struct media_player *mp,
+							DBusMessageIter *iter)
+{
+	dbus_bool_t value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	/* TODO: Add a struct member to hold tracklist info */
+	DBG("Value = %s", value ? "TRUE" : "FALSE");
+
+	return TRUE;
+}
+
+static gboolean set_tracklist_property(struct media_player *mp, const char *key,
+							DBusMessageIter *entry)
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
+							DBusMessageIter *iter)
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
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
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
 static gboolean properties_changed(DBusConnection *connection, DBusMessage *msg,
 							void *user_data)
 {
@@ -1702,6 +1807,24 @@ static gboolean properties_changed(DBusConnection *connection, DBusMessage *msg,
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
 static gboolean position_changed(DBusConnection *connection, DBusMessage *msg,
 							void *user_data)
 {
@@ -1738,6 +1861,11 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 						path, MEDIA_PLAYER_INTERFACE,
 						properties_changed,
 						mp, NULL);
+	mp->tracklist_watch = g_dbus_add_properties_watch(conn,
+						sender, path,
+						MEDIA_PLAYER_TRACKLIST_INTERFACE,
+						tracklist_properties_changed,
+						mp, NULL);
 	mp->seek_watch = g_dbus_add_signal_watch(conn, sender,
 						path, MEDIA_PLAYER_INTERFACE,
 						"Seeked", position_changed,
-- 
1.7.9.5

