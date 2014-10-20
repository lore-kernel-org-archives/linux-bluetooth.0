Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/8] shared/att: bt_att_cancel should not cancel pending requests/indications.
Date: Mon, 20 Oct 2014 14:00:54 -0700
Message-Id: <1413838861-29956-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1413838861-29956-1-git-send-email-armansito@chromium.org>
References: <1413838861-29956-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_att_cancel and bt_att_cancel_all no longer destroy any pending
request or indication, since this would cause a later bt_att_send to
erroneously send out a request or indication before a
response/confirmation for a pending one is received. Instead, they now
keep the pending operations but clear their response and destroy
callbacks since the upper layer is no longer interested in them.
---
 src/shared/att.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 503e06c..c70d396 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1029,15 +1029,17 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
 		return false;
 
 	if (att->pending_req && att->pending_req->id == id) {
-		op = att->pending_req;
-		att->pending_req = NULL;
-		goto done;
+		/* Don't cancel the pending request; remove it's handlers */
+		att->pending_req->callback = NULL;
+		att->pending_req->destroy = NULL;
+		return true;
 	}
 
 	if (att->pending_ind && att->pending_ind->id == id) {
-		op = att->pending_ind;
-		att->pending_ind = NULL;
-		goto done;
+		/* Don't cancel the pending indication; remove it's handlers */
+		att->pending_ind->callback = NULL;
+		att->pending_ind->destroy = NULL;
+		return true;
 	}
 
 	op = queue_remove_if(att->req_queue, match_op_id, UINT_TO_PTR(id));
@@ -1073,13 +1075,15 @@ bool bt_att_cancel_all(struct bt_att *att)
 	queue_remove_all(att->write_queue, NULL, NULL, destroy_att_send_op);
 
 	if (att->pending_req) {
-		destroy_att_send_op(att->pending_req);
-		att->pending_req = NULL;
+		/* Don't cancel the pending request; remove it's handlers */
+		att->pending_req->callback = NULL;
+		att->pending_req->destroy = NULL;
 	}
 
 	if (att->pending_ind) {
-		destroy_att_send_op(att->pending_ind);
-		att->pending_ind = NULL;
+		/* Don't cancel the pending indication; remove it's handlers */
+		att->pending_ind->callback = NULL;
+		att->pending_ind->destroy = NULL;
 	}
 
 	return true;
-- 
2.1.0.rc2.206.gedb03e5

