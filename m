Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Arman Uguray <armansito@chromium.org>
Subject: [PATCH 1/2] shared/att: Remove parameters structures.
Date: Mon,  7 Jul 2014 22:05:00 -0700
Message-Id: <1404795901-29367-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1404795901-29367-1-git-send-email-armansito@chromium.org>
References: <1404795901-29367-1-git-send-email-armansito@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the PDU encoding functionality from src/shared/att. This is
now left up to the upper layer and the responsibilities of bt_att are restricted
to handle the low-level transport and the sequential/non-sequential ATT protocol
logic.
---
 src/shared/att-types.h | 153 +----------------------------------
 src/shared/att.c       | 210 ++++++++++++++++++++-----------------------------
 src/shared/att.h       |  19 ++---
 3 files changed, 98 insertions(+), 284 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 636a5e3..1637f6f 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -23,183 +23,34 @@
 
 #include <stdint.h>
 
-/* Error response */
+/* ATT protocol opcodes */
 #define BT_ATT_OP_ERROR_RSP	      		0x01
-struct bt_att_error_rsp_param {
-	uint8_t request_opcode;
-	uint16_t handle;
-	uint8_t	error_code;
-};
-
-/* Exchange MTU */
 #define BT_ATT_OP_MTU_REQ			0x02
-struct bt_att_mtu_req_param {
-	uint16_t client_rx_mtu;
-};
-
 #define BT_ATT_OP_MTU_RSP			0x03
-struct bt_att_mtu_rsp_param {
-	uint16_t server_rx_mtu;
-};
-
-/* Find Information */
 #define BT_ATT_OP_FIND_INFO_REQ			0x04
-struct bt_att_find_info_req_param {
-	uint16_t start_handle;
-	uint16_t end_handle;
-};
-
 #define BT_ATT_OP_FIND_INFO_RSP			0x05
-struct bt_att_find_info_rsp_param {
-	uint8_t format;
-	const uint8_t *info_data;
-	uint16_t length;
-};
-
-/* Find By Type Value */
 #define BT_ATT_OP_FIND_BY_TYPE_VAL_REQ		0x06
-struct bt_att_find_by_type_value_req_param {
-	uint16_t start_handle;
-	uint16_t end_handle;
-	uint16_t type;  /* 2 octet UUID */
-	const uint8_t *value;
-	uint16_t length;  /* MAX length: (ATT_MTU - 7) */
-};
-
 #define BT_ATT_OP_FIND_BY_TYPE_VAL_RSP		0x07
-struct bt_att_find_by_type_value_rsp_param {
-	const uint8_t *handles_info_list;
-	uint16_t length;
-};
-
-/* Read By Type */
 #define BT_ATT_OP_READ_BY_TYPE_REQ		0x08
-struct bt_att_read_by_type_req_param {
-	uint16_t start_handle;
-	uint16_t end_handle;
-	bt_uuid_t type;  /* 2 or 16 octet UUID */
-};
-
 #define BT_ATT_OP_READ_BY_TYPE_RSP		0x09
-struct bt_att_read_by_type_rsp_param {
-	uint8_t length;
-	const uint8_t *attr_data_list;
-	uint16_t list_length;  /* Length of "attr_data_list" */
-};
-
-/* Read */
 #define BT_ATT_OP_READ_REQ			0x0a
-struct bt_att_read_req_param {
-	uint16_t handle;
-};
-
 #define BT_ATT_OP_READ_RSP			0x0b
-struct bt_att_read_rsp_param {
-	const uint8_t *value;
-	uint16_t length;
-};
-
-/* Read Blob */
 #define BT_ATT_OP_READ_BLOB_REQ			0x0c
-struct bt_att_read_blob_req_param {
-	uint16_t handle;
-	uint16_t offset;
-};
-
 #define BT_ATT_OP_READ_BLOB_RSP			0x0d
-struct bt_att_read_blob_rsp_param {
-	const uint8_t *part_value;
-	uint16_t length;
-};
-
-/* Read Multiple */
 #define BT_ATT_OP_READ_MULT_REQ			0x0e
