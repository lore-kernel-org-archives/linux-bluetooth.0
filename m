Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/11] AVRCP: Remove conversions inside media.c
Date: Thu, 25 Oct 2012 16:59:11 +0300
Message-Id: <1351173554-28039-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The conversion should be done in avrcp.c as it is already doing for
controller players.
---
 audio/avrcp.c | 369 +++++++++++++++++++++++++++++++++-------------------------
 audio/avrcp.h |   9 +-
 audio/media.c | 315 ++++++++-----------------------------------------
 3 files changed, 267 insertions(+), 426 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 35fc249..6ed085b 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -435,12 +435,123 @@ static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
 	cid[2] = cid_in;
 }
 
+static const char *attr_to_str(uint8_t attr)
+{
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		return "Equalizer";
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		return "Repeat";
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		return "Shuffle";
+	case AVRCP_ATTRIBUTE_SCAN:
+		return "Scan";
+	}
+
+	return NULL;
+}
+
+static int attrval_to_val(uint8_t attr, const char *value)
+{
+	int ret;
+
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_EQUALIZER_OFF;
+		else if (!strcmp(value, "on"))
+			ret = AVRCP_EQUALIZER_ON;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_REPEAT_MODE_OFF;
+		else if (!strcmp(value, "singletrack"))
+			ret = AVRCP_REPEAT_MODE_SINGLE;
+		else if (!strcmp(value, "alltracks"))
+			ret = AVRCP_REPEAT_MODE_ALL;
+		else if (!strcmp(value, "group"))
+			ret = AVRCP_REPEAT_MODE_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_SHUFFLE_OFF;
+		else if (!strcmp(value, "alltracks"))
+			ret = AVRCP_SHUFFLE_ALL;
+		else if (!strcmp(value, "group"))
+			ret = AVRCP_SHUFFLE_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case AVRCP_ATTRIBUTE_SCAN:
+		if (!strcmp(value, "off"))
+			ret = AVRCP_SCAN_OFF;
+		else if (!strcmp(value, "alltracks"))
+			ret = AVRCP_SCAN_ALL;
+		else if (!strcmp(value, "group"))
+			ret = AVRCP_SCAN_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static int attr_to_val(const char *str)
+{
+	if (!strcasecmp(str, "Equalizer"))
+		return AVRCP_ATTRIBUTE_EQUALIZER;
+	else if (!strcasecmp(str, "Repeat"))
+		return AVRCP_ATTRIBUTE_REPEAT_MODE;
+	else if (!strcasecmp(str, "Shuffle"))
+		return AVRCP_ATTRIBUTE_SHUFFLE;
+	else if (!strcasecmp(str, "Scan"))
+		return AVRCP_ATTRIBUTE_SCAN;
+
+	return -EINVAL;
+}
+
 static int player_get_setting(struct avrcp_player *player, uint8_t id)
 {
+	const char *key;
+	const char *value;
+
 	if (player == NULL)
 		return -ENOENT;
 
-	return player->cb->get_setting(id, player->user_data);
+	key = attr_to_str(id);
+	if (key == NULL)
+		return -EINVAL;
+
+	value = player->cb->get_setting(key, player->user_data);
+
+	return attrval_to_val(id, value);
+}
+
+static int play_status_to_val(const char *status)
+{
+	if (!strcasecmp(status, "stopped"))
+		return AVRCP_PLAY_STATUS_STOPPED;
+	else if (!strcasecmp(status, "playing"))
+		return AVRCP_PLAY_STATUS_PLAYING;
+	else if (!strcasecmp(status, "paused"))
+		return AVRCP_PLAY_STATUS_PAUSED;
+	else if (!strcasecmp(status, "forward-seek"))
+		return AVRCP_PLAY_STATUS_FWD_SEEK;
+	else if (!strcasecmp(status, "reverse-seek"))
+		return AVRCP_PLAY_STATUS_REV_SEEK;
+	else if (!strcasecmp(status, "error"))
+		return AVRCP_PLAY_STATUS_ERROR;
+
+	return -EINVAL;
 }
 
 void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
@@ -466,7 +577,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	switch (id) {
 	case AVRCP_EVENT_STATUS_CHANGED:
 		size = 2;
-		pdu->params[1] = *((uint8_t *)data);
+		pdu->params[1] = play_status_to_val(data);
 
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
@@ -483,9 +594,14 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 		settings = data;
 		pdu->params[1] = g_list_length(settings);
 		for (; settings; settings = settings->next) {
-			uint8_t attr = GPOINTER_TO_UINT(settings->data);
+			const char *key = settings->data;
+			int attr;
 			int val;
 
+			attr = attr_to_val(key);
+			if (attr < 0)
+				continue;
+
 			val = player_get_setting(player, attr);
 			if (val < 0)
 				continue;
@@ -522,12 +638,40 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	return;
 }
 
-static const char *player_get_metadata(struct avrcp_player *player, uint32_t attr)
+static const char *metadata_to_str(uint32_t id)
+{
+	switch (id) {
+	case AVRCP_MEDIA_ATTRIBUTE_TITLE:
+		return "Title";
+	case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
+		return "Artist";
+	case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
+		return "Album";
+	case AVRCP_MEDIA_ATTRIBUTE_GENRE:
+		return "Genre";
+	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
+		return "Track";
+	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
+		return "NumberOfTracks";
+	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
+		return "Duration";
+	}
+
+	return NULL;
+}
+
+static const char *player_get_metadata(struct avrcp_player *player, uint32_t id)
 {
+	const char *key;
+
+	key = metadata_to_str(id);
+	if (key == NULL)
+		return NULL;
+
 	if (player != NULL)
-		return player->cb->get_metadata(attr, player->user_data);
+		return player->cb->get_metadata(key, player->user_data);
 
-	if (attr == AVRCP_MEDIA_ATTRIBUTE_TITLE)
+	if (id == AVRCP_MEDIA_ATTRIBUTE_TITLE)
 		return "";
 
 	return NULL;
@@ -629,13 +773,66 @@ static gboolean session_abort_pending_pdu(struct avrcp *session)
 	return TRUE;
 }
 
+static const char *attrval_to_str(uint8_t attr, uint8_t value)
+{
+	switch (attr) {
+	case AVRCP_ATTRIBUTE_EQUALIZER:
+		switch (value) {
+		case AVRCP_EQUALIZER_ON:
+			return "on";
+		case AVRCP_EQUALIZER_OFF:
+			return "off";
+		}
+
+		break;
+	case AVRCP_ATTRIBUTE_REPEAT_MODE:
+		switch (value) {
+		case AVRCP_REPEAT_MODE_OFF:
+			return "off";
+		case AVRCP_REPEAT_MODE_SINGLE:
+			return "singletrack";
+		case AVRCP_REPEAT_MODE_ALL:
+			return "alltracks";
+		case AVRCP_REPEAT_MODE_GROUP:
+			return "group";
+		}
+
+		break;
+	/* Shuffle and scan have the same values */
+	case AVRCP_ATTRIBUTE_SHUFFLE:
+	case AVRCP_ATTRIBUTE_SCAN:
+		switch (value) {
+		case AVRCP_SCAN_OFF:
+			return "off";
+		case AVRCP_SCAN_ALL:
+			return "alltracks";
+		case AVRCP_SCAN_GROUP:
+			return "group";
+		}
+
+		break;
+	}
+
+	return NULL;
+}
+
 static int player_set_setting(struct avrcp_player *player, uint8_t id,
 								uint8_t val)
 {
+	const char *key, *value;
+
+	key = attr_to_str(id);
+	if (key == NULL)
+		return -EINVAL;
+
+	value = attrval_to_str(id, val);
+	if (value == NULL)
+		return -EINVAL;
+
 	if (player == NULL)
 		return -ENOENT;
 
-	return player->cb->set_setting(id, val, player->user_data);
+	return player->cb->set_setting(key, value, player->user_data);
 }
 
 static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
@@ -989,10 +1186,14 @@ static uint32_t player_get_duration(struct avrcp_player *player)
 
 static uint8_t player_get_status(struct avrcp_player *player)
 {
+	const char *value;
+
 	if (player == NULL)
 		return AVRCP_PLAY_STATUS_STOPPED;
 
-	return player->cb->get_status(player->user_data);
+	value = player->cb->get_status(player->user_data);
+
+	return play_status_to_val(value);
 }
 
 static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
@@ -1079,7 +1280,8 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 
 		pdu->params[++len] = g_list_length(settings);
 		for (; settings; settings = settings->next) {
-			uint8_t attr = GPOINTER_TO_UINT(settings->data);
+			const char *key = settings->data;
+			uint8_t attr = attr_to_val(key);
 			int val;
 
 			val = player_get_setting(player, attr);
@@ -1410,65 +1612,6 @@ static void avrcp_get_play_status(struct avrcp *session)
 					session);
 }
 
-static const char *attrval_to_str(uint8_t attr, uint8_t value)
-{
-	switch (attr) {
-	case AVRCP_ATTRIBUTE_EQUALIZER:
-		switch (value) {
-		case AVRCP_EQUALIZER_ON:
-			return "on";
-		case AVRCP_EQUALIZER_OFF:
-			return "off";
-		}
-
-		break;
-	case AVRCP_ATTRIBUTE_REPEAT_MODE:
-		switch (value) {
-		case AVRCP_REPEAT_MODE_OFF:
-			return "off";
-		case AVRCP_REPEAT_MODE_SINGLE:
-			return "singletrack";
-		case AVRCP_REPEAT_MODE_ALL:
-			return "alltracks";
-		case AVRCP_REPEAT_MODE_GROUP:
-			return "group";
-		}
-
-		break;
-	/* Shuffle and scan have the same values */
-	case AVRCP_ATTRIBUTE_SHUFFLE:
-	case AVRCP_ATTRIBUTE_SCAN:
-		switch (value) {
-		case AVRCP_SCAN_OFF:
-			return "off";
-		case AVRCP_SCAN_ALL:
-			return "alltracks";
-		case AVRCP_SCAN_GROUP:
-			return "group";
-		}
-
-		break;
-	}
-
-	return NULL;
-}
-
-static const char *attr_to_str(uint8_t attr)
-{
-	switch (attr) {
-	case AVRCP_ATTRIBUTE_EQUALIZER:
-		return "Equalizer";
-	case AVRCP_ATTRIBUTE_REPEAT_MODE:
-		return "Repeat";
-	case AVRCP_ATTRIBUTE_SHUFFLE:
-		return "Shuffle";
-	case AVRCP_ATTRIBUTE_SCAN:
-		return "Scan";
-	}
-
-	return NULL;
-}
-
 static gboolean avrcp_player_value_rsp(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -1572,28 +1715,6 @@ static void avrcp_list_player_attributes(struct avrcp *session)
 					session);
 }
 
