Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v3 2/4] src/shared/att: Implement basic boilerplate.
Date: Mon,  9 Jun 2014 18:33:58 -0700
Message-Id: <1402364040-11502-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1402364040-11502-1-git-send-email-armansito@chromium.org>
References: <1402364040-11502-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the getters, setters, creation, ref, and unref
functions for struct bt_att. Also added is a simple table for
determining the ATT op type given an opcode and the io read handler that
currently does nothing.
---
 src/shared/att.c | 280 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 264 insertions(+), 16 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 6398ca7..270a9df 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -34,6 +34,8 @@
 
 #define ATT_DEFAULT_LE_MTU		23
 #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
+#define ATT_OP_CMD_MASK			0x40
+#define ATT_OP_SIGNED_MASK		0x80
 
 struct att_send_op;
 
@@ -51,12 +53,14 @@ struct bt_att {
 	struct queue *write_queue;	/* Queue of PDUs ready to send */
 	bool writer_active;
 
-	/* TODO Add queues for registered request and notification handlers */
+	/* TODO: Add queues for registered request and notification handlers */
+	/* TODO: Add a timeout mechanism for pending ops */
 
 	uint8_t *buf;
 	uint16_t mtu;
 
 	uint8_t auth_sig[12];
+	bool sig_set;
 
 	unsigned int next_send_id;	/* IDs for "send" ops */
 	unsigned int next_reg_id;	/* IDs for registered callbacks */
@@ -66,8 +70,68 @@ struct bt_att {
 	void *debug_data;
 };
 
+typedef enum {
+	ATT_OP_TYPE_REQ,
+	ATT_OP_TYPE_RSP,
+	ATT_OP_TYPE_CMD,
+	ATT_OP_TYPE_IND,
+	ATT_OP_TYPE_NOT,
+	ATT_OP_TYPE_CONF,
+	ATT_OP_TYPE_UNKNOWN,
+} att_op_type_t;
+
+static att_op_type_t get_op_type(uint8_t opcode)
+{
+	switch (opcode) {
+	/* Requests */
+	case BT_ATT_OP_MTU_REQ:
+	case BT_ATT_OP_FIND_INFO_REQ:
+	case BT_ATT_OP_FIND_BY_TYPE_VAL_REQ:
+	case BT_ATT_OP_READ_BY_TYPE_REQ:
+	case BT_ATT_OP_READ_REQ:
+	case BT_ATT_OP_READ_BLOB_REQ:
+	case BT_ATT_OP_READ_MULT_REQ:
+	case BT_ATT_OP_READ_BY_GRP_TYPE_REQ:
+	case BT_ATT_OP_WRITE_REQ:
+	case BT_ATT_OP_PREP_WRITE_REQ:
+	case BT_ATT_OP_EXEC_WRITE_REQ:
+		return ATT_OP_TYPE_REQ;
+	/* Commands */
+	case BT_ATT_OP_SIGNED_WRITE_CMD:
+	case BT_ATT_OP_WRITE_CMD:
+		return ATT_OP_TYPE_CMD;
+	/* Responses */
+	case BT_ATT_OP_ERROR_RSP:
+	case BT_ATT_OP_MTU_RSP:
+	case BT_ATT_OP_FIND_INFO_RSP:
+	case BT_ATT_OP_FIND_BY_TYPE_VAL_RSP:
+	case BT_ATT_OP_READ_BY_TYPE_RSP:
+	case BT_ATT_OP_READ_RSP:
+	case BT_ATT_OP_READ_BLOB_RSP:
+	case BT_ATT_OP_READ_MULT_RSP:
+	case BT_ATT_OP_READ_BY_GRP_TYPE_RSP:
+	case BT_ATT_OP_WRITE_RSP:
+	case BT_ATT_OP_PREP_WRITE_RSP:
+	case BT_ATT_OP_EXEC_WRITE_RSP:
+		return ATT_OP_TYPE_RSP;
+	/* Notifications */
+	case BT_ATT_OP_HANDLE_VAL_NOT:
+		return ATT_OP_TYPE_NOT;
+	/* Indications */
+	case BT_ATT_OP_HANDLE_VAL_IND:
+		return ATT_OP_TYPE_IND;
+	/* Confirmations */
+	case BT_ATT_OP_HANDLE_VAL_CONF:
+		return ATT_OP_TYPE_CONF;
+	default:
+		return ATT_OP_TYPE_UNKNOWN;
+	}
+	return ATT_OP_TYPE_UNKNOWN;
+}
+
 struct att_send_op {
 	unsigned int id;
+	att_op_type_t op_type;
 	uint16_t opcode;
 	void *pdu;
 	uint16_t len;
@@ -76,51 +140,229 @@ struct att_send_op {
 	void *user_data;
 };
 
+static void destroy_att_send_op(void *data)
+{
+	struct att_send_op *op = data;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op->pdu);
+	free(op);
+}
+
+static void read_watch_destroy(void *user_data)
+{
+	struct bt_att *att = user_data;
+
+	if (!att->destroyed)
+		return;
+
+	if (att->pending_req)
+		destroy_att_send_op(att->pending_req);
+
+	if (att->pending_ind)
+		destroy_att_send_op(att->pending_ind);
+
+	free(att);
+}
+
+static bool can_read_data(struct io *io, void *user_data)
+{
+	struct bt_att *att = user_data;
+	uint8_t *pdu;
+	ssize_t bytes_read;
+
+	bytes_read = read(att->fd, att->buf, att->mtu);
+	if (bytes_read < 0)
+		return false;
+
+	util_hexdump('>', att->buf, bytes_read,
+					att->debug_callback, att->debug_data);
+
+	if (bytes_read < ATT_MIN_PDU_LEN)
+		goto done;
+
+	/* TODO: Handle different types of PDUs here */
+
+done:
+	if (att->destroyed)
+		return false;
+
+	return true;
+}
+
 struct bt_att *bt_att_new(int fd)
 {
-	/* TODO */
+	struct bt_att *att;
+
+	if (fd < 0)
+		return NULL;
+
+	att = new0(struct bt_att, 1);
+	if (!att)
+		return NULL;
+
+	att->fd = fd;
+
+	att->mtu = ATT_DEFAULT_LE_MTU;
+	att->buf = malloc(att->mtu);
+	if (!att->buf)
+		goto fail;
+
+	att->io = io_new(fd);
+	if (!att->io)
+		goto fail;
+
+	att->req_queue = queue_new();
+	if (!att->req_queue)
+		goto fail;
+
+	att->ind_queue = queue_new();
+	if (!att->ind_queue)
+		goto fail;
+
+	att->write_queue = queue_new();
+	if (!att->write_queue)
+		goto fail;
+
+	if (!io_set_read_handler(att->io, can_read_data, att,
+							read_watch_destroy))
+		goto fail;
+
+	return bt_att_ref(att);
+
+fail:
+	queue_destroy(att->req_queue, NULL);
+	queue_destroy(att->ind_queue, NULL);
+	queue_destroy(att->write_queue, NULL);
+	io_destroy(att->io);
+	free(att->buf);
+	free(att);
+
 	return NULL;
 }
 
 struct bt_att *bt_att_ref(struct bt_att *att)
 {
-	/* TODO */
-	return NULL;
+	if (!att)
+		return NULL;
+
+	__sync_fetch_and_add(&att->ref_count, 1);
+
+	return att;
 }
 
 void bt_att_unref(struct bt_att *att)
 {
-	/* TODO */
+	if (!att)
+		return;
+
+	if (__sync_sub_and_fetch(&att->ref_count, 1))
+		return;
+
+	bt_att_cancel_all(att);
+
+	io_set_write_handler(att->io, NULL, NULL, NULL);
+	io_set_read_handler(att->io, NULL, NULL, NULL);
+
+	queue_destroy(att->req_queue, NULL);
+	queue_destroy(att->ind_queue, NULL);
+	queue_destroy(att->write_queue, NULL);
+	att->req_queue = NULL;
+	att->ind_queue = NULL;
+	att->write_queue = NULL;
+
+	io_destroy(att->io);
+	att->io = NULL;
+
+	if (att->close_on_unref)
+		close(att->fd);
+
+	if (att->debug_destroy)
+		att->debug_destroy(att->debug_data);
+
+	free(att->buf);
+	att->buf = NULL;
+
+	/*
+	 * Defer freeing the bt_att structure here; if this call to unref
+	 * happened during a callback called from the io read handler, we can
+	 * end up freeing the structure prematurely, in which case the clean up
+	 * should occur in read_watch_destroy.
+	 */
+	if (att->pending_req)
+		destroy_att_send_op(att->pending_req);
+
+	if (att->pending_ind)
+		destroy_att_send_op(att->pending_ind);
+
+	att->destroyed = true;
 }
 
 bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
 {
-	/* TODO */
-	return false;
+	if (!att)
+		return false;
+
+	att->close_on_unref = do_close;
+
+	return true;
 }
 
 bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
 				void *user_data, bt_att_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	if (!att)
+		return false;
+
+	if (att->debug_destroy)
+		att->debug_destroy(att->debug_data);
+
+	att->debug_callback = callback;
+	att->debug_destroy = destroy;
+	att->debug_data = user_data;
+
+	return true;
 }
 
 uint16_t bt_att_get_mtu(struct bt_att *att)
 {
-	/* TODO */
-	return 0;
+	if (!att)
+		return 0;
+
+	return att->mtu;
 }
 
 bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
 {
-	/* TODO */
-	return false;
+	char *buf;
+
+	if (!att)
+		return false;
+
+	if (mtu < ATT_DEFAULT_LE_MTU)
+		return false;
+
+	buf = malloc(mtu);
+	if (!buf)
+		return false;
+
+	free(att->buf);
+
+	att->mtu = mtu;
+	att->buf = buf;
+
+	return true;
 }
 
 void bt_att_set_auth_signature(struct bt_att *att, uint8_t signature[12])
 {
-	/* TODO */
+	if (!att)
+		return;
+
+	memcpy(att->auth_sig, signature, sizeof(signature));
+	att->sig_set = true;
 }
 
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
@@ -134,8 +376,14 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 
 bool bt_att_cancel_all(struct bt_att *att)
 {
-	/* TODO */
-	return false;
+	if (!att)
+		return false;
+
+	queue_remove_all(att->req_queue, NULL, NULL, destroy_att_send_op);
+	queue_remove_all(att->ind_queue, NULL, NULL, destroy_att_send_op);
+	queue_remove_all(att->write_queue, NULL, NULL, destroy_att_send_op);
+
+	return true;
 }
 
 unsigned int bt_att_register_request(struct bt_att *att,
-- 
1.8.3.2

