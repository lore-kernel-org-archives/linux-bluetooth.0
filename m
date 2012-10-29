Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] AVRCP: Add initial support for controller player
Date: Mon, 29 Oct 2012 16:41:43 +0200
Message-Id: <1351521709-4063-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This also bump controller record to 1.3.
---
 audio/avrcp.c | 531 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 441 insertions(+), 90 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 57502ff..4f14513 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -190,6 +190,7 @@ struct avrcp {
 	int features;
 
 	void (*init) (struct avrcp *session);
+	void (*destroy) (struct avrcp *sesion);
 
 	const struct control_pdu_handler *control_handlers;
 
@@ -216,7 +217,7 @@ static uint32_t company_ids[] = {
 	IEEEID_BTSIG,
 };
 
-static void register_notification(struct avrcp *session, uint8_t event);
+static void avrcp_register_notification(struct avrcp *session, uint8_t event);
 
 static sdp_record_t *avrcp_ct_record(void)
 {
@@ -227,7 +228,7 @@ static sdp_record_t *avrcp_ct_record(void)
 	sdp_record_t *record;
 	sdp_data_t *psm, *version, *features;
 	uint16_t lp = AVCTP_CONTROL_PSM;
-	uint16_t avrcp_ver = 0x0100, avctp_ver = 0x0103;
+	uint16_t avrcp_ver = 0x0103, avctp_ver = 0x0103;
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 						AVRCP_FEATURE_CATEGORY_2 |
 						AVRCP_FEATURE_CATEGORY_3 |
@@ -431,20 +432,12 @@ static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
 	cid[2] = cid_in;
 }
 
-static int player_get_attribute(struct avrcp_player *player, uint8_t attr)
+static int player_get_setting(struct avrcp_player *player, uint8_t id)
 {
-	int value;
-
-	DBG("attr %u", attr);
-
 	if (player == NULL)
 		return -ENOENT;
 
-	value = player->cb->get_setting(attr, player->user_data);
-	if (value < 0)
-		DBG("attr %u not supported by player", attr);
-
-	return value;
+	return player->cb->get_setting(id, player->user_data);
 }
 
 void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
@@ -490,7 +483,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 			uint8_t attr = GPOINTER_TO_UINT(settings->data);
 			int val;
 
-			val = player_get_attribute(player, attr);
+			val = player_get_setting(player, attr);
 			if (val < 0)
 				continue;
 
@@ -643,14 +636,6 @@ static int player_set_setting(struct avrcp_player *player, uint8_t id,
 	return player->cb->set_setting(id, val, player->user_data);
 }
 
-static int player_get_setting(struct avrcp_player *player, uint8_t id)
-{
-	if (player == NULL)
-		return -ENOENT;
-
-	return player->cb->get_setting(id, player->user_data);
-}
-
 static uint8_t avrcp_handle_get_capabilities(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -1095,7 +1080,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 			uint8_t attr = GPOINTER_TO_UINT(settings->data);
 			int val;
 
-			val = player_get_attribute(player, attr);
+			val = player_get_setting(player, attr);
 			if (val < 0)
 				continue;
 
@@ -1357,6 +1342,319 @@ static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
 	return NULL;
 }
 
+static const char *status_to_string(uint8_t status)
+{
+	switch (status) {
+	case AVRCP_PLAY_STATUS_STOPPED:
+		return "stopped";
+	case AVRCP_PLAY_STATUS_PLAYING:
+		return "playing";
+	case AVRCP_PLAY_STATUS_PAUSED:
+		return "paused";
+	case AVRCP_PLAY_STATUS_FWD_SEEK:
+		return "forward-seek";
+	case AVRCP_PLAY_STATUS_REV_SEEK:
+		return "reverse-seek";
+	case AVRCP_PLAY_STATUS_ERROR:
+		return "error";
+	default:
+		return NULL;
+	}
+}
+
+static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_header *pdu = (void *) operands;
+	uint32_t duration;
+	uint32_t position;
+	uint8_t status;
+
+	if (code == AVC_CTYPE_REJECTED || ntohs(pdu->params_len) != 9)
+		return FALSE;
+
+	memcpy(&duration, pdu->params, sizeof(uint32_t));
+	duration = ntohl(duration);
+
+	memcpy(&position, pdu->params + 4, sizeof(uint32_t));
+	position = ntohl(position);
+
+	memcpy(&status, pdu->params + 8, sizeof(uint8_t));
+	DBG("%s", status_to_string(status));
+
+	return FALSE;
+}
+
+static void avrcp_get_play_status(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH];
+	struct avrcp_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_GET_PLAY_STATUS;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					avrcp_get_play_status_rsp,
+					session);
+}
+
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
+static gboolean avrcp_player_value_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t count;
+	int i;
+
+	if (code == AVC_CTYPE_REJECTED)
+		return FALSE;
+
+	count = pdu->params[0];
+
+	if (pdu->params_len < count * 2)
+		return FALSE;
+
+	for (i = 1; count > 0; count--, i += 2) {
+		const char *key;
+		const char *value;
+
+		key = attr_to_str(pdu->params[i]);
+		if (key == NULL)
+			continue;
+
+		value = attrval_to_str(pdu->params[i], pdu->params[i + 1]);
+		if (value == NULL)
+			continue;
+
+		DBG("%s: %s", key, value);
+	}
+
+	return FALSE;
+}
+
+static void avrcp_get_current_player_value(struct avrcp *session,
+						uint8_t *attrs, uint8_t count)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 5];
+	struct avrcp_header *pdu = (void *) buf;
+	int i;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_GET_CURRENT_PLAYER_VALUE;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params_len = htons(count + 1);
+	pdu->params[0] = count;
+
+	for (i = 0; count > 0; count--, i++)
+		pdu->params[i + 1] = attrs[i];
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					avrcp_player_value_rsp, session);
+}
+
+static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t count;
+
+	if (code == AVC_CTYPE_REJECTED)
+		return FALSE;
+
+	count = pdu->params[0];
+
+	if (ntohs(pdu->params_len) < count) {
+		error("Invalid parameters");
+		return FALSE;
+	}
+
+	avrcp_get_current_player_value(session, &pdu->params[1],
+							pdu->params[0]);
+
+	return FALSE;
+}
+
+static void avrcp_list_player_attributes(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH];
+	struct avrcp_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_LIST_PLAYER_ATTRIBUTES;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
+					avrcp_list_player_attributes_rsp,
+					session);
+}
+
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
+static gboolean avrcp_get_attributes_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_header *pdu = (void *) operands;
+	uint8_t count;
+	int i;
+
+	if (code == AVC_CTYPE_REJECTED)
+		return FALSE;
+
+	count = pdu->params[0];
+
+	if (ntohs(pdu->params_len) - 1 < count * 8) {
+		error("Invalid parameters");
+		return FALSE;
+	}
+
+	for (i = 1; count > 0; count--) {
+		uint32_t id;
+		uint16_t charset, len;
+
+		memcpy(&id, &pdu->params[i], sizeof(uint32_t));
+		id = ntohl(id);
+		i += sizeof(uint32_t);
+
+		memcpy(&charset, &pdu->params[i], sizeof(uint16_t));
+		charset = ntohs(charset);
+		i += sizeof(uint16_t);
+
+		memcpy(&len, &pdu->params[i], sizeof(uint16_t));
+		len = ntohs(len);
+		i += sizeof(uint16_t);
+
+		if (charset == 106) {
+			const char *key = metadata_to_str(id);
+			char *value = g_strndup((char *) &pdu->params[i], len);
+
+			DBG("%s: %s", key , value);
+			g_free(value);
+		}
+
+		i += len;
+	}
+
+	return FALSE;
+}
+
+static void avrcp_get_element_attributes(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 9];
+	struct avrcp_header *pdu = (void *) buf;
+	uint16_t length;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_GET_ELEMENT_ATTRIBUTES;
+	pdu->params_len = htons(9);
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, length,
+					avrcp_get_attributes_rsp,
+					session);
+}
+
 static gboolean avrcp_handle_event(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -1366,7 +1664,9 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 	struct avrcp_player *player = session->player;
 	struct avrcp_header *pdu = (void *) operands;
 	uint8_t event;
-	uint8_t volume;
+	uint8_t value;
+	uint8_t count;
+	int i;
 
 	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
 		return FALSE;
@@ -1375,24 +1675,58 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 
 	switch (event) {
 	case AVRCP_EVENT_VOLUME_CHANGED:
-		volume = pdu->params[1] & 0x7F;
+		value = pdu->params[1] & 0x7F;
 
 		if (player)
-			player->cb->set_volume(volume, session->dev,
+			player->cb->set_volume(value, session->dev,
 							player->user_data);
 
 		break;
+	case AVRCP_EVENT_STATUS_CHANGED:
+		value = pdu->params[1];
+
+		avrcp_get_play_status(session);
+
+		break;
+	case AVRCP_EVENT_TRACK_CHANGED:
+		avrcp_get_element_attributes(session);
+
+		break;
+
+	case AVRCP_EVENT_SETTINGS_CHANGED:
+		count = pdu->params[1];
+
+		for (i = 2; count > 0; count--, i += 2) {
+			const char *key;
+			const char *value;
+
+			key = attr_to_str(pdu->params[i]);
+			if (key == NULL)
+				continue;
+
+			value = attrval_to_str(pdu->params[i],
+						pdu->params[i + 1]);
+			if (value == NULL)
+				continue;
+
+			DBG("%s: %s", key, value);
+		}
+
+		break;
 	}
 
 	if (code == AVC_CTYPE_CHANGED) {
-		register_notification(session, event);
+		session->registered_events ^= (1 << event);
+		avrcp_register_notification(session, event);
 		return FALSE;
 	}
 
+	session->registered_events |= (1 << event);
+
 	return TRUE;
 }
 
-static void register_notification(struct avrcp *session, uint8_t event)
+static void avrcp_register_notification(struct avrcp *session, uint8_t event)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
 	struct avrcp_header *pdu = (void *) buf;
@@ -1420,6 +1754,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 {
 	struct avrcp *session = user_data;
 	struct avrcp_header *pdu = (void *) operands;
+	uint16_t events = 0;
 	uint8_t count;
 
 	if (pdu->params[0] != CAP_EVENTS_SUPPORTED)
@@ -1430,14 +1765,26 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 	for (; count > 0; count--) {
 		uint8_t event = pdu->params[1 + count];
 
+		events |= (1 << event);
+
 		switch (event) {
 		case AVRCP_EVENT_STATUS_CHANGED:
 		case AVRCP_EVENT_TRACK_CHANGED:
-			register_notification(session, event);
+		case AVRCP_EVENT_SETTINGS_CHANGED:
+			avrcp_register_notification(session, event);
 			break;
 		}
 	}
 
+	if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
+		avrcp_list_player_attributes(session);
+
+	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
+		avrcp_get_play_status(session);
+
+	if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
+		avrcp_get_element_attributes(session);
+
 	return FALSE;
 }
 
@@ -1463,31 +1810,6 @@ static void avrcp_get_capabilities(struct avrcp *session)
 					session);
 }
 
