Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v5 3/4] src/shared/att: Implement write handler and bt_att_send.
Date: Wed, 18 Jun 2014 13:25:42 -0700
Message-Id: <1403123143-17543-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1403123143-17543-1-git-send-email-armansito@chromium.org>
References: <1403123143-17543-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the write handler logic, including the way send
operations are process from the various internal queues. Added PDU
encoding for the Exchange MTU request.
---
 src/shared/att.c | 307 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 304 insertions(+), 3 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 4659674..000a227 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -27,10 +27,12 @@
 
 #include <stdlib.h>
 #include <unistd.h>
+#include <errno.h>
 
 #include "src/shared/io.h"
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
+#include "src/shared/timeout.h"
 #include "lib/uuid.h"
 #include "src/shared/att.h"
 
@@ -38,6 +40,7 @@
 #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
 #define ATT_OP_CMD_MASK			0x40
 #define ATT_OP_SIGNED_MASK		0x80
+#define ATT_TIMEOUT_INTERVAL		30000  /* 30000 ms */
 
 struct att_send_op;
 
@@ -129,6 +132,7 @@ static enum att_op_type get_op_type(uint8_t opcode)
 
 struct att_send_op {
 	unsigned int id;
+	unsigned int timeout_id;
 	enum att_op_type type;
 	uint16_t opcode;
 	void *pdu;
@@ -138,10 +142,146 @@ struct att_send_op {
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
+	((uint8_t *) op->pdu)[0] = op->opcode;
+	put_le16(p->client_rx_mtu, ((uint8_t *) op->pdu) + 1);
+	op->len = len;
+
+	return true;
+}
+
+static bool encode_pdu(struct att_send_op *op, const void *param,
+						uint16_t length, uint16_t mtu)
+{
+	/* If no parameters are given, simply set the PDU to consist of the
+	 * opcode (e.g. BT_ATT_OP_WRITE_RSP),
+	 */
+	if (!length || !param) {
+		op->len = 1;
+		op->pdu = malloc(1);
+		if (!op->pdu)
+			return false;
+
+		((uint8_t *) op->pdu)[0] = op->opcode;
+		return true;
+	}
+
+	/* TODO: If the opcode has the "signed" bit set, make sure that the
+	 * resulting PDU contains the authentication signature. Return an error,
+	 * if the provided parameters structure is such that it leaves no room
+	 * for an authentication signature in the PDU, or if no signing data
+	 * has been set to generate the authentication signature.
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
+	enum att_op_type op_type;
+
+	if (!length && !param)
+		return NULL;
+
+	op_type = get_op_type(opcode);
+	if (op_type == ATT_OP_TYPE_UNKNOWN)
+		return NULL;
+
+	/* If the opcode corresponds to an operation type that does not elicit a
+	 * response from the remote end, then no callback should have been
+	 * provided, since it will never be called.
+	 */
+	if (callback && op_type != ATT_OP_TYPE_REQ && op_type != ATT_OP_TYPE_IND)
+		return NULL;
+
+	/* Similarly, if the operation does elicit a response then a callback
+	 * must be provided.
+	 */
+	if (!callback && (op_type == ATT_OP_TYPE_REQ || op_type == ATT_OP_TYPE_IND))
+		return NULL;
+
+	op = new0(struct att_send_op, 1);
+	if (!op)
+		return NULL;
+
+	op->type = op_type;
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
+static struct att_send_op *pick_next_send_op(struct bt_att *att)
+{
+	struct att_send_op *op;
+
+	/* See if any operations are already in the write queue */
+	op = queue_pop_head(att->write_queue);
+	if (op)
+		return op;
+
+	/* If there is no pending request, pick an operation from the
+	 * request queue.
+	 */
+	if (!att->pending_req) {
+		op = queue_pop_head(att->req_queue);
+		if (op)
+			return op;
+	}
+
+	/* There is either a request pending or no requests queued. If there is
+	 * no pending indication, pick an operation from the indication queue.
+	 */
+	if (!att->pending_ind) {
+		op = queue_pop_head(att->ind_queue);
+		if (op)
+			return op;
+	}
+
+	return NULL;
+}
+
 static void destroy_att_send_op(void *data)
 {
 	struct att_send_op *op = data;
 
+	if (op->timeout_id)
+		timeout_remove(op->timeout_id);
+
 	if (op->destroy)
 		op->destroy(op->user_data);
 
@@ -149,6 +289,128 @@ static void destroy_att_send_op(void *data)
 	free(op);
 }
 
+struct timeout_data {
+	struct bt_att *att;
+	unsigned int id;
+};
+
+static bool timeout_cb(void *user_data)
+{
+	struct timeout_data *timeout = user_data;
+	struct bt_att *att = timeout->att;
+	struct att_send_op *op = NULL;
+
+	if (att->pending_req && att->pending_req->id == timeout->id) {
+		op = att->pending_req;
+		att->pending_req = NULL;
+	} else if (att->pending_ind && att->pending_ind->id == timeout->id) {
+		op = att->pending_ind;
+		att->pending_ind = NULL;
+	}
+
+	if (!op)
+		return false;
+
+	att->invalid = true;
+
+	util_debug(att->debug_callback, att->debug_data,
+				"Operation timed out: 0x%02x", op->opcode);
+
+	if (att->timeout_callback)
+		att->timeout_callback(op->id, op->opcode, att->timeout_data);
+
+	op->timeout_id = 0;
+	destroy_att_send_op(op);
+
+	return false;
+}
+
+static void write_watch_destroy(void *user_data)
+{
+	struct bt_att *att = user_data;
+
+	att->writer_active = false;
+}
+
+static bool can_write_data(struct io *io, void *user_data)
+{
+	struct bt_att *att = user_data;
+	struct att_send_op *op;
+	struct timeout_data *timeout;
+	ssize_t bytes_written;
+
+	op = pick_next_send_op(att);
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
+	/* Based on the operation type, set either the pending request or the
+	 * pending indication. If it came from the write queue, then there is
+	 * no need to keep it around.
+	 */
+	switch (op->type) {
+	case ATT_OP_TYPE_REQ:
+		att->pending_req = op;
+		break;
+	case ATT_OP_TYPE_IND:
+		att->pending_ind = op;
+		break;
+	default:
+		destroy_att_send_op(op);
+		return true;
+	}
+
+	timeout = new0(struct timeout_data, 1);
+	if (!timeout)
+		return true;
+
+	timeout->att = att;
+	timeout->id = op->id;
+	op->timeout_id = timeout_add(ATT_TIMEOUT_INTERVAL, timeout_cb,
+								timeout, free);
+
+	/* Return true as there may be more operations ready to write. */
+	return true;
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
+	if (queue_isempty(att->write_queue)) {
+		if ((att->pending_req || queue_isempty(att->req_queue)) &&
+			(att->pending_ind || queue_isempty(att->ind_queue)))
+			return;
+	}
+
+	if (!io_set_write_handler(att->io, can_write_data, att,
+							write_watch_destroy))
+		return;
+
+	att->writer_active = true;
+}
+
 static bool can_read_data(struct io *io, void *user_data)
 {
 	struct bt_att *att = user_data;
@@ -345,8 +607,47 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 				bt_att_request_func_t callback, void *user_data,
 				bt_att_destroy_func_t destroy)
 {
-	/* TODO */
-	return 0;
+	struct att_send_op *op;
+	bool result;
+
+	if (!att)
+		return 0;
+
+	if (att->invalid)
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
+	switch (op->type) {
+	case ATT_OP_TYPE_REQ:
+		result = queue_push_tail(att->req_queue, op);
+		break;
+	case ATT_OP_TYPE_IND:
+		result = queue_push_tail(att->ind_queue, op);
+		break;
+	default:
+		result = queue_push_tail(att->write_queue, op);
+		break;
+	}
+
+	if (!result) {
+		free(op->pdu);
+		free(op);
+		return 0;
+	}
+
+	wakeup_writer(att);
+
+	return op->id;
 }
 
 static bool match_op_id(const void *a, const void *b)
@@ -392,7 +693,7 @@ bool bt_att_cancel(struct bt_att *att, unsigned int id)
 done:
 	destroy_att_send_op(op);
 
-	/* TODO: Set the write handler here */
+	wakeup_writer(att);
 
 	return true;
 }
-- 
1.8.3.2

