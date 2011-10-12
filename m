Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 03/12] Don't overwrite metadata when changing track
Date: Wed, 12 Oct 2011 12:11:13 -0300
Message-Id: <1318432282-25002-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318432282-25002-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we use the same hash table to set the new metadata, we have 2
undesired behaviors:

1) New track may contain fields from previous track if it didn't set all
the fields
2) If we fail on parsing the signal, we will still change some of the
fields
---
 audio/media.c     |   41 ++++++++++++++++++++++++++---------------
 doc/media-api.txt |    6 ++++++
 2 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index ef595b3..c9fe0f0 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1353,6 +1353,7 @@ static gboolean parse_player_metadata(struct media_player *mp,
 {
 	DBusMessageIter dict;
 	DBusMessageIter var;
+	GHashTable *track;
 	int ctype;
 	gboolean title = FALSE;
 
@@ -1362,6 +1363,9 @@ static gboolean parse_player_metadata(struct media_player *mp,
 
 	dbus_message_iter_recurse(iter, &dict);
 
+	track = g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
+							metadata_value_free);
+
 	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
 							DBUS_TYPE_INVALID) {
 		DBusMessageIter entry;
@@ -1370,21 +1374,21 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		int id;
 
 		if (ctype != DBUS_TYPE_DICT_ENTRY)
-			return FALSE;
+			goto parse_error;
 
 		dbus_message_iter_recurse(&dict, &entry);
 		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
-			return FALSE;
+			goto parse_error;
 
 		dbus_message_iter_get_basic(&entry, &key);
 		dbus_message_iter_next(&entry);
 
 		id = metadata_to_val(key);
 		if (id < 0)
-			return FALSE;
+			goto parse_error;
 
 		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
-			return FALSE;
+			goto parse_error;
 
 		dbus_message_iter_recurse(&entry, &var);
 
@@ -1399,7 +1403,7 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		case AVRCP_MEDIA_ATTRIBUTE_GENRE:
 			if (value->type != DBUS_TYPE_STRING) {
 				g_free(value);
-				return FALSE;
+				goto parse_error;
 			}
 
 			dbus_message_iter_get_basic(&var, &value->value.str);
@@ -1409,13 +1413,13 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		case AVRCP_MEDIA_ATTRIBUTE_DURATION:
 			if (value->type != DBUS_TYPE_UINT32) {
 				g_free(value);
-				return FALSE;
+				goto parse_error;
 			}
 
 			dbus_message_iter_get_basic(&var, &value->value.num);
 			break;
 		default:
-			return FALSE;
+			goto parse_error;
 		}
 
 		switch (value->type) {
@@ -1427,24 +1431,31 @@ static gboolean parse_player_metadata(struct media_player *mp,
 			DBG("%s=%u", key, value->value.num);
 		}
 
-		if (!mp->track)
-			mp->track = g_hash_table_new_full(g_direct_hash,
-							g_direct_equal, NULL,
-							metadata_value_free);
-
-		g_hash_table_replace(mp->track, GUINT_TO_POINTER(id), value);
+		g_hash_table_replace(track, GUINT_TO_POINTER(id), value);
 		dbus_message_iter_next(&dict);
 	}
 
-	if (title == FALSE)
-		return TRUE;
+	if (g_hash_table_size(track) == 0) {
+		g_hash_table_unref(track);
+		track = NULL;
+	}
 
+	if (mp->track != NULL)
+		g_hash_table_unref(mp->track);
+
+	mp->track = track;
 	mp->position = 0;
 	g_timer_start(mp->timer);
 
 	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, NULL);
 
 	return TRUE;
+
+parse_error:
+	if (track)
+		g_hash_table_unref(track);
+
+	return FALSE;
 }
 
 static gboolean track_changed(DBusConnection *connection, DBusMessage *msg,
diff --git a/doc/media-api.txt b/doc/media-api.txt
index 7dc7661..b8dcdbd 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -144,6 +144,12 @@ Signals		PropertyChanged(string setting, variant value)
 
 		TrackChanged(dict metadata)
 
+			This signal indicates that current track has changed.
+			All available metadata for the new track shall be set
+			at once in the metadata argument. Metadata cannot be
+			updated in parts, otherwise it will be interpreted as
+			multiple track changes.
+
 			Possible values:
 
 				string Title:
-- 
1.7.7

