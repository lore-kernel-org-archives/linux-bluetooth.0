Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/9] AVRCP: Fix crash on disconnect
Date: Fri,  5 Oct 2012 23:20:49 +0200
Message-Id: <1349472050-25928-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
References: <1349472050-25928-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case of multiple session being active the code was registering one
PDU hanlder per AVRCP session and given the session pointer as user data
causing the following:

    24 bytes in 1 blocks are definitely lost in loss record 370 of 893
       at 0x4A0884D: malloc (vg_replace_malloc.c:263)
       by 0x4C803FE: g_malloc (in /usr/lib64/libglib-2.0.so.0.3200.4)
       by 0x12EE9D: avctp_register_browsing_pdu_handler (avctp.c:1259)
       by 0x12FD7B: state_changed (avrcp.c:1402)
       by 0x12D391: avctp_set_state (avctp.c:403)
       by 0x12E6B4: avctp_confirm_cb (avctp.c:871)
       by 0x1606A3: server_cb (btio.c:254)
       by 0x4C7A824: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
       by 0x4C7AB57: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
       by 0x4C7AF51: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3200.4)
       by 0x120EA1: main (main.c:551)

To fix this the PDU handlers are now per AVCTP session/channel so each
AVRCP session can register its own handler and pass itself as user
data.
---
 audio/avctp.c | 180 ++++++++++++++++++++++++++++++++++++----------------------
 audio/avctp.h |  10 ++--
 audio/avrcp.c |  56 +++++++++---------
 audio/avrcp.h |   1 +
 4 files changed, 148 insertions(+), 99 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index aa9a1ca..228d5b7 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -137,6 +137,7 @@ struct avctp_channel {
 	uint16_t imtu;
 	uint16_t omtu;
 	uint8_t *buffer;
+	GSList *handlers;
 };
 
 struct avctp {
@@ -148,6 +149,9 @@ struct avctp {
 	int uinput;
 
 	guint auth_id;
+	unsigned int passthrough_id;
+	unsigned int unit_id;
+	unsigned int subunit_id;
 
 	struct avctp_channel *control;
 	struct avctp_channel *browsing;
@@ -186,9 +190,7 @@ static struct {
 
 static GSList *callbacks = NULL;
 static GSList *servers = NULL;
-static GSList *control_handlers = NULL;
 static uint8_t id = 0;
-static struct avctp_browsing_pdu_handler *browsing_handler = NULL;
 
 static void auth_cb(DBusError *derr, void *user_data);
 
@@ -346,6 +348,7 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 		g_source_remove(chan->watch);
 
 	g_free(chan->buffer);
+	g_slist_free_full(chan->handlers, g_free);
 	g_free(chan);
 }
 
@@ -454,6 +457,7 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 	uint8_t *operands;
 	struct avctp_header *avctp;
 	int sock, ret, packet_size, operand_count;
+	struct avctp_browsing_pdu_handler *handler;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		goto failed;
@@ -480,10 +484,18 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 	packet_size = AVCTP_HEADER_LENGTH;
 	avctp->cr = AVCTP_RESPONSE;
 
-	packet_size += browsing_handler->cb(session, avctp->transaction,
+	handler = g_slist_nth_data(browsing->handlers, 0);
+	if (handler == NULL) {
+		DBG("handler not found");
+		packet_size += avrcp_browsing_general_reject(operands);
+		goto send;
+	}
+
+	packet_size += handler->cb(session, avctp->transaction,
 						operands, operand_count,
-						browsing_handler->user_data);
+						handler->user_data);
 
+send:
 	if (packet_size != 0) {
 		ret = write(sock, buf, packet_size);
 		if (ret != packet_size)
@@ -570,7 +582,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 		goto done;
 	}
 
-	handler = find_handler(control_handlers, avc->opcode);
+	handler = find_handler(control->handlers, avc->opcode);
 	if (!handler) {
 		DBG("handler not found for 0x%02x", avc->opcode);
 		packet_size += avrcp_handle_vendor_reject(&code, operands);
@@ -774,6 +786,19 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) session_cb, session);
 
+	session->passthrough_id = avctp_register_pdu_handler(session,
+						AVC_OP_PASSTHROUGH,
+						handle_panel_passthrough,
+						NULL);
+	session->unit_id = avctp_register_pdu_handler(session,
+						AVC_OP_UNITINFO,
+						handle_unit_info,
+						NULL);
+	session->subunit_id = avctp_register_pdu_handler(session,
+						AVC_OP_SUBUNITINFO,
+						handle_subunit_info,
+						NULL);
+
 	init_uinput(session);
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTED);
@@ -896,12 +921,6 @@ static void avctp_browsing_confirm(struct avctp *session, GIOChannel *chan,
 		return;
 	}
 
