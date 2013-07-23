Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] audio/AVRCP: Rework role detection
Date: Tue, 23 Jul 2013 15:52:29 +0300
Message-Id: <1374583952-16361-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes AVRCP agnostic to any roles so the same session can be used
both for controller and target role.
---
 profiles/audio/avrcp.c | 427 +++++++++++++++++++++++++------------------------
 1 file changed, 219 insertions(+), 208 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index cd0a736..ad7742d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -209,19 +209,19 @@ struct avrcp_player {
 	GDestroyNotify destroy;
 };
 
-struct avrcp {
-	struct avrcp_server *server;
-	struct avctp *conn;
-	struct btd_device *dev;
+struct avrcp_data {
 	struct avrcp_player *player;
-	gboolean target;
 	uint16_t version;
 	int features;
 	GSList *players;
+};
 
-	void (*init_control) (struct avrcp *session);
-	void (*init_browsing) (struct avrcp *session);
-	void (*destroy) (struct avrcp *sesion);
+struct avrcp {
+	struct avrcp_server *server;
+	struct avctp *conn;
+	struct btd_device *dev;
+	struct avrcp_data *target;
+	struct avrcp_data *controller;
 
 	const struct passthrough_handler *passthrough_handlers;
 	const struct control_pdu_handler *control_handlers;
@@ -937,7 +937,7 @@ static uint8_t avrcp_handle_list_player_attributes(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	uint16_t len = ntohs(pdu->params_len);
 	unsigned int i;
 
@@ -969,7 +969,7 @@ static uint8_t avrcp_handle_list_player_values(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	uint16_t len = ntohs(pdu->params_len);
 	unsigned int i;
 
@@ -1038,7 +1038,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t identifier = bt_get_le64(&pdu->params[0]);
 	uint16_t pos;
@@ -1110,7 +1110,7 @@ static uint8_t avrcp_handle_get_current_player_value(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	uint16_t len = ntohs(pdu->params_len);
 	uint8_t *settings;
 	unsigned int i;
@@ -1169,7 +1169,7 @@ static uint8_t avrcp_handle_set_player_value(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	uint16_t len = ntohs(pdu->params_len);
 	unsigned int i;
 	uint8_t *param;
@@ -1288,7 +1288,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	uint16_t len = ntohs(pdu->params_len);
 	uint32_t position;
 	uint32_t duration;
@@ -1332,9 +1332,9 @@ static GList *player_list_settings(struct avrcp_player *player)
 
 static bool avrcp_handle_play(struct avrcp *session)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 
-	if (session->player == NULL)
+	if (player == NULL)
 		return false;
 
 	return player->cb->play(player->user_data);
@@ -1342,9 +1342,9 @@ static bool avrcp_handle_play(struct avrcp *session)
 
 static bool avrcp_handle_stop(struct avrcp *session)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 
-	if (session->player == NULL)
+	if (player == NULL)
 		return false;
 
 	return player->cb->stop(player->user_data);
@@ -1352,9 +1352,9 @@ static bool avrcp_handle_stop(struct avrcp *session)
 
 static bool avrcp_handle_pause(struct avrcp *session)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 
-	if (session->player == NULL)
+	if (player == NULL)
 		return false;
 
 	return player->cb->pause(player->user_data);
@@ -1362,9 +1362,9 @@ static bool avrcp_handle_pause(struct avrcp *session)
 
 static bool avrcp_handle_next(struct avrcp *session)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 
-	if (session->player == NULL)
+	if (player == NULL)
 		return false;
 
 	return player->cb->next(player->user_data);
@@ -1372,15 +1372,15 @@ static bool avrcp_handle_next(struct avrcp *session)
 
 static bool avrcp_handle_previous(struct avrcp *session)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 
-	if (session->player == NULL)
+	if (player == NULL)
 		return false;
 
 	return player->cb->previous(player->user_data);
 }
 
-static const struct passthrough_handler tg_passthrough_handlers[] = {
+static const struct passthrough_handler passthrough_handlers[] = {
 		{ AVC_PLAY, avrcp_handle_play },
 		{ AVC_STOP, avrcp_handle_stop },
 		{ AVC_PAUSE, avrcp_handle_pause },
@@ -1415,7 +1415,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	struct btd_device *dev = session->dev;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
@@ -1441,7 +1441,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
 		len = 9;
-		uid = player_get_uid(player);
+		uid = player_get_uid(session->target->player);
 		memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
 
 		break;
@@ -1473,9 +1473,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 
 		break;
 	case AVRCP_EVENT_VOLUME_CHANGED:
-		if (session->version < 0x0104)
-			goto err;
-
 		pdu->params[1] = media_transport_get_device_volume(dev);
 		if (pdu->params[1] > 127)
 			goto err;
@@ -1506,7 +1503,7 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	uint16_t len = ntohs(pdu->params_len);
 	struct pending_pdu *pending;
 
@@ -1573,7 +1570,7 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	uint16_t len = ntohs(pdu->params_len);
 	uint8_t volume;
 
@@ -1597,7 +1594,7 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
-static const struct control_pdu_handler tg_control_handlers[] = {
+static const struct control_pdu_handler control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_capabilities },
 		{ AVRCP_LIST_PLAYER_ATTRIBUTES, AVC_CTYPE_STATUS,
@@ -1622,6 +1619,8 @@ static const struct control_pdu_handler tg_control_handlers[] = {
 					avrcp_handle_get_play_status },
 		{ AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
 					avrcp_handle_register_notification },
+		{ AVRCP_SET_ABSOLUTE_VOLUME, AVC_CTYPE_CONTROL,
+					avrcp_handle_set_absolute_volume },
 		{ AVRCP_REQUEST_CONTINUING, AVC_CTYPE_CONTROL,
 					avrcp_handle_request_continuing },
 		{ AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
@@ -1629,16 +1628,6 @@ static const struct control_pdu_handler tg_control_handlers[] = {
 		{ },
 };
 
-static const struct control_pdu_handler ct_control_handlers[] = {
-		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
-					avrcp_handle_get_capabilities },
-		{ AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
-					avrcp_handle_register_notification },
-		{ AVRCP_SET_ABSOLUTE_VOLUME, AVC_CTYPE_CONTROL,
-					avrcp_handle_set_absolute_volume },
-		{ },
-};
-
 /* handle vendordep pdu inside an avctp packet */
 static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
@@ -1796,7 +1785,7 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	struct avrcp_header *pdu = (void *) operands;
 	uint32_t duration;
@@ -1860,7 +1849,7 @@ static gboolean avrcp_player_value_rsp(struct avctp *conn,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	struct avrcp_header *pdu = (void *) operands;
 	uint8_t count;
@@ -2007,7 +1996,7 @@ static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
 						void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct avrcp_header *pdu = (void *) operands;
 	uint8_t count;
 
@@ -2122,7 +2111,7 @@ static struct media_item *parse_media_element(struct avrcp *session,
 		name[namelen] = '\0';
 	}
 
-	player = session->player;
+	player = session->controller->player;
 	mp = player->user_data;
 
 	item = media_player_create_item(mp, name, PLAYER_ITEM_TYPE_AUDIO, uid);
@@ -2137,7 +2126,7 @@ static struct media_item *parse_media_element(struct avrcp *session,
 static struct media_item *parse_media_folder(struct avrcp *session,
 					uint8_t *operands, uint16_t len)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	uint16_t namelen;
 	char name[255];
@@ -2166,7 +2155,7 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 {
 	struct avrcp_browsing_header *pdu = (void *) operands;
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct pending_list_items *p = player->p;
 	uint16_t count;
 	uint32_t items, total;
@@ -2250,7 +2239,7 @@ static void avrcp_list_items(struct avrcp *session, uint32_t start,
 {
 	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 10 +
 			AVRCP_MEDIA_ATTRIBUTE_LAST * sizeof(uint32_t)];
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct avrcp_browsing_header *pdu = (void *) buf;
 	uint16_t length = AVRCP_BROWSING_HEADER_LENGTH + 10;
 	uint32_t attribute;
@@ -2284,7 +2273,7 @@ static gboolean avrcp_change_path_rsp(struct avctp *conn,
 {
 	struct avrcp_browsing_header *pdu = (void *) operands;
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	int ret;
 
@@ -2321,7 +2310,7 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 						void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	struct avrcp_browsing_header *pdu = (void *) operands;
 	uint32_t items;
@@ -2390,7 +2379,7 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 						void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct avrcp_browsing_header *pdu = (void *) operands;
 	uint8_t count;
 
@@ -2420,6 +2409,7 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 
 static void avrcp_get_item_attributes(struct avrcp *session, uint64_t uid)
 {
+	struct avrcp_player *player = session->controller->player;
 	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 12];
 	struct avrcp_browsing_header *pdu = (void *) buf;
 
@@ -2428,7 +2418,7 @@ static void avrcp_get_item_attributes(struct avrcp *session, uint64_t uid)
 	pdu->pdu_id = AVRCP_GET_ITEM_ATTRIBUTES;
 	pdu->params[0] = 0x03;
 	bt_put_be64(uid, &pdu->params[1]);
-	bt_put_be16(session->player->uid_counter, &pdu->params[9]);
+	bt_put_be16(player->uid_counter, &pdu->params[9]);
 	pdu->param_len = htons(12);
 
 	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
@@ -2494,7 +2484,7 @@ static bool ct_set_setting(struct media_player *mp, const char *key,
 	if (session == NULL)
 		return false;
 
-	if (session->version < 0x0103)
+	if (session->controller->version < 0x0103)
 		return false;
 
 	attr = attr_to_val(key);
@@ -2607,7 +2597,7 @@ static int ct_list_items(struct media_player *mp, const char *name,
 static void avrcp_change_path(struct avrcp *session, uint8_t direction,
 								uint64_t uid)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 11];
 	struct avrcp_browsing_header *pdu = (void *) buf;
 
@@ -2644,7 +2634,7 @@ static gboolean avrcp_search_rsp(struct avctp *conn, uint8_t *operands,
 {
 	struct avrcp_browsing_header *pdu = (void *) operands;
 	struct avrcp *session = (void *) user_data;
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	int ret;
 
@@ -2704,7 +2694,7 @@ static int ct_search(struct media_player *mp, const char *string,
 static void avrcp_play_item(struct avrcp *session, uint64_t uid)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + 11];
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct avrcp_header *pdu = (void *) buf;
 	uint16_t length;
 
@@ -2750,7 +2740,7 @@ static int ct_play_item(struct media_player *mp, const char *name,
 static void avrcp_add_to_nowplaying(struct avrcp *session, uint64_t uid)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + 11];
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct avrcp_header *pdu = (void *) buf;
 	uint16_t length;
 
@@ -2829,10 +2819,12 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
 	player->user_data = mp;
 	player->destroy = (GDestroyNotify) media_player_destroy;
 
-	if (session->player == NULL)
-		session->player = player;
+	if (session->controller->player == NULL)
+		session->controller->player = player;
 
-	session->players = g_slist_prepend(session->players, player);
+	session->controller->players = g_slist_prepend(
+						session->controller->players,
+						player);
 
 	return player;
 }
@@ -2841,7 +2833,7 @@ static struct avrcp_player *find_ct_player(struct avrcp *session, uint16_t id)
 {
 	GSList *l;
 
-	for (l = session->players; l; l = l->next) {
+	for (l = session->controller->players; l; l = l->next) {
 		struct avrcp_player *player = l->data;
 
 		if (player->id == 0) {
@@ -2905,7 +2897,7 @@ avrcp_parse_media_player_item(struct avrcp *session, uint8_t *operands,
 		media_player_set_name(mp, name);
 	}
 
-	if (session->player == player && !player->browsed)
+	if (session->controller->player == player && !player->browsed)
 		avrcp_set_browsed_player(session, player);
 
 	return player;
@@ -2933,7 +2925,9 @@ static void player_remove(gpointer data)
 	for (l = player->sessions; l; l = l->next) {
 		struct avrcp *session = l->data;
 
-		session->players = g_slist_remove(session->players, player);
+		session->controller->players = g_slist_remove(
+						session->controller->players,
+						player);
 	}
 
 	player_destroy(player);
@@ -2954,7 +2948,7 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 							operand_count < 5)
 		return FALSE;
 
-	removed = g_slist_copy(session->players);
+	removed = g_slist_copy(session->controller->players);
 	count = bt_get_be16(&operands[6]);
 
 	for (i = 8; count && i < operand_count; count--) {
@@ -2984,8 +2978,8 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 		i += len;
 	}
 
-	if (g_slist_find(removed, session->player))
-		session->player = NULL;
+	if (g_slist_find(removed, session->controller->player))
+		session->controller->player = NULL;
 
 	g_slist_free_full(removed, player_remove);
 
@@ -3009,7 +3003,7 @@ static void avrcp_get_media_player_list(struct avrcp *session)
 static void avrcp_volume_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	uint8_t volume;
 
 	if (player == NULL)
@@ -3023,7 +3017,7 @@ static void avrcp_volume_changed(struct avrcp *session,
 static void avrcp_status_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	uint8_t value;
 	const char *curval, *strval;
@@ -3044,7 +3038,7 @@ static void avrcp_track_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
 	if (session->browsing_id) {
-		struct avrcp_player *player = session->player;
+		struct avrcp_player *player = session->controller->player;
 		player->uid = bt_get_be64(&pdu->params[1]);
 		avrcp_get_item_attributes(session, player->uid);
 	} else
@@ -3054,7 +3048,7 @@ static void avrcp_track_changed(struct avrcp *session,
 static void avrcp_setting_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	struct media_player *mp = player->user_data;
 	uint8_t count = pdu->params[1];
 	int i;
@@ -3084,7 +3078,7 @@ static void avrcp_available_players_changed(struct avrcp *session,
 static void avrcp_addressed_player_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 	uint16_t id = bt_get_be16(&pdu->params[1]);
 
 	if (player != NULL && player->id == id)
@@ -3098,7 +3092,7 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 	}
 
 	player->uid_counter = bt_get_be16(&pdu->params[3]);
-	session->player = player;
+	session->controller->player = player;
 
 	if (player->features != NULL)
 		return;
@@ -3108,7 +3102,7 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 
 static void avrcp_uids_changed(struct avrcp *session, struct avrcp_header *pdu)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->controller->player;
 
 	player->uid_counter = bt_get_be16(&pdu->params[1]);
 }
@@ -3269,7 +3263,7 @@ static void destroy_browsing(void *data)
 	session->browsing_id = 0;
 }
 
-static void session_tg_init_browsing(struct avrcp *session)
+static void session_init_browsing(struct avrcp *session)
 {
 	session->browsing_id = avctp_register_browsing_pdu_handler(
 							session->conn,
@@ -3278,154 +3272,212 @@ static void session_tg_init_browsing(struct avrcp *session)
 							destroy_browsing);
 }
 
-static void session_tg_init_control(struct avrcp *session)
+static struct avrcp_data *data_init(struct avrcp *session, const char *uuid)
+{
+	struct avrcp_data *data;
+	const sdp_record_t *rec;
+	sdp_list_t *list;
+	sdp_profile_desc_t *desc;
+
+	data = g_new0(struct avrcp_data, 1);
+
+	rec = btd_device_get_record(session->dev, uuid);
+	if (rec == NULL)
+		return data;
+
+	if (sdp_get_profile_descs(rec, &list) == 0) {
+		desc = list->data;
+		data->version = desc->version;
+	}
+
+	sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES, &data->features);
+	sdp_list_free(list, free);
+
+	return data;
+}
+
+static void target_init(struct avrcp *session)
 {
 	struct avrcp_server *server = session->server;
+	struct avrcp_data *target;
 	struct avrcp_player *player;
 	struct btd_service *service;
+	btd_service_state_t old_state = BTD_SERVICE_STATE_UNAVAILABLE;
 
-	if (session->version < 0x0103)
+	if (session->target != NULL)
 		return;
 
-	DBG("%p version 0x%04x", session, session->version);
+	target = data_init(session, AVRCP_REMOTE_UUID);
+	session->target = target;
+
+	DBG("%p version 0x%04x", target, target->version);
+
+	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
+	if (service != NULL) {
+		old_state = btd_service_get_state(service);
+		btd_service_connecting_complete(service, 0);
+	}
+
+	if (target->version < 0x0103)
+		return;
 
 	player = g_slist_nth_data(server->players, 0);
 	if (player != NULL) {
-		session->player = player;
+		target->player = player;
 		player->sessions = g_slist_prepend(player->sessions, session);
 	}
 
-	session->passthrough_id = avctp_register_passthrough_handler(
-							session->conn,
-							handle_passthrough,
-							session);
-	session->passthrough_handlers = tg_passthrough_handlers;
-	session->control_id = avctp_register_pdu_handler(session->conn,
-							AVC_OP_VENDORDEP,
-							handle_vendordep_pdu,
-							session);
-	session->control_handlers = tg_control_handlers;
-	session->supported_events = (1 << AVRCP_EVENT_STATUS_CHANGED) |
+	session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
 				(1 << AVRCP_EVENT_TRACK_CHANGED) |
 				(1 << AVRCP_EVENT_TRACK_REACHED_START) |
 				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
 				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
 
-	if (session->version >= 0x0104)
-		avrcp_register_notification(session,
-						AVRCP_EVENT_VOLUME_CHANGED);
+	if (target->version < 0x0104)
+		return;
 
-	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
-	if (service != NULL)
-		btd_service_connecting_complete(service, 0);
-}
+	avrcp_register_notification(session, AVRCP_EVENT_VOLUME_CHANGED);
 
-static void session_ct_init_browsing(struct avrcp *session)
-{
-	session->browsing_id = avctp_register_browsing_pdu_handler(
-							session->conn,
-							handle_browsing_pdu,
-							session,
-							destroy_browsing);
+	/* Auto-connect browsing channel only if initiator */
+	if (old_state == BTD_SERVICE_STATE_CONNECTING &&
+				target->features & AVRCP_FEATURE_BROWSING)
+		avctp_connect_browsing(session->conn);
 }
 
-static void session_ct_init_control(struct avrcp *session)
+static void controller_init(struct avrcp *session)
 {
 	struct avrcp_player *player;
 	struct btd_service *service;
+	struct avrcp_data *controller;
+	btd_service_state_t old_state = BTD_SERVICE_STATE_UNAVAILABLE;
 
-	DBG("%p version 0x%04x", session, session->version);
+	if (session->controller != NULL)
+		return;
 
-	session->control_id = avctp_register_pdu_handler(session->conn,
-							AVC_OP_VENDORDEP,
-							handle_vendordep_pdu,
-							session);
-	session->control_handlers = ct_control_handlers;
-	if (session->version >= 0x0104)
-		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
+	controller = data_init(session, AVRCP_TARGET_UUID);
+	session->controller = controller;
+
+	DBG("%p version 0x%04x", controller, controller->version);
+
+	if (controller->version >= 0x0104)
+		session->supported_events |= (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
 	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
-	if (service != NULL)
+	if (service != NULL) {
+		old_state = btd_service_get_state(service);
 		btd_service_connecting_complete(service, 0);
+	}
+
+	/* Only create player if category 1 is supported */
+	if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
+		return;
 
 	player = create_ct_player(session, 0);
 	if (player == NULL)
 		return;
 
-	if (session->version < 0x0103)
+	if (controller->version < 0x0103)
 		return;
 
 	avrcp_get_capabilities(session);
+
+	if (controller->version < 0x0104)
+		return;
+
+	/* Auto-connect browsing channel only if initiator */
+	if (old_state == BTD_SERVICE_STATE_CONNECTING &&
+				controller->features & AVRCP_FEATURE_BROWSING)
+		avctp_connect_browsing(session->conn);
 }
 
-static void session_destroy(struct avrcp *session)
+static void session_init_control(struct avrcp *session)
 {
-	struct avrcp_server *server = session->server;
+	session->passthrough_id = avctp_register_passthrough_handler(
+							session->conn,
+							handle_passthrough,
+							session);
+	session->passthrough_handlers = passthrough_handlers;
+	session->control_id = avctp_register_pdu_handler(session->conn,
+							AVC_OP_VENDORDEP,
+							handle_vendordep_pdu,
+							session);
+	session->control_handlers = control_handlers;
 
-	server->sessions = g_slist_remove(server->sessions, session);
+	if (btd_device_get_service(session->dev, AVRCP_TARGET_UUID) != NULL)
+		controller_init(session);
 
-	if (session->passthrough_id > 0)
-		avctp_unregister_passthrough_handler(session->passthrough_id);
+	if (btd_device_get_service(session->dev, AVRCP_REMOTE_UUID) != NULL)
+		target_init(session);
+}
 
-	if (session->control_id > 0)
-		avctp_unregister_pdu_handler(session->control_id);
+static void controller_destroy(struct avrcp *session)
+{
+	struct avrcp_data *controller = session->controller;
+	struct btd_service *service;
 
-	if (session->browsing_id > 0)
-		avctp_unregister_browsing_pdu_handler(session->browsing_id);
+	DBG("%p", controller);
 
-	g_free(session);
+	g_slist_free_full(controller->players, player_destroy);
+
+	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
+
+	if (session->control_id == 0)
+		btd_service_connecting_complete(service, -EIO);
+	else
+		btd_service_disconnecting_complete(service, 0);
+
+	g_free(controller);
 }
 
-static void session_tg_destroy(struct avrcp *session)
+static void target_destroy(struct avrcp *session)
 {
-	struct avrcp_player *player = session->player;
+	struct avrcp_data *target = session->target;
+	struct avrcp_player *player = target->player;
 	struct btd_service *service;
 
-	DBG("%p", session);
+	DBG("%p", target);
 
 	if (player != NULL)
 		player->sessions = g_slist_remove(player->sessions, session);
 
 	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
-	if (service == NULL)
-		return session_destroy(session);
 
 	if (session->control_id == 0)
 		btd_service_connecting_complete(service, -EIO);
 	else
 		btd_service_disconnecting_complete(service, 0);
 
-	session_destroy(session);
+	g_free(target);
 }
 
-static void session_ct_destroy(struct avrcp *session)
+static void session_destroy(struct avrcp *session)
 {
-	struct btd_service *service;
+	struct avrcp_server *server = session->server;
 
-	DBG("%p", session);
+	server->sessions = g_slist_remove(server->sessions, session);
 
-	g_slist_free_full(session->players, player_destroy);
+	if (session->controller != NULL)
+		controller_destroy(session);
 
-	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
-	if (service == NULL)
-		return session_destroy(session);
+	if (session->target != NULL)
+		target_destroy(session);
 
-	if (session->control_id == 0)
-		btd_service_connecting_complete(service, -EIO);
-	else
-		btd_service_disconnecting_complete(service, 0);
+	if (session->passthrough_id > 0)
+		avctp_unregister_passthrough_handler(session->passthrough_id);
 
-	session_destroy(session);
+	if (session->control_id > 0)
+		avctp_unregister_pdu_handler(session->control_id);
+
+	if (session->browsing_id > 0)
+		avctp_unregister_browsing_pdu_handler(session->browsing_id);
+
+	g_free(session);
 }
 
 static struct avrcp *session_create(struct avrcp_server *server,
 						struct btd_device *device)
 {
 	struct avrcp *session;
-	const sdp_record_t *rec;
-	sdp_list_t *list;
-	sdp_profile_desc_t *desc;
-	struct btd_service *sink, *source;
 
 	session = g_new0(struct avrcp, 1);
 	session->server = server;
@@ -3434,52 +3486,6 @@ static struct avrcp *session_create(struct avrcp_server *server,
 
 	server->sessions = g_slist_append(server->sessions, session);
 
-	sink = btd_device_get_service(device, A2DP_SINK_UUID);
-	source = btd_device_get_service(device, A2DP_SOURCE_UUID);
-
-	/* If sink and source are not supported assume the controller must
-	 * be the initiator
-	 */
-	if (sink == NULL && source == NULL)
-		session->target = !avctp_is_initiator(session->conn);
-	else if (sink && !source)
-		session->target = TRUE;
-	else if (source && !sink)
-		session->target = FALSE;
-	else if (sink && sink_is_active(sink))
-		session->target = TRUE;
-	else
-		session->target = FALSE;
-
-	if (session->target) {
-		session->init_control = session_tg_init_control;
-		session->init_browsing = session_tg_init_browsing;
-		session->destroy = session_tg_destroy;
-
-		rec = btd_device_get_record(device, AVRCP_REMOTE_UUID);
-		if (rec == NULL)
-			btd_device_add_uuid(device, AVRCP_REMOTE_UUID);
-	} else {
-		session->init_control = session_ct_init_control;
-		session->init_browsing = session_ct_init_browsing;
-		session->destroy = session_ct_destroy;
-		rec = btd_device_get_record(device, AVRCP_TARGET_UUID);
-		if (rec == NULL)
-			btd_device_add_uuid(device, AVRCP_TARGET_UUID);
-	}
-
-	if (rec == NULL)
-		return session;
-
-	if (sdp_get_profile_descs(rec, &list) < 0)
-		return session;
-
-	desc = list->data;
-	session->version = desc->version;
-	sdp_get_int_attr(rec, SDP_ATTR_SUPPORTED_FEATURES, &session->features);
-
-	sdp_list_free(list, free);
-
 	return session;
 }
 
@@ -3500,7 +3506,7 @@ static void state_changed(struct btd_device *device, avctp_state_t old_state,
 		if (session == NULL)
 			break;
 
-		session->destroy(session);
+		session_destroy(session);
 
 		break;
 	case AVCTP_STATE_CONNECTING:
@@ -3514,18 +3520,15 @@ static void state_changed(struct btd_device *device, avctp_state_t old_state,
 		if (session == NULL || session->control_id > 0)
 			break;
 
-		session->init_control(session);
-
-		if (session->version >= 0x0104 &&
-				session->features & AVRCP_FEATURE_BROWSING)
-			avctp_connect_browsing(session->conn);
+		session_init_control(session);
 
 		break;
 	case AVCTP_STATE_BROWSING_CONNECTED:
 		if (session == NULL || session->browsing_id > 0)
 			break;
 
-		session->init_browsing(session);
+		session_init_browsing(session);
+
 		break;
 	default:
 		return;
@@ -3727,9 +3730,13 @@ struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 	/* Assign player to session without current player */
 	for (l = server->sessions; l; l = l->next) {
 		struct avrcp *session = l->data;
+		struct avrcp_data *target = session->target;
 
-		if (session->player == NULL) {
-			session->player = player;
+		if (target == NULL)
+			continue;
+
+		if (target->player == NULL) {
+			target->player = player;
 			player->sessions = g_slist_append(player->sessions,
 								session);
 		}
@@ -3748,9 +3755,13 @@ void avrcp_unregister_player(struct avrcp_player *player)
 	/* Remove player from sessions using it */
 	for (l = player->sessions; l; l = l->next) {
 		struct avrcp *session = l->data;
+		struct avrcp_data *target = session->target;
+
+		if (target == NULL)
+			continue;
 
-		if (session->player == player)
-			session->player = g_slist_nth_data(server->players, 0);
+		if (target->player == player)
+			target->player = g_slist_nth_data(server->players, 0);
 	}
 
 	player_destroy(player);
@@ -3762,7 +3773,7 @@ static gboolean avrcp_handle_set_volume(struct avctp *conn,
 					void *user_data)
 {
 	struct avrcp *session = user_data;
-	struct avrcp_player *player = session->player;
+	struct avrcp_player *player = session->target->player;
 	struct avrcp_header *pdu = (void *) operands;
 	uint8_t volume;
 
@@ -3790,10 +3801,10 @@ int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
 		return -EINVAL;
 
 	session = find_session(server->sessions, dev);
-	if (session == NULL)
+	if (session == NULL || session->target == NULL)
 		return -ENOTCONN;
 
-	if (session->version < 0x0104)
+	if (session->target->version < 0x0104)
 		return -ENOTSUP;
 
 	memset(buf, 0, sizeof(buf));
-- 
1.8.3.1