-struct bt_att_read_multiple_req_param {
-	const uint16_t *handles;
-	uint16_t num_handles;
-};
-
 #define BT_ATT_OP_READ_MULT_RSP			0x0f
-struct bt_att_read_multiple_rsp_param {
-	const uint8_t *values;
-	uint16_t length;
-};
-
-/* Read By Group Type */
 #define BT_ATT_OP_READ_BY_GRP_TYPE_REQ		0x10
-struct bt_att_read_by_group_type_req_param {
-	uint16_t start_handle;
-	uint16_t end_handle;
-	bt_uuid_t type;
-};
-
 #define BT_ATT_OP_READ_BY_GRP_TYPE_RSP		0x11
-struct bt_att_read_by_group_type_rsp_param {
-	uint8_t length;
-	const uint8_t *attr_data_list;
-	uint16_t list_length;  /* Length of "attr_data_list" */
-};
-
-/* Write Request */
 #define BT_ATT_OP_WRITE_REQ			0x12
-/*
- * bt_att_write_param is used for write request and signed and unsigned write
- * command.
- */
-struct bt_att_write_param {
-	uint16_t handle;
-	const uint8_t *value;
-	uint16_t length;
-};
-
-#define BT_ATT_OP_WRITE_RSP			0x13  /* No parameters */
-
-/* Write Command */
+#define BT_ATT_OP_WRITE_RSP			0x13
 #define BT_ATT_OP_WRITE_CMD			0x52
-
-/* Signed Write Command */
 #define BT_ATT_OP_SIGNED_WRITE_CMD		0xD2
-
-/* Prepare Write */
 #define BT_ATT_OP_PREP_WRITE_REQ		0x16
-struct bt_att_prepare_write_req_param {
-	uint16_t handle;
-	uint16_t offset;
-	const uint8_t *part_value;
-	uint16_t length;
-};
-
 #define BT_ATT_OP_PREP_WRITE_RSP		0x17
-struct bt_att_prepare_write_rsp_param {
-	uint16_t handle;
-	uint16_t offset;
-	const uint8_t *part_value;
-	uint16_t length;
-};
-
-/* Execute Write */
 #define BT_ATT_OP_EXEC_WRITE_REQ		0x18
-typedef enum {
-	BT_ATT_EXEC_WRITE_FLAG_CANCEL	= 0x00,
-	BT_ATT_EXEC_WRITE_FLAG_WRITE	= 0x01,
-} bt_att_exec_write_flag_t;
-
-struct bt_att_exec_write_req_param {
-	bt_att_exec_write_flag_t flags;
-};
-
 #define BT_ATT_OP_EXEC_WRITE_RSP		0x19
-
-/* Handle Value Notification/Indication */
 #define BT_ATT_OP_HANDLE_VAL_NOT		0x1B
 #define BT_ATT_OP_HANDLE_VAL_IND		0x1D
-struct bt_att_notify_param {
-	uint16_t handle;
-	const uint8_t *value;
-	uint16_t length;
-};
-
-/* Handle Value Confirmation */
 #define BT_ATT_OP_HANDLE_VAL_CONF		0x1E
 
 /* Error codes for Error response PDU */
diff --git a/src/shared/att.c b/src/shared/att.c
index 57f887e..e5e38ac 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -130,6 +130,36 @@ static enum att_op_type get_op_type(uint8_t opcode)
 	return ATT_OP_TYPE_UNKNOWN;
 }
 