-static const char *metadata_to_str(uint32_t id)
-{
-	switch (id) {
-	case AVRCP_MEDIA_ATTRIBUTE_TITLE:
-		return "Title";
-	case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
-		return "Artist";
-	case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
-		return "Album";
-	case AVRCP_MEDIA_ATTRIBUTE_GENRE:
-		return "Genre";
-	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
-		return "Track";
-	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
-		return "NumberOfTracks";
-	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
-		return "Duration";
-	}
-
-	return NULL;
-}
-
 static gboolean avrcp_get_attributes_rsp(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -1774,74 +1895,6 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event)
 					avrcp_handle_event, session);
 }
 
-static int attr_to_val(const char *str)
-{
-	if (!strcasecmp(str, "Equalizer"))
-		return AVRCP_ATTRIBUTE_EQUALIZER;
-	else if (!strcasecmp(str, "Repeat"))
-		return AVRCP_ATTRIBUTE_REPEAT_MODE;
-	else if (!strcasecmp(str, "Shuffle"))
-		return AVRCP_ATTRIBUTE_SHUFFLE;
-	else if (!strcasecmp(str, "Scan"))
-		return AVRCP_ATTRIBUTE_SCAN;
-
-	return -EINVAL;
-}
-
-static int attrval_to_val(uint8_t attr, const char *value)
-{
-	int ret;
-
-	switch (attr) {
-	case AVRCP_ATTRIBUTE_EQUALIZER:
-		if (!strcmp(value, "off"))
-			ret = AVRCP_EQUALIZER_OFF;
-		else if (!strcmp(value, "on"))
-			ret = AVRCP_EQUALIZER_ON;
-		else
-			ret = -EINVAL;
-
-		return ret;
-	case AVRCP_ATTRIBUTE_REPEAT_MODE:
-		if (!strcmp(value, "off"))
-			ret = AVRCP_REPEAT_MODE_OFF;
-		else if (!strcmp(value, "singletrack"))
-			ret = AVRCP_REPEAT_MODE_SINGLE;
-		else if (!strcmp(value, "alltracks"))
-			ret = AVRCP_REPEAT_MODE_ALL;
-		else if (!strcmp(value, "group"))
-			ret = AVRCP_REPEAT_MODE_GROUP;
-		else
-			ret = -EINVAL;
-
-		return ret;
-	case AVRCP_ATTRIBUTE_SHUFFLE:
-		if (!strcmp(value, "off"))
-			ret = AVRCP_SHUFFLE_OFF;
-		else if (!strcmp(value, "alltracks"))
-			ret = AVRCP_SHUFFLE_ALL;
-		else if (!strcmp(value, "group"))
-			ret = AVRCP_SHUFFLE_GROUP;
-		else
-			ret = -EINVAL;
-
-		return ret;
-	case AVRCP_ATTRIBUTE_SCAN:
-		if (!strcmp(value, "off"))
-			ret = AVRCP_SCAN_OFF;
-		else if (!strcmp(value, "alltracks"))
-			ret = AVRCP_SCAN_ALL;
-		else if (!strcmp(value, "group"))
-			ret = AVRCP_SCAN_GROUP;
-		else
-			ret = -EINVAL;
-
-		return ret;
-	}
-
-	return -EINVAL;
-}
-
 static void avrcp_set_player_value(struct avrcp *session, uint8_t attr,
 								uint8_t val)
 {
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 7f54adb..e607fb1 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -79,12 +79,13 @@
 
 struct avrcp_player_cb {
 	GList *(*list_settings) (void *user_data);
-	int (*get_setting) (uint8_t attr, void *user_data);
-	int (*set_setting) (uint8_t attr, uint8_t value, void *user_data);
+	const char *(*get_setting) (const char *key, void *user_data);
+	int (*set_setting) (const char *key, const char *value,
+							void *user_data);
 	uint64_t (*get_uid) (void *user_data);
-	const char *(*get_metadata) (uint32_t id, void *user_data);
+	const char *(*get_metadata) (const char *key, void *user_data);
 	GList *(*list_metadata) (void *user_data);
-	uint8_t (*get_status) (void *user_data);
+	const char *(*get_status) (void *user_data);
 	uint32_t (*get_position) (void *user_data);
 	uint32_t (*get_duration) (void *user_data);
 	void (*set_volume) (uint8_t volume, struct audio_device *dev,
diff --git a/audio/media.c b/audio/media.c
index 7abf077..cec938a 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -98,7 +98,7 @@ struct media_player {
 	guint			watch;
 	guint			property_watch;
 	guint			track_watch;
-	uint8_t			status;
+	char			*status;
 	uint32_t		position;
 	uint32_t		duration;
 	uint8_t			volume;
@@ -980,6 +980,7 @@ static void media_player_free(gpointer data)
 	g_timer_destroy(mp->timer);
 	g_free(mp->sender);
 	g_free(mp->path);
+	g_free(mp->status);
 	g_free(mp);
 }
 
@@ -1007,193 +1008,6 @@ static void media_player_remove(struct media_player *mp)
 	media_player_destroy(mp);
 }
 
-static const char *attrval_to_str(uint8_t attr, uint8_t value)
-{
-	switch (attr) {
-	case AVRCP_ATTRIBUTE_EQUALIZER:
-		switch (value) {
-		case AVRCP_EQUALIZER_ON:
-			return "on";
-		case AVRCP_EQUALIZER_OFF:
-			return "off";
-		}
-
-		break;
-	case AVRCP_ATTRIBUTE_REPEAT_MODE:
-		switch (value) {
-		case AVRCP_REPEAT_MODE_OFF:
-			return "off";
-		case AVRCP_REPEAT_MODE_SINGLE:
-			return "singletrack";
-		case AVRCP_REPEAT_MODE_ALL:
-			return "alltracks";
-		case AVRCP_REPEAT_MODE_GROUP:
-			return "group";
-		}
-
-		break;
-	/* Shuffle and scan have the same values */
-	case AVRCP_ATTRIBUTE_SHUFFLE:
-	case AVRCP_ATTRIBUTE_SCAN:
-		switch (value) {
-		case AVRCP_SCAN_OFF:
-			return "off";
-		case AVRCP_SCAN_ALL:
-			return "alltracks";
-		case AVRCP_SCAN_GROUP:
-			return "group";
-		}
-
-		break;
-	}
-
-	return NULL;
-}
-
-static int attrval_to_val(uint8_t attr, const char *value)
-{
-	int ret;
-
-	switch (attr) {
-	case AVRCP_ATTRIBUTE_EQUALIZER:
-		if (!strcmp(value, "off"))
-			ret = AVRCP_EQUALIZER_OFF;
-		else if (!strcmp(value, "on"))
-			ret = AVRCP_EQUALIZER_ON;
-		else
-			ret = -EINVAL;
-
-		return ret;
-	case AVRCP_ATTRIBUTE_REPEAT_MODE:
-		if (!strcmp(value, "off"))
-			ret = AVRCP_REPEAT_MODE_OFF;
-		else if (!strcmp(value, "singletrack"))
-			ret = AVRCP_REPEAT_MODE_SINGLE;
-		else if (!strcmp(value, "alltracks"))
-			ret = AVRCP_REPEAT_MODE_ALL;
-		else if (!strcmp(value, "group"))
-			ret = AVRCP_REPEAT_MODE_GROUP;
-		else
-			ret = -EINVAL;
-
-		return ret;
-	case AVRCP_ATTRIBUTE_SHUFFLE:
-		if (!strcmp(value, "off"))
-			ret = AVRCP_SHUFFLE_OFF;
-		else if (!strcmp(value, "alltracks"))
-			ret = AVRCP_SHUFFLE_ALL;
-		else if (!strcmp(value, "group"))
-			ret = AVRCP_SHUFFLE_GROUP;
-		else
-			ret = -EINVAL;
-
-		return ret;
-	case AVRCP_ATTRIBUTE_SCAN:
-		if (!strcmp(value, "off"))
-			ret = AVRCP_SCAN_OFF;
-		else if (!strcmp(value, "alltracks"))
-			ret = AVRCP_SCAN_ALL;
-		else if (!strcmp(value, "group"))
-			ret = AVRCP_SCAN_GROUP;
-		else
-			ret = -EINVAL;
-
-		return ret;
-	}
-
-	return -EINVAL;
-}
-
-static const char *attr_to_str(uint8_t attr)
-{
-	switch (attr) {
-	case AVRCP_ATTRIBUTE_EQUALIZER:
-		return "Equalizer";
-	case AVRCP_ATTRIBUTE_REPEAT_MODE:
-		return "Repeat";
-	case AVRCP_ATTRIBUTE_SHUFFLE:
-		return "Shuffle";
-	case AVRCP_ATTRIBUTE_SCAN:
-		return "Scan";
-	}
-
-	return NULL;
-}
-
-static int attr_to_val(const char *str)
-{
-	if (!strcasecmp(str, "Equalizer"))
-		return AVRCP_ATTRIBUTE_EQUALIZER;
-	else if (!strcasecmp(str, "Repeat"))
-		return AVRCP_ATTRIBUTE_REPEAT_MODE;
-	else if (!strcasecmp(str, "Shuffle"))
-		return AVRCP_ATTRIBUTE_SHUFFLE;
-	else if (!strcasecmp(str, "Scan"))
-		return AVRCP_ATTRIBUTE_SCAN;
-
-	return -EINVAL;
-}
-
-static int play_status_to_val(const char *status)
-{
-	if (!strcasecmp(status, "stopped"))
-		return AVRCP_PLAY_STATUS_STOPPED;
-	else if (!strcasecmp(status, "playing"))
-		return AVRCP_PLAY_STATUS_PLAYING;
-	else if (!strcasecmp(status, "paused"))
-		return AVRCP_PLAY_STATUS_PAUSED;
-	else if (!strcasecmp(status, "forward-seek"))
-		return AVRCP_PLAY_STATUS_FWD_SEEK;
-	else if (!strcasecmp(status, "reverse-seek"))
-		return AVRCP_PLAY_STATUS_REV_SEEK;
-	else if (!strcasecmp(status, "error"))
-		return AVRCP_PLAY_STATUS_ERROR;
-
-	return -EINVAL;
-}
-
-static int metadata_to_val(const char *str)
-{
-	if (!strcasecmp(str, "Title"))
-		return AVRCP_MEDIA_ATTRIBUTE_TITLE;
-	else if (!strcasecmp(str, "Artist"))
-		return AVRCP_MEDIA_ATTRIBUTE_ARTIST;
-	else if (!strcasecmp(str, "Album"))
-		return AVRCP_MEDIA_ATTRIBUTE_ALBUM;
-	else if (!strcasecmp(str, "Genre"))
-		return AVRCP_MEDIA_ATTRIBUTE_GENRE;
-	else if (!strcasecmp(str, "NumberOfTracks"))
-		return AVRCP_MEDIA_ATTRIBUTE_N_TRACKS;
-	else if (!strcasecmp(str, "Number"))
-		return AVRCP_MEDIA_ATTRIBUTE_TRACK;
-	else if (!strcasecmp(str, "Duration"))
-		return AVRCP_MEDIA_ATTRIBUTE_DURATION;
-
-	return -EINVAL;
-}
-
-static const char *metadata_to_str(uint32_t id)
-{
-	switch (id) {
-	case AVRCP_MEDIA_ATTRIBUTE_TITLE:
-		return "Title";
-	case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
-		return "Artist";
-	case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
-		return "Album";
-	case AVRCP_MEDIA_ATTRIBUTE_GENRE:
-		return "Genre";
-	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
-		return "Track";
-	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
-		return "NumberOfTracks";
-	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
-		return "Duration";
-	}
-
-	return NULL;
-}
-
 static GList *list_settings(void *user_data)
 {
 	struct media_player *mp = user_data;
@@ -1206,38 +1020,24 @@ static GList *list_settings(void *user_data)
 	return g_hash_table_get_keys(mp->settings);
 }
 
-static int get_setting(uint8_t attr, void *user_data)
+static const char *get_setting(const char *key, void *user_data)
 {
 	struct media_player *mp = user_data;
-	guint attr_uint = attr;
-	void *value;
-
-	DBG("%s", attr_to_str(attr));
 
-	value = g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr_uint));
-	if (!value)
-		return -EINVAL;
+	DBG("%s", key);
 
-	return GPOINTER_TO_UINT(value);
+	return g_hash_table_lookup(mp->settings, key);
 }
 
