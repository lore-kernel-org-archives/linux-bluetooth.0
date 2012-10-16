Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] AVRCP: Don't respond with errors when no player is registered
Date: Tue, 16 Oct 2012 14:58:12 +0300
Message-Id: <1350388692-15239-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350388692-15239-1-git-send-email-luiz.dentz@gmail.com>
References: <1350388692-15239-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some devices w.g. Sony MW600 will stop using certain commands if an
error happen, so the code now just fake a player and once a real
player is registered it takes place of the fake one.
---
 audio/avrcp.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 17 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 5a18cb4..cd57358 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -493,6 +493,28 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	return;
 }
 
+static const char *player_get_string(struct avrcp_player *player, uint32_t attr)
+{
+	if (player != NULL)
+		return player->cb->get_string(attr, player->user_data);
+
+	if (attr == AVRCP_MEDIA_ATTRIBUTE_TITLE)
+		return "";
+
+	return NULL;
+}
+
+static uint32_t player_get_uint32(struct avrcp_player *player, uint32_t attr)
+{
+	if (player != NULL)
+		return player->cb->get_uint32(attr, player->user_data);
+
+	if (attr == AVRCP_MEDIA_ATTRIBUTE_DURATION)
+		return UINT32_MAX;
+
+	return 0;
+}
+
 static uint16_t player_write_media_attribute(struct avrcp_player *player,
 						uint32_t id, uint8_t *buf,
 						uint16_t *pos,
@@ -510,7 +532,7 @@ static uint16_t player_write_media_attribute(struct avrcp_player *player,
 	case AVRCP_MEDIA_ATTRIBUTE_TRACK:
 	case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
 	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
-		num = player->cb->get_uint32(id, player->user_data);
+		num = player_get_uint32(player, id);
 		if (num == 0)
 			break;
 
@@ -518,7 +540,7 @@ static uint16_t player_write_media_attribute(struct avrcp_player *player,
 		value = valstr;
 		break;
 	default:
-		value = player->cb->get_string(id, player->user_data);
+		value = player_get_string(player, id);
 	}
 
 	if (value == NULL) {
@@ -610,6 +632,9 @@ static int player_set_attribute(struct avrcp_player *player,
 {
 	DBG("Change attribute: %u %u", attr, val);
 
+	if (player == NULL)
+		return -ENOENT;
+
 	return player->cb->set_setting(attr, val, player->user_data);
 }
 
@@ -619,6 +644,9 @@ static int player_get_attribute(struct avrcp_player *player, uint8_t attr)
 
 	DBG("attr %u", attr);
 
+	if (player == NULL)
+		return -ENOENT;
+
 	value = player->cb->get_setting(attr, player->user_data);
 	if (value < 0)
 		DBG("attr %u not supported by player", attr);
@@ -675,7 +703,7 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp *session,
 	uint16_t len = ntohs(pdu->params_len);
 	unsigned int i;
 
-	if (len != 0 || player == NULL) {
+	if (len != 0) {
 		pdu->params_len = htons(1);
 		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 		return AVC_CTYPE_REJECTED;
@@ -707,7 +735,7 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp *session,
 	uint16_t len = ntohs(pdu->params_len);
 	unsigned int i;
 
-	if (len != 1 || player == NULL)
+	if (len != 1)
 		goto err;
 
 	if (player_get_attribute(player, pdu->params[0]) < 0)
@@ -729,6 +757,15 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static GList *player_list_metadata(struct avrcp_player *player)
+{
+	if (player != NULL)
+		return player->cb->list_metadata(player->user_data);
+
+	return g_list_prepend(NULL,
+				GUINT_TO_POINTER(AVRCP_MEDIA_ATTRIBUTE_TITLE));
+}
+
 static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -741,7 +778,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 	GList *attr_ids;
 	uint16_t offset;
 
-	if (len < 9 || identifier != 0 || player == NULL)
+	if (len < 9 || identifier != 0)
 		goto err;
 
 	nattr = pdu->params[8];
@@ -754,7 +791,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 		 * Return all available information, at least
 		 * title must be returned if there's a track selected.
 		 */
-		attr_ids = player->cb->list_metadata(player->user_data);
+		attr_ids = player_list_metadata(player);
 		len = g_list_length(attr_ids);
 	} else {
 		unsigned int i;
@@ -810,8 +847,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp *session,
 	uint8_t *settings;
 	unsigned int i;
 
-	if (player == NULL || len <= 1 || pdu->params[0] != len - 1 ||
-							player == NULL)
+	if (len <= 1 || pdu->params[0] != len - 1)
 		goto err;
 
 	/*
@@ -944,6 +980,14 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint32_t player_get_position(struct avrcp_player *player)
+{
+	if (player == NULL)
+		return 0;
+
+	return player->cb->get_position(player->user_data);
+}
+
 static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -953,17 +997,14 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 	uint32_t position;
 	uint32_t duration;
 
-	if (len != 0 || player == NULL) {
+	if (len != 0) {
 		pdu->params_len = htons(1);
 		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 		return AVC_CTYPE_REJECTED;
 	}
 
-	position = player->cb->get_position(player->user_data);
-	duration = player->cb->get_uint32(AVRCP_MEDIA_ATTRIBUTE_DURATION,
-							player->user_data);
-	if (duration == 0)
-		duration = UINT32_MAX;
+	position = player_get_position(player);
+	duration = player_get_uint32(player, AVRCP_MEDIA_ATTRIBUTE_DURATION);
 
 	position = htonl(position);
 	duration = htonl(duration);
@@ -977,6 +1018,22 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 	return AVC_CTYPE_STABLE;
 }
 
+static uint64_t player_get_uid(struct avrcp_player *player)
+{
+	if (player == NULL)
+		return UINT64_MAX;
+
+	return player->cb->get_status(player->user_data);
+}
+
+static uint8_t player_get_status(struct avrcp_player *player)
+{
+	if (player == NULL)
+		return AVRCP_PLAY_STATUS_STOPPED;
+
+	return player->cb->get_status(player->user_data);
+}
+
 static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -990,18 +1047,18 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	 * one is applicable only for EVENT_PLAYBACK_POS_CHANGED. See AVRCP
 	 * 1.3 spec, section 5.4.2.
 	 */
-	if (len != 5 || player == NULL)
+	if (len != 5)
 		goto err;
 
 	switch (pdu->params[0]) {
 	case AVRCP_EVENT_STATUS_CHANGED:
 		len = 2;
-		pdu->params[1] = player->cb->get_status(player->user_data);
+		pdu->params[1] = player_get_status(player);
 
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
 		len = 9;
-		uid = player->cb->get_uid(player->user_data);
+		uid = player_get_uid(player);
 		memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
 
 		break;
-- 
1.7.11.4