+static const struct {
+	uint8_t req_opcode;
+	uint8_t rsp_opcode;
+} att_req_rsp_mapping_table[] = {
+	{ BT_ATT_OP_MTU_REQ,			BT_ATT_OP_MTU_RSP },
+	{ BT_ATT_OP_FIND_INFO_REQ,		BT_ATT_OP_FIND_INFO_RSP},
+	{ BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,	BT_ATT_OP_FIND_BY_TYPE_VAL_RSP },
+	{ BT_ATT_OP_READ_BY_TYPE_REQ,		BT_ATT_OP_READ_BY_TYPE_RSP },
+	{ BT_ATT_OP_READ_REQ,			BT_ATT_OP_READ_RSP },
+	{ BT_ATT_OP_READ_BLOB_REQ,		BT_ATT_OP_READ_BLOB_RSP },
+	{ BT_ATT_OP_READ_MULT_REQ,		BT_ATT_OP_READ_MULT_RSP },
+	{ BT_ATT_OP_READ_BY_GRP_TYPE_REQ,	BT_ATT_OP_READ_BY_GRP_TYPE_RSP },
+	{ BT_ATT_OP_WRITE_REQ,			BT_ATT_OP_WRITE_RSP },
+	{ BT_ATT_OP_PREP_WRITE_REQ,		BT_ATT_OP_PREP_WRITE_RSP },
+	{ BT_ATT_OP_EXEC_WRITE_REQ,		BT_ATT_OP_EXEC_WRITE_RSP },
+	{ }
+};
+
+static uint8_t get_req_opcode(uint8_t rsp_opcode)
+{
+	int i;
+
+	for (i = 0; att_req_rsp_mapping_table[i].rsp_opcode; i++) {
+		if (att_req_rsp_mapping_table[i].rsp_opcode == rsp_opcode)
+			return att_req_rsp_mapping_table[i].req_opcode;
+	}
+
+	return 0;
+}
+
 struct att_send_op {
 	unsigned int id;
 	unsigned int timeout_id;
@@ -137,77 +167,44 @@ struct att_send_op {
 	uint16_t opcode;
 	void *pdu;
 	uint16_t len;
-	bt_att_request_func_t callback;
+	bt_att_response_func_t callback;
 	bt_att_destroy_func_t destroy;
 	void *user_data;
 };
 
-static bool encode_mtu_req(struct att_send_op *op, const void *param,
+static bool encode_pdu(struct att_send_op *op, const void *pdu,
 						uint16_t length, uint16_t mtu)
 {
-	const struct bt_att_mtu_req_param *p = param;
-	const uint16_t len = 3;
+	uint16_t pdu_len = 1;
 
-	if (length != sizeof(*p))
-		return false;
+	if (length && pdu)
+		pdu_len += length;
 
-	if (len > mtu)
+	if (pdu_len > mtu)
 		return false;
 
-	op->pdu = malloc(len);
+	op->len = pdu_len;
+	op->pdu = malloc(op->len);
 	if (!op->pdu)
 		return false;
 
 	((uint8_t *) op->pdu)[0] = op->opcode;
-	put_le16(p->client_rx_mtu, ((uint8_t *) op->pdu) + 1);
-	op->len = len;
+	if (pdu_len > 1)
+		memcpy(op->pdu + 1, pdu, length);
 
 	return true;
 }
 
-static bool encode_pdu(struct att_send_op *op, const void *param,
-						uint16_t length, uint16_t mtu)
-{
-	/* If no parameters are given, simply set the PDU to consist of the
-	 * opcode (e.g. BT_ATT_OP_WRITE_RSP),
-	 */
-	if (!length || !param) {
-		op->len = 1;
-		op->pdu = malloc(1);
-		if (!op->pdu)
-			return false;
-
-		((uint8_t *) op->pdu)[0] = op->opcode;
-		return true;
-	}
-
-	/* TODO: If the opcode has the "signed" bit set, make sure that the
-	 * resulting PDU contains the authentication signature. Return an error,
-	 * if the provided parameters structure is such that it leaves no room
-	 * for an authentication signature in the PDU, or if no signing data
-	 * has been set to generate the authentication signature.
-	 */
-
-	switch (op->opcode) {
-	case BT_ATT_OP_MTU_REQ:
-		return encode_mtu_req(op, param, length, mtu);
-	default:
-		break;
-	}
-
-	return false;
-}
-
-static struct att_send_op *create_att_send_op(uint8_t opcode, const void *param,
+static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
 						uint16_t length, uint16_t mtu,
-						bt_att_request_func_t callback,
+						bt_att_response_func_t callback,
 						void *user_data,
 						bt_att_destroy_func_t destroy)
 {
 	struct att_send_op *op;
 	enum att_op_type op_type;
 
-	if (!length && !param)
+	if (length && !pdu)
 		return NULL;
 
 	op_type = get_op_type(opcode);
@@ -237,7 +234,7 @@ static struct att_send_op *create_att_send_op(uint8_t opcode, const void *param,
 	op->destroy = destroy;
 	op->user_data = user_data;
 
-	if (!encode_pdu(op, param, length, mtu)) {
+	if (!encode_pdu(op, pdu, length, mtu)) {
 		free(op);
 		return NULL;
 	}
@@ -411,94 +408,58 @@ static void wakeup_writer(struct bt_att *att)
 	att->writer_active = true;
 }
 
-static bool request_complete(struct bt_att *att, uint8_t req_opcode,
-					uint8_t rsp_opcode, const void *param,
-					uint16_t len)
+static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
+								ssize_t pdu_len)
 {
 	struct att_send_op *op = att->pending_req;
+	uint8_t req_opcode;
+	uint8_t rsp_opcode;
+	uint8_t *rsp_pdu = NULL;
+	uint16_t rsp_pdu_len = 0;
 
+	/* If no request is pending, then the response is unexpected. */
 	if (!op) {
-		/* There is no pending request so the response is unexpected. */
 		wakeup_writer(att);
-		return false;
-	}
-
-	if (op->opcode != req_opcode) {
-		/* The request opcode corresponding to the received response
-		 * opcode does not match the currently pending request.
-		 */
-		return false;
+		return;
 	}
 
-	if (op->callback)
-		op->callback(rsp_opcode, param, len, op->user_data);
-
-	destroy_att_send_op(op);
-	att->pending_req = NULL;
-
-	wakeup_writer(att);
-	return true;
-}
-
-static bool handle_error_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
-								ssize_t pdu_len)
-{
-	struct bt_att_error_rsp_param param;
-
-	if (pdu_len != 5)
-		return false;
-
-	memset(&param, 0, sizeof(param));
-	param.request_opcode = pdu[1];
-	param.handle = get_le16(pdu + 2);
-	param.error_code = pdu[4];
+	/* If the received response doesn't match the pending request, or if
+	 * the request is malformed, end the current request with failure.
+	 */
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		if (pdu_len != 4)
+			goto fail;
 
-	return request_complete(att, pdu[1], opcode, &param, sizeof(param));
-}
+		req_opcode = pdu[0];
+	} else if (!(req_opcode = get_req_opcode(opcode)))
+		goto fail;
 
-static bool handle_mtu_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
-								ssize_t pdu_len)
-{
-	struct bt_att_mtu_rsp_param param;
+	if (req_opcode != op->opcode)
+		goto fail;
 
-	if (pdu_len != 3)
-		return false;
+	rsp_opcode = opcode;
 
-	memset(&param, 0, sizeof(param));
-	param.server_rx_mtu = get_le16(pdu + 1);
+	if (pdu_len > 0) {
+		rsp_pdu = pdu;
+		rsp_pdu_len = pdu_len;
+	}
 
-	return request_complete(att, BT_ATT_OP_MTU_REQ, opcode,
-							&param, sizeof(param));
-}
+	goto done;
 
