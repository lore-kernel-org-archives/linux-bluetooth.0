Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v3 3/4] src/shared/att: Implement write handler and bt_att_send.
Date: Mon,  9 Jun 2014 18:33:59 -0700
Message-Id: <1402364040-11502-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1402364040-11502-1-git-send-email-armansito@chromium.org>
References: <1402364040-11502-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the write handler logic, including the way send
operations are process from the various internal queues. Added PDU
encoding for the Exchange MTU request.
---
 src/shared/att.c | 261 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 3 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 270a9df..f3ece02 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -26,9 +26,11 @@
 #endif
 
 #include <unistd.h>
+#include <errno.h>
 
 #include "src/shared/io.h"
 #include "src/shared/queue.h"
+#include "src/shared/util.h"
 #include "lib/uuid.h"
 #include "src/shared/att.h"
 
@@ -133,13 +135,155 @@ struct att_send_op {
 	unsigned int id;
 	att_op_type_t op_type;
 	uint16_t opcode;
-	void *pdu;
+	uint8_t *pdu;
 	uint16_t len;
 	bt_att_request_func_t callback;
 	bt_att_destroy_func_t destroy;
 	void *user_data;
 };
 
+static bool encode_mtu_req(struct att_send_op *op, const void *param,
+						uint16_t length, uint16_t mtu)
+{
+	const struct bt_att_mtu_req_param *p = param;
+	const uint16_t len = 3;
+
+	if (length != sizeof(*p))
+		return false;
+
+	if (len > mtu)
+		return false;
+
+	op->pdu = malloc(len);
+	if (!op->pdu)
+		return false;
+
+	op->pdu[0] = op->opcode;
+	put_le16(p->client_rx_mtu, op->pdu + 1);
+	op->len = len;
+
+	return true;
+}
+
+static bool encode_pdu(struct att_send_op *op, const void *param,
+						uint16_t length, uint16_t mtu)
+{
+	/* If no parameters are given, simply set the PDU to consist of the
+	 * opcode.
+	 */
+	if (length == 0) {
+		op->len = 1;
+		op->pdu = malloc(1);
+		if (!op->pdu)
+			return false;
+
+		op->pdu[0] = op->opcode;
+		return true;
+	}
+
+	/* TODO: If the opcode has the "signed" bit set, make sure that the
+	 * resulting PDU contains the authentication signature. Return an error,
+	 * if the provided parameters structure is such that it leaves no room
+	 * for an authentication signature in the PDU.
+	 */
+
+	switch (op->opcode) {
+	case BT_ATT_OP_MTU_REQ:
+		return encode_mtu_req(op, param, length, mtu);
+	dafault:
+		break;
+	}
+
+	return false;
+}
+
+static struct att_send_op *create_att_send_op(uint8_t opcode, const void *param,
+						uint16_t length, uint16_t mtu,
+						bt_att_request_func_t callback,
+						void *user_data,
+						bt_att_destroy_func_t destroy)
+{
+	struct att_send_op *op;
+	att_op_type_t op_type;
+
+	op_type = get_op_type(opcode);
+	if (op_type == ATT_OP_TYPE_UNKNOWN)
+		return NULL;
+
+	/* If the opcode corresponds to an operation type that does not elicit a
+	 * response from the remote end, then no callbacks should have been
+	 * provided. Otherwise, at least a callback should be provided.
+	 */
+	if (op_type == ATT_OP_TYPE_REQ || op_type == ATT_OP_TYPE_IND) {
+		if (!callback)
+			return NULL;
+	} else if (callback || user_data || destroy)
+		return NULL;
+
+	if (length > 0 && !param)
+		return NULL;
+
+	op = new0(struct att_send_op, 1);
+	if (!op)
+		return NULL;
+
+	op->op_type = op_type;
+	op->opcode = opcode;
+	op->callback = callback;
+	op->destroy = destroy;
+	op->user_data = user_data;
+
+	if (!encode_pdu(op, param, length, mtu)) {
+		free(op);
+		return NULL;
+	}
+
+	return op;
+}
+
+typedef enum {
+	SEND_QUEUE_REQ,
+	SEND_QUEUE_IND,
+	SEND_QUEUE_WRITE,
+} send_queue_t;
+
+static struct att_send_op *pick_next_send_op(struct bt_att *att,
+						send_queue_t *orig_queue)
+{
+	struct att_send_op *op;
+
+	/* See if any operations are already in the write queue */
+	op = queue_pop_head(att->write_queue);
+	if (op) {
+		*orig_queue = SEND_QUEUE_WRITE;
+		return op;
+	}
+
+	/* If there is no pending request, pick an operation from the
+	 * request queue.
+	 */
+	if (!att->pending_req) {
+		op = queue_pop_head(att->req_queue);
+		if (op) {
+			*orig_queue = SEND_QUEUE_REQ;
+			return op;
+		}
+	}
+
+	/* There is either a request pending or no requests queued. If there is
+	 * no pending indication, pick an operation from the indication queue.
+	 */
+	if (!att->pending_ind) {
+		op = queue_pop_head(att->ind_queue);
+		if (op) {
+			*orig_queue = SEND_QUEUE_IND;
+			return op;
+		}
+	}
+
+	return NULL;
+}
+
 static void destroy_att_send_op(void *data)
 {
 	struct att_send_op *op = data;
@@ -151,6 +295,81 @@ static void destroy_att_send_op(void *data)
 	free(op);
 }
 
