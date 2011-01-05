Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
Cc: claudio.takahasi@openbossa.org, padovan@profusion.mobi,
	rshaffer@codeaurora.org, linux-bluetooth@vger.kernel.org,
	Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/2] Fix g_attrib_send() to include a new ID parameter
Date: Tue,  4 Jan 2011 16:01:37 -0800
Message-Id: <1294185698-1499-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1294185698-1499-1-git-send-email-bgix@codeaurora.org>
References: <1294185698-1499-1-git-send-email-bgix@codeaurora.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Overall purpose of change is to enable a GATT procedure to be
	executed atomically, even if it requires multiple ATT
	request/response transactions.

Fix g_attrib_send() to include an ID parameter, if the pkt to
	be sent should be added to the Head of the pkt queue.
	If the ID is Zero, legacy functionality is maintained,
	and the pkt will be added at the tail of the queuer, and
	a new ID will be generated, and returned to the caller. If
	ID is non-zero, the pkt will be added to the head of the
	queue, with the ID value requested, which will also be
	returned to the caller.

Fix received_data() to not service the send queue until after the
	received data has been processed by calling the cmd->func()
	callback, to allow the callback to insert another pkt on
	the head of the queue.

Fix all callers of g_attrib_send() to include new parameter.
---
 attrib/client.c     |    2 +-
 attrib/gatt.c       |   12 ++++++------
 attrib/gattrib.c    |   22 +++++++++++++++-------
 attrib/gattrib.h    |    7 ++++---
 attrib/gatttool.c   |    2 +-
 src/attrib-server.c |    2 +-
 6 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 10bbf7d..4301082 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -295,7 +295,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 	switch (pdu[0]) {
 	case ATT_OP_HANDLE_IND:
 		olen = enc_confirmation(opdu, sizeof(opdu));
-		g_attrib_send(gatt->attrib, opdu[0], opdu, olen,
+		g_attrib_send(gatt->attrib, 0, opdu[0], opdu, olen,
 						NULL, NULL, NULL);
 	case ATT_OP_HANDLE_NOTIFY:
 		if (characteristic_set_value(chr, &pdu[3], len - 3) < 0)
diff --git a/attrib/gatt.c b/attrib/gatt.c
index bca8b49..320759f 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -68,7 +68,7 @@ guint gatt_discover_primary(GAttrib *attrib, uint16_t start, uint16_t end,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, op, pdu, plen, func, user_data, NULL);
+	return g_attrib_send(attrib, 0, op, pdu, plen, func, user_data, NULL);
 }
 
 guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
@@ -93,7 +93,7 @@ guint gatt_read_char_by_uuid(GAttrib *attrib, uint16_t start, uint16_t end,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, ATT_OP_READ_BY_TYPE_REQ,
+	return g_attrib_send(attrib, 0, ATT_OP_READ_BY_TYPE_REQ,
 					pdu, plen, func, user_data, NULL);
 }
 
@@ -104,7 +104,7 @@ guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc func,
 	guint16 plen;
 
 	plen = enc_read_req(handle, pdu, sizeof(pdu));
-	return g_attrib_send(attrib, ATT_OP_READ_REQ, pdu, plen, func,
+	return g_attrib_send(attrib, 0, ATT_OP_READ_REQ, pdu, plen, func,
 							user_data, NULL);
 }
 
@@ -115,7 +115,7 @@ guint gatt_write_char(GAttrib *attrib, uint16_t handle, uint8_t *value,
 	guint16 plen;
 
 	plen = enc_write_req(handle, value, vlen, pdu, sizeof(pdu));
-	return g_attrib_send(attrib, ATT_OP_WRITE_REQ, pdu, plen, func,
+	return g_attrib_send(attrib, 0, ATT_OP_WRITE_REQ, pdu, plen, func,
 							user_data, NULL);
 }
 
@@ -129,7 +129,7 @@ guint gatt_find_info(GAttrib *attrib, uint16_t start, uint16_t end,
 	if (plen == 0)
 		return 0;
 
-	return g_attrib_send(attrib, ATT_OP_FIND_INFO_REQ, pdu, plen, func,
+	return g_attrib_send(attrib, 0, ATT_OP_FIND_INFO_REQ, pdu, plen, func,
 							user_data, NULL);
 }
 
@@ -140,6 +140,6 @@ guint gatt_write_cmd(GAttrib *attrib, uint16_t handle, uint8_t *value, int vlen,
 	guint16 plen;
 
 	plen = enc_write_cmd(handle, value, vlen, pdu, sizeof(pdu));
-	return g_attrib_send(attrib, ATT_OP_WRITE_CMD, pdu, plen, NULL,
+	return g_attrib_send(attrib, 0, ATT_OP_WRITE_CMD, pdu, plen, NULL,
 							user_data, notify);
 }
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 9268001..79ee2e9 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -286,6 +286,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	uint8_t buf[512], status;
 	gsize len;
 	GIOStatus iostat;
+	gboolean qempty;
 
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
 		attrib->read_watch = 0;
@@ -333,8 +334,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
 	status = 0;
 
 done:
-	if (attrib->queue && g_queue_is_empty(attrib->queue) == FALSE)
-		wake_up_sender(attrib);
+	qempty = attrib->queue == NULL || g_queue_is_empty(attrib->queue);
 
 	if (cmd) {
 		if (cmd->func)
@@ -343,6 +343,9 @@ done:
 		command_destroy(cmd);
 	}
 
+	if (!qempty)
+		wake_up_sender(attrib);
+
 	return TRUE;
 }
 
@@ -368,9 +371,9 @@ GAttrib *g_attrib_new(GIOChannel *io)
 	return g_attrib_ref(attrib);
 }
 
-guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
-				guint16 len, GAttribResultFunc func,
-				gpointer user_data, GDestroyNotify notify)
+guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
+		const guint8 *pdu, guint16 len, GAttribResultFunc func,
+		gpointer user_data, GDestroyNotify notify)
 {
 	struct command *c;
 
@@ -386,9 +389,14 @@ guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
 	c->func = func;
 	c->user_data = user_data;
 	c->notify = notify;
-	c->id = ++attrib->next_cmd_id;
 
-	g_queue_push_tail(attrib->queue, c);
+	if (id) {
+		c->id = id;
+		g_queue_push_head(attrib->queue, c);
+	} else {
+		c->id = ++attrib->next_cmd_id;
+		g_queue_push_tail(attrib->queue, c);
+	}
 
 	if (g_queue_get_length(attrib->queue) == 1)
 		wake_up_sender(attrib);
diff --git a/attrib/gattrib.h b/attrib/gattrib.h
index 0940289..1a966a7 100644
--- a/attrib/gattrib.h
+++ b/attrib/gattrib.h
@@ -50,9 +50,10 @@ gboolean g_attrib_set_disconnect_function(GAttrib *attrib,
 gboolean g_attrib_set_destroy_function(GAttrib *attrib,
 		GDestroyNotify destroy, gpointer user_data);
 
-guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
-				guint16 len, GAttribResultFunc func,
-				gpointer user_data, GDestroyNotify notify);
+guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
+			const guint8 *pdu, guint16 len, GAttribResultFunc func,
+			gpointer user_data, GDestroyNotify notify);
+
 gboolean g_attrib_cancel(GAttrib *attrib, guint id);
 gboolean g_attrib_cancel_all(GAttrib *attrib);
 
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index a234e36..a6f92db 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -272,7 +272,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	olen = enc_confirmation(opdu, sizeof(opdu));
 
 	if (olen > 0)
-		g_attrib_send(attrib, opdu[0], opdu, olen, NULL, NULL, NULL);
+		g_attrib_send(attrib, 0, opdu[0], opdu, olen, NULL, NULL, NULL);
 }
 
 static gboolean listen_start(gpointer user_data)
diff --git a/src/attrib-server.c b/src/attrib-server.c
index cbc01ee..aee2ace 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -694,7 +694,7 @@ done:
 	if (status)
 		length = enc_error_resp(ipdu[0], 0x0000, status, opdu, channel->mtu);
 
-	g_attrib_send(channel->attrib, opdu[0], opdu, length,
+	g_attrib_send(channel->attrib, 0, opdu[0], opdu, length,
 							NULL, NULL, NULL);
 }
 
-- 
1.7.1
-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