-static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
-					uint8_t code, uint8_t subunit,
-					uint8_t *operands, size_t operand_count,
-					void *user_data)
-{
-	return FALSE;
-}
-
-static void avrcp_get_play_status(struct avrcp *session)
-{
-	uint8_t buf[AVRCP_HEADER_LENGTH];
-	struct avrcp_header *pdu = (void *) buf;
-
-	memset(buf, 0, sizeof(buf));
-
-	set_company_id(pdu->company_id, IEEEID_BTSIG);
-	pdu->pdu_id = AVRCP_GET_PLAY_STATUS;
-	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
-
-	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
-					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
-					avrcp_get_play_status_rsp,
-					session);
-}
-
 static struct avrcp *find_session(GSList *list, struct audio_device *dev)
 {
 	for (; list; list = list->next) {
@@ -1516,7 +1838,8 @@ static void session_tg_init(struct avrcp *session)
 	session->control_handlers = tg_control_handlers;
 
 	if (session->version >= 0x0104) {
-		register_notification(session, AVRCP_EVENT_VOLUME_CHANGED);
+		avrcp_register_notification(session,
+						AVRCP_EVENT_VOLUME_CHANGED);
 		if (session->features & AVRCP_FEATURE_BROWSING)
 			avctp_connect_browsing(session->conn);
 	}
@@ -1533,19 +1856,75 @@ static void session_tg_init(struct avrcp *session)
 
 static void session_ct_init(struct avrcp *session)
 {
+	struct avrcp_player *player;
+
 	session->control_handlers = ct_control_handlers;
 
 	DBG("%p version 0x%04x", session, session->version);
 
-	if (session->version >= 0x0103) {
-		avrcp_get_capabilities(session);
-		avrcp_get_play_status(session);
-	}
-
 	session->control_id = avctp_register_pdu_handler(session->conn,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							session);
+
+	if (session->version < 0x0103)
+		return;
+
+	player = g_new0(struct avrcp_player, 1);
+	player->sessions = g_slist_prepend(player->sessions, session);
+	session->player = player;
+
+	avrcp_get_capabilities(session);
+}
+
+static void session_destroy(struct avrcp *session)
+{
+	struct avrcp_server *server = session->server;
+
+	server->sessions = g_slist_remove(server->sessions, session);
+
+	if (session->control_id > 0)
+		avctp_unregister_pdu_handler(session->control_id);
+
+	if (session->browsing_id > 0)
+		avctp_unregister_browsing_pdu_handler(session->browsing_id);
+
+	g_free(session);
+}
+
+static void session_tg_destroy(struct avrcp *session)
+{
+	struct avrcp_player *player = session->player;
+
+	DBG("%p", session);
+
+	if (player != NULL)
+		player->sessions = g_slist_remove(player->sessions, session);
+
+	session_destroy(session);
+}
+
+static void player_destroy(gpointer data)
+{
+	struct avrcp_player *player = data;
+
+	if (player->destroy)
+		player->destroy(player->user_data);
+
+	g_slist_free(player->sessions);
+	g_free(player);
+}
+
+static void session_ct_destroy(struct avrcp *session)
+{
+	struct avrcp_player *player = session->player;
+
+	DBG("%p", session);
+
+	if (player != NULL)
+		player_destroy(player);
+
+	session_destroy(session);
 }
 
 static struct avrcp *session_create(struct avrcp_server *server,
@@ -1574,9 +1953,11 @@ static struct avrcp *session_create(struct avrcp_server *server,
 
 	if (session->target) {
 		session->init = session_tg_init;
+		session->destroy = session_tg_destroy;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
 	} else {
 		session->init = session_ct_init;
+		session->destroy = session_ct_destroy;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
 	}
 
@@ -1595,25 +1976,6 @@ static struct avrcp *session_create(struct avrcp_server *server,
 	return session;
 }
 
-static void session_destroy(struct avrcp *session)
-{
-	struct avrcp_server *server = session->server;
-	struct avrcp_player *player = session->player;
-
-	server->sessions = g_slist_remove(server->sessions, session);
-
-	if (session->control_id > 0)
-		avctp_unregister_pdu_handler(session->control_id);
-
-	if (session->browsing_id > 0)
-		avctp_unregister_browsing_pdu_handler(session->browsing_id);
-
-	if (player != NULL)
-		player->sessions = g_slist_remove(player->sessions, session);
-
-	g_free(session);
-}
-
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 				avctp_state_t new_state, void *user_data)
 {
@@ -1631,7 +1993,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (session == NULL)
 			break;
 
-		session_destroy(session);
+		session->destroy(session);
 
 		break;
 	case AVCTP_STATE_CONNECTING:
@@ -1740,17 +2102,6 @@ int avrcp_register(const bdaddr_t *src, GKeyFile *config)
 	return 0;
 }
 
-static void player_destroy(gpointer data)
-{
-	struct avrcp_player *player = data;
-
-	if (player->destroy)
-		player->destroy(player->user_data);
-
-	g_slist_free(player->sessions);
-	g_free(player);
-}
-
 void avrcp_unregister(const bdaddr_t *src)
 {
 	struct avrcp_server *server;
-- 
1.7.11.7

