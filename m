Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] AVRCP: Add support for available player changed event for CT role
Date: Wed, 13 Mar 2013 17:02:51 -0300
Message-Id: <1363204974-21023-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for registering to available player changed event if
supported by TG.
---
 profiles/audio/avrcp.c  | 404 ++++++++++++++++++++++++++++--------------------
 profiles/audio/avrcp.h  |   1 +
 profiles/audio/player.c |   5 +-
 profiles/audio/player.h |   3 +-
 4 files changed, 239 insertions(+), 174 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index cfa4a51..aba7e86 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -196,6 +196,7 @@ struct avrcp {
 	gboolean target;
 	uint16_t version;
 	int features;
+	GSList *players;
 
 	void (*init_control) (struct avrcp *session);
 	void (*init_browsing) (struct avrcp *session);
@@ -2058,23 +2059,205 @@ static void avrcp_player_parse_features(struct avrcp_player *player,
 	}
 }
 
-static void avrcp_parse_media_player_item(struct avrcp *session,
-					uint8_t *operands, uint16_t len)
+static void avrcp_set_player_value(struct avrcp *session, uint8_t attr,
+								uint8_t val)
 {
-	struct avrcp_player *player = session->player;
-	struct media_player *mp = player->user_data;
+	uint8_t buf[AVRCP_HEADER_LENGTH + 3];
+	struct avrcp_header *pdu = (void *) buf;
+	uint8_t length;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_SET_PLAYER_VALUE;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	pdu->params[0] = 1;
+	pdu->params[1] = attr;
+	pdu->params[2] = val;
+	pdu->params_len = htons(3);
+
+	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_NOTIFY,
+					AVC_SUBUNIT_PANEL, buf, length,
+					avrcp_player_value_rsp, session);
+}
+
+static bool ct_set_setting(struct media_player *mp, const char *key,
+					const char *value, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	int attr;
+	int val;
+	struct avrcp *session;
+
+	session = player->sessions->data;
+	if (session == NULL)
+		return false;
+
+	if (session->version < 0x0103)
+		return false;
+
+	attr = attr_to_val(key);
+	if (attr < 0)
+		return false;
+
+	val = attrval_to_val(attr, value);
+	if (val < 0)
+		return false;
+
+	avrcp_set_player_value(session, attr, val);
+
+	return true;
+}
+
+static int ct_press(struct avrcp_player *player, uint8_t op)
+{
+	int err;
+	struct avrcp *session;
+
+	session = player->sessions->data;
+	if (session == NULL)
+		return -ENOTCONN;
+
+	err = avctp_send_passthrough(session->conn, op);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int ct_play(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_PLAY);
+}
+
+static int ct_pause(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_PAUSE);
+}
+
+static int ct_stop(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_STOP);
+}
+
+static int ct_next(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_FORWARD);
+}
+
+static int ct_previous(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_BACKWARD);
+}
+
+static int ct_fast_forward(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_FAST_FORWARD);
+}
+
+static int ct_rewind(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_REWIND);
+}
+
+static const struct media_player_callback ct_cbs = {
+	.set_setting	= ct_set_setting,
+	.play		= ct_play,
+	.pause		= ct_pause,
+	.stop		= ct_stop,
+	.next		= ct_next,
+	.previous	= ct_previous,
+	.fast_forward	= ct_fast_forward,
+	.rewind		= ct_rewind,
+};
+
+static struct avrcp_player *create_ct_player(struct avrcp *session,
+								uint16_t id)
+{
+	struct avrcp_player *player;
+	struct media_player *mp;
+	const char *path;
+
+	player = g_new0(struct avrcp_player, 1);
+	player->sessions = g_slist_prepend(player->sessions, session);
+
+	path = device_get_path(session->dev->btd_dev);
+
+	mp = media_player_controller_create(path, id);
+	if (mp == NULL)
+		return NULL;
+
+	media_player_set_callbacks(mp, &ct_cbs, player);
+	player->user_data = mp;
+	player->destroy = (GDestroyNotify) media_player_destroy;
+
+	if (session->player == NULL)
+		session->player = player;
+
+	session->players = g_slist_prepend(session->players, player);
+
+	return player;
+}
+
+static struct avrcp_player *find_ct_player(struct avrcp *session, uint16_t id)
+{
+	GSList *l;
+
+	for (l = session->players; l; l = l->next) {
+		struct avrcp_player *player = l->data;
+
+		if (player->id == 0) {
+			player->id = id;
+			return player;
+		}
+
+		if (player->id == id)
+			return player;
+	}
+
+	return NULL;
+}
+
+static struct avrcp_player *
+avrcp_parse_media_player_item(struct avrcp *session, uint8_t *operands,
+							uint16_t len)
+{
+	struct avrcp_player *player;
+	struct media_player *mp;
 	uint16_t id, namelen;
 	uint32_t subtype;
 	const char *curval, *strval;
 	char name[255];
 
 	if (len < 28)
-		return;
+		return NULL;
 
 	id = bt_get_be16(&operands[0]);
 
-	if (player->id != id)
-		return;
+	player = find_ct_player(session, id);
+	if (player == NULL) {
+		player = create_ct_player(session, id);
+		if (player == NULL)
+			return NULL;
+	}
+
+	mp = player->user_data;
 
 	media_player_set_type(mp, type_to_string(operands[2]));
 
@@ -2100,7 +2283,22 @@ static void avrcp_parse_media_player_item(struct avrcp *session,
 		media_player_set_name(mp, name);
 	}
 
-	avrcp_set_browsed_player(session, player);
+	if (session->player == player)
+		avrcp_set_browsed_player(session, player);
+
+	return player;
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
+	g_free(player->features);
+	g_free(player);
 }
 
 static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
