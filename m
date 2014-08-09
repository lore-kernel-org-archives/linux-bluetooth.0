Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 1/1] shared/att: Handle disconnects.
Date: Fri,  8 Aug 2014 18:46:09 -0700
Message-Id: <1407548769-5903-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1407548769-5903-1-git-send-email-armansito@chromium.org>
References: <1407548769-5903-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds disconnect handling to bt_att, in which
io_set_disconnect_handler is used to set up a handler which cancels all
pending and queued ATT operations, marks the bt_att structure as invalid
and notifies the user via a specialized callback which can be set using
bt_att_set_disconnect_cb.

Once the bt_att structure is invalidated, either due to a timed-out ATT protocol
request/indication or a disconnect, it now destroys the underlying io structure.
---
 src/shared/att.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++---------
 src/shared/att.h |   5 +++
 2 files changed, 97 insertions(+), 16 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 0d27dfa..5fa0c8f 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -47,9 +47,14 @@ struct att_send_op;
 struct bt_att {
 	int ref_count;
 	int fd;
-	bool close_on_unref;
 	struct io *io;
-	bool invalid;  /* bt_att becomes invalid when a request times out */
+
+	/* bt_att becomes invalid when a request times out or if the physical
+	 * link is disconnected; the underlying io will be destroyed as a
+	 * result.
+	 */
+	bool invalid;
+	unsigned int io_destroy_id;
 
 	struct queue *req_queue;	/* Queued ATT protocol requests */
 	struct att_send_op *pending_req;
@@ -75,6 +80,10 @@ struct bt_att {
 	bt_att_debug_func_t debug_callback;
 	bt_att_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	bt_att_disconnect_func_t disconn_callback;
+	bt_att_destroy_func_t disconn_destroy;
+	void *disconn_data;
 };
 
 enum att_op_type {
@@ -354,6 +363,8 @@ static bool timeout_cb(void *user_data)
 		return false;
 
 	att->invalid = true;
+	io_destroy(att->io);
+	att->io = NULL;
 
 	util_debug(att->debug_callback, att->debug_data,
 				"Operation timed out: 0x%02x", op->opcode);
@@ -602,6 +613,44 @@ static bool can_read_data(struct io *io, void *user_data)
 	return true;
 }
 
+static bool io_destroy_cb(void *user_data)
+{
+	struct bt_att *att = user_data;
+
+	if (!att->io)
+		return false;
+
+	io_destroy(att->io);
+	att->io = NULL;
+	att->io_destroy_id = 0;
+
+	util_debug(att->debug_callback, att->debug_data, "io destroyed");
+
+	return false;
+}
+
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
+	if (att->disconn_callback)
+		att->disconn_callback(att->disconn_data);
+
+	/* It's unsafe to destroy the struct io during the disconnect callback.
+	 * post a task on the main loop to perform this later.
+	 */
+	att->io_destroy_id = timeout_add(1, io_destroy_cb, att, NULL);
+
+	return false;
+}
+
 struct bt_att *bt_att_new(int fd)
 {
 	struct bt_att *att;
@@ -643,6 +692,9 @@ struct bt_att *bt_att_new(int fd)
 	if (!io_set_read_handler(att->io, can_read_data, att, NULL))
 		goto fail;
 
+	if (!io_set_disconnect_handler(att->io, disconnect_cb, att, NULL))
+		goto fail;
+
 	return bt_att_ref(att);
 
 fail:
@@ -677,8 +729,13 @@ void bt_att_unref(struct bt_att *att)
 	bt_att_unregister_all(att);
 	bt_att_cancel_all(att);
 
-	io_set_write_handler(att->io, NULL, NULL, NULL);
-	io_set_read_handler(att->io, NULL, NULL, NULL);
+	if (att->io_destroy_id)
+		timeout_remove(att->io_destroy_id);
+
+	if (att->io) {
+		io_destroy(att->io);
+		att->io = NULL;
+	}
 
 	queue_destroy(att->req_queue, NULL);
 	queue_destroy(att->ind_queue, NULL);
@@ -689,18 +746,15 @@ void bt_att_unref(struct bt_att *att)
 	att->write_queue = NULL;
 	att->notify_list = NULL;
 
-	io_destroy(att->io);
-	att->io = NULL;
-
-	if (att->close_on_unref)
-		close(att->fd);
-
 	if (att->timeout_destroy)
 		att->timeout_destroy(att->timeout_data);
 
 	if (att->debug_destroy)
 		att->debug_destroy(att->debug_data);
 
+	if (att->disconn_destroy)
+		att->disconn_destroy(att->disconn_data);
+
 	free(att->buf);
 	att->buf = NULL;
 
@@ -709,12 +763,10 @@ void bt_att_unref(struct bt_att *att)
 
 bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
 {
-	if (!att)
+	if (!att || !att->io)
 		return false;
 
-	att->close_on_unref = do_close;
-
-	return true;
+	return io_set_close_on_destroy(att->io, do_close);
 }
 
 bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
@@ -780,6 +832,24 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
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
@@ -845,11 +915,13 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
 
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
 
@@ -885,11 +957,15 @@ bool bt_att_cancel_all(struct bt_att *att)
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