-static int set_setting(uint8_t attr, uint8_t val, void *user_data)
+static int set_setting(const char *key, const char *value, void *user_data)
 {
 	struct media_player *mp = user_data;
-	const char *property, *value;
-	guint attr_uint = attr;
 	DBusMessage *msg;
 	DBusMessageIter iter, var;
 
-	property = attr_to_str(attr);
-	value = attrval_to_str(attr, val);
-
-	DBG("%s = %s", property, value);
+	DBG("%s = %s", key, value);
 
-	if (property == NULL || value == NULL)
-		return -EINVAL;
-
-	if (!g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr_uint)))
+	if (!g_hash_table_lookup(mp->settings, key))
 		return -EINVAL;
 
 	msg = dbus_message_new_method_call(mp->sender, mp->path,
@@ -1249,7 +1049,7 @@ static int set_setting(uint8_t attr, uint8_t val, void *user_data)
 	}
 
 	dbus_message_iter_init_append(msg, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &property);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &key);
 
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
 						DBUS_TYPE_STRING_AS_STRING,
@@ -1286,19 +1086,19 @@ static uint64_t get_uid(void *user_data)
 	return 0;
 }
 
-static const char *get_metadata(uint32_t id, void *user_data)
+static const char *get_metadata(const char *key, void *user_data)
 {
 	struct media_player *mp = user_data;
 
-	DBG("%s", metadata_to_str(id));
+	DBG("%s", key);
 
 	if (mp->track == NULL)
 		return NULL;
 
-	return g_hash_table_lookup(mp->track, GUINT_TO_POINTER(id));
+	return g_hash_table_lookup(mp->track, key);
 }
 
