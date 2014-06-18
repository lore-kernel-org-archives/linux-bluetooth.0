Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v5 2/4] src/shared/att: Implement basic boilerplate.
Date: Wed, 18 Jun 2014 13:25:41 -0700
Message-Id: <1403123143-17543-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1403123143-17543-1-git-send-email-armansito@chromium.org>
References: <1403123143-17543-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the getters, setters, creation, ref, and unref
functions for struct bt_att. Also added is a simple table for
determining the ATT op type given an opcode and the io read handler that
currently does nothing.
---
 src/shared/att.c | 306 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 286 insertions(+), 20 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 4a1cac4..4659674 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -25,15 +25,19 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
 #include <unistd.h>
 
 #include "src/shared/io.h"
 #include "src/shared/queue.h"
+#include "src/shared/util.h"
 #include "lib/uuid.h"
 #include "src/shared/att.h"
 
 #define ATT_DEFAULT_LE_MTU		23
 #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
+#define ATT_OP_CMD_MASK			0x40
+#define ATT_OP_SIGNED_MASK		0x80
 
 struct att_send_op;
 
@@ -51,8 +55,6 @@ struct bt_att {
 	struct queue *write_queue;	/* Queue of PDUs ready to send */
 	bool writer_active;
 
-	/* TODO Add notify queue */
-
 	uint8_t *buf;
 	uint16_t mtu;
 
@@ -68,8 +70,66 @@ struct bt_att {
 	void *debug_data;
 };
 
+enum att_op_type {
+	ATT_OP_TYPE_REQ,
+	ATT_OP_TYPE_RSP,
+	ATT_OP_TYPE_CMD,
+	ATT_OP_TYPE_IND,
+	ATT_OP_TYPE_NOT,
+	ATT_OP_TYPE_CONF,
+	ATT_OP_TYPE_UNKNOWN,
+};
+
+static const struct {
+	uint8_t opcode;
+	enum att_op_type type;
+} att_opcode_type_table[] = {
+	{ BT_ATT_OP_ERROR_RSP,			ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_MTU_REQ,			ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_MTU_RSP,			ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_FIND_INFO_REQ,		ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_FIND_INFO_RSP,		ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,	ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_FIND_BY_TYPE_VAL_RSP,	ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_READ_BY_TYPE_REQ,		ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_READ_BY_TYPE_RSP,		ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_READ_REQ,			ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_READ_RSP,			ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_READ_BLOB_REQ,		ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_READ_BLOB_RSP,		ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_READ_MULT_REQ,		ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_READ_MULT_RSP,		ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_READ_BY_GRP_TYPE_REQ,	ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_READ_BY_GRP_TYPE_RSP,	ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_WRITE_REQ,			ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_WRITE_RSP,			ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_WRITE_CMD,			ATT_OP_TYPE_CMD },
+	{ BT_ATT_OP_SIGNED_WRITE_CMD,		ATT_OP_TYPE_CMD },
+	{ BT_ATT_OP_PREP_WRITE_REQ,		ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_PREP_WRITE_RSP,		ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_EXEC_WRITE_REQ,		ATT_OP_TYPE_REQ },
+	{ BT_ATT_OP_EXEC_WRITE_RSP,		ATT_OP_TYPE_RSP },
+	{ BT_ATT_OP_HANDLE_VAL_NOT,		ATT_OP_TYPE_NOT },
+	{ BT_ATT_OP_HANDLE_VAL_IND,		ATT_OP_TYPE_IND },
+	{ BT_ATT_OP_HANDLE_VAL_CONF,		ATT_OP_TYPE_CONF },
+	{ }
+};
+
+static enum att_op_type get_op_type(uint8_t opcode)
+{
+	int i;
+
+	for (i = 0; att_opcode_type_table[i].opcode; i++) {
+		if (att_opcode_type_table[i].opcode == opcode)
+			return att_opcode_type_table[i].type;
+	}
+
+	return ATT_OP_TYPE_UNKNOWN;
+}
+
 struct att_send_op {
 	unsigned int id;
+	enum att_op_type type;
 	uint16_t opcode;
 	void *pdu;
 	uint16_t len;
@@ -78,54 +138,206 @@ struct att_send_op {
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
+		return true;
+
+	/* TODO: Handle different types of PDUs here */
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
+	if (!io_set_read_handler(att->io, can_read_data, att, NULL))
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
+	if (att->timeout_destroy)
+		att->timeout_destroy(att->timeout_data);
+
+	if (att->debug_destroy)
+		att->debug_destroy(att->debug_data);
+
+	free(att->buf);
+	att->buf = NULL;
+
+	free(att);
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
 
 bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
 						void *user_data,
 						bt_att_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	if (!att)
+		return false;
+
+	if (att->timeout_destroy)
+		att->timeout_destroy(att->timeout_data);
+
+	att->timeout_callback = callback;
+	att->timeout_destroy = destroy;
+	att->timeout_data = user_data;
+
+	return true;
 }
 
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
@@ -137,16 +349,70 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	return 0;
 }
 
+static bool match_op_id(const void *a, const void *b)
+{
+	const struct att_send_op *op = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return op->id == id;
+}
+
 bool bt_att_cancel(struct bt_att *att, unsigned int id)
 {
-	/* TODO */
-	return false;
+	struct att_send_op *op;
+
+	if (!att || !id)
+		return false;
+
+	if (att->pending_req && att->pending_req->id == id) {
+		op = att->pending_req;
+		goto done;
+	}
+
+	if (att->pending_ind && att->pending_ind->id == id) {
+		op = att->pending_ind;
+		goto done;
+	}
+
+	op = queue_remove_if(att->req_queue, match_op_id, UINT_TO_PTR(id));
+	if (op)
+		goto done;
+
+	op = queue_remove_if(att->ind_queue, match_op_id, UINT_TO_PTR(id));
+	if (op)
+		goto done;
+
+	op = queue_remove_if(att->write_queue, match_op_id, UINT_TO_PTR(id));
+	if (op)
+		goto done;
+
+	if (!op)
+		return false;
+
+done:
+	destroy_att_send_op(op);
+
+	/* TODO: Set the write handler here */
+
+	return true;
 }
 
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
+	if (att->pending_req)
+		destroy_att_send_op(att->pending_req);
+
+	if (att->pending_ind)
+		destroy_att_send_op(att->pending_ind);
+
+	return true;
 }
 
 unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
-- 
1.8.3.2

