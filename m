Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Arman Uguray <armansito@chromium.org>
Subject: [PATCH 2/2] shared/att: Implement bt_att_register.
Date: Mon,  7 Jul 2014 22:05:01 -0700
Message-Id: <1404795901-29367-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1404795901-29367-1-git-send-email-armansito@chromium.org>
References: <1404795901-29367-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_att_register and the internal mechanism for invoking
registered callbacks when a non-response/non-indication PDU is received from the
remote end.
---
 src/shared/att.c | 207 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 186 insertions(+), 21 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index e5e38ac..0d27dfa 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -58,6 +58,10 @@ struct bt_att {
 	struct queue *write_queue;	/* Queue of PDUs ready to send */
 	bool writer_active;
 
+	struct queue *notify_list;	/* List of registered callbacks */
+	bool in_notify;
+	bool need_notify_cleanup;
+
 	uint8_t *buf;
 	uint16_t mtu;
 
@@ -172,6 +176,61 @@ struct att_send_op {
 	void *user_data;
 };
 
+static void destroy_att_send_op(void *data)
+{
+	struct att_send_op *op = data;
+
+	if (op->timeout_id)
+		timeout_remove(op->timeout_id);
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op->pdu);
+	free(op);
+}
+
+struct att_notify {
+	unsigned int id;
+	uint16_t opcode;
+	bool removed;
+	bt_att_notify_func_t callback;
+	bt_att_destroy_func_t destroy;
+	void *user_data;
+};
+
+static void destroy_att_notify(void *data)
+{
+	struct att_notify *notify = data;
+
+	if (notify->destroy)
+		notify->destroy(notify->user_data);
+
+	free(notify);
+}
+
+static bool match_notify_id(const void *a, const void *b)
+{
+	const struct att_notify *notify = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return notify->id == id;
+}
+
+static bool match_notify_removed(const void *a, const void *b)
+{
+	const struct att_notify *notify = a;
+
+	return notify->removed;
+}
+
+static void mark_notify_removed(void *data, void *user_data)
+{
+	struct att_notify *notify = data;
+
+	notify->removed = true;
+}
+
 static bool encode_pdu(struct att_send_op *op, const void *pdu,
 						uint16_t length, uint16_t mtu)
 {
@@ -272,20 +331,6 @@ static struct att_send_op *pick_next_send_op(struct bt_att *att)
 	return NULL;
 }
 
-static void destroy_att_send_op(void *data)
-{
-	struct att_send_op *op = data;
-
-	if (op->timeout_id)
-		timeout_remove(op->timeout_id);
-
-	if (op->destroy)
-		op->destroy(op->user_data);
-
-	free(op->pdu);
-	free(op);
-}
-
 struct timeout_data {
 	struct bt_att *att;
 	unsigned int id;
@@ -462,6 +507,57 @@ done:
 	wakeup_writer(att);
 }
 