-static uint8_t get_status(void *user_data)
+static const char *get_status(void *user_data)
 {
 	struct media_player *mp = user_data;
 
@@ -1311,7 +1111,7 @@ static uint32_t get_position(void *user_data)
 	double timedelta;
 	uint32_t sec, msec;
 
-	if (mp->status != AVRCP_PLAY_STATUS_PLAYING)
+	if (g_strcmp0(mp->status, "playing") != 0)
 		return mp->position;
 
 	timedelta = g_timer_elapsed(mp->timer, NULL);
@@ -1379,7 +1179,6 @@ static void media_player_exit(DBusConnection *connection, void *user_data)
 static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
 {
 	const char *value;
-	int val;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
 		return FALSE;
@@ -1387,21 +1186,16 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
 	dbus_message_iter_get_basic(iter, &value);
 	DBG("Status=%s", value);
 
-	val = play_status_to_val(value);
-	if (val < 0) {
-		error("Invalid status");
-		return FALSE;
-	}
-
-	if (mp->status == val)
+	if (g_strcmp0(mp->status, value) == 0)
 		return TRUE;
 
 	mp->position = get_position(mp);
 	g_timer_start(mp->timer);
 
-	mp->status = val;
+	g_free(mp->status);
+	mp->status = g_strdup(value);
 
-	avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, &val);
+	avrcp_player_event(mp->player, AVRCP_EVENT_STATUS_CHANGED, mp->status);
 
 	return TRUE;
 }
