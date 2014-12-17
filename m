Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] attrib/gattrib: Add track for internal request id
Date: Wed, 17 Dec 2014 16:26:14 +0100
Message-Id: <1418829975-17375-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418829975-17375-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418829975-17375-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If user provides req_id to the g_attrib_send, he assume that req_id
should be used for transaction.
With this patch, gattrib  keeps track on user requested req_id and
actual pending req_id which allow to e.g. cancel correct transaction
when user request it.
---
 attrib/gattrib.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index ab43f84..c75866b 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -51,10 +51,12 @@ struct _GAttrib {
 	struct queue *callbacks;
 	uint8_t *buf;
 	int buflen;
+	struct queue *track_ids;
 };
 
 
 struct attrib_callbacks {
+	unsigned int id;
 	GAttribResultFunc result_func;
 	GAttribNotifyFunc notify_func;
 	GDestroyNotify destroy_func;
@@ -63,6 +65,60 @@ struct attrib_callbacks {
 	uint16_t notify_handle;
 };
 
+struct id_pair {
+	unsigned int org_id;
+	unsigned int pend_id;
+};
+
+
+static bool find_with_pend_id(const void *data, const void *user_data)
+{
+	const struct id_pair *p = data;
+	unsigned int pending = PTR_TO_INT(user_data);
+
+	return (p->pend_id == pending);
+}
+
+static bool find_with_org_id(const void *data, const void *user_data)
+{
+	const struct id_pair *p = data;
+	unsigned int orig_id = PTR_TO_INT(user_data);
+
+	return (p->org_id == orig_id);
+}
+
+static void remove_stored_ids(GAttrib *attrib, unsigned int pending_id)
+{
+	struct id_pair *p;
+
+	p = queue_remove_if(attrib->track_ids, find_with_pend_id,
+						INT_TO_PTR(pending_id));
+
+	free(p);
+}
+
+static void store_id(GAttrib *attrib, unsigned int org_id,
+							unsigned int pend_id)
+{
+	struct id_pair *t;
+
+	t = queue_find(attrib->track_ids, find_with_org_id, INT_TO_PTR(org_id));
+	if (t) {
+		t->pend_id = pend_id;
+		return;
+	}
+
+	t = new0(struct id_pair, 1);
+	if (!t)
+		return;
+
+	t->org_id = org_id;
+	t->pend_id = pend_id;
+
+	if (!queue_push_tail(attrib->track_ids, t))
+		free(t);
+}
+
 GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
 {
 	gint fd;
@@ -95,6 +151,10 @@ GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu)
 	if (!attr->callbacks)
 		goto fail;
 
+	attr->track_ids = queue_new();
+	if (!attr->track_ids)
+		goto fail;
+
 	return g_attrib_ref(attr);
 
 fail:
@@ -153,6 +213,7 @@ void g_attrib_unref(GAttrib *attrib)
 	bt_att_unref(attrib->att);
 
 	queue_destroy(attrib->callbacks, attrib_callbacks_destroy);
+	queue_destroy(attrib->track_ids, free);
 
 	free(attrib->buf);
 
@@ -229,6 +290,8 @@ static void attrib_callback_result(uint8_t opcode, const void *pdu,
 	if (cb->result_func)
 		cb->result_func(status, buf, length + 1, cb->user_data);
 
+	remove_stored_ids(cb->parent, cb->id);
+
 	free(buf);
 }
 
@@ -282,18 +345,49 @@ guint g_attrib_send(GAttrib *attrib, guint id, const guint8 *pdu, guint16 len,
 		queue_push_head(attrib->callbacks, cb);
 		response_cb = attrib_callback_result;
 		destroy_cb = attrib_callbacks_remove;
+
 	}
 
-	return bt_att_send(attrib->att, pdu[0], (void *)pdu + 1, len - 1,
+	cb->id = bt_att_send(attrib->att, pdu[0], (void *) pdu + 1, len - 1,
 						response_cb, cb, destroy_cb);
+
+	if (id == 0)
+		return cb->id;
+
+	/*
+	 * If user what us to use given id, lets keep track on that so we give
+	 * user a possibility to cancel ongoing request
+	 */
+	store_id(attrib, id, cb->id);
+	return id;
+}
+
+static unsigned int get_id(GAttrib *attrib, guint id)
+{
+	struct id_pair *p;
+	unsigned int result = id;
+
+	p = queue_remove_if(attrib->track_ids, find_with_org_id,
+							INT_TO_PTR(id));
+	if (!p)
+		return id;
+
+	result = p->pend_id;
+	free(p);
+
+	return result;
 }
 
 gboolean g_attrib_cancel(GAttrib *attrib, guint id)
 {
+	unsigned int pend_id;
+
 	if (!attrib)
 		return FALSE;
 
-	return bt_att_cancel(attrib->att, id);
+	pend_id = get_id(attrib, id);
+
+	return bt_att_cancel(attrib->att, pend_id);
 }
 
 gboolean g_attrib_cancel_all(GAttrib *attrib)
@@ -301,6 +395,8 @@ gboolean g_attrib_cancel_all(GAttrib *attrib)
 	if (!attrib)
 		return FALSE;
 
+	queue_remove_all(attrib->track_ids, NULL, NULL, free);
+
 	return bt_att_cancel_all(attrib->att);
 }
 
-- 
1.8.4

