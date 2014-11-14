Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 1/7] shared/att: Add API for sending ATT error response.
Date: Thu, 13 Nov 2014 18:49:47 -0800
Message-Id: <1415933393-28902-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1415933393-28902-1-git-send-email-armansito@chromium.org>
References: <1415933393-28902-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds bt_att_send_error_rsp which sends an ATT protocol error
response PDU over the underlying link based on the parameters that are
passed to it. This is a useful function since it reduces a lot of
repeated code in shared/gatt-server that does the same thing.

The "error" parameter is expressed as a signed integer (in line with the
new shared/gatt-db APIs). bt_att_send_error_rsp correctly maps this
(including possible UNIX errnos) to ATT protocol error codes. In
addition, struct bt_att_pdu_error_rsp is introduced to represent a
packed error response PDU which can be sent directly over the wire once
properly encoded in network order.
---
 src/shared/att-types.h    |  12 +++
 src/shared/att.c          |  60 ++++++++++++-
 src/shared/att.h          |   3 +
 src/shared/gatt-client.c  |   8 +-
 src/shared/gatt-helpers.c |   8 +-
 src/shared/gatt-server.c  | 208 +++++++++++++---------------------------------
 6 files changed, 145 insertions(+), 154 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 24bf3da..3d8829a 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -23,6 +23,10 @@
 
 #include <stdint.h>
 
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
 #define BT_ATT_DEFAULT_LE_MTU 23
 
 /* ATT protocol opcodes */
@@ -55,6 +59,14 @@
 #define BT_ATT_OP_HANDLE_VAL_IND		0x1D
 #define BT_ATT_OP_HANDLE_VAL_CONF		0x1E
 
+/* Packed struct definitions for ATT protocol PDUs */
+/* TODO: Complete these definitions for all opcodes */
+struct bt_att_pdu_error_rsp {
+	uint8_t opcode;
+	uint16_t handle;
+	uint8_t ecode;
+} __packed;
+
 /* Special opcode to receive all requests (legacy servers) */
 #define BT_ATT_ALL_REQUESTS 0x00
 
diff --git a/src/shared/att.c b/src/shared/att.c
index 6e1e538..2bc7682 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -35,13 +35,22 @@
 #include "src/shared/timeout.h"
 #include "lib/uuid.h"
 #include "src/shared/att.h"
-#include "src/shared/att-types.h"
 
 #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
 #define ATT_OP_CMD_MASK			0x40
 #define ATT_OP_SIGNED_MASK		0x80
 #define ATT_TIMEOUT_INTERVAL		30000  /* 30000 ms */
 
+/*
+ * Common Profile and Service Error Code descriptions (see Supplement to the
+ * Bluetooth Core Specification, sections 1.2 and 2). The error codes within
+ * 0xE0-0xFC are reserved for future use. The remaining 3 are defined as the
+ * following:
+ */
+#define BT_ERROR_CCC_IMPROPERLY_CONFIGURED	0xfd
+#define BT_ERROR_ALREADY_IN_PROGRESS		0xfe
+#define BT_ERROR_OUT_OF_RANGE			0xff
+
 struct att_send_op;
 
 struct bt_att {
@@ -1139,6 +1148,55 @@ bool bt_att_cancel_all(struct bt_att *att)
 	return true;
 }
 
+static uint8_t att_ecode_from_error(int err)
+{
+	/*
+	 * If the error fits in a single byte, treat it as an ATT protocol
+	 * error as is. Since "0" is not a valid ATT protocol error code, we map
+	 * that to UNLIKELY below.
+	 */
+	if (err > 0 && err < UINT8_MAX)
+		return err;
+
+	/*
+	 * Since we allow UNIX errnos, map them to appropriate ATT protocol
+	 * and "Common Profile and Service" error codes.
+	 */
+	switch (err) {
+	case -ENOENT:
+		return BT_ATT_ERROR_INVALID_HANDLE;
+	case -ENOMEM:
+		return BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+	case -EALREADY:
+		return BT_ERROR_ALREADY_IN_PROGRESS;
+	case -EOVERFLOW:
+		return BT_ERROR_OUT_OF_RANGE;
+	}
+
+	return BT_ATT_ERROR_UNLIKELY;
+}
+
+unsigned int bt_att_send_error_rsp(struct bt_att *att, uint8_t opcode,
+						uint16_t handle, int error)
+{
+	struct bt_att_pdu_error_rsp pdu;
+	uint8_t ecode;
+
+	if (!att || !opcode)
+		return 0;
+
+	ecode = att_ecode_from_error(error);
+
+	memset(&pdu, 0, sizeof(pdu));
+
+	pdu.opcode = opcode;
+	put_le16(handle, &pdu.handle);
+	pdu.ecode = ecode;
+
+	return bt_att_send(att, BT_ATT_OP_ERROR_RSP, &pdu, sizeof(pdu),
+							NULL, NULL, NULL);
+}
+
 unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
 						bt_att_notify_func_t callback,
 						void *user_data,