@@ -2112,13 +2310,16 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	uint16_t count;
 	size_t i;
+	GSList *removed;
 
 	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 5)
 		return FALSE;
 
+	removed = g_slist_copy(session->players);
 	count = bt_get_be16(&operands[6]);
 
 	for (i = 8; count && i < operand_count; count--) {
+		struct avrcp_player *player;
 		uint8_t type;
 		uint16_t len;
 
@@ -2136,11 +2337,16 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 			return FALSE;
 		}
 
-		avrcp_parse_media_player_item(session, &operands[i], len);
+		player = avrcp_parse_media_player_item(session, &operands[i],
+									len);
+		if (player)
+			removed = g_slist_remove(removed, player);
 
 		i += len;
 	}
 
+	g_slist_free_full(removed, player_destroy);
+
 	return FALSE;
 }
 
@@ -2228,6 +2434,12 @@ static void avrcp_setting_changed(struct avrcp *session,
 	}
 }
 
+static void avrcp_available_players_changed(struct avrcp *session,
+						struct avrcp_header *pdu)
+{
+	avrcp_get_media_player_list(session);
+}
+
 static void avrcp_addressed_player_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
@@ -2237,8 +2449,13 @@ static void avrcp_addressed_player_changed(struct avrcp *session,
 	if (player->id == id)
 		return;
 
-	player->id = id;
+	player = find_ct_player(session, id);
+	if (player == NULL)
+		return;
+
 	player->uid_counter = bt_get_be16(&pdu->params[3]);
+	session->player = player;
+
 	avrcp_get_media_player_list(session);
 }
 
@@ -2282,6 +2499,9 @@ static gboolean avrcp_handle_event(struct avctp *conn,
 	case AVRCP_EVENT_SETTINGS_CHANGED:
 		avrcp_setting_changed(session, pdu);
 		break;
+	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
+		avrcp_available_players_changed(session, pdu);
+		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		avrcp_addressed_player_changed(session, pdu);
 		break;
@@ -2316,134 +2536,6 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event)
 					avrcp_handle_event, session);
 }
 
-static void avrcp_set_player_value(struct avrcp *session, uint8_t attr,
-								uint8_t val)
-{
-	uint8_t buf[AVRCP_HEADER_LENGTH + 3];
-	struct avrcp_header *pdu = (void *) buf;
-	uint8_t length;
-
-	memset(buf, 0, sizeof(buf));
-
-	set_company_id(pdu->company_id, IEEEID_BTSIG);
-	pdu->pdu_id = AVRCP_SET_PLAYER_VALUE;
-	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
-	pdu->params[0] = 1;
-	pdu->params[1] = attr;
-	pdu->params[2] = val;
-	pdu->params_len = htons(3);
-
-	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
-
-	avctp_send_vendordep_req(session->conn, AVC_CTYPE_NOTIFY,
-					AVC_SUBUNIT_PANEL, buf, length,
-					avrcp_player_value_rsp, session);
-}
-
-static bool ct_set_setting(struct media_player *mp, const char *key,
-					const char *value, void *user_data)
-{
-	struct avrcp_player *player = user_data;
-	int attr;
-	int val;
-	struct avrcp *session;
-
-	session = player->sessions->data;
-	if (session == NULL)
-		return false;
-
-	if (session->version < 0x0103)
-		return false;
-
-	attr = attr_to_val(key);
-	if (attr < 0)
-		return false;
-
-	val = attrval_to_val(attr, value);
-	if (val < 0)
-		return false;
-
-	avrcp_set_player_value(session, attr, val);
-
-	return true;
-}
-
-static int ct_press(struct avrcp_player *player, uint8_t op)
-{
-	int err;
-	struct avrcp *session;
-
-	session = player->sessions->data;
-	if (session == NULL)
-		return -ENOTCONN;
-
-	err = avctp_send_passthrough(session->conn, op);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-static int ct_play(struct media_player *mp, void *user_data)
-{
-	struct avrcp_player *player = user_data;
-
-	return ct_press(player, AVC_PLAY);
-}
-
-static int ct_pause(struct media_player *mp, void *user_data)
-{
-	struct avrcp_player *player = user_data;
-
-	return ct_press(player, AVC_PAUSE);
-}
-
-static int ct_stop(struct media_player *mp, void *user_data)
-{
-	struct avrcp_player *player = user_data;
-
-	return ct_press(player, AVC_STOP);
-}
-
-static int ct_next(struct media_player *mp, void *user_data)
-{
-	struct avrcp_player *player = user_data;
-
-	return ct_press(player, AVC_FORWARD);
-}
-
-static int ct_previous(struct media_player *mp, void *user_data)
-{
-	struct avrcp_player *player = user_data;
-
-	return ct_press(player, AVC_BACKWARD);
-}
-
-static int ct_fast_forward(struct media_player *mp, void *user_data)
-{
-	struct avrcp_player *player = user_data;
-
-	return ct_press(player, AVC_FAST_FORWARD);
-}
-
-static int ct_rewind(struct media_player *mp, void *user_data)
-{
-	struct avrcp_player *player = user_data;
-
-	return ct_press(player, AVC_REWIND);
-}
-
-static const struct media_player_callback ct_cbs = {
-	.set_setting	= ct_set_setting,
-	.play		= ct_play,
-	.pause		= ct_pause,
-	.stop		= ct_stop,
-	.next		= ct_next,
-	.previous	= ct_previous,
-	.fast_forward	= ct_fast_forward,
-	.rewind		= ct_rewind,
-};
-
 static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 					uint8_t code, uint8_t subunit,
 					uint8_t *operands, size_t operand_count,
@@ -2470,6 +2562,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 		case AVRCP_EVENT_SETTINGS_CHANGED:
 		case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		case AVRCP_EVENT_UIDS_CHANGED:
+		case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 			avrcp_register_notification(session, event);
 			break;
 		}