@@ -1441,7 +1235,6 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
 {
 	DBusMessageIter var;
 	const char *value, *curval;
-	int attr, val;
 	GList *settings;
 
 	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
@@ -1455,27 +1248,18 @@ static gboolean set_player_property(struct media_player *mp, const char *key,
 	if (strcasecmp(key, "Position") == 0)
 		return set_position(mp, &var);
 
-	attr = attr_to_val(key);
-	if (attr < 0)
-		return FALSE;
-
 	if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
 		return FALSE;
 
 	dbus_message_iter_get_basic(&var, &value);
 
-	val = attrval_to_val(attr, value);
-	if (val < 0)
-		return FALSE;
-
-	curval = g_hash_table_lookup(mp->settings, GUINT_TO_POINTER(attr));
+	curval = g_hash_table_lookup(mp->settings, key);
 	if (g_strcmp0(curval, value) == 0)
 		return TRUE;
 
 	DBG("%s=%s", key, value);
 
-	g_hash_table_replace(mp->settings, GUINT_TO_POINTER(attr),
-						GUINT_TO_POINTER(val));
+	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
 
 	settings = list_settings(mp);
 
@@ -1529,7 +1313,7 @@ static gboolean parse_player_metadata(struct media_player *mp,
 
 	dbus_message_iter_recurse(iter, &dict);
 
-	track = g_hash_table_new_full(g_direct_hash, g_direct_equal, NULL,
+	track = g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
 								g_free);
 
 	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
@@ -1540,7 +1324,6 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		char valstr[20];
 		char *value;
 		uint32_t num;
-		int id;
 		int type;
 
 		if (ctype != DBUS_TYPE_DICT_ENTRY)
@@ -1553,10 +1336,6 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		dbus_message_iter_get_basic(&entry, &key);
 		dbus_message_iter_next(&entry);
 
-		id = metadata_to_val(key);
-		if (id < 0)
-			goto parse_error;
-
 		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
 			goto parse_error;
 
@@ -1564,36 +1343,46 @@ static gboolean parse_player_metadata(struct media_player *mp,
 
 		type = dbus_message_iter_get_arg_type(&var);
 
-		switch (id) {
-		case AVRCP_MEDIA_ATTRIBUTE_TITLE:
+		if (strcasecmp(key, "Title") == 0) {
+			if (type != DBUS_TYPE_STRING)
+				goto parse_error;
 			title = TRUE;
-		case AVRCP_MEDIA_ATTRIBUTE_ARTIST:
-		case AVRCP_MEDIA_ATTRIBUTE_ALBUM:
-		case AVRCP_MEDIA_ATTRIBUTE_GENRE:
+			dbus_message_iter_get_basic(&var, &string);
+		} else if (strcasecmp(key, "Artist") == 0) {
 			if (type != DBUS_TYPE_STRING)
 				goto parse_error;
 
 			dbus_message_iter_get_basic(&var, &string);
-			break;
-		case AVRCP_MEDIA_ATTRIBUTE_TRACK:
-		case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
+		} else if (strcasecmp(key, "Album") == 0) {
+			if (type != DBUS_TYPE_STRING)
+				goto parse_error;
+
+			dbus_message_iter_get_basic(&var, &string);
+		} else if (strcasecmp(key, "Genre") == 0) {
+			if (type != DBUS_TYPE_STRING)
+				goto parse_error;
+
+			dbus_message_iter_get_basic(&var, &string);
+		} else if (strcasecmp(key, "Duration") == 0) {
 			if (type != DBUS_TYPE_UINT32)
 				goto parse_error;
 
 			dbus_message_iter_get_basic(&var, &num);
-			break;
-		case AVRCP_MEDIA_ATTRIBUTE_DURATION:
+			mp->duration = num;
+		} else if (strcasecmp(key, "Track") == 0) {
 			if (type != DBUS_TYPE_UINT32)
 				goto parse_error;
 
 			dbus_message_iter_get_basic(&var, &num);
-			mp->duration = num;
-			break;
-		default:
+		} else if (strcasecmp(key, "NumberOfTracks") == 0) {
+			if (type != DBUS_TYPE_UINT32)
+				goto parse_error;
+
+			dbus_message_iter_get_basic(&var, &num);
+		} else
 			goto parse_error;
-		}
 
-		switch (dbus_message_iter_get_arg_type(&var)) {
+		switch (type) {
 		case DBUS_TYPE_STRING:
 			value = g_strdup(string);
 			break;
@@ -1603,18 +1392,15 @@ static gboolean parse_player_metadata(struct media_player *mp,
 		}
 
 		DBG("%s=%s", key, value);
-		g_hash_table_replace(track, GUINT_TO_POINTER(id), value);
+		g_hash_table_replace(track, g_strdup(key), value);
 		dbus_message_iter_next(&dict);
 	}
 
 	if (g_hash_table_size(track) == 0) {
 		g_hash_table_unref(track);
 		track = NULL;
-	} else if (title == FALSE) {
-		uint32_t id = AVRCP_MEDIA_ATTRIBUTE_TITLE;
-
-		g_hash_table_insert(track, GUINT_TO_POINTER(id), g_strdup(""));
-	}
+	} else if (title == FALSE)
+		g_hash_table_insert(track, g_strdup("Title"), g_strdup(""));
 
 	if (mp->track != NULL)
 		g_hash_table_unref(mp->track);
@@ -1692,7 +1478,8 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 		return NULL;
 	}
 
-	mp->settings = g_hash_table_new(g_direct_hash, g_direct_equal);
+	mp->settings = g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
+								g_free);
 
 	adapter->players = g_slist_append(adapter->players, mp);
 
-- 
1.7.11.7