-	if (browsing_handler == NULL) {
-		error("Browsing: Handler not registered");
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		return;
-	}
-
 	if (bt_io_accept(chan, avctp_connect_browsing_cb, session, NULL,
 								&err))
 		return;
@@ -994,10 +1013,6 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
 	return io;
 }
 
-static unsigned int passthrough_id = 0;
-static unsigned int unit_id = 0;
-static unsigned int subunit_id = 0;
-
 int avctp_register(const bdaddr_t *src, gboolean master)
 {
 	struct avctp_server *server;
@@ -1026,18 +1041,6 @@ int avctp_register(const bdaddr_t *src, gboolean master)
 
 	servers = g_slist_append(servers, server);
 
-	if (!passthrough_id)
-		passthrough_id = avctp_register_pdu_handler(AVC_OP_PASSTHROUGH,
-					handle_panel_passthrough, NULL);
-
-	if (!unit_id)
-		unit_id = avctp_register_pdu_handler(AVC_OP_UNITINFO, handle_unit_info,
-									NULL);
-
-	if (!subunit_id)
-		subunit_id = avctp_register_pdu_handler(AVC_OP_SUBUNITINFO,
-						handle_subunit_info, NULL);
-
 	return 0;
 }
 
@@ -1061,24 +1064,6 @@ void avctp_unregister(const bdaddr_t *src)
 	g_io_channel_shutdown(server->control_io, TRUE, NULL);
 	g_io_channel_unref(server->control_io);
 	g_free(server);
-
-	if (servers)
-		return;
-
-	if (passthrough_id) {
-		avctp_unregister_pdu_handler(passthrough_id);
-		passthrough_id = 0;
-	}
-
-	if (unit_id) {
-		avctp_unregister_pdu_handler(unit_id);
-		passthrough_id = 0;
-	}
-
-	if (subunit_id) {
-		avctp_unregister_pdu_handler(subunit_id);
-		subunit_id = 0;
-	}
 }
 
 int avctp_send_passthrough(struct avctp *session, uint8_t op)
@@ -1230,13 +1215,18 @@ gboolean avctp_remove_state_cb(unsigned int id)
 	return FALSE;
 }
 
-unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
-							void *user_data)
+unsigned int avctp_register_pdu_handler(struct avctp *session, uint8_t opcode,
+						avctp_control_pdu_cb cb,
+						void *user_data)
 {
+	struct avctp_channel *control = session->control;
 	struct avctp_pdu_handler *handler;
 	static unsigned int id = 0;
 
-	handler = find_handler(control_handlers, opcode);
+	if (control == NULL)
+		return 0;
+
+	handler = find_handler(control->handlers, opcode);
 	if (handler)
 		return 0;
 
@@ -1246,36 +1236,63 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
 	handler->user_data = user_data;
 	handler->id = ++id;
 
-	control_handlers = g_slist_append(control_handlers, handler);
+	control->handlers = g_slist_append(control->handlers, handler);
 
 	return handler->id;
 }
 
-unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
-					void *user_data)
+unsigned int avctp_register_browsing_pdu_handler(struct avctp *session,
+						avctp_browsing_pdu_cb cb,
+						void *user_data)
 {
-	unsigned int id = 0;
+	struct avctp_channel *browsing = session->browsing;
+	struct avctp_browsing_pdu_handler *handler;
+	static unsigned int id = 0;
+
+	if (browsing == NULL)
+		return 0;
+
+	if (browsing->handlers != NULL)
+		return 0;
+
+	handler = g_new(struct avctp_browsing_pdu_handler, 1);
+	handler->cb = cb;
+	handler->user_data = user_data;
+	handler->id = ++id;
 
-	browsing_handler = g_new(struct avctp_browsing_pdu_handler, 1);
-	browsing_handler->cb = cb;
-	browsing_handler->user_data = user_data;
-	browsing_handler->id = ++id;
+	browsing->handlers = g_slist_append(browsing->handlers, handler);
 
-	return browsing_handler->id;
+	return handler->id;
 }
 
 gboolean avctp_unregister_pdu_handler(unsigned int id)
 {
 	GSList *l;
 
-	for (l = control_handlers; l != NULL; l = l->next) {
-		struct avctp_pdu_handler *handler = l->data;
+	for (l = servers; l; l = l->next) {
+		struct avctp_server *server = l->data;
+		GSList *s;
 
-		if (handler->id == id) {
-			control_handlers = g_slist_remove(control_handlers,
-								handler);
-			g_free(handler);
-			return TRUE;
+		for (s = server->sessions; s; s = s->next) {
+			struct avctp *session = s->data;
+			struct avctp_channel *control = session->control;
+			GSList *h;
+
+			if (control == NULL)
+				continue;
+
+			for (h = control->handlers; h; h = h->next) {
+				struct avctp_pdu_handler *handler = h->data;
+
+				if (handler->id != id)
+					continue;
+
+				control->handlers = g_slist_remove(
+							control->handlers,
+							handler);
+				g_free(handler);
+				return TRUE;
+			}
 		}
 	}
 
@@ -1284,12 +1301,37 @@ gboolean avctp_unregister_pdu_handler(unsigned int id)
 
 gboolean avctp_unregister_browsing_pdu_handler(unsigned int id)
 {
-	if (browsing_handler->id != id)
-		return FALSE;
+	GSList *l;
 
-	g_free(browsing_handler);
-	browsing_handler = NULL;
-	return TRUE;
+	for (l = servers; l; l = l->next) {
+		struct avctp_server *server = l->data;
+		GSList *s;
+
+		for (s = server->sessions; s; s = s->next) {
+			struct avctp *session = l->data;
+			struct avctp_channel *browsing = session->browsing;
+			GSList *h;
+
+			if (browsing == NULL)
+				continue;
+
+			for (h = browsing->handlers; h; h = h->next) {
+				struct avctp_browsing_pdu_handler *handler =
+								h->data;
+
+				if (handler->id != id)
+					continue;
+
+				browsing->handlers = g_slist_remove(
+							browsing->handlers,
+							handler);
+				g_free(handler);
+				return TRUE;
+			}
+		}
+	}
+
+	return FALSE;
 }
 
 struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
diff --git a/audio/avctp.h b/audio/avctp.h
index 6d39a20..41cf6c5 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -98,12 +98,14 @@ struct avctp *avctp_get(const bdaddr_t *src, const bdaddr_t *dst);
 int avctp_connect_browsing(struct avctp *session);
 void avctp_disconnect(struct avctp *session);
 
-unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
-							void *user_data);
+unsigned int avctp_register_pdu_handler(struct avctp *session, uint8_t opcode,
+						avctp_control_pdu_cb cb,
+						void *user_data);
 gboolean avctp_unregister_pdu_handler(unsigned int id);
 
-unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
-							void *user_data);
+unsigned int avctp_register_browsing_pdu_handler(struct avctp *session,
+						avctp_browsing_pdu_cb cb,
+						void *user_data);
 gboolean avctp_unregister_browsing_pdu_handler(unsigned int id);
 
 int avctp_send_passthrough(struct avctp *session, uint8_t op);
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 1ed6a24..f31372b 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -184,8 +184,8 @@ struct avrcp {
 	uint16_t version;
 	int features;
 
-	unsigned int control_handler;
-	unsigned int browsing_handler;
+	unsigned int control_id;
+	unsigned int browsing_id;
 	uint16_t registered_events;
 	uint8_t transaction;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
@@ -1228,6 +1228,19 @@ static struct browsing_pdu_handler {
 		{ },
 };
 
+size_t avrcp_browsing_general_reject(uint8_t *operands)
+{
+	struct avrcp_browsing_header *pdu = (void *) operands;
+	uint8_t status;
+
+	pdu->pdu_id = AVRCP_GENERAL_REJECT;
+	status = AVRCP_STATUS_INVALID_COMMAND;
+
+	pdu->param_len = htons(sizeof(status));
+	memcpy(pdu->params, &status, (sizeof(status)));
+	return AVRCP_BROWSING_HEADER_LENGTH + sizeof(status);
+}
+
 static size_t handle_browsing_pdu(struct avctp *conn,
 					uint8_t transaction, uint8_t *operands,
 					size_t operand_count, void *user_data)
@@ -1235,7 +1248,6 @@ static size_t handle_browsing_pdu(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct browsing_pdu_handler *handler;
 	struct avrcp_browsing_header *pdu = (void *) operands;
-	uint8_t status;
 
 	DBG("AVRCP Browsing PDU 0x%02X, len 0x%04X", pdu->pdu_id,
 							pdu->param_len);
@@ -1245,20 +1257,12 @@ static size_t handle_browsing_pdu(struct avctp *conn,
 			break;
 	}
 
-	if (handler == NULL || handler->func == NULL) {
-		pdu->pdu_id = AVRCP_GENERAL_REJECT;
-		status = AVRCP_STATUS_INVALID_COMMAND;
-		goto err;
-	}
+	if (handler == NULL || handler->func == NULL)
+		return avrcp_browsing_general_reject(operands);
 
 	session->transaction = transaction;
 	handler->func(session, pdu, transaction);
 	return AVRCP_BROWSING_HEADER_LENGTH + ntohs(pdu->param_len);
-
-err:
-	pdu->param_len = htons(sizeof(status));
-	memcpy(pdu->params, &status, (sizeof(status)));
-	return AVRCP_BROWSING_HEADER_LENGTH + sizeof(status);
 }
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
@@ -1370,12 +1374,12 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		server->sessions = g_slist_remove(server->sessions, session);
 
-		if (session->control_handler)
-			avctp_unregister_pdu_handler(session->control_handler);
+		if (session->control_id > 0)
+			avctp_unregister_pdu_handler(session->control_id);
 
-		if (session->browsing_handler)
+		if (session->browsing_id > 0)
 			avctp_unregister_browsing_pdu_handler(
-						session->browsing_handler);
+							session->browsing_id);
 
 		if (session->player != NULL)
 			session->player->sessions = g_slist_remove(
@@ -1394,15 +1398,6 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		session->dev = dev;
 		session->player = g_slist_nth_data(server->players, 0);
 
-		session->control_handler = avctp_register_pdu_handler(
-							AVC_OP_VENDORDEP,
-							handle_vendordep_pdu,
-							session);
-		session->browsing_handler =
-					avctp_register_browsing_pdu_handler(
-							handle_browsing_pdu,
-							session);
-
 		server->sessions = g_slist_append(server->sessions, session);
 
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
@@ -1429,6 +1424,15 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			if (session->features & AVRCP_FEATURE_BROWSING)
 				avctp_connect_browsing(session->conn);
 		}
+
+		session->control_id = avctp_register_pdu_handler(session->conn,
+							AVC_OP_VENDORDEP,
+							handle_vendordep_pdu,
+							session);
+		session->browsing_id = avctp_register_browsing_pdu_handler(
+							session->conn,
+							handle_browsing_pdu,
+							session);
 	default:
 		return;
 	}
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 42d902b..6c651dd 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -105,3 +105,4 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
 
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
+size_t avrcp_browsing_general_reject(uint8_t *operands);
-- 
1.7.11.4

