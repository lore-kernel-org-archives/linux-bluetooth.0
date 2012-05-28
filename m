Return-Path: <cyrus@holtmann.org>
From: Ido Yariv <ido@wizery.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>
Subject: [PATCH] gattrib: Fix a request/response command deadlock
Date: Mon, 28 May 2012 21:34:31 +0300
Message-Id: <1338230071-27599-1-git-send-email-ido@wizery.com>
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
 attrib/gattrib.c |   86 +++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 769be36..769d746 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -47,6 +47,7 @@ struct _GAttrib {
 	guint write_watch;
 	guint timeout_watch;
 	GQueue *queue;
+	GQueue *response_queue;
 	GSList *events;
 	guint next_cmd_id;
 	guint next_evt_id;
@@ -175,9 +176,13 @@ static void attrib_destroy(GAttrib *attrib)
 
 	while ((c = g_queue_pop_head(attrib->queue)))
 		command_destroy(c);
+	while ((c = g_queue_pop_head(attrib->response_queue)))
+		command_destroy(c);
 
 	g_queue_free(attrib->queue);
 	attrib->queue = NULL;
+	g_queue_free(attrib->response_queue);
+	attrib->response_queue = NULL;
 
 	for (l = attrib->events; l; l = l->next)
 		event_destroy(l->data);
@@ -259,21 +264,34 @@ static gboolean can_write_data(GIOChannel *io, GIOCondition cond,
 	GError *gerr = NULL;
 	gsize len;
 	GIOStatus iostat;
+	GQueue *queue;
 
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
 		return FALSE;
 
-	cmd = g_queue_peek_head(attrib->queue);
+	queue = attrib->response_queue;
+	cmd = g_queue_peek_head(queue);
+	if (cmd == NULL) {
+		queue = attrib->queue;
+		cmd = g_queue_peek_head(queue);
+	}
 	if (cmd == NULL)
 		return FALSE;
 
+	/*
+	 * Verify that we didn't already send this command. This can only
+	 * happen with elementes from attrib->queue.
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
@@ -315,7 +333,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	uint8_t buf[512], status;
 	gsize len;
 	GIOStatus iostat;
-	gboolean qempty;
+	gboolean qempty, respqempty;
 
 	if (attrib->timeout_watch > 0) {
 		g_source_remove(attrib->timeout_watch);
@@ -369,6 +387,8 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 
 done:
 	qempty = attrib->queue == NULL || g_queue_is_empty(attrib->queue);
+	respqempty = attrib->response_queue == NULL ||
+			g_queue_is_empty(attrib->response_queue);
 
 	if (cmd) {
 		if (cmd->func)
@@ -377,7 +397,7 @@ done:
 		command_destroy(cmd);
 	}
 
-	if (!qempty)
+	if (!qempty || !respqempty)
 		wake_up_sender(attrib);
 
 	return TRUE;
@@ -397,6 +417,7 @@ GAttrib *g_attrib_new(GIOChannel *io)
 
 	attrib->io = g_io_channel_ref(io);
 	attrib->queue = g_queue_new();
+	attrib->response_queue = g_queue_new();
 
 	attrib->read_watch = g_io_add_watch(attrib->io,
 			G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
@@ -421,6 +442,7 @@ guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
 			gpointer user_data, GDestroyNotify notify)
 {
 	struct command *c;
+	GQueue *queue;
 
 	c = g_try_new0(struct command, 1);
 	if (c == NULL)
@@ -435,15 +457,25 @@ guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
 	c->user_data = user_data;
 	c->notify = notify;
 
+	if (is_response(opcode))
+		queue = attrib->response_queue;
+	else
+		queue = attrib->queue;
+
 	if (id) {
 		c->id = id;
-		g_queue_push_head(attrib->queue, c);
+		g_queue_push_head(queue, c);
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
@@ -459,38 +491,49 @@ static gint command_cmp_by_id(gconstpointer a, gconstpointer b)
 
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
+	queue = attrib->queue;
+	if (queue)
+		l = g_queue_find_custom(queue, GUINT_TO_POINTER(id),
+					command_cmp_by_id);
+	if (l == NULL) {
+		queue = attrib->response_queue;
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
+static gboolean g_attrib_cancel_all_per_queue(GQueue *queue)
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
@@ -504,12 +547,21 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
 
 	if (head) {
 		/* ... and put it back in the queue */
-		g_queue_push_head(attrib->queue, head);
+		g_queue_push_head(queue, head);
 	}
 
 	return TRUE;
 }
 
+gboolean g_attrib_cancel_all(GAttrib *attrib)
+{
+	if (attrib == NULL)
+		return FALSE;
+
+	return g_attrib_cancel_all_per_queue(attrib->queue) &&
+		g_attrib_cancel_all_per_queue(attrib->response_queue);
+}
+
 gboolean g_attrib_set_debug(GAttrib *attrib,
 		GAttribDebugFunc func, gpointer user_data)
 {
-- 
1.7.7.6

