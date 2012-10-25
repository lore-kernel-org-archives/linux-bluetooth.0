Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/11] AVRCP: Fix using void * for metadata values
Date: Thu, 25 Oct 2012 16:59:05 +0300
Message-Id: <1351173554-28039-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces get_metadata callback with get_string and get_uint32
which uses proper types as return.
---
 audio/avrcp.c | 23 ++++----------
 audio/avrcp.h |  3 +-
 audio/media.c | 96 ++++++++++++++++++++++-------------------------------------
 3 files changed, 42 insertions(+), 80 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 2f5df21..fe304d1 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -500,8 +500,7 @@ static uint16_t player_write_media_attribute(struct avrcp_player *player,
 {
 	uint16_t len;
 	uint16_t attr_len;
-	char valstr[20];
-	void *value;
+	const char *value = NULL;
 
 	DBG("%u", id);
 
@@ -511,15 +510,6 @@ static uint16_t player_write_media_attribute(struct avrcp_player *player,
 		return 0;
 	}
 
-	switch (id) {
-	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
-	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
-	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
-		snprintf(valstr, 20, "%u", GPOINTER_TO_UINT(value));
-		value = valstr;
-		break;
-	}
-
 	attr_len = strlen(value);
 	value = ((char *) value) + *offset;
 	len = attr_len - *offset;
@@ -946,7 +936,6 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 	uint16_t len = ntohs(pdu->params_len);
 	uint32_t position;
 	uint32_t duration;
-	void *pduration;
 
 	if (len != 0 || player == NULL) {
 		pdu->params_len = htons(1);
@@ -955,14 +944,12 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 	}
 
 	position = player->cb->get_position(player->user_data);
-	pduration = player->cb->get_metadata(AVRCP_MEDIA_ATTRIBUTE_DURATION,
-							player->user_data);
-	if (pduration != NULL)
-		duration = htonl(GPOINTER_TO_UINT(pduration));
-	else
-		duration = htonl(UINT32_MAX);
+	duration = player->cb->get_duration(player->user_data);
+	if (duration == 0)
+		duration = UINT32_MAX;
 
 	position = htonl(position);
+	duration = htonl(duration);
 
 	memcpy(&pdu->params[0], &duration, 4);
 	memcpy(&pdu->params[4], &position, 4);
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 6c651dd..31fdf8d 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -80,10 +80,11 @@ struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
 	int (*set_setting) (uint8_t attr, uint8_t value, void *user_data);
 	uint64_t (*get_uid) (void *user_data);
-	void *(*get_metadata) (uint32_t id, void *user_data);
+	const char *(*get_metadata) (uint32_t id, void *user_data);
 	GList *(*list_metadata) (void *user_data);
 	uint8_t (*get_status) (void *user_data);
 	uint32_t (*get_position) (void *user_data);
+	uint32_t (*get_duration) (void *user_data);
 	void (*set_volume) (uint8_t volume, struct audio_device *dev,
 							void *user_data);
 };
diff --git a/audio/media.c b/audio/media.c
index f2b5b2f..28ed942 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -100,18 +100,11 @@ struct media_player {
 	guint			track_watch;
 	uint8_t			status;
 	uint32_t		position;
+	uint32_t		duration;
 	uint8_t			volume;
 	GTimer			*timer;
 };
 
-struct metadata_value {
-	int			type;
-	union {
-		char		*str;
-		uint32_t	num;
-	} value;
-};
-
 static GSList *adapters = NULL;
 
 static void endpoint_request_free(struct endpoint_request *request)
@@ -1281,28 +1274,16 @@ static uint64_t get_uid(void *user_data)
 	return 0;
 }
 
-static void *get_metadata(uint32_t id, void *user_data)
+static const char *get_metadata(uint32_t id, void *user_data)
 {
 	struct media_player *mp = user_data;
-	struct metadata_value *value;
 
 	DBG("%s", metadata_to_str(id));
 
 	if (mp->track == NULL)
 		return NULL;
 
-	value = g_hash_table_lookup(mp->track, GUINT_TO_POINTER(id));
-	if (!value)
-		return NULL;
-
-	switch (value->type) {
-	case DBUS_TYPE_STRING:
-		return value->value.str;
-	case DBUS_TYPE_UINT32:
-		return GUINT_TO_POINTER(value->value.num);
-	}
-
-	return NULL;
+	return g_hash_table_lookup(mp->track, GUINT_TO_POINTER(id));
 }
 
 static uint8_t get_status(void *user_data)
@@ -1329,6 +1310,13 @@ static uint32_t get_position(void *user_data)
 	return mp->position + sec * 1000 + msec;
 }
 
