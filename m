Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/11] AVRCP: Don't respond with errors when no player is registered
Date: Thu, 25 Oct 2012 16:59:06 +0300
Message-Id: <1351173554-28039-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some devices w.g. Sony MW600 will stop using certain commands if an
error happen, so the code now just fake a player and once a real
player is registered it takes place of the fake one.
---
 audio/avrcp.c | 117 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 33 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index fe304d1..a14833a 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -493,6 +493,17 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	return;
 }
 
+static const char *player_get_metadata(struct avrcp_player *player, uint32_t attr)
+{
+	if (player != NULL)
+		return player->cb->get_metadata(attr, player->user_data);
+
+	if (attr == AVRCP_MEDIA_ATTRIBUTE_TITLE)
+		return "";
+
+	return NULL;
+}
+
 static uint16_t player_write_media_attribute(struct avrcp_player *player,
 						uint32_t id, uint8_t *buf,
 						uint16_t *pos,
@@ -504,7 +515,7 @@ static uint16_t player_write_media_attribute(struct avrcp_player *player,
 
 	DBG("%u", id);
 
-	value = player->cb->get_metadata(id, player->user_data);
+	value = player_get_metadata(player, id);
 	if (value == NULL) {
 		*offset = 0;
 		return 0;
@@ -589,25 +600,21 @@ static gboolean session_abort_pending_pdu(struct avrcp *session)
 	return TRUE;
 }
 
-static int player_set_attribute(struct avrcp_player *player,
-						uint8_t attr, uint8_t val)
+static int player_set_setting(struct avrcp_player *player, uint8_t id,
+								uint8_t val)
 {
-	DBG("Change attribute: %u %u", attr, val);
+	if (player == NULL)
+		return -ENOENT;
 
-	return player->cb->set_setting(attr, val, player->user_data);
+	return player->cb->set_setting(id, val, player->user_data);
 }
 
-static int player_get_attribute(struct avrcp_player *player, uint8_t attr)
+static int player_get_setting(struct avrcp_player *player, uint8_t id)
 {
-	int value;
-
-	DBG("attr %u", attr);
-
-	value = player->cb->get_setting(attr, player->user_data);
-	if (value < 0)
-		DBG("attr %u not supported by player", attr);
+	if (player == NULL)
+		return -ENOENT;
 
-	return value;
+	return player->cb->get_setting(id, player->user_data);
 }
 
 static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
@@ -659,7 +666,7 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp *session,
 	uint16_t len = ntohs(pdu->params_len);
 	unsigned int i;
 
-	if (len != 0 || player == NULL) {
+	if (len != 0) {
 		pdu->params_len = htons(1);
 		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 		return AVC_CTYPE_REJECTED;
@@ -669,7 +676,7 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp *session,
 		goto done;
 
 	for (i = 1; i <= AVRCP_ATTRIBUTE_SCAN; i++) {
-		if (player_get_attribute(player, i) < 0)
+		if (player_get_setting(player, i) < 0)
 			continue;
 
 		len++;
@@ -691,10 +698,10 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp *session,
 	uint16_t len = ntohs(pdu->params_len);
 	unsigned int i;
 
-	if (len != 1 || player == NULL)
+	if (len != 1)
 		goto err;
 
-	if (player_get_attribute(player, pdu->params[0]) < 0)
+	if (player_get_setting(player, pdu->params[0]) < 0)
 		goto err;
 
 	len = attr_get_max_val(pdu->params[0]);
@@ -713,6 +720,15 @@ err:
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
@@ -725,7 +741,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 	GList *attr_ids;
 	uint16_t offset;
 
-	if (len < 9 || identifier != 0 || player == NULL)
+	if (len < 9 || identifier != 0)
 		goto err;
 
 	nattr = pdu->params[8];
@@ -738,7 +754,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 		 * Return all available information, at least
 		 * title must be returned if there's a track selected.
 		 */
-		attr_ids = player->cb->list_metadata(player->user_data);
+		attr_ids = player_list_metadata(player);
 		len = g_list_length(attr_ids);
 	} else {
 		unsigned int i;
@@ -794,8 +810,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp *session,
 	uint8_t *settings;
 	unsigned int i;
 
-	if (player == NULL || len <= 1 || pdu->params[0] != len - 1 ||
-							player == NULL)
+	if (len <= 1 || pdu->params[0] != len - 1)
 		goto err;
 
 	/*
@@ -819,7 +834,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp *session,
 			continue;
 		}
 
-		val = player_get_attribute(player, settings[i]);
+		val = player_get_setting(player, settings[i]);
 		if (val < 0)
 			continue;
 
@@ -866,7 +881,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp *session,
 	 */
 	for (len = 0, i = 0, param = &pdu->params[1]; i < pdu->params[0];
 							i++, param += 2) {
-		if (player_set_attribute(player, param[0], param[1]) < 0)
+		if (player_set_setting(player, param[0], param[1]) < 0)
 			continue;
 
 		len++;
@@ -928,6 +943,36 @@ err:
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
+static uint32_t player_get_duration(struct avrcp_player *player)
+{
+	uint32_t num;
+
+	if (player == NULL)
+		return UINT32_MAX;
+
+	num = player->cb->get_duration(player->user_data);
+	if (num == 0)
+		return UINT32_MAX;
+
+	return num;
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
 static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -937,29 +982,35 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 	uint32_t position;
 	uint32_t duration;
 
-	if (len != 0 || player == NULL) {
+	if (len != 0) {
 		pdu->params_len = htons(1);
 		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
 		return AVC_CTYPE_REJECTED;
 	}
 
-	position = player->cb->get_position(player->user_data);
-	duration = player->cb->get_duration(player->user_data);
-	if (duration == 0)
-		duration = UINT32_MAX;
+	position = player_get_position(player);
+	duration = player_get_duration(player);
 
 	position = htonl(position);
 	duration = htonl(duration);
 
 	memcpy(&pdu->params[0], &duration, 4);
 	memcpy(&pdu->params[4], &position, 4);
-	pdu->params[8] = player->cb->get_status(player->user_data);;
+	pdu->params[8] = player_get_status(player);;
 
 	pdu->params_len = htons(9);
 
 	return AVC_CTYPE_STABLE;
 }
 
+static uint64_t player_get_uid(struct avrcp_player *player)
+{
+	if (player == NULL)
+		return UINT64_MAX;
+
+	return player->cb->get_uid(player->user_data);
+}
+
 static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -973,18 +1024,18 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
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
1.7.11.7