+static void wakeup_writer(struct bt_att *att);
+
+static bool can_write_data(struct io *io, void *user_data)
+{
+	struct bt_att *att = user_data;
+	struct att_send_op *op;
+	ssize_t bytes_written;
+	send_queue_t orig_queue;
+
+	op = pick_next_send_op(att, &orig_queue);
+	if (!op)
+		return false;
+
+	bytes_written = write(att->fd, op->pdu, op->len);
+	if (bytes_written < 0) {
+		util_debug(att->debug_callback, att->debug_data,
+					"write failed: %s", strerror(errno));
+		if (op->callback)
+			op->callback(BT_ATT_OP_ERROR_RSP, NULL, 0,
+							op->user_data);
+
+		destroy_att_send_op(op);
+		return true;
+	}
+
+	util_debug(att->debug_callback, att->debug_data,
+					"ATT op 0x%02x", op->opcode);
+
+	util_hexdump('<', op->pdu, bytes_written,
+					att->debug_callback, att->debug_data);
+
+	/* Based on the origin queue, set either the pending request or the
+	 * pending indication. If it came from the write queue, then there is
+	 * no need to keep it around.
+	 */
+	if (orig_queue == SEND_QUEUE_WRITE)
+		destroy_att_send_op(op);
+	else if (orig_queue == SEND_QUEUE_REQ)
+		att->pending_req = op;
+	else if (orig_queue == SEND_QUEUE_IND)
+		att->pending_ind = op;
+
+	/* Try to wake up the writer */
+	att->writer_active = false;
+	wakeup_writer(att);
+
+	return false;
+}
+
+static void wakeup_writer(struct bt_att *att)
+{
+	if (att->writer_active)
+		return;
+
+	/* Set the write handler only if there is anything that can be sent
+	 * at all.
+	 */
+	if (!queue_isempty(att->write_queue))
+		goto set_handler;
+
+	if (!att->pending_req && !queue_isempty(att->req_queue))
+		goto set_handler;
+
+	if (!att->pending_ind && !queue_isempty(att->ind_queue))
+		goto set_handler;
+
+	return;
+
+set_handler:
+	if (!io_set_write_handler(att->io, can_write_data, att, NULL))
+		return;
+
+	att->writer_active = true;
+}
+
 static void read_watch_destroy(void *user_data)
 {
 	struct bt_att *att = user_data;
@@ -370,8 +589,44 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 				bt_att_request_func_t callback, void *user_data,
 				bt_att_destroy_func_t destroy)
 {
-	/* TODO */
-	return 0;
+	struct att_send_op *op;
+	struct queue *op_queue;
+
+	if (!att)
+		return 0;
+
+	op = create_att_send_op(opcode, param, length, att->mtu, callback,
+							user_data, destroy);
+	if (!op)
+		return 0;
+
+	if (att->next_send_id < 1)
+		att->next_send_id = 1;
+
+	op->id = att->next_send_id++;
+
+	/* Add the op to the correct queue based on its type */
+	switch (op->op_type) {
+	case ATT_OP_TYPE_REQ:
+		op_queue = att->req_queue;
+		break;
+	case ATT_OP_TYPE_IND:
+		op_queue = att->ind_queue;
+		break;
+	default:
+		op_queue = att->write_queue;
+		break;
+	}
+
+	if (!queue_push_tail(op_queue, op)) {
+		free(op->pdu);
+		free(op);
+		return 0;
+	}
+
+	wakeup_writer(att);
+
+	return op->id;
 }
 
 bool bt_att_cancel_all(struct bt_att *att)
-- 
1.8.3.2