+static uint32_t get_duration(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	return mp->duration;
+}
+
 static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data)
 {
 	struct media_player *mp = user_data;
@@ -1362,6 +1350,7 @@ static struct avrcp_player_cb player_cb = {
 	.get_uid = get_uid,
 	.get_metadata = get_metadata,
 	.get_position = get_position,
+	.get_duration = get_duration,
 	.get_status = get_status,
 	.set_volume = set_volume
 };
@@ -1407,7 +1396,6 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
 static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 {
 	uint32_t value;
-	struct metadata_value *duration;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
 			return FALSE;
@@ -1424,15 +1412,11 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 		return TRUE;
 	}
 
-	duration = g_hash_table_lookup(mp->track, GUINT_TO_POINTER(
-					AVRCP_MEDIA_ATTRIBUTE_DURATION));
-
 	/*
 	 * If position is the maximum value allowed or greater than track's
 	 * duration, we send a track-reached-end event.
 	 */
-	if (mp->position == UINT32_MAX ||
-			(duration && mp->position >= duration->value.num))
+	if (mp->position == UINT32_MAX || mp->position >= mp->duration)
 		avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_END,
 									NULL);
 
@@ -1505,19 +1489,6 @@ static gboolean property_changed(DBusConnection *connection, DBusMessage *msg,
 	return TRUE;
 }
 
-static void metadata_value_free(gpointer data)
-{
-	struct metadata_value *value = data;
-
-	switch (value->type) {
-	case DBUS_TYPE_STRING:
-		g_free(value->value.str);
-		break;
-	}
-
-	g_free(value);
-}
-
 static gboolean parse_player_metadata(struct media_player *mp,
 							DBusMessageIter *iter)
 {
@@ -1535,14 +1506,18 @@ static gboolean parse_player_metadata(struct media_player *mp,
 	dbus_message_iter_recurse(iter, &dict);
 
 	track = g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
-							metadata_value_free);
+								g_free);
 
 	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
 							DBUS_TYPE_INVALID) {
 		DBusMessageIter entry;
 		const char *key;
-		struct metadata_value *value;
+		const char *string;
+		char valstr[20];
+		char *value;
+		uint32_t num;
 		int id;
+		int type;
 
 		if (ctype != DBUS_TYPE_DICT_ENTRY)
 			goto parse_error;
@@ -1563,8 +1538,7 @@ static gboolean parse_player_metadata(struct media_player *mp,
 
 		dbus_message_iter_recurse(&entry, &var);
 
-		value = g_new0(struct metadata_value, 1);
-		value->type = dbus_message_iter_get_arg_type(&var);
+		type = dbus_message_iter_get_arg_type(&var);
 
 		switch (id) {
 		case AVRCP_MEDIA_ATTRIBUTE_TITLE:
@@ -1572,36 +1546,39 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
 		case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
 		case AVRCP_MEDIA_ATTRIBUTE_GENRE:
-			if (value->type != DBUS_TYPE_STRING) {
-				g_free(value);
+			if (type != DBUS_TYPE_STRING)
 				goto parse_error;
-			}
 
-			dbus_message_iter_get_basic(&var, &value->value.str);
+			dbus_message_iter_get_basic(&var, &string);
 			break;
 		case AVRCP_MEDIA_ATTRIBUTE_TRACK:
 		case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
+			if (type != DBUS_TYPE_UINT32)
+				goto parse_error;
+
+			dbus_message_iter_get_basic(&var, &num);
+			break;
 		case AVRCP_MEDIA_ATTRIBUTE_DURATION:
-			if (value->type != DBUS_TYPE_UINT32) {
-				g_free(value);
+			if (type != DBUS_TYPE_UINT32)
 				goto parse_error;
-			}
 
-			dbus_message_iter_get_basic(&var, &value->value.num);
+			dbus_message_iter_get_basic(&var, &num);
+			mp->duration = num;
 			break;
 		default:
 			goto parse_error;
 		}
 
-		switch (value->type) {
+		switch (dbus_message_iter_get_arg_type(&var)) {
 		case DBUS_TYPE_STRING:
-			value->value.str = g_strdup(value->value.str);
-			DBG("%s=%s", key, value->value.str);
+			value = g_strdup(string);
 			break;
 		default:
-			DBG("%s=%u", key, value->value.num);
+			snprintf(valstr, 20, "%u", num);
+			value = g_strdup(valstr);
 		}
 
+		DBG("%s=%s", key, value);
 		g_hash_table_replace(track, GUINT_TO_POINTER(id), value);
 		dbus_message_iter_next(&dict);
 	}
@@ -1610,12 +1587,9 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		g_hash_table_unref(track);
 		track = NULL;
 	} else if (title == FALSE) {
-		struct metadata_value *value = g_new(struct metadata_value, 1);
 		uint32_t id = AVRCP_MEDIA_ATTRIBUTE_TITLE;
 
-		value->type = DBUS_TYPE_STRING;
-		value->value.str = g_strdup("");
-		g_hash_table_insert(track, GUINT_TO_POINTER(id), value);
+		g_hash_table_insert(track, GUINT_TO_POINTER(id), g_strdup(""));
 	}
 
 	if (mp->track != NULL)
-- 
1.7.11.7

