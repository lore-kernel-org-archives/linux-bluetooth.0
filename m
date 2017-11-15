Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avctp: Use different queues for passthrough and vendor PDUs
Date: Wed, 15 Nov 2017 14:07:13 +0200
Message-Id: <20171115120713.7888-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

passthrough commands comes from a different specification which can
have more specific rules regarding timeout, etc, so this moves button
presses to their own queue which should enable them to be send in
parallel to other command on the control channel.
---
 profiles/audio/avctp.c | 225 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 152 insertions(+), 73 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 0d395814c..43309a020 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -61,7 +61,7 @@
  */
 #define AVC_PRESS_TIMEOUT	2
 
-#define CONTROL_TIMEOUT		AVC_PRESS_TIMEOUT
+#define CONTROL_TIMEOUT		10
 #define BROWSING_TIMEOUT	10
 
 #define QUIRK_NO_RELEASE 1 << 0
@@ -154,7 +154,7 @@ struct avctp_browsing_req {
 typedef int (*avctp_process_cb) (void *data);
 
 struct avctp_pending_req {
-	struct avctp_channel *chan;
+	struct avctp_queue *queue;
 	uint8_t transaction;
 	guint timeout;
 	bool retry;
@@ -164,6 +164,13 @@ struct avctp_pending_req {
 	GDestroyNotify destroy;
 };
 
+struct avctp_queue {
+	struct avctp_channel *chan;
+	struct avctp_pending_req *p;
+	GQueue *queue;
+	guint process_id;
+};
+
 struct avctp_channel {
 	struct avctp *session;
 	GIOChannel *io;
@@ -173,10 +180,8 @@ struct avctp_channel {
 	uint16_t omtu;
 	uint8_t *buffer;
 	GSList *handlers;
-	struct avctp_pending_req *p;
-	GQueue *queue;
+	GSList *queues;
 	GSList *processed;
-	guint process_id;
 	GDestroyNotify destroy;
 };
 
@@ -514,6 +519,21 @@ static void pending_destroy(gpointer data, gpointer user_data)
 	g_free(req);
 }
 
+static void avctp_queue_destroy(void *data)
+{
+	struct avctp_queue *queue = data;
+
+	if (queue->process_id > 0)
+		g_source_remove(queue->process_id);
+
+	if (queue->p)
+		pending_destroy(queue->p, NULL);
+
+	g_queue_foreach(queue->queue, pending_destroy, NULL);
+	g_queue_free(queue->queue);
+	g_free(queue);
+}
+
 static void avctp_channel_destroy(struct avctp_channel *chan)
 {
 	g_io_channel_shutdown(chan->io, TRUE, NULL);
@@ -522,18 +542,11 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 	if (chan->watch)
 		g_source_remove(chan->watch);
 
-	if (chan->p)
-		pending_destroy(chan->p, NULL);
-
-	if (chan->process_id > 0)
-		g_source_remove(chan->process_id);
-
 	if (chan->destroy)
 		chan->destroy(chan);
 
 	g_free(chan->buffer);
-	g_queue_foreach(chan->queue, pending_destroy, NULL);
-	g_queue_free(chan->queue);
+	g_slist_free_full(chan->queues, avctp_queue_destroy);
 	g_slist_foreach(chan->processed, pending_destroy, NULL);
 	g_slist_free(chan->processed);
 	g_slist_free_full(chan->handlers, g_free);
@@ -700,10 +713,11 @@ static int avctp_send(struct avctp_channel *control, uint8_t transaction,
 	return err;
 }
 
-static int avctp_browsing_send(struct avctp_channel *browsing,
+static int avctp_browsing_send(struct avctp_queue *queue,
 				uint8_t transaction, uint8_t cr,
 				uint8_t *operands, size_t operand_count)
 {
+	struct avctp_channel *browsing = queue->chan;
 	struct avctp_header *avctp;
 	struct msghdr msg;
 	struct iovec iov[2];
@@ -742,7 +756,7 @@ static void control_req_destroy(void *data)
 {
 	struct avctp_control_req *req = data;
 	struct avctp_pending_req *p = req->p;
-	struct avctp *session = p->chan->session;
+	struct avctp *session = p->queue->chan->session;
 
 	if (p->err == 0 || req->func == NULL)
 		goto done;
@@ -759,7 +773,7 @@ static void browsing_req_destroy(void *data)
 {
 	struct avctp_browsing_req *req = data;
 	struct avctp_pending_req *p = req->p;
-	struct avctp *session = p->chan->session;
+	struct avctp *session = p->queue->chan->session;
 
 	if (p->err == 0 || req->func == NULL)
 		goto done;
@@ -773,8 +787,8 @@ done:
 
 static gboolean req_timeout(gpointer user_data)
 {
-	struct avctp_channel *chan = user_data;
-	struct avctp_pending_req *p = chan->p;
+	struct avctp_queue *queue = user_data;
+	struct avctp_pending_req *p = queue->p;
 
 	DBG("transaction %u retry %s", p->transaction, p->retry ? "true" :
 								"false");
@@ -789,31 +803,48 @@ static gboolean req_timeout(gpointer user_data)
 	p->err = -ETIMEDOUT;
 
 	pending_destroy(p, NULL);
-	chan->p = NULL;
+	queue->p = NULL;
 
-	if (chan->process_id == 0)
-		chan->process_id = g_idle_add(process_queue, chan);
+	if (queue->process_id == 0)
+		queue->process_id = g_idle_add(process_queue, queue);
 
 	return FALSE;
 }
 
+static int process_passthrough(void *data)
+{
+	struct avctp_control_req *req = data;
+	struct avctp_pending_req *p = req->p;
+	int ret;
+
+	ret = avctp_send(p->queue->chan, p->transaction, AVCTP_COMMAND,
+			req->code, req->subunit, req->op, req->operands,
+			req->operand_count);
+	if (ret < 0)
+		return ret;
+
+	p->timeout = g_timeout_add_seconds(AVC_PRESS_TIMEOUT, req_timeout,
+								p->queue);
+
+	return 0;
+}
+
 static int process_control(void *data)
 {
 	struct avctp_control_req *req = data;
 	struct avctp_pending_req *p = req->p;
 	int ret;
 
-	ret = avctp_send(p->chan, p->transaction, AVCTP_COMMAND, req->code,
-			req->subunit, req->op, req->operands,
+	ret = avctp_send(p->queue->chan, p->transaction, AVCTP_COMMAND,
+			req->code, req->subunit, req->op, req->operands,
 			req->operand_count);
 	if (ret < 0)
 		return ret;
 
-	if (req->op != AVC_OP_PASSTHROUGH)
-		p->retry = !p->retry;
+	p->retry = !p->retry;
 
 	p->timeout = g_timeout_add_seconds(CONTROL_TIMEOUT, req_timeout,
-								p->chan);
+								p->queue);
 
 	return 0;
 }
@@ -824,28 +855,28 @@ static int process_browsing(void *data)
 	struct avctp_pending_req *p = req->p;
 	int ret;
 
-	ret = avctp_browsing_send(p->chan, p->transaction, AVCTP_COMMAND,
+	ret = avctp_browsing_send(p->queue, p->transaction, AVCTP_COMMAND,
 					req->operands, req->operand_count);
 	if (ret < 0)
 		return ret;
 
 	p->timeout = g_timeout_add_seconds(BROWSING_TIMEOUT, req_timeout,
-								p->chan);
+								p->queue);
 
 	return 0;
 }
 
 static gboolean process_queue(void *user_data)
 {
-	struct avctp_channel *chan = user_data;
-	struct avctp_pending_req *p = chan->p;
+	struct avctp_queue *queue = user_data;
+	struct avctp_pending_req *p = queue->p;
 
-	chan->process_id = 0;
+	queue->process_id = 0;
 
 	if (p != NULL)
 		return FALSE;
 
-	while ((p = g_queue_pop_head(chan->queue))) {
+	while ((p = g_queue_pop_head(queue->queue))) {
 
 		if (p->process(p->data) == 0)
 			break;
@@ -856,7 +887,7 @@ static gboolean process_queue(void *user_data)
 	if (p == NULL)
 		return FALSE;
 
-	chan->p = p;
+	queue->p = p;
 
 	return FALSE;
 
@@ -868,27 +899,36 @@ static void control_response(struct avctp_channel *control,
 					uint8_t *operands,
 					size_t operand_count)
 {
-	struct avctp_pending_req *p = control->p;
+	struct avctp_pending_req *p;
 	struct avctp_control_req *req;
 	GSList *l;
 
-	if (p && p->transaction == avctp->transaction) {
-		req = p->data;
-		if (req->op != avc->opcode)
-			goto done;
+	for (l = control->queues; l; l = g_slist_next(l)) {
+		struct avctp_queue *queue = l->data;
 
-		control->processed = g_slist_prepend(control->processed, p);
+		p = queue->p;
 
-		if (p->timeout > 0) {
-			g_source_remove(p->timeout);
-			p->timeout = 0;
-		}
+		if (p && p->transaction == avctp->transaction) {
+			req = p->data;
+			if (req->op != avc->opcode)
+				goto done;
+
+			control->processed = g_slist_prepend(control->processed,
+									p);
 
-		control->p = NULL;
+			if (p->timeout > 0) {
+				g_source_remove(p->timeout);
+				p->timeout = 0;
+			}
+
+			queue->p = NULL;
 
-		if (control->process_id == 0)
-			control->process_id = g_idle_add(process_queue,
-								control);
+			if (queue->process_id == 0)
+				queue->process_id = g_idle_add(process_queue,
+								queue);
+
+			break;
+		}
 	}
 
 done:
@@ -920,11 +960,18 @@ static void browsing_response(struct avctp_channel *browsing,
 					uint8_t *operands,
 					size_t operand_count)
 {
-	struct avctp_pending_req *p = browsing->p;
+	struct avctp_pending_req *p;
 	struct avctp_browsing_req *req;
 	GSList *l;
 
-	if (p && p->transaction == avctp->transaction) {
+	for (l = browsing->queues; l; l = g_slist_next(l)) {
+		struct avctp_queue *queue = l->data;
+
+		p = queue->p;
+
+		if (!p || p->transaction != avctp->transaction)
+			continue;
+
 		browsing->processed = g_slist_prepend(browsing->processed, p);
 
 		if (p->timeout > 0) {
@@ -932,11 +979,12 @@ static void browsing_response(struct avctp_channel *browsing,
 			p->timeout = 0;
 		}
 
-		browsing->p = NULL;
+		queue->p = NULL;
 
-		if (browsing->process_id == 0)
-			browsing->process_id = g_idle_add(process_queue,
-								browsing);
+		if (queue->process_id == 0)
+			queue->process_id = g_idle_add(process_queue, queue);
+
+		break;
 	}
 
 	for (l = browsing->processed; l; l = l->next) {
@@ -1193,8 +1241,20 @@ static void init_uinput(struct avctp *session)
 		DBG("AVRCP: uinput initialized for %s", address);
 }
 
+static struct avctp_queue *avctp_queue_create(struct avctp_channel *chan)
+{
+	struct avctp_queue *queue;
+
+	queue = g_new0(struct avctp_queue, 1);
+	queue->chan = chan;
+	queue->queue = g_queue_new();
+
+	return queue;
+}
+
 static struct avctp_channel *avctp_channel_create(struct avctp *session,
 							GIOChannel *io,
+							int queues,
 							GDestroyNotify destroy)
 {
 	struct avctp_channel *chan;
@@ -1202,9 +1262,15 @@ static struct avctp_channel *avctp_channel_create(struct avctp *session,
 	chan = g_new0(struct avctp_channel, 1);
 	chan->session = session;
 	chan->io = g_io_channel_ref(io);
-	chan->queue = g_queue_new();
 	chan->destroy = destroy;
 
+	while (queues--) {
+		struct avctp_queue *queue;
+
+		queue = avctp_queue_create(chan);
+		chan->queues = g_slist_prepend(chan->queues, queue);
+	}
+
 	return chan;
 }
 
@@ -1232,6 +1298,7 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 {
 	struct avctp *session = data;
 	struct avctp_channel *browsing = session->browsing;
+	struct avctp_queue *queue;
 	char address[18];
 	uint16_t imtu, omtu;
 	GError *gerr = NULL;
@@ -1257,7 +1324,7 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 	DBG("AVCTP Browsing: connected to %s", address);
 
 	if (browsing == NULL) {
-		browsing = avctp_channel_create(session, chan,
+		browsing = avctp_channel_create(session, chan, 1,
 						avctp_destroy_browsing);
 		session->browsing = browsing;
 	}
@@ -1272,8 +1339,9 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTED, 0);
 
 	/* Process any request that was pending the connection to complete */
-	if (browsing->process_id == 0 && !g_queue_is_empty(browsing->queue))
-		browsing->process_id = g_idle_add(process_queue, browsing);
+	queue = g_slist_nth_data(browsing->queues, 0);
+	if (queue->process_id == 0 && !g_queue_is_empty(queue->queue))
+		queue->process_id = g_idle_add(process_queue, queue);
 
 	return;
 
@@ -1314,7 +1382,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	DBG("AVCTP: connected to %s", address);
 
 	if (session->control == NULL)
-		session->control = avctp_channel_create(session, chan, NULL);
+		session->control = avctp_channel_create(session, chan, 2, NULL);
 
 	session->control->imtu = imtu;
 	session->control->omtu = omtu;
@@ -1436,7 +1504,7 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	}
 
 	avctp_set_state(session, AVCTP_STATE_CONNECTING, 0);
-	session->control = avctp_channel_create(session, chan, NULL);
+	session->control = avctp_channel_create(session, chan, 2, NULL);
 
 	src = btd_adapter_get_address(device_get_adapter(dev));
 	dst = device_get_address(dev);
@@ -1606,7 +1674,7 @@ void avctp_unregister(struct btd_adapter *adapter)
 	g_free(server);
 }
 
-static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
+static struct avctp_pending_req *pending_create(struct avctp_queue *queue,
 						avctp_process_cb process,
 						void *data,
 						GDestroyNotify destroy)
@@ -1614,8 +1682,8 @@ static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
 	struct avctp_pending_req *p;
 
 	p = g_new0(struct avctp_pending_req, 1);
-	p->chan = chan;
-	p->transaction = chan_get_transaction(chan);
+	p->queue = queue;
+	p->transaction = chan_get_transaction(queue->chan);
 	p->process = process;
 	p->data = data;
 	p->destroy = destroy;
@@ -1629,6 +1697,7 @@ static int avctp_send_req(struct avctp *session, uint8_t code,
 				avctp_rsp_cb func, void *user_data)
 {
 	struct avctp_channel *control = session->control;
+	struct avctp_queue *queue;
 	struct avctp_pending_req *p;
 	struct avctp_control_req *req;
 
@@ -1649,14 +1718,22 @@ static int avctp_send_req(struct avctp *session, uint8_t code,
 	req->operand_count = operand_count;
 	req->user_data = user_data;
 
-	p = pending_create(control, process_control, req, control_req_destroy);
+	if (opcode == AVC_OP_PASSTHROUGH) {
+		queue = g_slist_nth_data(control->queues, 0);
+		p = pending_create(queue, process_passthrough, req,
+					control_req_destroy);
+	} else {
+		queue = g_slist_nth_data(control->queues, 1);
+		p = pending_create(queue, process_control, req,
+					control_req_destroy);
+	}
 
 	req->p = p;
 
-	g_queue_push_tail(control->queue, p);
+	g_queue_push_tail(queue->queue, p);
 
-	if (control->process_id == 0)
-		control->process_id = g_idle_add(process_queue, control);
+	if (queue->process_id == 0)
+		queue->process_id = g_idle_add(process_queue, queue);
 
 	return 0;
 }
@@ -1666,6 +1743,7 @@ int avctp_send_browsing_req(struct avctp *session,
 				avctp_browsing_rsp_cb func, void *user_data)
 {
 	struct avctp_channel *browsing = session->browsing;
+	struct avctp_queue *queue;
 	struct avctp_pending_req *p;
 	struct avctp_browsing_req *req;
 
@@ -1678,19 +1756,20 @@ int avctp_send_browsing_req(struct avctp *session,
 	req->operand_count = operand_count;
 	req->user_data = user_data;
 
-	p = pending_create(browsing, process_browsing, req,
-			browsing_req_destroy);
+	queue = g_slist_nth_data(browsing->queues, 0);
+
+	p = pending_create(queue, process_browsing, req, browsing_req_destroy);
 
 	req->p = p;
 
-	g_queue_push_tail(browsing->queue, p);
+	g_queue_push_tail(queue->queue, p);
 
 	/* Connection did not complete, delay process of the request */
 	if (browsing->watch == 0)
 		return 0;
 
-	if (browsing->process_id == 0)
-		browsing->process_id = g_idle_add(process_queue, browsing);
+	if (queue->process_id == 0)
+		queue->process_id = g_idle_add(process_queue, queue);
 
 	return 0;
 }
@@ -2058,7 +2137,7 @@ struct avctp *avctp_connect(struct btd_device *device)
 		return NULL;
 	}
 
-	session->control = avctp_channel_create(session, io, NULL);
+	session->control = avctp_channel_create(session, io, 2, NULL);
 	session->initiator = true;
 	g_io_channel_unref(io);
 
@@ -2095,7 +2174,7 @@ int avctp_connect_browsing(struct avctp *session)
 		return -EIO;
 	}
 
-	session->browsing = avctp_channel_create(session, io,
+	session->browsing = avctp_channel_create(session, io, 1,
 						avctp_destroy_browsing);
 	g_io_channel_unref(io);
 
-- 
2.13.6

