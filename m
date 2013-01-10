Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/13 v2] media: Implement new RegisterPlayer API
Date: Thu, 10 Jan 2013 15:37:17 +0200
Message-Id: <1357825038-21970-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

RegisterPlayer now uses MPRIS spec
---
 profiles/audio/media.c | 294 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 195 insertions(+), 99 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index b184f01..4b91656 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -28,6 +28,7 @@
 #endif
 
 #include <errno.h>
+#include <inttypes.h>
 
 #include <glib.h>
 #include <gdbus/gdbus.h>
@@ -51,7 +52,7 @@
 
 #define MEDIA_INTERFACE "org.bluez.Media1"
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
-#define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
+#define MEDIA_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
 
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
@@ -1153,17 +1154,18 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
 
 static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 {
-	uint32_t value;
+	uint64_t value;
 
-	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT64)
 			return FALSE;
 
 	dbus_message_iter_get_basic(iter, &value);
-	DBG("Position=%u", value);
 
-	mp->position = value;
+	mp->position = value / 1000;
 	g_timer_start(mp->timer);
 
+	DBG("Position=%u", mp->position);
+
 	if (!mp->position) {
 		avrcp_player_event(mp->player,
 					AVRCP_EVENT_TRACK_REACHED_START, NULL);
@@ -1181,12 +1183,98 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	return TRUE;
 }
 
+static void set_metadata(struct media_player *mp, const char *key,
+							const char *value)
+{
+	DBG("%s=%s", key, value);
+	g_hash_table_replace(mp->track, g_strdup(key), g_strdup(value));
+}
+
+static gboolean parse_string_metadata(struct media_player *mp, const char *key,
+							DBusMessageIter *iter)
+{
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	set_metadata(mp, key, value);
+
+	return TRUE;
+}
+
+static gboolean parse_array_metadata(struct media_player *mp, const char *key,
+							DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return FALSE;
+
+	dbus_message_iter_recurse(iter, &array);
+
+	if (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_INVALID)
+		return TRUE;
+
+	if (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&array, &value);
+
+	set_metadata(mp, key, value);
+
+	return TRUE;
+}
+
+static gboolean parse_int64_metadata(struct media_player *mp, const char *key,
+							DBusMessageIter *iter)
+{
+	uint64_t value;
+	char valstr[20];
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT64)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	if (strcasecmp(key, "Duration") == 0) {
+		value /= 1000;
+		mp->duration = value;
+	}
+
+	snprintf(valstr, 20, "%" PRIu64, value);
+
+	set_metadata(mp, key, valstr);
+
+	return TRUE;
+}
+
+static gboolean parse_int32_metadata(struct media_player *mp, const char *key,
+							DBusMessageIter *iter)
+{
+	uint32_t value;
+	char valstr[20];
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT32)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	snprintf(valstr, 20, "%u", value);
+
+	set_metadata(mp, key, valstr);
+
+	return TRUE;
+}
+
 static gboolean parse_player_metadata(struct media_player *mp,
 							DBusMessageIter *iter)
 {
 	DBusMessageIter dict;
 	DBusMessageIter var;
-	GHashTable *track;
 	int ctype;
 	gboolean title = FALSE;
 	uint64_t uid;
@@ -1197,155 +1285,163 @@ static gboolean parse_player_metadata(struct media_player *mp,
 
 	dbus_message_iter_recurse(iter, &dict);
 
-	track = g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
+	if (mp->track != NULL)
+		g_hash_table_unref(mp->track);
+
+	mp->track = g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
 								g_free);
 
 	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
 							DBUS_TYPE_INVALID) {
 		DBusMessageIter entry;
 		const char *key;
-		const char *string;
-		char valstr[20];
-		char *value;
-		uint32_t num;
-		int type;
 
 		if (ctype != DBUS_TYPE_DICT_ENTRY)
-			goto parse_error;
+			return FALSE;
 
 		dbus_message_iter_recurse(&dict, &entry);
 		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
-			goto parse_error;
+			return FALSE;
 
 		dbus_message_iter_get_basic(&entry, &key);
 		dbus_message_iter_next(&entry);
 
 		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
-			goto parse_error;
+			return FALSE;
 
 		dbus_message_iter_recurse(&entry, &var);
 
-		type = dbus_message_iter_get_arg_type(&var);
-
-		if (strcasecmp(key, "Title") == 0) {
-			if (type != DBUS_TYPE_STRING)
-				goto parse_error;
+		if (strcasecmp(key, "xesam:title") == 0) {
+			if (!parse_string_metadata(mp, "Title", &var))
+				return FALSE;
 			title = TRUE;
-			dbus_message_iter_get_basic(&var, &string);
-		} else if (strcasecmp(key, "Artist") == 0) {
-			if (type != DBUS_TYPE_STRING)
-				goto parse_error;
-
-			dbus_message_iter_get_basic(&var, &string);
-		} else if (strcasecmp(key, "Album") == 0) {
-			if (type != DBUS_TYPE_STRING)
-				goto parse_error;
-
-			dbus_message_iter_get_basic(&var, &string);
-		} else if (strcasecmp(key, "Genre") == 0) {
-			if (type != DBUS_TYPE_STRING)
-				goto parse_error;
-
-			dbus_message_iter_get_basic(&var, &string);
-		} else if (strcasecmp(key, "Duration") == 0) {
-			if (type != DBUS_TYPE_UINT32)
-				goto parse_error;
-
-			dbus_message_iter_get_basic(&var, &num);
-			mp->duration = num;
-		} else if (strcasecmp(key, "TrackNumber") == 0) {
-			if (type != DBUS_TYPE_UINT32)
-				goto parse_error;
-
-			dbus_message_iter_get_basic(&var, &num);
-		} else if (strcasecmp(key, "NumberOfTracks") == 0) {
-			if (type != DBUS_TYPE_UINT32)
-				goto parse_error;
-
-			dbus_message_iter_get_basic(&var, &num);
+		} else if (strcasecmp(key, "xesam:artist") == 0) {
+			if (!parse_array_metadata(mp, "Artist", &var))
+				return FALSE;
+		} else if (strcasecmp(key, "xesam:album") == 0) {
+			if (!parse_string_metadata(mp, "Album", &var))
+				return FALSE;
+		} else if (strcasecmp(key, "xesam:genre") == 0) {
+			if (!parse_array_metadata(mp, "Genre", &var))
+				return FALSE;
+		} else if (strcasecmp(key, "mpris:length") == 0) {
+			if (!parse_int64_metadata(mp, "Duration", &var))
+				return FALSE;
+		} else if (strcasecmp(key, "xesam:trackNumber") == 0) {
+			if (!parse_int32_metadata(mp, "TrackNumber", &var))
+				return FALSE;
 		} else
-			goto parse_error;
-
-		switch (type) {
-		case DBUS_TYPE_STRING:
-			value = g_strdup(string);
-			break;
-		default:
-			snprintf(valstr, 20, "%u", num);
-			value = g_strdup(valstr);
-		}
+			DBG("%s not supported, ignoring", key);
 
-		DBG("%s=%s", key, value);
-		g_hash_table_replace(track, g_strdup(key), value);
 		dbus_message_iter_next(&dict);
 	}
 
-	if (g_hash_table_size(track) == 0) {
-		g_hash_table_unref(track);
-		track = NULL;
-	} else if (title == FALSE)
-		g_hash_table_insert(track, g_strdup("Title"), g_strdup(""));
+	if (title == FALSE)
+		g_hash_table_insert(mp->track, g_strdup("Title"),
+								g_strdup(""));
 
-	if (mp->track != NULL)
-		g_hash_table_unref(mp->track);
-
-	mp->track = track;
 	mp->position = 0;
 	g_timer_start(mp->timer);
 	uid = get_uid(mp);
 
 	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, &uid);
