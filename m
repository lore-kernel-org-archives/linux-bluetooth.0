Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] AVRCP: Fix using void * for metadata values
Date: Tue, 16 Oct 2012 14:58:11 +0300
Message-Id: <1350388692-15239-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces get_metadata callback with get_string and get_uint32
which uses proper types as return.
---
 audio/avrcp.c | 32 ++++++++++++++++++--------------
 audio/avrcp.h |  3 ++-
 audio/media.c | 31 ++++++++++++++++++++++++-------
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 2f5df21..5a18cb4 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -501,23 +501,29 @@ static uint16_t player_write_media_attribute(struct avrcp_player *player,
 	uint16_t len;
 	uint16_t attr_len;
 	char valstr[20];
-	void *value;
+	const char *value = NULL;
+	uint32_t num;
 
 	DBG("%u", id);
 
-	value = player->cb->get_metadata(id, player->user_data);
-	if (value == NULL) {
-		*offset = 0;
-		return 0;
-	}
-
 	switch (id) {
 	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
 	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
 	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
-		snprintf(valstr, 20, "%u", GPOINTER_TO_UINT(value));
+		num = player->cb->get_uint32(id, player->user_data);
+		if (num == 0)
+			break;
+
+		snprintf(valstr, 20, "%u", num);
 		value = valstr;
 		break;
+	default:
+		value = player->cb->get_string(id, player->user_data);
+	}
+
+	if (value == NULL) {
+		*offset = 0;
+		return 0;
 	}
 
 	attr_len = strlen(value);
@@ -946,7 +952,6 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 	uint16_t len = ntohs(pdu->params_len);
 	uint32_t position;
 	uint32_t duration;
-	void *pduration;
 
 	if (len != 0 || player == NULL) {
 		pdu->params_len = htons(1);
@@ -955,14 +960,13 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 	}
 
 	position = player->cb->get_position(player->user_data);
-	pduration = player->cb->get_metadata(AVRCP_MEDIA_ATTRIBUTE_DURATION,
+	duration = player->cb->get_uint32(AVRCP_MEDIA_ATTRIBUTE_DURATION,
 							player->user_data);
-	if (pduration != NULL)
-		duration = htonl(GPOINTER_TO_UINT(pduration));
-	else
-		duration = htonl(UINT32_MAX);
+	if (duration == 0)
+		duration = UINT32_MAX;
 
 	position = htonl(position);
+	duration = htonl(duration);
 
 	memcpy(&pdu->params[0], &duration, 4);
 	memcpy(&pdu->params[4], &position, 4);
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 6c651dd..1a1e111 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -80,7 +80,8 @@ struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
 	int (*set_setting) (uint8_t attr, uint8_t value, void *user_data);
 	uint64_t (*get_uid) (void *user_data);
-	void *(*get_metadata) (uint32_t id, void *user_data);
+	uint32_t (*get_uint32) (uint32_t id, void *user_data);
+	const char *(*get_string) (uint32_t id, void *user_data);
 	GList *(*list_metadata) (void *user_data);
 	uint8_t (*get_status) (void *user_data);
 	uint32_t (*get_position) (void *user_data);
diff --git a/audio/media.c b/audio/media.c
index f2b5b2f..116e2cd 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1281,7 +1281,7 @@ static uint64_t get_uid(void *user_data)
 	return 0;
 }
 
-static void *get_metadata(uint32_t id, void *user_data)
+static const char *get_string(uint32_t id, void *user_data)
 {
 	struct media_player *mp = user_data;
 	struct metadata_value *value;
@@ -1295,16 +1295,32 @@ static void *get_metadata(uint32_t id, void *user_data)
 	if (!value)
 		return NULL;
 
-	switch (value->type) {
-	case DBUS_TYPE_STRING:
+	if (value->type == DBUS_TYPE_STRING)
 		return value->value.str;
-	case DBUS_TYPE_UINT32:
-		return GUINT_TO_POINTER(value->value.num);
-	}
 
 	return NULL;
 }
 
+static uint32_t get_uint32(uint32_t id, void *user_data)
+{
+	struct media_player *mp = user_data;
+	struct metadata_value *value;
+
+	DBG("%s", metadata_to_str(id));
+
+	if (mp->track == NULL)
+		return 0;
+
+	value = g_hash_table_lookup(mp->track, GUINT_TO_POINTER(id));
+	if (!value)
+		return 0;
+
+	if (value->type == DBUS_TYPE_UINT32)
+		return value->value.num;
+
+	return 0;
+}
+
 static uint8_t get_status(void *user_data)
 {
 	struct media_player *mp = user_data;
@@ -1360,7 +1376,8 @@ static struct avrcp_player_cb player_cb = {
 	.set_setting = set_setting,
 	.list_metadata = list_metadata,
 	.get_uid = get_uid,
-	.get_metadata = get_metadata,
+	.get_uint32 = get_uint32,
+	.get_string = get_string,
 	.get_position = get_position,
 	.get_status = get_status,
 	.set_volume = set_volume
-- 
1.7.11.4

