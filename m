Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
Cc: rshaffer@codeaurora.org, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org, Brian Gix <bgix@codeaurora.org>
Subject: [RFC 1/2] Add g_attrib_send_seq()
Date: Fri, 17 Dec 2010 14:48:51 -0800
Message-Id: <1292626132-30029-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
References: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add g_attrib_send_seq() as an extension to g_attrib_send().
 	g_attrib_send_seq() functionally queues an entire
 	"GATT Procedure" as defined in the BT Core v4.0.
 	The intention is that the full procedure is run
 	to completion before the next GATT Procedure is
 	started. Subsequent ATT requests to a continuing
 	procedure are added to the head of the Attrib queue.

Fix g_attrib_send() to be the degenerative case of g_attrib_send_seq()
	This function now chains to g_attrib_send_seq() with arguments
	indicating that it is *not* a compound (multi-step) GATT
	procedure, but rather that the entire procedure is performed
	with a single ATT opcode request/response.

Fix received_data() to recognize that incoming response is (or isn't)
	part of a compound Procedure, so that it waits for additional
	requests before servicing the Attrib queue.
---
 attrib/gattrib.c |   44 ++++++++++++++++++++++++++++++++++++--------
 attrib/gattrib.h |    4 ++++
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index eace01b..8ef5d92 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -58,6 +58,7 @@ struct command {
 	guint16 len;
 	guint8 expected;
 	gboolean sent;
+	gboolean compound;
 	GAttribResultFunc func;
 	gpointer user_data;
 	GDestroyNotify notify;
@@ -285,6 +286,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	uint8_t buf[512], status;
 	gsize len;
 	GIOStatus iostat;
+	gboolean compound = FALSE;
 
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
 		attrib->read_watch = 0;
@@ -319,6 +321,8 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 		return attrib->events != NULL;
 	}
 
+	compound = cmd->compound;
+
 	if (buf[0] == ATT_OP_ERROR) {
 		status = buf[4];
 		goto done;
@@ -332,7 +336,8 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	status = 0;
 
 done:
-	if (attrib->queue && g_queue_is_empty(attrib->queue) == FALSE)
+	if (!compound && attrib->queue &&
+			g_queue_is_empty(attrib->queue) == FALSE)
 		wake_up_sender(attrib);
 
 	if (cmd) {
@@ -340,6 +345,11 @@ done:
 			cmd->func(status, buf, len, cmd->user_data);
 
 		command_destroy(cmd);
+
+		if (compound && attrib->queue &&
+			g_queue_is_empty(attrib->queue) == FALSE)
+			wake_up_sender(attrib);
+
 	}
 
 	return TRUE;
@@ -367,12 +377,16 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	return g_attrib_ref(attrib);
 }
 
-guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
-				guint16 len, GAttribResultFunc func,
-				gpointer user_data, GDestroyNotify notify)
+guint g_attrib_send_seq(GAttrib *attrib, gboolean compound, guint id,
+				guint8 opcode, const guint8 *pdu, guint16 len,
+				GAttribResultFunc func, gpointer user_data,
+				GDestroyNotify notify)
 {
 	struct command *c;
 
+	if (attrib == NULL || attrib->queue == NULL)
+		return 0;
+
 	c = g_try_new0(struct command, 1);
 	if (c == NULL)
 		return 0;
@@ -385,16 +399,30 @@ guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
 	c->func = func;
 	c->user_data = user_data;
 	c->notify = notify;
-	c->id = ++attrib->next_cmd_id;
+	c->compound = compound;
 
-	g_queue_push_tail(attrib->queue, c);
+	if (id) {
+		c->id = id;
+		g_queue_push_head(attrib->queue, c);
+	} else {
+		c->id = ++attrib->next_cmd_id;
+		g_queue_push_tail(attrib->queue, c);
 
-	if (g_queue_get_length(attrib->queue) == 1)
-		wake_up_sender(attrib);
+		if (g_queue_get_length(attrib->queue) == 1)
+			wake_up_sender(attrib);
+	}
 
 	return c->id;
 }
 
+guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
+				guint16 len, GAttribResultFunc func,
+				gpointer user_data, GDestroyNotify notify)
+{
+	return g_attrib_send_seq(attrib, FALSE, 0, opcode,
+				pdu, len, func, user_data, notify);
+}
+
 static gint command_cmp_by_id(gconstpointer a, gconstpointer b)
 {
 	const struct command *cmd = a;
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 0940289..ade21bc 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -53,6 +53,10 @@ gboolean g_attrib_set_destroy_function(GAttrib *attrib,
 guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
 				guint16 len, GAttribResultFunc func,
 				gpointer user_data, GDestroyNotify notify);
+guint g_attrib_send_seq(GAttrib *attrib, gboolean compound, guint id,
+				guint8 opcode, const guint8 *pdu,
+				guint16 len, GAttribResultFunc func,
+				gpointer user_data, GDestroyNotify notify);
 gboolean g_attrib_cancel(GAttrib *attrib, guint id);
 gboolean g_attrib_cancel_all(GAttrib *attrib);
 
-- 
1.7.2.2