-	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_START,
-								NULL);
+	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_START, NULL);
 
 	return TRUE;
+}
+
+static gboolean set_property(struct media_player *mp, const char *key,
+							const char *value)
+{
+	const char *curval;
+	GList *settings;
+
+	curval = g_hash_table_lookup(mp->settings, key);
+	if (g_strcmp0(curval, value) == 0)
+		return TRUE;
+
+	DBG("%s=%s", key, value);
+
+	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
+
+	settings = list_settings(mp);
+
+	avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED, settings);
+
+	g_list_free(settings);
+
+	return TRUE;
+}
+
+static gboolean set_shuffle(struct media_player *mp, DBusMessageIter *iter)
+{
+	dbus_bool_t value;
+	const char *strvalue;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
 
-parse_error:
-	if (track)
-		g_hash_table_unref(track);
+	strvalue = value ? "alltracks" : "off";
 
-	return FALSE;
+	return set_property(mp, "Shuffle", strvalue);
+}
+
+static const char *loop_status_to_repeat(const char *value)
+{
+	if (strcasecmp(value, "None") == 0)
+		return "off";
+	else if (strcasecmp(value, "Track") == 0)
+		return "singletrack";
+	else if (strcasecmp(value, "Track") == 0)
+		return "alltracks";
+
+	return NULL;
+}
+
+static gboolean set_repeat(struct media_player *mp, DBusMessageIter *iter)
+{
+	const char *value;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(iter, &value);
+
+	value = loop_status_to_repeat(value);
+	if (value == NULL)
+		return FALSE;
+
+	return set_property(mp, "Repeat", value);
 }
 
 static gboolean set_player_property(struct media_player *mp, const char *key,
 							DBusMessageIter *entry)
 {
 	DBusMessageIter var;
-	const char *value, *curval;
-	GList *settings;
 
 	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
 		return FALSE;
 
 	dbus_message_iter_recurse(entry, &var);
 
-	if (strcasecmp(key, "Status") == 0)
+	if (strcasecmp(key, "PlaybackStatus") == 0)
 		return set_status(mp, &var);
 
 	if (strcasecmp(key, "Position") == 0)
 		return set_position(mp, &var);
 
-	if (strcasecmp(key, "Track") == 0)
+	if (strcasecmp(key, "Metadata") == 0)
 		return parse_player_metadata(mp, &var);
 
-	if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
-		return FALSE;
-
-	dbus_message_iter_get_basic(&var, &value);
-
-	curval = g_hash_table_lookup(mp->settings, key);
-	if (g_strcmp0(curval, value) == 0)
-		return TRUE;
-
-	DBG("%s=%s", key, value);
-
-	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
-
-	settings = list_settings(mp);
+	if (strcasecmp(key, "Shuffle") == 0)
+		return set_shuffle(mp, &var);
 
-	avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED, settings);
+	if (strcasecmp(key, "LoopStatus") == 0)
+		return set_repeat(mp, &var);
 
-	g_list_free(settings);
+	DBG("%s not supported, ignoring", key);
 
 	return TRUE;
 }
-- 
1.8.0.1

