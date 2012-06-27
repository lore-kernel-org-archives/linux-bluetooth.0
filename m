Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 07/14] AVRCP: Move profile specific fields from players
Date: Wed, 27 Jun 2012 15:27:41 +0200
Message-ID: <1340803668-31686-7-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Transactions, events and fragmentation are not specified to
every player. Those fields are specific to profile, so
move them to new AVRCP session structure.
---
 audio/avrcp.c |   83 ++++++++++++++++++++++++++++++++-------------------------
 audio/avrcp.h |    5 +++-
 audio/media.c |   10 +++----
 3 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 4e3b641..430f216 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -159,8 +159,12 @@ struct avrcp_header {
 #define AVRCP_PDU_MTU	(AVRCP_MTU - AVRCP_HEADER_LENGTH)
 
 struct avrcp_session {
+	struct avctp *avctp_session;
 	uint16_t version_tg;
 	uint16_t version_ct;
+	uint16_t registered_events;
+	uint8_t transaction[16];
+	struct pending_pdu *pending_pdu;
 };
 
 struct avrcp_server {
@@ -180,14 +184,8 @@ struct pending_pdu {
 
 struct avrcp_player {
 	struct avrcp_server *server;
-	struct avctp *session;
 	struct audio_device *dev;
-
 	unsigned int handler;
-	uint16_t registered_events;
-	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
-	struct pending_pdu *pending_pdu;
-
 	struct avrcp_player_cb *cb;
 	void *user_data;
 	GDestroyNotify destroy;
@@ -396,17 +394,17 @@ static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
 	cid[2] = cid_in;
 }
 
-int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
+int avrcp_event(struct avrcp_session *session, uint8_t id, void *data)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + 9];
 	struct avrcp_header *pdu = (void *) buf;
 	uint16_t size;
 	int err;
 
-	if (player->session == NULL)
+	if (session->avctp_session == NULL)
 		return -ENOTCONN;
 
-	if (!(player->registered_events & (1 << id)))
+	if (!(session->registered_events & (1 << id)))
 		return 0;
 
 	memset(buf, 0, sizeof(buf));
@@ -439,15 +437,14 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 	}
 
 	pdu->params_len = htons(size);
-
-	err = avctp_send_vendordep(player->session, player->transaction_events[id],
+	err = avctp_send_vendordep(session->avctp_session, session->transaction[id],
 					AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
 					buf, size + AVRCP_HEADER_LENGTH);
 	if (err < 0)
 		return err;
 
 	/* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
-	player->registered_events ^= 1 << id;
+	session->registered_events ^= 1 << id;
 
 	return 0;
 }
@@ -546,14 +543,14 @@ static struct pending_pdu *pending_pdu_new(uint8_t pdu_id, GList *attr_ids,
 	return pending;
 }
 
-static gboolean player_abort_pending_pdu(struct avrcp_player *player)
+static gboolean pending_pdu_abort(struct avrcp_session *session)
 {
-	if (player->pending_pdu == NULL)
+	if (session->pending_pdu == NULL)
 		return FALSE;
 
-	g_list_free(player->pending_pdu->attr_ids);
-	g_free(player->pending_pdu);
-	player->pending_pdu = NULL;
+	g_list_free(session->pending_pdu->attr_ids);
+	g_free(session->pending_pdu);
+	session->pending_pdu = NULL;
 
 	return TRUE;
 }
@@ -684,6 +681,7 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
+	struct avrcp_session *session = &player->server->session;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t *identifier = (uint64_t *) &pdu->params[0];
 	uint16_t pos;
@@ -729,14 +727,14 @@ static uint8_t avrcp_handle_get_element_attributes(struct avrcp_player *player,
 	if (!len)
 		goto err;
 
-	player_abort_pending_pdu(player);
+	pending_pdu_abort(session);
 	pos = 1;
 	offset = 0;
 	attr_ids = player_fill_media_attribute(player, attr_ids, pdu->params,
 								&pos, &offset);
 
 	if (attr_ids != NULL) {
-		player->pending_pdu = pending_pdu_new(pdu->pdu_id, attr_ids,
+		session->pending_pdu = pending_pdu_new(pdu->pdu_id, attr_ids,
 								offset);
 		pdu->packet_type = AVRCP_PACKET_TYPE_START;
 	}
@@ -929,6 +927,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
+	struct avrcp_session *session = &player->server->session;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
 
@@ -962,8 +961,8 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 	}
 
 	/* Register event and save the transaction used */
-	player->registered_events |= (1 << pdu->params[0]);
-	player->transaction_events[pdu->params[0]] = transaction;
+	session->registered_events |= (1 << pdu->params[0]);
+	session->transaction[pdu->params[0]] = transaction;
 
 	pdu->params_len = htons(len);
 
@@ -979,13 +978,14 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp_player *player,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
+	struct avrcp_session *session = &player->server->session;
 	uint16_t len = ntohs(pdu->params_len);
 	struct pending_pdu *pending;
 
-	if (len != 1 || player->pending_pdu == NULL)
+	if (len != 1 || session->pending_pdu == NULL)
 		goto err;
 
-	pending = player->pending_pdu;
+	pending = session->pending_pdu;
 
 	if (pending->pdu_id != pdu->params[0])
 		goto err;
@@ -999,8 +999,8 @@ static uint8_t avrcp_handle_request_continuing(struct avrcp_player *player,
 	pdu->pdu_id = pending->pdu_id;
 
 	if (pending->attr_ids == NULL) {
-		g_free(player->pending_pdu);
-		player->pending_pdu = NULL;
+		g_free(session->pending_pdu);
+		session->pending_pdu = NULL;
 		pdu->packet_type = AVRCP_PACKET_TYPE_END;
 	} else {
 		pdu->packet_type = AVRCP_PACKET_TYPE_CONTINUING;
@@ -1019,18 +1019,19 @@ static uint8_t avrcp_handle_abort_continuing(struct avrcp_player *player,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
 {
+	struct avrcp_session *session = &player->server->session;
 	uint16_t len = ntohs(pdu->params_len);
 	struct pending_pdu *pending;
 
-	if (len != 1 || player->pending_pdu == NULL)
+	if (len != 1 || session->pending_pdu == NULL)
 		goto err;
 
-	pending = player->pending_pdu;
+	pending = session->pending_pdu;
 
 	if (pending->pdu_id != pdu->params[0])
 		goto err;
 
-	player_abort_pending_pdu(player);
+	pending_pdu_abort(session);
 	pdu->params_len = 0;
 
 	return AVC_CTYPE_ACCEPTED;
@@ -1127,7 +1128,7 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 				pdu->pdu_id != AVRCP_GET_ELEMENT_ATTRIBUTES &&
 				pdu->pdu_id != AVRCP_REQUEST_CONTINUING &&
 				pdu->pdu_id != AVRCP_ABORT_CONTINUING)
-		player_abort_pending_pdu(player);
+		pending_pdu_abort(&player->server->session);
 
 	return AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
 
@@ -1205,7 +1206,7 @@ static void register_volume_notification(struct avrcp_player *player)
 
 	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
 
-	avctp_send_vendordep_req(player->session, AVC_CTYPE_NOTIFY,
+	avctp_send_vendordep_req(player->server->session.avctp_session, AVC_CTYPE_NOTIFY,
 					AVC_SUBUNIT_PANEL, buf, length,
 					avrcp_handle_volume_changed, player);
 }
@@ -1214,6 +1215,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 				avctp_state_t new_state, void *user_data)
 {
 	struct avrcp_server *server;
+	struct avrcp_session *session;
 	struct avrcp_player *player;
 	const sdp_record_t *rec_tg, *rec_ct;
 	sdp_list_t *list;
@@ -1223,15 +1225,18 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	if (!server)
 		return;
 
+	session = &server->session;
+
 	player = server->addressed_player;
 	if (!player)
 		return;
 
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
-		player->session = NULL;
+		session->avctp_session = NULL;
+
 		player->dev = NULL;
-		player->registered_events = 0;
+		session->registered_events = 0;
 
 		if (player->handler) {
 			avctp_unregister_pdu_handler(player->handler);
@@ -1240,7 +1245,8 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		break;
 	case AVCTP_STATE_CONNECTING:
-		player->session = avctp_connect(&dev->src, &dev->dst);
+		session->avctp_session = avctp_connect(&dev->src, &dev->dst);
+
 		player->dev = dev;
 
 		if (!player->handler)
@@ -1303,6 +1309,11 @@ void avrcp_disconnect(struct audio_device *dev)
 	avctp_disconnect(session);
 }
 
+struct avrcp_session *avrcp_get_session(struct avrcp_player *player)
+{
+	return &player->server->session;
+}
+
 int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 {
 	sdp_record_t *record;
@@ -1378,7 +1389,7 @@ static void player_destroy(gpointer data)
 	if (player->destroy)
 		player->destroy(player->user_data);
 
-	player_abort_pending_pdu(player);
+	pending_pdu_abort(&player->server->session);
 
 	if (player->handler)
 		avctp_unregister_pdu_handler(player->handler);
@@ -1488,7 +1499,7 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
 	if (player == NULL)
 		return -ENOTSUP;
 
-	if (player->session == NULL)
+	if (server->session.avctp_session == NULL)
 		return -ENOTCONN;
 
 	memset(buf, 0, sizeof(buf));
@@ -1501,7 +1512,7 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
 
 	DBG("volume=%u", volume);
 
-	return avctp_send_vendordep_req(player->session, AVC_CTYPE_CONTROL,
+	return avctp_send_vendordep_req(server->session.avctp_session, AVC_CTYPE_CONTROL,
 					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
 					avrcp_handle_set_volume, player);
 }
diff --git a/audio/avrcp.h b/audio/avrcp.h
index dcc67f6..1b4a887 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -103,11 +103,14 @@ struct avrcp_player_cb {
 							void *user_data);
 };
 
+struct avrcp_player *player;
+
 int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
 void avrcp_unregister(const bdaddr_t *src);
 
 gboolean avrcp_connect(struct audio_device *dev);
 void avrcp_disconnect(struct audio_device *dev);
+struct avrcp_session *avrcp_get_session(struct avrcp_player *player);
 int avrcp_set_volume(struct audio_device *dev, uint8_t volume);
 
 struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
@@ -116,7 +119,7 @@ struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
 						GDestroyNotify destroy);
 void avrcp_unregister_player(struct avrcp_player *player);
 
-int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
+int avrcp_event(struct avrcp_session *session, uint8_t id, void *data);
 
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
diff --git a/audio/media.c b/audio/media.c
index cc8ac37..5c958c6 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1414,7 +1414,7 @@ static gboolean set_status(struct media_player *mp, DBusMessageIter *iter)
 
 	mp->status = val;
 
-	avrcp_player_event(mp->player, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED, &val);
+	avrcp_event(avrcp_get_session(mp->player), AVRCP_EVENT_PLAYBACK_STATUS_CHANGED, &val);
 
 	return TRUE;
 }
@@ -1434,7 +1434,7 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	g_timer_start(mp->timer);
 
 	if (!mp->position) {
-		avrcp_player_event(mp->player,
+		avrcp_event(avrcp_get_session(mp->player),
 					AVRCP_EVENT_TRACK_REACHED_START, NULL);
 		return TRUE;
 	}
@@ -1448,7 +1448,7 @@ static gboolean set_position(struct media_player *mp, DBusMessageIter *iter)
 	 */
 	if (mp->position == UINT32_MAX ||
 			(duration && mp->position >= duration->value.num))
-		avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_END,
+		avrcp_event(avrcp_get_session(mp->player), AVRCP_EVENT_TRACK_REACHED_END,
 									NULL);
 
 	return TRUE;
@@ -1641,8 +1641,8 @@ static gboolean parse_player_metadata(struct media_player *mp,
 	g_timer_start(mp->timer);
 	uid = get_uid(mp);
 
-	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_CHANGED, &uid);
-	avrcp_player_event(mp->player, AVRCP_EVENT_TRACK_REACHED_START,
+	avrcp_event(avrcp_get_session(mp->player), AVRCP_EVENT_TRACK_CHANGED, &uid);
+	avrcp_event(avrcp_get_session(mp->player), AVRCP_EVENT_TRACK_REACHED_START,
 								NULL);
 
 	return TRUE;
-- 
on behalf of ST-Ericsson

