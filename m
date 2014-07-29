Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH] shared/att: Handle disconnects.
Date: Tue, 29 Jul 2014 13:13:39 -0700
Message-Id: <1406664819-24970-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds disconnect handling to bt_att, in which
io_set_disconnect_handler is used to set up a handler which cancels all
pending and queued ATT operations, marks the bt_att structure as invalid
and notifies the user via a specialized callback which can be set using
bt_att_set_disconnect_cb.
---
 src/shared/att.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/shared/att.h |  5 +++++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 0d27dfa..bc856dc 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -49,7 +49,11 @@ struct bt_att {
 	int fd;
 	bool close_on_unref;
 	struct io *io;
-	bool invalid;  /* bt_att becomes invalid when a request times out */
+
+	/* bt_att becomes invalid when a request times out or if the physical
+	 * link is disconnected.
+	 */
+	bool invalid;
 
 	struct queue *req_queue;	/* Queued ATT protocol requests */
 	struct att_send_op *pending_req;
@@ -75,6 +79,10 @@ struct bt_att {
 	bt_att_debug_func_t debug_callback;
 	bt_att_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	bt_att_disconnect_func_t disconn_callback;
+	bt_att_destroy_func_t disconn_destroy;
+	void *disconn_data;
 };
 
 enum att_op_type {
@@ -602,6 +610,24 @@ static bool can_read_data(struct io *io, void *user_data)
 	return true;
 }
 
+static bool disconnect_cb(struct io *io, void *user_data)
+{
+	struct bt_att *att = user_data;
+
+	bt_att_cancel_all(att);
+
+	att->invalid = true;
+
+	util_debug(att->debug_callback, att->debug_data,
+						"Physical link disconnected");
+
+
+	if (att->disconn_callback)
+		att->disconn_callback(att->disconn_data);
+
+	return false;
+}
+
 struct bt_att *bt_att_new(int fd)
 {
 	struct bt_att *att;
@@ -643,6 +669,9 @@ struct bt_att *bt_att_new(int fd)
 	if (!io_set_read_handler(att->io, can_read_data, att, NULL))
 		goto fail;
 
+	if (!io_set_disconnect_handler(att->io, disconnect_cb, att, NULL))
+		goto fail;
+
 	return bt_att_ref(att);
 
 fail:
@@ -701,6 +730,9 @@ void bt_att_unref(struct bt_att *att)
 	if (att->debug_destroy)
 		att->debug_destroy(att->debug_data);
 
+	if (att->disconn_destroy)
+		att->disconn_destroy(att->disconn_data);
+
 	free(att->buf);
 	att->buf = NULL;
 
@@ -780,6 +812,24 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
 	return true;
 }
 
+bool bt_att_set_disconnect_cb(struct bt_att *att,
+					bt_att_disconnect_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy)
+{
+	if (!att)
+		return false;
+
+	if (att->disconn_destroy)
+		att->disconn_destroy(att->disconn_data);
+
+	att->disconn_callback = callback;
+	att->disconn_destroy = destroy;
+	att->disconn_data = user_data;
+
+	return true;
+}
+
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 				const void *pdu, uint16_t length,
 				bt_att_response_func_t callback, void *user_data,
@@ -845,11 +895,13 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
 
 	if (att->pending_req && att->pending_req->id == id) {
 		op = att->pending_req;
+		att->pending_req = NULL;
 		goto done;
 	}
 
 	if (att->pending_ind && att->pending_ind->id == id) {
 		op = att->pending_ind;
+		att->pending_ind = NULL;
 		goto done;
 	}
 
@@ -885,11 +937,15 @@ bool bt_att_cancel_all(struct bt_att *att)
 	queue_remove_all(att->ind_queue, NULL, NULL, destroy_att_send_op);
 	queue_remove_all(att->write_queue, NULL, NULL, destroy_att_send_op);
 
-	if (att->pending_req)
+	if (att->pending_req) {
 		destroy_att_send_op(att->pending_req);
+		att->pending_req = NULL;
+	}
 
-	if (att->pending_ind)
+	if (att->pending_ind) {
 		destroy_att_send_op(att->pending_ind);
+		att->pending_ind = NULL;
+	}
 
 	return true;
 }
diff --git a/src/shared/att.h b/src/shared/att.h
index 9fcd780..cf44704 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -43,6 +43,7 @@ typedef void (*bt_att_destroy_func_t)(void *user_data);
 typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_att_timeout_func_t)(unsigned int id, uint8_t opcode,
 							void *user_data);
+typedef void (*bt_att_disconnect_func_t)(void *user_data);
 
 bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
 				void *user_data, bt_att_destroy_func_t destroy);
@@ -53,6 +54,10 @@ bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu);
 bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
 						void *user_data,
 						bt_att_destroy_func_t destroy);
+bool bt_att_set_disconnect_cb(struct bt_att *att,
+					bt_att_disconnect_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy);
 
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 					const void *pdu, uint16_t length,
-- 
2.0.0.526.g5318336

