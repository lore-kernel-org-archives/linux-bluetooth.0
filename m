Return-Path: <cyrus@holtmann.org>
From: Ido Yariv <ido@wizery.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Ido Yariv <ido@wizery.com>
Subject: [PATCH v3] gattrib: Fix a request/response command deadlock
Date: Tue, 29 May 2012 11:39:23 +0300
Message-Id: <1338280763-3050-1-git-send-email-ido@wizery.com>
In-Reply-To: <20120529024058.GA2382@echo>
References: <20120529024058.GA2382@echo>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

New requests and responses are never sent if a request was sent and the
response for it hasn't been received yet. As a result, if both end
points send requests at the same time, a deadlock could occur. This
could happen, for instance, if the client sends a read request and the
server sends an indication before responding to the read request.

Fix this by introducing an additional queue for responses. Responses may
be sent while there's still a pending request/indication.
---
Changes from v2:
- Cancel responses in g_attrib_cancel_all even if the requests queue is NULL

 attrib/gattrib.c |  111 ++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 87 insertions(+), 24 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 769be36..9886a92 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -46,7 +46,8 @@ struct _GAttrib {
 	guint read_watch;
 	guint write_watch;
 	guint timeout_watch;
-	GQueue *queue;
+	GQueue *requests;
+	GQueue *responses;
 	GSList *events;
 	guint next_cmd_id;
 	guint next_evt_id;
@@ -173,11 +174,17 @@ static void attrib_destroy(GAttrib *attrib)
 	GSList *l;
 	struct command *c;
 
-	while ((c = g_queue_pop_head(attrib->queue)))
+	while ((c = g_queue_pop_head(attrib->requests)))
+		command_destroy(c);
+
+	while ((c = g_queue_pop_head(attrib->responses)))
 		command_destroy(c);
 
-	g_queue_free(attrib->queue);
-	attrib->queue = NULL;
+	g_queue_free(attrib->requests);
+	attrib->requests = NULL;
+
+	g_queue_free(attrib->responses);
+	attrib->responses = NULL;
 
 	for (l = attrib->events; l; l = l->next)
 		event_destroy(l->data);
@@ -259,21 +266,34 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 	GError *gerr = NULL;
 	gsize len;
 	GIOStatus iostat;
+	GQueue *queue;
 
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
 		return FALSE;
 
-	cmd = g_queue_peek_head(attrib->queue);
+	queue = attrib->responses;
+	cmd = g_queue_peek_head(queue);
+	if (cmd == NULL) {
+		queue = attrib->requests;
+		cmd = g_queue_peek_head(queue);
+	}
 	if (cmd == NULL)
 		return FALSE;
 
+	/*
+	 * Verify that we didn't already send this command. This can only
+	 * happen with elementes from attrib->requests.
+	 */
+	if (cmd->sent)
+		return FALSE;
+
 	iostat = g_io_channel_write_chars(io, (gchar *) cmd->pdu, cmd->len,
 								&len, &gerr);
 	if (iostat != G_IO_STATUS_NORMAL)
 		return FALSE;
 
 	if (cmd->expected == 0) {
-		g_queue_pop_head(attrib->queue);
+		g_queue_pop_head(queue);
 		command_destroy(cmd);
 
 		return TRUE;
@@ -315,7 +335,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	uint8_t buf[512], status;
 	gsize len;
 	GIOStatus iostat;
-	gboolean qempty;
+	gboolean norequests, noresponses;
 
 	if (attrib->timeout_watch > 0) {
 		g_source_remove(attrib->timeout_watch);
@@ -349,7 +369,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	if (is_response(buf[0]) == FALSE)
 		return TRUE;
 
-	cmd = g_queue_pop_head(attrib->queue);
+	cmd = g_queue_pop_head(attrib->requests);
 	if (cmd == NULL) {
 		/* Keep the watch if we have events to report */
 		return attrib->events != NULL;
@@ -368,7 +388,10 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	status = 0;
 
 done:
-	qempty = attrib->queue == NULL || g_queue_is_empty(attrib->queue);
+	norequests = attrib->requests == NULL ||
+			g_queue_is_empty(attrib->requests);
+	noresponses = attrib->responses == NULL ||
+			g_queue_is_empty(attrib->responses);
 
 	if (cmd) {
 		if (cmd->func)
@@ -377,7 +400,7 @@ done:
 		command_destroy(cmd);
 	}
 
-	if (!qempty)
+	if (!norequests || !noresponses)
 		wake_up_sender(attrib);
 
 	return TRUE;
@@ -396,7 +419,8 @@ GAttrib *g_attrib_new(GIOChannel *io)
 		return NULL;
 
 	attrib->io = g_io_channel_ref(io);
-	attrib->queue = g_queue_new();
+	attrib->requests = g_queue_new();
+	attrib->responses = g_queue_new();
 
 	attrib->read_watch = g_io_add_watch(attrib->io,
 			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
@@ -421,6 +445,7 @@ guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
 			gpointer user_data, GDestroyNotify notify)
 {
 	struct command *c;
+	GQueue *queue;
 
 	c = g_try_new0(struct command, 1);
 	if (c == NULL)
@@ -435,15 +460,29 @@ guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
 	c->user_data = user_data;
 	c->notify = notify;
 
+	if (is_response(opcode))
+		queue = attrib->responses;
+	else
+		queue = attrib->requests;
+
 	if (id) {
 		c->id = id;
-		g_queue_push_head(attrib->queue, c);
+		if (!is_response(opcode))
+			g_queue_push_head(queue, c);
+		else
+			/* Don't re-order responses even if an ID is given */
+			g_queue_push_tail(queue, c);
 	} else {
 		c->id = ++attrib->next_cmd_id;
-		g_queue_push_tail(attrib->queue, c);
+		g_queue_push_tail(queue, c);
 	}
 
-	if (g_queue_get_length(attrib->queue) == 1)
+	/*
+	 * If a command was added to the queue and it was empty before, wake up
+	 * the sender. If the sender was already woken up by the second queue,
+	 * wake_up_sender will just return.
+	 */
+	if (g_queue_get_length(queue) == 1)
 		wake_up_sender(attrib);
 
 	return c->id;
@@ -459,38 +498,49 @@ static gint command_cmp_by_id(gconstpointer a, gconstpointer b)
 
 gboolean g_attrib_cancel(GAttrib *attrib, guint id)
 {
-	GList *l;
+	GList *l = NULL;
 	struct command *cmd;
+	GQueue *queue;
 
-	if (attrib == NULL || attrib->queue == NULL)
+	if (attrib == NULL)
 		return FALSE;
 
-	l = g_queue_find_custom(attrib->queue, GUINT_TO_POINTER(id),
-							command_cmp_by_id);
+	queue = attrib->requests;
+	if (queue)
+		l = g_queue_find_custom(queue, GUINT_TO_POINTER(id),
+					command_cmp_by_id);
+	if (l == NULL) {
+		queue = attrib->responses;
+		if (!queue)
+			return FALSE;
+		l = g_queue_find_custom(queue, GUINT_TO_POINTER(id),
+					command_cmp_by_id);
+	}
+
 	if (l == NULL)
 		return FALSE;
 
 	cmd = l->data;
 
-	if (cmd == g_queue_peek_head(attrib->queue) && cmd->sent)
+	if (cmd == g_queue_peek_head(queue) && cmd->sent)
 		cmd->func = NULL;
 	else {
-		g_queue_remove(attrib->queue, cmd);
+		g_queue_remove(queue, cmd);
 		command_destroy(cmd);
 	}
 
 	return TRUE;
 }
 
-gboolean g_attrib_cancel_all(GAttrib *attrib)
+static gboolean cancel_all_per_queue(GQueue *queue)
 {
 	struct command *c, *head = NULL;
 	gboolean first = TRUE;
 
-	if (attrib == NULL || attrib->queue == NULL)
+	if (queue == NULL)
 		return FALSE;
 
-	while ((c = g_queue_pop_head(attrib->queue))) {
+	while ((c = g_queue_pop_head(queue))) {
 		if (first && c->sent) {
 			/* If the command was sent ignore its callback ... */
 			c->func = NULL;
@@ -504,12 +554,25 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
 
 	if (head) {
 		/* ... and put it back in the queue */
-		g_queue_push_head(attrib->queue, head);
+		g_queue_push_head(queue, head);
 	}
 
 	return TRUE;
 }
 
+gboolean g_attrib_cancel_all(GAttrib *attrib)
+{
+	gboolean ret;
+
+	if (attrib == NULL)
+		return FALSE;
+
+	ret = cancel_all_per_queue(attrib->requests);
+	ret = cancel_all_per_queue(attrib->responses) && ret;
+
+	return ret;
+}
+
 gboolean g_attrib_set_debug(GAttrib *attrib,
 		GAttribDebugFunc func, gpointer user_data)
 {
-- 
1.7.7.6

