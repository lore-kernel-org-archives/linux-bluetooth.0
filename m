Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/16] AVCTP: Add proper queueing for channels
Date: Mon, 15 Oct 2012 16:05:30 +0200
Message-Id: <1350309936-31588-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add a request queue to channels to avoid dispatching too many requests
at once as the number of transaction is quite limited (16).
---
 audio/avctp.c | 343 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 245 insertions(+), 98 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index b982a3b..0db6031 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -125,19 +125,40 @@ struct avctp_server {
 	GSList *sessions;
 };
 
-struct avctp_rsp_handler {
-	uint8_t id;
+struct avctp_control_req {
+	struct avctp_pending_req *p;
+	uint8_t code;
+	uint8_t subunit;
+	uint8_t op;
+	uint8_t *operands;
+	uint16_t operand_count;
 	avctp_rsp_cb func;
 	void *user_data;
 };
 
+typedef int (*avctp_process_cb) (void *data);
+
+struct avctp_pending_req {
+	struct avctp_channel *chan;
+	uint8_t transaction;
+	guint timeout;
+	avctp_process_cb process;
+	void *data;
+	GDestroyNotify destroy;
+};
+
 struct avctp_channel {
+	struct avctp *session;
 	GIOChannel *io;
 	guint watch;
 	uint16_t imtu;
 	uint16_t omtu;
 	uint8_t *buffer;
 	GSList *handlers;
+	struct avctp_pending_req *p;
+	GQueue *queue;
+	GSList *processed;
+	guint process_id;
 };
 
 struct avctp {
@@ -157,7 +178,6 @@ struct avctp {
 	struct avctp_channel *browsing;
 
 	uint8_t key_quirks[256];
-	GSList *handlers;
 };
 
 struct avctp_pdu_handler {
@@ -190,9 +210,9 @@ static struct {
 
 static GSList *callbacks = NULL;
 static GSList *servers = NULL;
-static uint8_t id = 0;
 
 static void auth_cb(DBusError *derr, void *user_data);
+static gboolean process_queue(gpointer user_data);
 
 static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
 {
@@ -339,6 +359,19 @@ static struct avctp_pdu_handler *find_handler(GSList *list, uint8_t opcode)
 	return NULL;
 }
 
+static void pending_destroy(void *data)
+{
+	struct avctp_pending_req *req = data;
+
+	if (req->destroy)
+		req->destroy(req->data);
+
+	if (req->timeout > 0)
+		g_source_remove(req->timeout);
+
+	g_free(req);
+}
+
 static void avctp_channel_destroy(struct avctp_channel *chan)
 {
 	g_io_channel_shutdown(chan->io, TRUE, NULL);
@@ -347,7 +380,12 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 	if (chan->watch)
 		g_source_remove(chan->watch);
 
+	if (chan->process_id > 0)
+		g_source_remove(chan->process_id);
+
 	g_free(chan->buffer);
+	g_queue_free_full(chan->queue, pending_destroy);
+	g_slist_free_full(chan->processed, pending_destroy);
 	g_slist_free_full(chan->handlers, g_free);
 	g_free(chan);
 }
@@ -383,7 +421,6 @@ static void avctp_disconnected(struct avctp *session)
 
 	server = session->server;
 	server->sessions = g_slist_remove(server->sessions, session);
-	g_slist_free_full(session->handlers, g_free);
 	g_free(session);
 }
 
@@ -423,26 +460,157 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 	}
 }
 
-static void control_response(struct avctp *session, struct avctp_header *avctp,
-				struct avc_header *avc, uint8_t *operands,
-				size_t operand_count)
+static int avctp_send(struct avctp_channel *control, uint8_t transaction,
+				uint8_t cr, uint8_t code,
+				uint8_t subunit, uint8_t opcode,
+				uint8_t *operands, size_t operand_count)
+{
+	struct avctp_header *avctp;
+	struct avc_header *avc;
+	struct msghdr msg;
+	struct iovec iov[2];
+	int sk, err = 0;
+
+	DBG("transaction %u", transaction);
+
+	iov[0].iov_base = control->buffer;
+	iov[0].iov_len  = sizeof(*avctp) + sizeof(*avc);
+	iov[1].iov_base = operands;
+	iov[1].iov_len  = operand_count;
+
+	if (control->omtu < (iov[0].iov_len + iov[1].iov_len))
+		return -EOVERFLOW;
+
+	sk = g_io_channel_unix_get_fd(control->io);
+
+	memset(control->buffer, 0, iov[0].iov_len);
+
+	avctp = (void *) control->buffer;
+	avc = (void *) avctp + sizeof(*avctp);
+
+	avctp->transaction = transaction;
+	avctp->packet_type = AVCTP_PACKET_SINGLE;
+	avctp->cr = cr;
+	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
+
+	avc->code = code;
+	avc->subunit_type = subunit;
+	avc->opcode = opcode;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 2;
+
+	if (sendmsg(sk, &msg, 0) < 0)
+		err = -errno;
+
+	return err;
+}
+
+static void control_req_destroy(void *data)
+{
+	struct avctp_control_req *req = data;
+
+	g_free(req->operands);
+	g_free(req);
+}
+
+static gboolean req_timeout(gpointer user_data)
+{
+	struct avctp_channel *chan = user_data;
+	struct avctp_pending_req *p = chan->p;
+
+	DBG("transaction %u", p->transaction);
+
+	p->timeout = 0;
+
+	pending_destroy(p);
+	chan->p = NULL;
+
+	if (chan->process_id == 0)
+		chan->process_id = g_idle_add(process_queue, chan);
+
+	return FALSE;
+}
+
+static int process_control(void *data)
+{
+	struct avctp_control_req *req = data;
+	struct avctp_pending_req *p = req->p;
+
+	return avctp_send(p->chan, p->transaction, AVCTP_COMMAND, req->code,
+					req->subunit, req->op,
+					req->operands, req->operand_count);
+}
+
+static gboolean process_queue(void *user_data)
+{
+	struct avctp_channel *chan = user_data;
+	struct avctp_pending_req *p = chan->p;
+
+	chan->process_id = 0;
+
+	if (p != NULL)
+		return FALSE;
+
+	while ((p = g_queue_pop_head(chan->queue))) {
+
+		if (p->process(p->data) == 0)
+			break;
+
+		pending_destroy(p);
+	}
+
+	if (p == NULL)
+		return FALSE;
+
+	chan->p = p;
+	p->timeout = g_timeout_add_seconds(2, req_timeout, chan);
+
+	return FALSE;
+
+}
+
+static void control_response(struct avctp_channel *control,
+					struct avctp_header *avctp,
+					struct avc_header *avc,
+					uint8_t *operands,
+					size_t operand_count)
 {
+	struct avctp_pending_req *p = control->p;
+	struct avctp_control_req *req = p->data;
 	GSList *l;
 
-	for (l = session->handlers; l; l = l->next) {
-		struct avctp_rsp_handler *handler = l->data;
+	if (p && p->transaction == avctp->transaction) {
+		control->processed = g_slist_prepend(control->processed, p);
+
+		if (p->timeout > 0) {
+			g_source_remove(p->timeout);
+			p->timeout = 0;
+		}
+
+		control->p = NULL;
+
+		if (control->process_id == 0)
+			control->process_id = g_idle_add(process_queue,
+								control);
+	}
+
+	for (l = control->processed; l; l = l->next) {
+		p = l->data;
+		req = p->data;
 
-		if (handler->id != avctp->transaction)
+		if (p->transaction != avctp->transaction)
 			continue;
 
-		if (handler->func && handler->func(session, avc->code,
+		if (req->func && req->func(control->session, avc->code,
 						avc->subunit_type,
 						operands, operand_count,
-						handler->user_data))
+						req->user_data))
 			return;
 
-		session->handlers = g_slist_remove(session->handlers, handler);
-		g_free(handler);
+		control->processed = g_slist_remove(control->processed, p);
+		pending_destroy(p);
 
 		return;
 	}
@@ -564,7 +732,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 			avc->opcode, operand_count);
 
 	if (avctp->cr == AVCTP_RESPONSE) {
-		control_response(session, avctp, avc, operands, operand_count);
+		control_response(control, avctp, avc, operands, operand_count);
 		return TRUE;
 	}
 
@@ -692,12 +860,15 @@ static void init_uinput(struct avctp *session)
 		DBG("AVRCP: uinput initialized for %s", address);
 }
 
-static struct avctp_channel *avctp_channel_create(GIOChannel *io)
+static struct avctp_channel *avctp_channel_create(struct avctp *session,
+							GIOChannel *io)
 {
 	struct avctp_channel *chan;
 
 	chan = g_new0(struct avctp_channel, 1);
+	chan->session = session;
 	chan->io = g_io_channel_ref(io);
+	chan->queue = g_queue_new();
 
 	return chan;
 }
@@ -731,7 +902,7 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 	DBG("AVCTP Browsing: connected to %s", address);
 
 	if (session->browsing == NULL)
-		session->browsing = avctp_channel_create(chan);
+		session->browsing = avctp_channel_create(session, chan);
 
 	session->browsing->imtu = imtu;
 	session->browsing->omtu = omtu;
@@ -777,7 +948,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	DBG("AVCTP: connected to %s", address);
 
 	if (session->control == NULL)
-		session->control = avctp_channel_create(chan);
+		session->control = avctp_channel_create(session, chan);
 
 	session->control->imtu = imtu;
 	session->control->omtu = omtu;
@@ -894,7 +1065,7 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	}
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
-	session->control = avctp_channel_create(chan);
+	session->control = avctp_channel_create(session, chan);
 
 	session->auth_id = btd_request_authorization(&dev->src, &dev->dst,
 							AVRCP_TARGET_UUID,
@@ -1066,52 +1237,25 @@ void avctp_unregister(const bdaddr_t *src)
 	g_free(server);
 }
 