+struct notify_data {
+	uint8_t opcode;
+	uint8_t *pdu;
+	ssize_t pdu_len;
+};
+
+static void notify_handler(void *data, void *user_data)
+{
+	struct att_notify *notify = data;
+	struct notify_data *not_data = user_data;
+
+	if (notify->removed)
+		return;
+
+	if (notify->opcode != not_data->opcode)
+		return;
+
+	if (notify->callback)
+		notify->callback(not_data->opcode, not_data->pdu,
+					not_data->pdu_len, notify->user_data);
+}
+
+static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
+								ssize_t pdu_len)
+{
+	struct notify_data data;
+
+	bt_att_ref(att);
+	att->in_notify = true;
+
+	memset(&data, 0, sizeof(data));
+	data.opcode = opcode;
+
+	if (pdu_len > 0) {
+		data.pdu = pdu;
+		data.pdu_len = pdu_len;
+	}
+
+	queue_foreach(att->notify_list, notify_handler, &data);
+
+	att->in_notify = false;
+
+	if (att->need_notify_cleanup) {
+		queue_remove_all(att->notify_list, match_notify_removed, NULL,
+							destroy_att_notify);
+		att->need_notify_cleanup = false;
+	}
+
+	bt_att_unref(att);
+}
+
 static bool can_read_data(struct io *io, void *user_data)
 {
 	struct bt_att *att = user_data;
@@ -485,12 +581,22 @@ static bool can_read_data(struct io *io, void *user_data)
 	/* Act on the received PDU based on the opcode type */
 	switch (get_op_type(opcode)) {
 	case ATT_OP_TYPE_RSP:
+		util_debug(att->debug_callback, att->debug_data,
+				"ATT response received: 0x%02x", opcode);
 		handle_rsp(att, opcode, pdu + 1, bytes_read - 1);
 		break;
-	default:
+	case ATT_OP_TYPE_CONF:
 		util_debug(att->debug_callback, att->debug_data,
 				"ATT opcode cannot be handled: 0x%02x", opcode);
 		break;
+	default:
+		/* For all other opcodes notify the upper layer of the PDU and
+		 * let them act on it.
+		 */
+		util_debug(att->debug_callback, att->debug_data,
+					"ATT PDU received: 0x%02x", opcode);
+		handle_notify(att, opcode, pdu + 1, bytes_read - 1);
+		break;
 	}
 
 	return true;
@@ -530,6 +636,10 @@ struct bt_att *bt_att_new(int fd)
 	if (!att->write_queue)
 		goto fail;
 
+	att->notify_list = queue_new();
+	if (!att->notify_list)
+		goto fail;
+
 	if (!io_set_read_handler(att->io, can_read_data, att, NULL))
 		goto fail;
 
@@ -564,6 +674,7 @@ void bt_att_unref(struct bt_att *att)
 	if (__sync_sub_and_fetch(&att->ref_count, 1))
 		return;
 
+	bt_att_unregister_all(att);
 	bt_att_cancel_all(att);
 
 	io_set_write_handler(att->io, NULL, NULL, NULL);
@@ -572,9 +683,11 @@ void bt_att_unref(struct bt_att *att)
 	queue_destroy(att->req_queue, NULL);
 	queue_destroy(att->ind_queue, NULL);
 	queue_destroy(att->write_queue, NULL);
+	queue_destroy(att->notify_list, NULL);
 	att->req_queue = NULL;
 	att->ind_queue = NULL;
 	att->write_queue = NULL;
+	att->notify_list = NULL;
 
 	io_destroy(att->io);
 	att->io = NULL;
@@ -786,18 +899,70 @@ unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
 						void *user_data,
 						bt_att_destroy_func_t destroy)
 {
-	/* TODO */
-	return 0;
+	struct att_notify *notify;
+
+	if (!att || !opcode || !callback)
+		return 0;
+
+	notify = new0(struct att_notify, 1);
+	if (!notify)
+		return 0;
+
+	notify->opcode = opcode;
+	notify->callback = callback;
+	notify->destroy = destroy;
+	notify->user_data = user_data;
+
+	if (att->next_reg_id < 1)
+		att->next_reg_id = 1;
+
+	notify->id = att->next_reg_id++;
+
+	if (!queue_push_tail(att->notify_list, notify)) {
+		free(notify);
+		return 0;
+	}
+
+	return notify->id;
 }
 
 bool bt_att_unregister(struct bt_att *att, unsigned int id)
 {
-	/* TODO */
-	return false;
+	struct att_notify *notify;
+
+	if (!att || !id)
+		return false;
+
+	notify = queue_find(att->notify_list, match_notify_id,
+							UINT_TO_PTR(id));
+	if (!notify)
+		return false;
+
+	if (!att->in_notify) {
+		queue_remove(att->notify_list, notify);
+		destroy_att_notify(notify);
+		return true;
+	}
+
+	notify->removed = true;
+	att->need_notify_cleanup = true;
+
+	return true;
 }
 
 bool bt_att_unregister_all(struct bt_att *att)
 {
-	/* TODO */
-	return false;
+	if (!att)
+		return false;
+
+	if (!att->in_notify) {
+		queue_remove_all(att->notify_list, NULL, NULL,
+							destroy_att_notify);
+		return true;
+	}
+
+	queue_foreach(att->notify_list, mark_notify_removed, NULL);
+	att->need_notify_cleanup = true;
+
+	return true;
 }
-- 
2.0.0.526.g5318336

