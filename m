Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto <luiz.dentz@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Vani <vani.patel@stericsson.com>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Subject: [PATCH BlueZ V3 2/5] AVRCP: Rename variables used for control channel
Date: Wed, 8 Aug 2012 12:26:26 +0530
Message-ID: <1344408986-11467-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

Prefix "control" is added to variables used for
control channel. This will improve redability
when Browsing channel is implemented
---
 audio/avctp.c |   83 +++++++++++++++++++++++++++++----------------------------
 audio/avctp.h |    5 ++-
 audio/avrcp.c |   54 ++++++++++++++++++------------------
 3 files changed, 72 insertions(+), 70 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index a20dba9..3bd021c 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -118,7 +118,7 @@ struct avctp_state_callback {
 
 struct avctp_server {
 	bdaddr_t src;
-	GIOChannel *io;
+	GIOChannel *control_io;
 	GSList *sessions;
 };
 
@@ -136,10 +136,10 @@ struct avctp {
 
 	int uinput;
 
-	GIOChannel *io;
-	guint io_id;
+	GIOChannel *control_io;
+	guint control_io_id;
 
-	uint16_t mtu;
+	uint16_t control_mtu;
 
 	uint8_t key_quirks[256];
 	GSList *handlers;
@@ -147,7 +147,7 @@ struct avctp {
 
 struct avctp_pdu_handler {
 	uint8_t opcode;
-	avctp_pdu_cb cb;
+	avctp_control_pdu_cb cb;
 	void *user_data;
 	unsigned int id;
 };
@@ -169,7 +169,7 @@ static struct {
 
 static GSList *callbacks = NULL;
 static GSList *servers = NULL;
-static GSList *handlers = NULL;
+static GSList *control_handlers = NULL;
 static uint8_t id = 0;
 
 static void auth_cb(DBusError *derr, void *user_data);
@@ -326,15 +326,15 @@ static void avctp_disconnected(struct avctp *session)
 	if (!session)
 		return;
 
-	if (session->io) {
-		g_io_channel_shutdown(session->io, TRUE, NULL);
-		g_io_channel_unref(session->io);
-		session->io = NULL;
+	if (session->control_io) {
+		g_io_channel_shutdown(session->control_io, TRUE, NULL);
+		g_io_channel_unref(session->control_io);
+		session->control_io = NULL;
 	}
 
-	if (session->io_id) {
-		g_source_remove(session->io_id);
-		session->io_id = 0;
+	if (session->control_io_id) {
+		g_source_remove(session->control_io_id);
+		session->control_io_id = 0;
 
 		if (session->state == AVCTP_STATE_CONNECTING) {
 			struct audio_device *dev;
@@ -445,7 +445,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		goto failed;
 
-	sock = g_io_channel_unix_get_fd(session->io);
+	sock = g_io_channel_unix_get_fd(session->control_io);
 
 	ret = read(sock, buf, sizeof(buf));
 	if (ret <= 0)
@@ -503,7 +503,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		goto done;
 	}
 
-	handler = find_handler(handlers, avc->opcode);
+	handler = find_handler(control_handlers, avc->opcode);
 	if (!handler) {
 		DBG("handler not found for 0x%02x", avc->opcode);
 		packet_size += avrcp_handle_vendor_reject(&code, operands);
@@ -639,14 +639,14 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 
 	DBG("AVCTP: connected to %s", address);
 
-	if (!session->io)
-		session->io = g_io_channel_ref(chan);
+	if (!session->control_io)
+		session->control_io = g_io_channel_ref(chan);
 
 	init_uinput(session);
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTED);
-	session->mtu = imtu;
-	session->io_id = g_io_add_watch(chan,
+	session->control_mtu = imtu;
+	session->control_io_id = g_io_add_watch(chan,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) session_cb, session);
 }
@@ -656,9 +656,9 @@ static void auth_cb(DBusError *derr, void *user_data)
 	struct avctp *session = user_data;
 	GError *err = NULL;
 
-	if (session->io_id) {
-		g_source_remove(session->io_id);
-		session->io_id = 0;
+	if (session->control_io_id) {
+		g_source_remove(session->control_io_id);
+		session->control_io_id = 0;
 	}
 
 	if (derr && dbus_error_is_set(derr)) {
@@ -667,7 +667,7 @@ static void auth_cb(DBusError *derr, void *user_data)
 		return;
 	}
 
-	if (!bt_io_accept(session->io, avctp_connect_cb, session,
+	if (!bt_io_accept(session->control_io, avctp_connect_cb, session,
 								NULL, &err)) {
 		error("bt_io_accept: %s", err->message);
 		g_error_free(err);
@@ -771,24 +771,24 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 			goto drop;
 	}
 
-	if (session->io) {
+	if (session->control_io) {
 		error("Refusing unexpected connect from %s", address);
 		goto drop;
 	}
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
-	session->io = g_io_channel_ref(chan);
+	session->control_io = g_io_channel_ref(chan);
 
 	if (audio_device_request_authorization(dev, AVRCP_TARGET_UUID,
 						auth_cb, session) < 0)
 		goto drop;
 
-	session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							session_cb, session);
+	session->control_io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP |
+						G_IO_NVAL, session_cb, session);
 	return;
 
 drop:
-	if (!session || !session->io)
+	if (!session || !session->control_io)
 		g_io_channel_shutdown(chan, TRUE, NULL);
 	if (session)
 		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
@@ -824,8 +824,8 @@ int avctp_register(const bdaddr_t *src, gboolean master)
 
 	server = g_new0(struct avctp_server, 1);
 
-	server->io = avctp_server_socket(src, master);
-	if (!server->io) {
+	server->control_io = avctp_server_socket(src, master);
+	if (!server->control_io) {
 		g_free(server);
 		return -1;
 	}
@@ -862,8 +862,8 @@ void avctp_unregister(const bdaddr_t *src)
 
 	servers = g_slist_remove(servers, server);
 
-	g_io_channel_shutdown(server->io, TRUE, NULL);
-	g_io_channel_unref(server->io);
+	g_io_channel_shutdown(server->control_io, TRUE, NULL);
+	g_io_channel_unref(server->control_io);
 	g_free(server);
 
 	if (servers)
@@ -910,7 +910,7 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op)
 	operands[0] = op & 0x7f;
 	operands[1] = 0;
 
-	sk = g_io_channel_unix_get_fd(session->io);
+	sk = g_io_channel_unix_get_fd(session->control_io);
 
 	if (write(sk, buf, sizeof(buf)) < 0)
 		return -errno;
@@ -939,7 +939,7 @@ static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
 	if (session->state != AVCTP_STATE_CONNECTED)
 		return -ENOTCONN;
 
-	sk = g_io_channel_unix_get_fd(session->io);
+	sk = g_io_channel_unix_get_fd(session->control_io);
 
 	memset(buf, 0, sizeof(buf));
 
@@ -1034,13 +1034,13 @@ gboolean avctp_remove_state_cb(unsigned int id)
 	return FALSE;
 }
 
-unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_pdu_cb cb,
+unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
 							void *user_data)
 {
 	struct avctp_pdu_handler *handler;
 	static unsigned int id = 0;
 
-	handler = find_handler(handlers, opcode);
+	handler = find_handler(control_handlers, opcode);
 	if (handler)
 		return 0;
 
@@ -1050,7 +1050,7 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_pdu_cb cb,
 	handler->user_data = user_data;
 	handler->id = ++id;
 
-	handlers = g_slist_append(handlers, handler);
+	control_handlers = g_slist_append(control_handlers, handler);
 
 	return handler->id;
 }
@@ -1059,11 +1059,12 @@ gboolean avctp_unregister_pdu_handler(unsigned int id)
 {
 	GSList *l;
 
-	for (l = handlers; l != NULL; l = l->next) {
+	for (l = control_handlers; l != NULL; l = l->next) {
 		struct avctp_pdu_handler *handler = l->data;
 
 		if (handler->id == id) {
-			handlers = g_slist_remove(handlers, handler);
+			control_handlers = g_slist_remove(control_handlers,
+								handler);
 			g_free(handler);
 			return TRUE;
 		}
@@ -1099,14 +1100,14 @@ struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
 		return NULL;
 	}
 
-	session->io = io;
+	session->control_io = io;
 
 	return session;
 }
 
 void avctp_disconnect(struct avctp *session)
 {
-	if (!session->io)
+	if (!session->control_io)
 		return;
 
 	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
diff --git a/audio/avctp.h b/audio/avctp.h
index 34b0c1c..b80e300 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -75,7 +75,8 @@ typedef void (*avctp_state_cb) (struct audio_device *dev,
 				avctp_state_t new_state,
 				void *user_data);
 
-typedef size_t (*avctp_pdu_cb) (struct avctp *session, uint8_t transaction,
+typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
+					uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
@@ -93,7 +94,7 @@ struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst);
 struct avctp *avctp_get(const bdaddr_t *src, const bdaddr_t *dst);
 void avctp_disconnect(struct avctp *session);
 
-unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_pdu_cb cb,
+unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
 							void *user_data);
 gboolean avctp_unregister_pdu_handler(unsigned int id);
 
diff --git a/audio/avrcp.c b/audio/avrcp.c
index ca40c1e..9d29073 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -162,7 +162,7 @@ struct avrcp_player {
 	struct avctp *session;
 	struct audio_device *dev;
 
-	unsigned int handler;
+	unsigned int control_handler;
 	uint16_t registered_events;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 	struct pending_pdu *pending_pdu;
@@ -255,9 +255,9 @@ static sdp_record_t *avrcp_tg_record(void)
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root, *apseq_browsing;
 	uuid_t root_uuid, l2cap, avctp, avrtg;
 	sdp_profile_desc_t profile[1];
-	sdp_list_t *aproto, *proto[2];
+	sdp_list_t *aproto_control, *proto_control[2];
 	sdp_record_t *record;
-	sdp_data_t *psm, *version, *features, *psm_browsing;
+	sdp_data_t *psm_control, *version, *features, *psm_browsing;
 	sdp_list_t *aproto_browsing, *proto_browsing[2] = {0};
 	uint16_t lp = AVCTP_CONTROL_PSM;
 	uint16_t lp_browsing = AVCTP_BROWSING_PSM;
@@ -283,19 +283,19 @@ static sdp_record_t *avrcp_tg_record(void)
 
 	/* Protocol Descriptor List */
 	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto[0] = sdp_list_append(0, &l2cap);
-	psm = sdp_data_alloc(SDP_UINT16, &lp);
-	proto[0] = sdp_list_append(proto[0], psm);
-	apseq = sdp_list_append(0, proto[0]);
+	proto_control[0] = sdp_list_append(0, &l2cap);
+	psm_control = sdp_data_alloc(SDP_UINT16, &lp);
+	proto_control[0] = sdp_list_append(proto_control[0], psm_control);
+	apseq = sdp_list_append(0, proto_control[0]);
 
 	sdp_uuid16_create(&avctp, AVCTP_UUID);
-	proto[1] = sdp_list_append(0, &avctp);
+	proto_control[1] = sdp_list_append(0, &avctp);
 	version = sdp_data_alloc(SDP_UINT16, &avctp_ver);
-	proto[1] = sdp_list_append(proto[1], version);
-	apseq = sdp_list_append(apseq, proto[1]);
+	proto_control[1] = sdp_list_append(proto_control[1], version);
+	apseq = sdp_list_append(apseq, proto_control[1]);
 
-	aproto = sdp_list_append(0, apseq);
-	sdp_set_access_protos(record, aproto);
+	aproto_control = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto_control);
 	proto_browsing[0] = sdp_list_append(0, &l2cap);
 	psm_browsing = sdp_data_alloc(SDP_UINT16, &lp_browsing);
 	proto_browsing[0] = sdp_list_append(proto_browsing[0], psm_browsing);
@@ -323,12 +323,12 @@ static sdp_record_t *avrcp_tg_record(void)
 	sdp_list_free(proto_browsing[0], 0);
 	sdp_list_free(proto_browsing[1], 0);
 	sdp_list_free(aproto_browsing, 0);
-	free(psm);
+	free(psm_control);
 	free(version);
-	sdp_list_free(proto[0], 0);
-	sdp_list_free(proto[1], 0);
+	sdp_list_free(proto_control[0], 0);
+	sdp_list_free(proto_control[1], 0);
 	sdp_list_free(apseq, 0);
-	sdp_list_free(aproto, 0);
+	sdp_list_free(aproto_control, 0);
 	sdp_list_free(pfseq, 0);
 	sdp_list_free(root, 0);
 	sdp_list_free(svclass_id, 0);
@@ -1037,13 +1037,13 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
-static struct pdu_handler {
+static struct control_pdu_handler {
 	uint8_t pdu_id;
 	uint8_t code;
 	uint8_t (*func) (struct avrcp_player *player,
 					struct avrcp_header *pdu,
 					uint8_t transaction);
-} handlers[] = {
+} control_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
 					avrcp_handle_get_capabilities },
 		{ AVRCP_LIST_PLAYER_ATTRIBUTES, AVC_CTYPE_STATUS,
@@ -1082,7 +1082,7 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 					void *user_data)
 {
 	struct avrcp_player *player = user_data;
-	struct pdu_handler *handler;
+	struct control_pdu_handler *handler;
 	struct avrcp_header *pdu = (void *) operands;
 	uint32_t company_id = get_company_id(pdu->company_id);
 
@@ -1102,7 +1102,7 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 		goto err_metadata;
 	}
 
-	for (handler = handlers; handler; handler++) {
+	for (handler = control_handlers; handler; handler++) {
 		if (handler->pdu_id == pdu->pdu_id)
 			break;
 	}
@@ -1229,9 +1229,9 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		player->dev = NULL;
 		player->registered_events = 0;
 
-		if (player->handler) {
-			avctp_unregister_pdu_handler(player->handler);
-			player->handler = 0;
+		if (player->control_handler) {
+			avctp_unregister_pdu_handler(player->control_handler);
+			player->control_handler = 0;
 		}
 
 		break;
@@ -1239,8 +1239,8 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		player->session = avctp_connect(&dev->src, &dev->dst);
 		player->dev = dev;
 
-		if (!player->handler)
-			player->handler = avctp_register_pdu_handler(
+		if (!player->control_handler)
+			player->control_handler = avctp_register_pdu_handler(
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							player);
@@ -1358,8 +1358,8 @@ static void player_destroy(gpointer data)
 
 	player_abort_pending_pdu(player);
 
-	if (player->handler)
-		avctp_unregister_pdu_handler(player->handler);
+	if (player->control_handler)
+		avctp_unregister_pdu_handler(player->control_handler);
 
 	g_free(player);
 }
-- 
1.7.5.4

