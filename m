Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 12/19] avrcp: implement ChangeTrack() method
Date: Tue, 19 Jul 2011 16:49:23 -0300
Message-Id: <1311104970-18600-13-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ChangeTrack() is used by applications to inform BlueZ that current track
changed, passing also the metadata. It's expected to work only when the
device is in TG role.
---
 audio/control.c     |  167 +++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/control-api.txt |    3 +
 2 files changed, 170 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 03f1cb4..670660f 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -261,6 +261,13 @@ struct avctp_server {
 struct media_info {
 	enum play_status status;
 	uint32_t current_position;
+
+	char *title;
+	char *artist;
+	char *album;
+	char *genre;
+	uint32_t ntracks;
+	uint32_t track;
 	uint32_t track_length;
 };
 
@@ -1240,6 +1247,47 @@ static void media_info_init(struct media_info *mi)
 	mi->current_position = 0xFFFFFFFF;
 }
 
+static void media_info_reset(struct media_info *mi)
+{
+	DBG("");
+
+	if (mi->title)
+		free(mi->title);
+
+	if (mi->artist)
+		free(mi->artist);
+
+	if (mi->album)
+		free(mi->album);
+
+	if (mi->genre)
+		free(mi->genre);
+
+	media_info_init(mi);
+}
+
+static void media_info_copy(struct media_info *dest, struct media_info *src)
+{
+	DBG("");
+
+	if (src->title)
+		dest->title = strdup(src->title);
+
+	if (src->artist)
+		dest->artist = strdup(src->artist);
+
+	if (src->album)
+		dest->album = strdup(src->album);
+
+	if (src->genre)
+		dest->genre = strdup(src->genre);
+
+	dest->ntracks = src->ntracks;
+	dest->track = src->track;
+	dest->track_length = src->track_length;
+}
+
+
 static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct control *control = data;
@@ -1817,6 +1865,124 @@ static DBusMessage *control_change_playback(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static gboolean media_info_parse(DBusMessageIter *iter, struct media_info *mi)
+{
+	DBusMessageIter dict;
+	DBusMessageIter var;
+	int ctype;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	if (ctype != DBUS_TYPE_ARRAY)
+		return FALSE;
+
+	media_info_init(mi);
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
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
+			return FALSE;
+
+		dbus_message_iter_recurse(&entry, &var);
+
+		if (!strcmp(key, "Title")) {
+			if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_STRING)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&var, &mi->title);
+		} else if (!strcmp(key, "Artist")) {
+			if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_STRING)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&var, &mi->artist);
+		} else if (!strcmp(key, "Album")) {
+			if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_STRING)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&var, &mi->album);
+		} else if (!strcmp(key, "Genre")) {
+			if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_STRING)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&var, &mi->genre);
+		} else if (!strcmp(key, "NumberOfTracks")) {
+			if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_UINT32)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&var, &mi->ntracks);
+		} else if (!strcmp(key, "TrackNumber")) {
+			if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_UINT32)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&var, &mi->track);
+		} else if (!strcmp(key, "TrackDuration")) {
+			if (dbus_message_iter_get_arg_type(&var) !=
+							DBUS_TYPE_UINT32)
+				return FALSE;
+
+			dbus_message_iter_get_basic(&var, &mi->track_length);
+		} else {
+			return FALSE;
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+	if (mi->title == NULL)
+		return FALSE;
+
+	return TRUE;
+}
+
+static DBusMessage *control_change_track(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+	DBusMessageIter iter;
+	struct media_info mi;
+
+	if (control->state != AVCTP_STATE_CONNECTED)
+		return btd_error_not_connected(msg);
+
+	if (control->target) /* Only supported if this device is in TG role */
+		return btd_error_not_supported(msg);
+
+	dbus_message_iter_init(msg, &iter);
+	if (!media_info_parse(&iter, &mi))
+		return btd_error_invalid_args(msg);
+
+	media_info_reset(&control->mi);
+	media_info_copy(&control->mi, &mi);
+
+	DBG("Track change:\n\ttitle: %s\n\tartist: %s\n\talbum: %s\n"
+			   "\tgenre: %s\n\tNumber of tracks: %u\n"
+			   "\tTrack number: %u\n\tTrack duration: %u",
+			   mi.title, mi.artist, mi.album, mi.genre,
+			   mi.ntracks, mi.track, mi.track_length);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable control_methods[] = {
 	{ "IsConnected",	"",	"b",	control_is_connected,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
@@ -1825,6 +1991,7 @@ static GDBusMethodTable control_methods[] = {
 	{ "VolumeDown",		"",	"",	volume_down },
 	{ "ChangeSetting",	"sv",	"",	control_change_setting },
 	{ "ChangePlayback",	"su",	"",	control_change_playback },
+	{ "ChangeTrack",	"a{sv}","",	control_change_track },
 	{ NULL, NULL, NULL, NULL }
 };
 
diff --git a/doc/control-api.txt b/doc/control-api.txt
index ca97544..c2fa0e9 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -68,6 +68,9 @@ Methods		void Connect()
 				TrackNumber	uint32
 				TrackDuration	uint32	(in milliseconds)
 
+			When track is changed, all metadata information not
+			supplied is treat as absent.
+
 		void ChangeSetting(string setting, variant value)
 
 			Called to transmit Application Settings, CT Status
-- 
1.7.6

