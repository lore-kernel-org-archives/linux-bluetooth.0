Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/att: Call destroy callback while canceling request.
Date: Fri, 31 Oct 2014 09:59:23 +0100
Message-Id: <1414745963-1622-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This should be called even if we want leave send_op as pending_req
or pending_ind.
---
 src/shared/att.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index c70d396..f5a691d 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -836,6 +836,16 @@ void bt_att_unref(struct bt_att *att)
 	if (att->debug_destroy)
 		att->debug_destroy(att->debug_data);
 
+	if (att->pending_req) {
+		destroy_att_send_op(att->pending_req);
+		att->pending_req = NULL;
+	}
+
+	if (att->pending_ind) {
+		destroy_att_send_op(att->pending_ind);
+		att->pending_ind = NULL;
+	}
+
 	free(att->buf);
 	att->buf = NULL;
 
@@ -1021,6 +1031,15 @@ static bool match_op_id(const void *a, const void *b)
 	return op->id == id;
 }
 
+static void cancel_att_send_op(struct att_send_op *op) {
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	op->user_data = NULL;
+	op->callback = NULL;
+	op->destroy = NULL;
+}
+
 bool bt_att_cancel(struct bt_att *att, unsigned int id)
 {
 	struct att_send_op *op;
@@ -1029,16 +1048,14 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
 		return false;
 
 	if (att->pending_req && att->pending_req->id == id) {
-		/* Don't cancel the pending request; remove it's handlers */
-		att->pending_req->callback = NULL;
-		att->pending_req->destroy = NULL;
+		/* Don't destroy the pending request; remove it's handlers */
+		cancel_att_send_op(att->pending_req);
 		return true;
 	}
 
 	if (att->pending_ind && att->pending_ind->id == id) {
-		/* Don't cancel the pending indication; remove it's handlers */
-		att->pending_ind->callback = NULL;
-		att->pending_ind->destroy = NULL;
+		/* Don't destroy the pending indication; remove it's handlers */
+		cancel_att_send_op(att->pending_ind);
 		return true;
 	}
 
@@ -1075,15 +1092,13 @@ bool bt_att_cancel_all(struct bt_att *att)
 	queue_remove_all(att->write_queue, NULL, NULL, destroy_att_send_op);
 
 	if (att->pending_req) {
-		/* Don't cancel the pending request; remove it's handlers */
-		att->pending_req->callback = NULL;
-		att->pending_req->destroy = NULL;
+		/* Don't destroy the pending request; remove it's handlers */
+		cancel_att_send_op(att->pending_req);
 	}
 
 	if (att->pending_ind) {
-		/* Don't cancel the pending indication; remove it's handlers */
-		att->pending_ind->callback = NULL;
-		att->pending_ind->destroy = NULL;
+		/* Don't destroy the pending indication; remove it's handlers */
+		cancel_att_send_op(att->pending_ind);
 	}
 
 	return true;
-- 
1.9.3

