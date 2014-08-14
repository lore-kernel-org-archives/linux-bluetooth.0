Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v3 3/3] shared/att: Handle disconnects.
Date: Wed, 13 Aug 2014 19:27:56 -0700
Message-Id: <1407983276-22573-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1407983276-22573-1-git-send-email-armansito@chromium.org>
References: <1407983276-22573-1-git-send-email-armansito@chromium.org>
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
 src/shared/att.c | 77 +++++++++++++++++++++++++++++++++++++++++++++-----------
 src/shared/att.h |  5 ++++
 2 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 6f5e405..b5ab742 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -48,7 +48,6 @@ struct bt_att {
 	int ref_count;
 	int fd;
 	struct io *io;
-	bool invalid;  /* bt_att becomes invalid when a request times out */
 
 	struct queue *req_queue;	/* Queued ATT protocol requests */
 	struct att_send_op *pending_req;
@@ -74,6 +73,10 @@ struct bt_att {
 	bt_att_debug_func_t debug_callback;
 	bt_att_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	bt_att_disconnect_func_t disconn_callback;
+	bt_att_destroy_func_t disconn_destroy;
+	void *disconn_data;
 };
 
 enum att_op_type {
@@ -352,7 +355,8 @@ static bool timeout_cb(void *user_data)
 	if (!op)
 		return false;
 
-	att->invalid = true;
+	io_destroy(att->io);
+	att->io = NULL;
 
 	util_debug(att->debug_callback, att->debug_data,
 				"Operation timed out: 0x%02x", op->opcode);
@@ -601,6 +605,25 @@ static bool can_read_data(struct io *io, void *user_data)
 	return true;
 }
 
+static bool disconnect_cb(struct io *io, void *user_data)
+{
+	struct bt_att *att = user_data;
+
+	bt_att_cancel_all(att);
+	bt_att_unregister_all(att);
+
+	io_destroy(att->io);
+	att->io = NULL;
+
+	util_debug(att->debug_callback, att->debug_data,
+						"Physical link disconnected");
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
@@ -642,6 +665,9 @@ struct bt_att *bt_att_new(int fd)
 	if (!io_set_read_handler(att->io, can_read_data, att, NULL))
 		goto fail;
 
+	if (!io_set_disconnect_handler(att->io, disconnect_cb, att, NULL))
+		goto fail;
+
 	return bt_att_ref(att);
 
 fail:
@@ -676,8 +702,8 @@ void bt_att_unref(struct bt_att *att)
 	bt_att_unregister_all(att);
 	bt_att_cancel_all(att);
 
-	io_set_write_handler(att->io, NULL, NULL, NULL);
-	io_set_read_handler(att->io, NULL, NULL, NULL);
+	io_destroy(att->io);
+	att->io = NULL;
 
 	queue_destroy(att->req_queue, NULL);
 	queue_destroy(att->ind_queue, NULL);
@@ -688,15 +714,15 @@ void bt_att_unref(struct bt_att *att)
 	att->write_queue = NULL;
 	att->notify_list = NULL;
 
-	io_destroy(att->io);
-	att->io = NULL;
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
 
@@ -705,7 +731,7 @@ void bt_att_unref(struct bt_att *att)
 
 bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
 {
-	if (!att)
+	if (!att || !att->io)
 		return false;
 
 	return io_set_close_on_destroy(att->io, do_close);
@@ -774,6 +800,24 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
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
@@ -782,10 +826,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	struct att_send_op *op;
 	bool result;
 
-	if (!att)
-		return 0;
-
-	if (att->invalid)
+	if (!att || !att->io)
 		return 0;
 
 	op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
@@ -839,11 +880,13 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
 
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
 
@@ -879,11 +922,15 @@ bool bt_att_cancel_all(struct bt_att *att)
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
@@ -895,7 +942,7 @@ unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
 {
 	struct att_notify *notify;
 
-	if (!att || !opcode || !callback)
+	if (!att || !opcode || !callback || !att->io)
 		return 0;
 
 	notify = new0(struct att_notify, 1);
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
2.1.0.rc2.206.gedb03e5

