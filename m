Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 05/22] avrcp: implement ChangeTrack() method
Date: Wed, 10 Aug 2011 10:06:19 -0300
Message-Id: <1312981596-7291-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ChangeTrack() is used by applications to inform bluetoothd that current
track changed, passing also the metadata.
---
 audio/control.c |  163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 672f640..cf3bd1f 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -226,6 +226,13 @@ struct avctp_server {
 };
 
 struct media_info {
+	char *title;
+	char *artist;
+	char *album;
+	char *genre;
+	uint32_t ntracks;
+	uint32_t track;
+	uint32_t track_len;
 	uint32_t elapsed;
 };
 
@@ -582,6 +589,41 @@ static void mp_set_attribute(struct media_player *mp,
 	mp->settings[attr] = val;
 }
 
+static void mp_set_media_attributes(struct control *control,
+							struct media_info *mi)
+{
+	struct media_player *mp = control->mp;
+
+	g_free(mp->mi.title);
+	mp->mi.title = g_strdup(mi->title);
+
+	g_free(mp->mi.artist);
+	mp->mi.artist = g_strdup(mi->artist);
+
+	g_free(mp->mi.album);
+	mp->mi.album = g_strdup(mi->album);
+
+	g_free(mp->mi.genre);
+	mp->mi.genre = g_strdup(mi->genre);
+
+	mp->mi.ntracks = mi->ntracks;
+	mp->mi.track = mi->track;
+	mp->mi.track_len = mi->track_len;
+
+	/*
+	 * elapsed is special. Whenever the track changes, we reset it to 0,
+	 * so client doesn't have to make another call to change_playback
+	 */
+	mp->mi.elapsed = 0;
+	g_timer_start(mp->timer);
+
+	DBG("Track changed:\n\ttitle: %s\n\tartist: %s\n\talbum: %s\n"
+			   "\tgenre: %s\n\tNumber of tracks: %u\n"
+			   "\tTrack number: %u\n\tTrack duration: %u",
+			   mi->title, mi->artist, mi->album, mi->genre,
+			   mi->ntracks, mi->track, mi->track_len);
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -864,6 +906,19 @@ static void init_uinput(struct control *control)
 		DBG("AVRCP: uinput initialized for %s", address);
 }
 
+static void media_info_init(struct media_info *mi)
+{
+	memset(mi, 0, sizeof(*mi));
+
+	/*
+	 * As per section 5.4.1 of AVRCP 1.3 spec, return 0xFFFFFFFF if TG
+	 * does not support these attributes (i.e. they were never set via
+	 * D-Bus)
+	 */
+	mi->track_len = 0xFFFFFFFF;
+	mi->elapsed = 0xFFFFFFFF;
+}
+
 static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct control *control = data;
@@ -1355,9 +1410,116 @@ static DBusMessage *mp_change_playback(DBusConnection *conn,
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
+			dbus_message_iter_get_basic(&var, &mi->track_len);
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
+static DBusMessage *mp_change_track(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+	DBusMessageIter iter;
+	struct media_info mi;
+
+
+	dbus_message_iter_init(msg, &iter);
+	if (!media_info_parse(&iter, &mi))
+		return btd_error_invalid_args(msg);
+
+	mp_set_media_attributes(control, &mi);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable mp_methods[] = {
 	{ "SetProperty",	"sv",		"",	mp_set_property },
 	{ "ChangePlayback",	"su",		"",	mp_change_playback },
+	{ "ChangeTrack",	"a{sv}",	"",	mp_change_track },
 	{ }
 };
 
@@ -1451,6 +1613,7 @@ struct control *control_init(struct audio_device *dev, uint16_t uuid16,
 					MEDIA_PLAYER_INTERFACE, dev->path);
 
 		mp->timer = g_timer_new();
+		media_info_init(&mp->mi);
 		control->mp = mp;
 	}
 
-- 
1.7.6