-static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
-				uint8_t code, uint8_t subunit, uint8_t opcode,
-				uint8_t *operands, size_t operand_count)
+static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
+						avctp_process_cb process,
+						void *data,
+						GDestroyNotify destroy)
 {
-	struct avctp_channel *control = session->control;
-	struct avctp_header *avctp;
-	struct avc_header *avc;
-	struct msghdr msg;
-	struct iovec iov[2];
-	int sk, err = 0;
-
-	if (session->state != AVCTP_STATE_CONNECTED)
-		return -ENOTCONN;
-
-	iov[0].iov_base = control->buffer;
-	iov[0].iov_len  = sizeof(*avctp) + sizeof(*avc);
-	iov[1].iov_base = operands;
-	iov[1].iov_len  = operand_count;
-
-	if (control->omtu < (iov[0].iov_len + iov[1].iov_len))
-		return -EOVERFLOW;
-
-	sk = g_io_channel_unix_get_fd(session->control->io);
-
-	memset(control->buffer, 0, iov[0].iov_len);
-
-	avctp = (void *) control->buffer;
-	avc = (void *) avctp + sizeof(*avctp);
-
-	avctp->transaction = transaction;
-	avctp->packet_type = AVCTP_PACKET_SINGLE;
-	avctp->cr = cr;
-	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
-
-	avc->code = code;
-	avc->subunit_type = subunit;
-	avc->opcode = opcode;
+	struct avctp_pending_req *p;
+	static uint8_t transaction = 0;
 
-	memset(&msg, 0, sizeof(msg));
-	msg.msg_iov = iov;
-	msg.msg_iovlen = 2;
+	p = g_new0(struct avctp_pending_req, 1);
+	p->chan = chan;
+	p->transaction = transaction;
+	p->process = process;
+	p->data = data;
+	p->destroy = destroy;
 
-	if (sendmsg(sk, &msg, 0) < 0)
-		err = -errno;
+	transaction++;
+	transaction %= 16;
 
-	return err;
+	return p;
 }
 
 static int avctp_send_req(struct avctp *session, uint8_t code,
@@ -1119,22 +1263,30 @@ static int avctp_send_req(struct avctp *session, uint8_t code,
 				uint8_t *operands, size_t operand_count,
 				avctp_rsp_cb func, void *user_data)
 {
-	struct avctp_rsp_handler *handler;
-	int err;
+	struct avctp_channel *control = session->control;
+	struct avctp_pending_req *p;
+	struct avctp_control_req *req;
 
-	err = avctp_send(session, id, AVCTP_COMMAND, code, subunit,
-				opcode, operands, operand_count);
-	if (err < 0)
-		return err;
+	if (control == NULL)
+		return -ENOTCONN;
 
-	handler = g_new0(struct avctp_rsp_handler, 1);
-	handler->id = id;
-	handler->func = func;
-	handler->user_data = user_data;
+	req = g_new0(struct avctp_control_req, 1);
+	req->code = code;
+	req->subunit = subunit;
+	req->op = opcode;
+	req->func = func;
+	req->operands = g_memdup(operands, operand_count);
+	req->operand_count = operand_count;
+	req->user_data = user_data;
+
+	p = pending_create(control, process_control, req, control_req_destroy);
+
+	req->p = p;
 
-	session->handlers = g_slist_prepend(session->handlers, handler);
+	g_queue_push_tail(control->queue, p);
 
-	id++;
+	if (control->process_id == 0)
+		control->process_id = g_idle_add(process_queue, control);
 
 	return 0;
 }
@@ -1143,15 +1295,18 @@ static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
 {
+	DBG("code %u", code);
+
 	if (code != AVC_CTYPE_ACCEPTED)
 		return FALSE;
 
 	/* Button release */
 	operands[0] |= 0x80;
 
-	avctp_send(session, id, AVCTP_COMMAND, AVC_CTYPE_CONTROL,
-					AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
-					operands, sizeof(operand_count));
+	avctp_send_req(session, AVC_CTYPE_CONTROL,
+				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
+				operands, operand_count,
+				NULL, NULL);
 
 	return FALSE;
 }
@@ -1160,6 +1315,8 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op)
 {
 	uint8_t operands[2];
 
+	DBG("");
+
 	/* Button pressed */
 	operands[0] = op & 0x7f;
 	operands[1] = 0;
@@ -1174,7 +1331,12 @@ int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
 				uint8_t *operands, size_t operand_count)
 {
-	return avctp_send(session, transaction, AVCTP_RESPONSE, code, subunit,
+	struct avctp_channel *control = session->control;
+
+	if (control == NULL)
+		return -ENOTCONN;
+
+	return avctp_send(control, transaction, AVCTP_RESPONSE, code, subunit,
 					AVC_OP_VENDORDEP, operands, operand_count);
 }
 
@@ -1183,24 +1345,9 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 					size_t operand_count,
 					avctp_rsp_cb func, void *user_data)
 {
-	struct avctp_rsp_handler *handler;
-	int err;
-
-	err = avctp_send(session, id, AVCTP_COMMAND, code, subunit,
-				AVC_OP_VENDORDEP, operands, operand_count);
-	if (err < 0)
-		return err;
-
-	handler = g_new0(struct avctp_rsp_handler, 1);
-	handler->id = id;
-	handler->func = func;
-	handler->user_data = user_data;
-
-	session->handlers = g_slist_prepend(session->handlers, handler);
-
-	id++;
-
-	return 0;
+	return avctp_send_req(session, code, subunit, AVC_OP_VENDORDEP,
+						operands, operand_count,
+						func, user_data);
 }
 
 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data)
@@ -1380,7 +1527,7 @@ struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
 		return NULL;
 	}
 
-	session->control = avctp_channel_create(io);
+	session->control = avctp_channel_create(session, io);
 	g_io_channel_unref(io);
 
 	return session;
@@ -1409,7 +1556,7 @@ int avctp_connect_browsing(struct avctp *session)
 		return -EIO;
 	}
 
-	session->browsing = avctp_channel_create(io);
+	session->browsing = avctp_channel_create(session, io);
 	g_io_channel_unref(io);
 
 	return 0;
-- 
1.7.11.4