-static void handle_rsp(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
-								ssize_t pdu_len)
-{
-	bool success;
+fail:
+	util_debug(att->debug_callback, att->debug_data,
+			"Failed to handle response PDU; opcode: 0x%02x", opcode);
 
-	switch (opcode) {
-	case BT_ATT_OP_ERROR_RSP:
-		success = handle_error_rsp(att, opcode, pdu, pdu_len);
-		break;
-	case BT_ATT_OP_MTU_RSP:
-		success = handle_mtu_rsp(att, opcode, pdu, pdu_len);
-		break;
-	default:
-		success = false;
-		util_debug(att->debug_callback, att->debug_data,
-				"Unknown response opcode: 0x%02x", opcode);
-		break;
-	}
+	rsp_opcode = BT_ATT_OP_ERROR_RSP;
 
-	if (success)
-		return;
+done:
+	if (op->callback)
+		op->callback(rsp_opcode, rsp_pdu, rsp_pdu_len, op->user_data);
 
-	util_debug(att->debug_callback, att->debug_data,
-			"Failed to handle respone PDU; opcode: 0x%02x", opcode);
+	destroy_att_send_op(op);
+	att->pending_req = NULL;
 
-	if (att->pending_req)
-		request_complete(att, att->pending_req->opcode,
-						BT_ATT_OP_ERROR_RSP, NULL, 0);
+	wakeup_writer(att);
 }
 
 static bool can_read_data(struct io *io, void *user_data)
