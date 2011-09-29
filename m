Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/3] AVRCP: allow track to be un-selected
Date: Thu, 29 Sep 2011 14:07:30 -0300
Message-Id: <1317316050-12855-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As of now there was no way to tell BlueZ that no track is selected. Now
if client send us a ChangeTrack() with empty metadata, it means there's no
track currently selected/playing. This is necessary in order to pass
TP/NFY/BV-04-C that expects us to respond with:
	- 0x0: a track is playing
	- UINT64_MAX: there's no track playing
---
 audio/avrcp.c |   36 +++++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 6e8b8ff..8fb23e0 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -191,6 +191,7 @@ struct media_info {
 	uint32_t track;
 	uint32_t track_len;
 	uint32_t elapsed;
+	uint64_t uid;
 };
 
 struct media_player {
@@ -570,18 +571,11 @@ static int avrcp_send_event(struct media_player *mp, uint8_t id, void *data)
 		pdu->params[1] = *((uint8_t *)data);
 
 		break;
-	case AVRCP_EVENT_TRACK_CHANGED: {
+	case AVRCP_EVENT_TRACK_CHANGED:
 		size = 9;
-
-		/*
-		 * AVRCP 1.3 supports only one track identifier: PLAYING
-		 * (0x0). When 1.4 version is added, this shall be changed to
-		 * contain the identifier of the track.
-		 */
-		memset(&pdu->params[1], 0, 8);
+		memcpy(&pdu->params[1], (uint64_t *) data, sizeof(uint64_t));
 
 		break;
-	}
 	default:
 		error("Unknown event %u", id);
 		return -EINVAL;
@@ -753,6 +747,9 @@ static int mp_get_attribute(struct media_player *mp, uint8_t attr)
 static void mp_set_media_attributes(struct media_player *mp,
 							struct media_info *mi)
 {
+	if (mp->mi.uid == UINT64_MAX && mi->uid == UINT64_MAX)
+		return;
+
 	g_free(mp->mi.title);
 	mp->mi.title = g_strdup(mi->title);
 
@@ -768,6 +765,7 @@ static void mp_set_media_attributes(struct media_player *mp,
 	mp->mi.ntracks = mi->ntracks;
 	mp->mi.track = mi->track;
 	mp->mi.track_len = mi->track_len;
+	mp->mi.uid = mi->uid;
 
 	/*
 	 * elapsed is special. Whenever the track changes, we reset it to 0,
@@ -782,7 +780,7 @@ static void mp_set_media_attributes(struct media_player *mp,
 			mi->title, mi->artist, mi->album, mi->genre,
 			mi->ntracks, mi->track, mi->track_len);
 
-	avrcp_send_event(mp, AVRCP_EVENT_TRACK_CHANGED, NULL);
+	avrcp_send_event(mp, AVRCP_EVENT_TRACK_CHANGED, &mi->uid);
 }
 
 static uint8_t avrcp_handle_get_capabilities(struct media_player *mp,
@@ -1166,8 +1164,7 @@ static uint8_t avrcp_handle_register_notification(struct media_player *mp,
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
 		len = 9;
-
-		memset(&pdu->params[1], 0, 8);
+		memcpy(&pdu->params[1], &mp->mi.uid, sizeof(uint64_t));
 
 		break;
 	default:
@@ -1320,6 +1317,7 @@ static void media_info_init(struct media_info *mi)
 	 */
 	mi->track_len = 0xFFFFFFFF;
 	mi->elapsed = 0xFFFFFFFF;
+	mi->uid = UINT64_MAX;
 }
 
 gboolean avrcp_connect(struct audio_device *dev)
@@ -1518,6 +1516,7 @@ static gboolean media_info_parse(DBusMessageIter *iter, struct media_info *mi)
 	DBusMessageIter dict;
 	DBusMessageIter var;
 	int ctype;
+	int nattr;
 
 	ctype = dbus_message_iter_get_arg_type(iter);
 	if (ctype != DBUS_TYPE_ARRAY)
@@ -1526,8 +1525,8 @@ static gboolean media_info_parse(DBusMessageIter *iter, struct media_info *mi)
 	media_info_init(mi);
 	dbus_message_iter_recurse(iter, &dict);
 
-	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
-							DBUS_TYPE_INVALID) {
+	for(nattr = 0; (ctype = dbus_message_iter_get_arg_type(&dict)) !=
+						DBUS_TYPE_INVALID; nattr++) {
 		DBusMessageIter entry;
 		const char *key;
 
@@ -1595,8 +1594,12 @@ static gboolean media_info_parse(DBusMessageIter *iter, struct media_info *mi)
 		dbus_message_iter_next(&dict);
 	}
 
-	if (mi->title == NULL)
-		return FALSE;
+	if (nattr > 0) {
+		if (mi->title == NULL)
+			return FALSE;
+
+		mi->uid = 0;
+	}
 
 	return TRUE;
 }
@@ -1609,7 +1612,6 @@ static DBusMessage *mp_change_track(DBusConnection *conn,
 	DBusMessageIter iter;
 	struct media_info mi;
 
-
 	dbus_message_iter_init(msg, &iter);
 	if (!media_info_parse(&iter, &mi))
 		return btd_error_invalid_args(msg);
-- 
1.7.6.4

