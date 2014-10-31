Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/att: Simplify bt_att_new
Date: Fri, 31 Oct 2014 14:22:20 +0200
Message-Id: <1414758140-28892-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This split bt_att_unref into bt_att_free so it can be used within
bt_att_new when freeing the data.
---
 src/shared/att.c | 68 +++++++++++++++++++++++---------------------------------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 6adde22..97f2541 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -743,6 +743,32 @@ static bool can_read_data(struct io *io, void *user_data)
 	return true;
 }
 
+static void bt_att_free(struct bt_att *att)
+{
+	if (att->pending_req)
+		destroy_att_send_op(att->pending_req);
+
+	if (att->pending_ind)
+		destroy_att_send_op(att->pending_ind);
+
+	io_destroy(att->io);
+
+	queue_destroy(att->req_queue, destroy_att_send_op);
+	queue_destroy(att->ind_queue, destroy_att_send_op);
+	queue_destroy(att->write_queue, destroy_att_send_op);
+	queue_destroy(att->notify_list, destroy_att_notify);
+	queue_destroy(att->disconn_list, destroy_att_disconn);
+
+	if (att->timeout_destroy)
+		att->timeout_destroy(att->timeout_data);
+
+	if (att->debug_destroy)
+		att->debug_destroy(att->debug_data);
+
+	free(att->buf);
+	free(att);
+}
+
 struct bt_att *bt_att_new(int fd)
 {
 	struct bt_att *att;
@@ -794,14 +820,7 @@ struct bt_att *bt_att_new(int fd)
 	return bt_att_ref(att);
 
 fail:
-	queue_destroy(att->req_queue, NULL);
-	queue_destroy(att->ind_queue, NULL);
-	queue_destroy(att->write_queue, NULL);
-	queue_destroy(att->notify_list, NULL);
-	queue_destroy(att->disconn_list, NULL);
-	io_destroy(att->io);
-	free(att->buf);
-	free(att);
+	bt_att_free(att);
 
 	return NULL;
 }
@@ -824,38 +843,7 @@ void bt_att_unref(struct bt_att *att)
 	if (__sync_sub_and_fetch(&att->ref_count, 1))
 		return;
 
-	bt_att_unregister_all(att);
-	bt_att_cancel_all(att);
-
-	if (att->pending_req)
-		destroy_att_send_op(att->pending_req);
-
-	if (att->pending_ind)
-		destroy_att_send_op(att->pending_ind);
-
-	io_destroy(att->io);
-	att->io = NULL;
-
-	queue_destroy(att->req_queue, NULL);
-	queue_destroy(att->ind_queue, NULL);
-	queue_destroy(att->write_queue, NULL);
-	queue_destroy(att->notify_list, NULL);
-	queue_destroy(att->disconn_list, NULL);
-	att->req_queue = NULL;
-	att->ind_queue = NULL;
-	att->write_queue = NULL;
-	att->notify_list = NULL;
-
-	if (att->timeout_destroy)
-		att->timeout_destroy(att->timeout_data);
-
-	if (att->debug_destroy)
-		att->debug_destroy(att->debug_data);
-
-	free(att->buf);
-	att->buf = NULL;
-
-	free(att);
+	bt_att_free(att);
 }
 
 bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
-- 
1.9.3