diff --git a/src/shared/att.h b/src/shared/att.h
index 1063021..99b5a5b 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -63,6 +63,9 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 bool bt_att_cancel(struct bt_att *att, unsigned int id);
 bool bt_att_cancel_all(struct bt_att *att);
 
+unsigned int bt_att_send_error_rsp(struct bt_att *att, uint8_t opcode,
+						uint16_t handle, int error);
+
 unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
 						bt_att_notify_func_t callback,
 						void *user_data,
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 30b271e..1f82048 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1285,10 +1285,14 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 
 static uint8_t process_error(const void *pdu, uint16_t length)
 {
-	if (!pdu || length != 4)
+	const struct bt_att_pdu_error_rsp *error_pdu;
+
+	if (!pdu || length != sizeof(struct bt_att_pdu_error_rsp))
 		return 0;
 
-	return ((uint8_t *) pdu)[3];
+	error_pdu = pdu;
+
+	return error_pdu->ecode;
 }
 
 static void enable_ccc_callback(uint8_t opcode, const void *pdu,
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 220d0eb..9c8a3ba 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -430,10 +430,14 @@ static void destroy_mtu_op(void *user_data)
 
 static uint8_t process_error(const void *pdu, uint16_t length)
 {
-	if (!pdu || length != 4)
+	const struct bt_att_pdu_error_rsp *error_pdu;
+
+	if (!pdu || length != sizeof(struct bt_att_pdu_error_rsp))
 		return 0;
 
-	return ((uint8_t *) pdu)[3];
+	error_pdu = pdu;
+
+	return error_pdu->ecode;
 }
 
 static void mtu_cb(uint8_t opcode, const void *pdu, uint16_t length,
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 2ca318a..2ef9269 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -22,6 +22,7 @@
  */
 
 #include <sys/uio.h>
+#include <errno.h>
 
 #include "src/shared/att.h"
 #include "lib/uuid.h"
@@ -29,7 +30,6 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/gatt-helpers.h"
-#include "src/shared/att-types.h"
 #include "src/shared/util.h"
 
 #ifndef MAX
@@ -133,22 +133,6 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	free(server);
 }
 
-static uint8_t att_ecode_from_error(int err)
-{
-	if (err < 0 || err > UINT8_MAX)
-		return 0xff;
-
-	return err;
-}
-
-static void encode_error_rsp(uint8_t opcode, uint16_t handle, uint8_t ecode,
-								uint8_t pdu[4])
-{
-	pdu[0] = opcode;
-	pdu[3] = ecode;
-	put_le16(handle, pdu + 1);
-}
-
 static bool get_uuid_le(const uint8_t *uuid, size_t len, bt_uuid_t *out_uuid)
 {
 	uint128_t u128;
@@ -247,7 +231,6 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	uint16_t mtu = bt_att_get_mtu(server->att);
 	uint8_t rsp_pdu[mtu];
 	uint16_t rsp_len;
-	uint8_t rsp_opcode;
 	uint8_t ecode = 0;
 	uint16_t ehandle = 0;
 	struct queue *q = NULL;
@@ -309,19 +292,17 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
-	rsp_opcode = BT_ATT_OP_READ_BY_GRP_TYPE_RSP;
+	queue_destroy(q, NULL);
 
-	goto done;
+	bt_att_send(server->att, BT_ATT_OP_READ_BY_GRP_TYPE_RSP,
+							rsp_pdu, rsp_len,
+							NULL, NULL, NULL);
 
-error:
-	rsp_opcode = BT_ATT_OP_ERROR_RSP;
-	rsp_len = 4;
-	encode_error_rsp(opcode, ehandle, ecode, rsp_pdu);
+	return;
 
-done:
+error:
 	queue_destroy(q, NULL);
-	bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len,
-							NULL, NULL, NULL);
+	bt_att_send_error_rsp(server->att, opcode, ehandle, ecode);
 }
 
 static void async_read_op_destroy(struct async_read_op *op)
