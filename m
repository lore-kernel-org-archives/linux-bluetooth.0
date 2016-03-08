Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/att: Fix not notifying the callback
Date: Tue,  8 Mar 2016 16:08:05 +0200
Message-Id: <1457446085-21426-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure that all request callback are called with
BT_ATT_OP_ERROR_RSP in case the link is dropped so they can propagate
the error back to the caller.
---
 src/shared/att.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 7b20757..a29c100 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -535,6 +535,16 @@ static void disconn_handler(void *data, void *user_data)
 		disconn->callback(err, disconn->user_data);
 }
 
+static void disc_att_send_op(void *data)
+{
+	struct att_send_op *op = data;
+
+	if (op->callback)
+		op->callback(BT_ATT_OP_ERROR_RSP, NULL, 0, op->user_data);
+
+	destroy_att_send_op(op);
+}
+
 static bool disconnect_cb(struct io *io, void *user_data)
 {
 	struct bt_att *att = user_data;
@@ -557,7 +567,16 @@ static bool disconnect_cb(struct io *io, void *user_data)
 	io_destroy(att->io);
 	att->io = NULL;
 
-	bt_att_cancel_all(att);
+	/* Notify request callbacks */
+	queue_remove_all(att->req_queue, NULL, NULL, disc_att_send_op);
+	queue_remove_all(att->ind_queue, NULL, NULL, disc_att_send_op);
+	queue_remove_all(att->write_queue, NULL, NULL, disc_att_send_op);
+
+	if (att->pending_req)
+		disc_att_send_op(att->pending_req);
+
+	if (att->pending_ind)
+		disc_att_send_op(att->pending_ind);
 
 	bt_att_ref(att);
 
-- 
2.5.0