@@ -2580,10 +2673,6 @@ static void session_ct_init_browsing(struct avrcp *session)
 
 static void session_ct_init_control(struct avrcp *session)
 {
-	struct avrcp_player *player;
-	struct media_player *mp;
-	const char *path;
-
 	DBG("%p version 0x%04x", session, session->version);
 
 	session->control_id = avctp_register_pdu_handler(session->conn,
@@ -2594,19 +2683,7 @@ static void session_ct_init_control(struct avrcp *session)
 	if (session->version >= 0x0104)
 		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
-	player = g_new0(struct avrcp_player, 1);
-	player->sessions = g_slist_prepend(player->sessions, session);
-	session->player = player;
-
-	path = device_get_path(session->dev->btd_dev);
-
-	mp = media_player_controller_create(path);
-	if (mp == NULL)
-		return;
-
-	media_player_set_callbacks(mp, &ct_cbs, player);
-	player->user_data = mp;
-	player->destroy = (GDestroyNotify) media_player_destroy;
+	create_ct_player(session, 0);
 
 	if (session->version < 0x0103)
 		return;
@@ -2641,26 +2718,11 @@ static void session_tg_destroy(struct avrcp *session)
 	session_destroy(session);
 }
 
-static void player_destroy(gpointer data)
-{
-	struct avrcp_player *player = data;
-
-	if (player->destroy)
-		player->destroy(player->user_data);
-
-	g_slist_free(player->sessions);
-	g_free(player->features);
-	g_free(player);
-}
-
 static void session_ct_destroy(struct avrcp *session)
 {
-	struct avrcp_player *player = session->player;
-
 	DBG("%p", session);
 
-	if (player != NULL)
-		player_destroy(player);
+	g_slist_free_full(session->players, player_destroy);
 
 	session_destroy(session);
 }
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 7759043..7b6fe92 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -74,6 +74,7 @@
 #define AVRCP_EVENT_TRACK_REACHED_END		0x03
 #define AVRCP_EVENT_TRACK_REACHED_START		0x04
 #define AVRCP_EVENT_SETTINGS_CHANGED		0x08
+#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED	0x0a
 #define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED	0x0b
 #define AVRCP_EVENT_UIDS_CHANGED		0x0c
 #define AVRCP_EVENT_VOLUME_CHANGED		0x0d
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index c09106d..ece33cc 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -765,13 +765,14 @@ void media_player_destroy(struct media_player *mp)
 	g_free(mp);
 }
 
-struct media_player *media_player_controller_create(const char *path)
+struct media_player *media_player_controller_create(const char *path,
+								uint16_t id)
 {
 	struct media_player *mp;
 
 	mp = g_new0(struct media_player, 1);
 	mp->device = g_strdup(path);
-	mp->path = g_strdup_printf("%s/player1", path);
+	mp->path = g_strdup_printf("%s/player%u", path, id);
 	mp->settings = g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free, g_free);
 	mp->track = g_hash_table_new_full(g_str_hash, g_str_equal,
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 8d6aa36..852042e 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -55,7 +55,8 @@ struct media_player_callback {
 	int (*rewind) (struct media_player *mp, void *user_data);
 };
 
-struct media_player *media_player_controller_create(const char *path);
+struct media_player *media_player_controller_create(const char *path,
+								uint16_t id);
 void media_player_destroy(struct media_player *mp);
 void media_player_set_duration(struct media_player *mp, uint32_t duration);
 void media_player_set_position(struct media_player *mp, uint32_t position);
-- 
1.8.1.4