@@ -355,13 +336,8 @@ static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
 
 	/* Terminate the operation if there was an error */
 	if (err) {
-		uint8_t pdu[4];
-		uint8_t att_ecode = att_ecode_from_error(err);
-
-		encode_error_rsp(BT_ATT_OP_READ_BY_TYPE_REQ, handle, att_ecode,
-									pdu);
-		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
-								NULL, NULL);
+		bt_att_send_error_rsp(server->att, BT_ATT_OP_READ_BY_TYPE_REQ,
+								handle, err);
 		async_read_op_destroy(op);
 		return;
 	}
@@ -397,19 +373,19 @@ done:
 static void process_read_by_type(struct async_read_op *op)
 {
 	struct bt_gatt_server *server = op->server;
-	uint8_t rsp_opcode;
-	uint8_t rsp_len;
 	uint8_t ecode;
-	uint16_t ehandle;
 	struct gatt_db_attribute *attr;
 	uint32_t perm;
 
 	attr = queue_pop_head(op->db_data);
 
 	if (op->done || !attr) {
-		rsp_opcode = BT_ATT_OP_READ_BY_TYPE_RSP;
-		rsp_len = op->pdu_len;
-		goto done;
+		bt_att_send(server->att, BT_ATT_OP_READ_BY_TYPE_RSP, op->pdu,
+								op->pdu_len,
+								NULL, NULL,
+								NULL);
+		async_read_op_destroy(op);
+		return;
 	}
 
 	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
@@ -435,14 +411,8 @@ static void process_read_by_type(struct async_read_op *op)
 	ecode = BT_ATT_ERROR_UNLIKELY;
 
 error:
-	ehandle = gatt_db_attribute_get_handle(attr);
-	rsp_opcode = BT_ATT_OP_ERROR_RSP;
-	rsp_len = 4;
-	encode_error_rsp(BT_ATT_OP_READ_BY_TYPE_REQ, ehandle, ecode, op->pdu);
-
-done:
-	bt_att_send(server->att, rsp_opcode, op->pdu, rsp_len, NULL,
-								NULL, NULL);
+	bt_att_send_error_rsp(server->att, BT_ATT_OP_READ_BY_TYPE_REQ,
+				gatt_db_attribute_get_handle(attr), ecode);
 	async_read_op_destroy(op);
 }
 
@@ -452,7 +422,6 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
 	bt_uuid_t type;
-	uint8_t rsp_pdu[4];
 	uint16_t ehandle = 0;
 	uint8_t ecode;
 	struct queue *q = NULL;
@@ -524,10 +493,8 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 	return;
 
 error:
-	encode_error_rsp(opcode, ehandle, ecode, rsp_pdu);
+	bt_att_send_error_rsp(server->att, opcode, ehandle, ecode);
 	queue_destroy(q, NULL);
-	bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
-							NULL, NULL, NULL);
 }
 
 static void put_uuid_le(const bt_uuid_t *src, void *dst)
@@ -612,7 +579,6 @@ static void find_info_cb(uint8_t opcode, const void *pdu,
 	uint16_t mtu = bt_att_get_mtu(server->att);
 	uint8_t rsp_pdu[mtu];
 	uint16_t rsp_len;
-	uint8_t rsp_opcode;
 	uint8_t ecode = 0;
 	uint16_t ehandle = 0;
 	struct queue *q = NULL;
@@ -659,19 +625,16 @@ static void find_info_cb(uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
-	rsp_opcode = BT_ATT_OP_FIND_INFO_RSP;
+	bt_att_send(server->att, BT_ATT_OP_FIND_INFO_RSP, rsp_pdu, rsp_len,
+							NULL, NULL, NULL);
+	queue_destroy(q, NULL);
 
-	goto done;
+	return;
 
 error:
-	rsp_opcode = BT_ATT_OP_ERROR_RSP;
-	rsp_len = 4;
-	encode_error_rsp(opcode, ehandle, ecode, rsp_pdu);
-
-done:
+	bt_att_send_error_rsp(server->att, opcode, ehandle, ecode);
 	queue_destroy(q, NULL);
-	bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len,
-							NULL, NULL, NULL);
+
 }
 
 static void async_write_op_destroy(struct async_write_op *op)
@@ -696,17 +659,11 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
 
 	handle = gatt_db_attribute_get_handle(attr);
 