@@ -524,7 +485,7 @@ static bool can_read_data(struct io *io, void *user_data)
 	/* Act on the received PDU based on the opcode type */
 	switch (get_op_type(opcode)) {
 	case ATT_OP_TYPE_RSP:
-		handle_rsp(att, opcode, pdu, bytes_read);
+		handle_rsp(att, opcode, pdu + 1, bytes_read - 1);
 		break;
 	default:
 		util_debug(att->debug_callback, att->debug_data,
@@ -707,8 +668,8 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
 }
 
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
-				const void *param, uint16_t length,
-				bt_att_request_func_t callback, void *user_data,
+				const void *pdu, uint16_t length,
+				bt_att_response_func_t callback, void *user_data,
 				bt_att_destroy_func_t destroy)
 {
 	struct att_send_op *op;
@@ -720,7 +681,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	if (att->invalid)
 		return 0;
 
-	op = create_att_send_op(opcode, param, length, att->mtu, callback,
+	op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
 							user_data, destroy);
 	if (!op)
 		return 0;
@@ -821,8 +782,9 @@ bool bt_att_cancel_all(struct bt_att *att)
 }
 
 unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
-				bt_att_request_func_t callback,
-				void *user_data, bt_att_destroy_func_t destroy)
+						bt_att_notify_func_t callback,
+						void *user_data,
+						bt_att_destroy_func_t destroy)
 {
 	/* TODO */
 	return 0;
diff --git a/src/shared/att.h b/src/shared/att.h
index 65c2152..9fcd780 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -35,13 +35,12 @@ void bt_att_unref(struct bt_att *att);
 
 bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
 
-typedef void (*bt_att_request_func_t)(uint8_t opcode, const void *param,
+typedef void (*bt_att_response_func_t)(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data);
+typedef void (*bt_att_notify_func_t)(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data);
 typedef void (*bt_att_destroy_func_t)(void *user_data);
 typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
-typedef void (*bt_att_notify_func_t)(uint8_t opcode,
-					const struct bt_att_notify_param *param,
-					void *user_data);
 typedef void (*bt_att_timeout_func_t)(unsigned int id, uint8_t opcode,
 							void *user_data);
 
@@ -56,14 +55,16 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
 						bt_att_destroy_func_t destroy);
 
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
-				const void *param, uint16_t length,
-				bt_att_request_func_t callback, void *user_data,
-				bt_att_destroy_func_t destroy);
+					const void *pdu, uint16_t length,
+					bt_att_response_func_t callback,
+					void *user_data,
+					bt_att_destroy_func_t destroy);
 bool bt_att_cancel(struct bt_att *att, unsigned int id);
 bool bt_att_cancel_all(struct bt_att *att);
 
 unsigned int bt_att_register(struct bt_att *att, uint8_t opcode,
-				bt_att_request_func_t callback,
-				void *user_data, bt_att_destroy_func_t destroy);
+						bt_att_notify_func_t callback,
+						void *user_data,
+						bt_att_destroy_func_t destroy);
 bool bt_att_unregister(struct bt_att *att, unsigned int id);
 bool bt_att_unregister_all(struct bt_att *att);
-- 
2.0.0.526.g5318336