-	if (err) {
-		uint8_t rsp_pdu[4];
-		uint8_t att_ecode = att_ecode_from_error(err);
-
-		encode_error_rsp(op->opcode, handle, att_ecode, rsp_pdu);
-		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
-							NULL, NULL, NULL);
-	} else {
+	if (err)
+		bt_att_send_error_rsp(server->att, op->opcode, handle, err);
+	else
 		bt_att_send(server->att, BT_ATT_OP_WRITE_RSP, NULL, 0,
 							NULL, NULL, NULL);
-	}
 
 	async_write_op_destroy(op);
 }
@@ -717,7 +674,6 @@ static void write_cb(uint8_t opcode, const void *pdu,
 	struct bt_gatt_server *server = user_data;
 	struct gatt_db_attribute *attr;
 	uint16_t handle = 0;
-	uint8_t rsp_pdu[4];
 	struct async_write_op *op = NULL;
 	uint8_t ecode;
 	uint32_t perm;
@@ -777,9 +733,7 @@ error:
 	if (opcode == BT_ATT_OP_WRITE_CMD)
 		return;
 
-	encode_error_rsp(opcode, handle, ecode, rsp_pdu);
-	bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
-							NULL, NULL, NULL);
+	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
 }
 
 static uint8_t get_read_rsp_opcode(uint8_t opcode)
@@ -824,12 +778,7 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	handle = gatt_db_attribute_get_handle(attr);
 
 	if (err) {
-		uint8_t pdu[4];
-		uint8_t att_ecode = att_ecode_from_error(err);
-
-		encode_error_rsp(op->opcode, handle, att_ecode, pdu);
-		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
-								NULL, NULL);
+		bt_att_send_error_rsp(server->att, op->opcode, handle, err);
 		async_read_op_destroy(op);
 		return;
 	}
@@ -846,7 +795,6 @@ static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
 								uint16_t handle,
 								uint16_t offset)
 {
-	uint8_t error_pdu[4];
 	struct gatt_db_attribute *attr;
 	uint8_t ecode;
 	uint32_t perm;
@@ -898,9 +846,7 @@ error:
 	if (op)
 		async_read_op_destroy(op);
 
-	encode_error_rsp(opcode, handle, ecode, error_pdu);
-	bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, error_pdu, 4, NULL, NULL,
-									NULL);
+	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
 }
 
 static void read_cb(uint8_t opcode, const void *pdu,
@@ -910,11 +856,8 @@ static void read_cb(uint8_t opcode, const void *pdu,
 	uint16_t handle;
 
 	if (length != 2) {
-		uint8_t pdu[4];
-
-		encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU, pdu);
-		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
-								NULL, NULL);
+		bt_att_send_error_rsp(server->att, opcode, 0,
+						BT_ATT_ERROR_INVALID_PDU);
 		return;
 	}
 
@@ -930,11 +873,8 @@ static void read_blob_cb(uint8_t opcode, const void *pdu,
 	uint16_t handle, offset;
 
 	if (length != 4) {
-		uint8_t pdu[4];
-
-		encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU, pdu);
-		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
-								NULL, NULL);
+		bt_att_send_error_rsp(server->att, opcode, 0,
+						BT_ATT_ERROR_INVALID_PDU);
 		return;
 	}
 
@@ -952,9 +892,6 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	uint16_t handle = 0;
 	uint16_t offset;
 	struct gatt_db_attribute *attr;
-	uint8_t rsp_opcode;
-	uint8_t rsp_pdu[MAX(4, length)];
-	uint16_t rsp_len;
 	uint8_t ecode;
 	uint32_t perm;
 
@@ -1019,60 +956,50 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 
 	queue_push_tail(server->prep_queue, prep_data);
 
-	/* Create the response */
-	rsp_len = length;
-	rsp_opcode = BT_ATT_OP_PREP_WRITE_RSP;
-	memcpy(rsp_pdu, pdu, rsp_len);
-
-	goto done;
+	bt_att_send(server->att, BT_ATT_OP_PREP_WRITE_RSP, pdu, length, NULL,
+								NULL, NULL);
+	return;
 
 error:
 	if (prep_data)
 		prep_write_data_destroy(prep_data);
 
-	rsp_opcode = BT_ATT_OP_ERROR_RSP;
-	rsp_len = 4;
-	encode_error_rsp(opcode, handle, ecode, rsp_pdu);
+	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
 
-done:
-	bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len, NULL, NULL,
-									NULL);
 }
 
 static void exec_next_prep_write(struct bt_gatt_server *server,
-					uint16_t ehandle, uint8_t att_ecode);
+						uint16_t ehandle, int err);
 
 static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
 								void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t handle = gatt_db_attribute_get_handle(attr);
-	uint16_t att_ecode = att_ecode_from_error(err);
 
-	exec_next_prep_write(server, handle, att_ecode);
+	exec_next_prep_write(server, handle, err);
 }
 
 static void exec_next_prep_write(struct bt_gatt_server *server,
-					uint16_t ehandle, uint8_t att_ecode)
+						uint16_t ehandle, int err)
 {
 	struct prep_write_data *next = NULL;
-	uint8_t rsp_opcode = BT_ATT_OP_EXEC_WRITE_RSP;
-	uint8_t error_pdu[4];
-	uint8_t *rsp_pdu = NULL;
-	uint16_t rsp_len = 0;
 	struct gatt_db_attribute *attr;
 	bool status;
 
-	if (att_ecode)
+	if (err)
 		goto error;
 
 	next = queue_pop_head(server->prep_queue);
-	if (!next)
-		goto done;
+	if (!next) {
+		bt_att_send(server->att, BT_ATT_OP_EXEC_WRITE_RSP, NULL, 0,
+							NULL, NULL, NULL);
+		return;
+	}
 
 	attr = gatt_db_get_attribute(server->db, next->handle);
 	if (!attr) {
-		att_ecode = BT_ATT_ERROR_UNLIKELY;
+		err = BT_ATT_ERROR_UNLIKELY;
 		goto error;
 	}
 
@@ -1086,17 +1013,11 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 	if (status)
 		return;
 
-	att_ecode = BT_ATT_ERROR_UNLIKELY;
+	err = BT_ATT_ERROR_UNLIKELY;
 
 error:
-	rsp_opcode = BT_ATT_OP_ERROR_RSP;
-	rsp_len = 4;
-	rsp_pdu = error_pdu;
-	encode_error_rsp(BT_ATT_OP_EXEC_WRITE_REQ, ehandle, att_ecode, rsp_pdu);
-
-done:
-	bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len, NULL, NULL,
-									NULL);
+	bt_att_send_error_rsp(server->att, BT_ATT_OP_EXEC_WRITE_REQ,
+								ehandle, err);
 }
 
 static void exec_write_cb(uint8_t opcode, const void *pdu,
@@ -1105,10 +1026,6 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
 	struct bt_gatt_server *server = user_data;
 	uint8_t flags;
 	uint8_t ecode;
-	uint8_t rsp_opcode;
-	uint8_t error_pdu[4];
-	uint8_t *rsp_pdu = NULL;
-	uint16_t rsp_len = 0;
 	bool write;
 
 	if (length != 1) {
@@ -1133,8 +1050,9 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
 	if (!write) {
 		queue_remove_all(server->prep_queue, NULL, NULL,
 						prep_write_data_destroy);
-		rsp_opcode = BT_ATT_OP_EXEC_WRITE_RSP;
-		goto done;
+		bt_att_send(server->att, BT_ATT_OP_EXEC_WRITE_RSP, NULL, 0,
+							NULL, NULL, NULL);
+		return;
 	}
 
 	exec_next_prep_write(server, 0, 0);
@@ -1142,14 +1060,7 @@ static void exec_write_cb(uint8_t opcode, const void *pdu,
 	return;
 
 error:
-	rsp_opcode = BT_ATT_OP_ERROR_RSP;
-	rsp_len = 4;
-	rsp_pdu = error_pdu;
-	encode_error_rsp(opcode, 0, ecode, rsp_pdu);
-
-done:
-	bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len, NULL, NULL,
-									NULL);
+	bt_att_send_error_rsp(server->att, opcode, 0, ecode);
 }
 
 static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
@@ -1158,12 +1069,11 @@ static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 	struct bt_gatt_server *server = user_data;
 	uint16_t client_rx_mtu;
 	uint16_t final_mtu;
-	uint8_t rsp_pdu[4];
+	uint8_t rsp_pdu[2];
 
 	if (length != 2) {
-		encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU, rsp_pdu);
-		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu,
-					sizeof(rsp_pdu), NULL, NULL, NULL);
+		bt_att_send_error_rsp(server->att, opcode, 0,
+						BT_ATT_ERROR_INVALID_PDU);
 		return;
 	}
 
-- 
2.1.0.rc2.206.gedb03e5

