Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/3] shared/gatt: Make discovery operations cancelable
Date: Fri, 27 Feb 2015 16:18:05 -0800
Message-Id: <1425082687-20832-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes discovery operations cancelable by exposing the
internal discovery op structure as bt_gatt_async_req. This structure
keeps track of the ATT request ids of discovery procedures that occur
over multiple ATT protocol requests.

Users can cancel an ongoing request by calling bt_gatt_async_req_cancel.
Each discovery helper function returns a pointer to the structure with
one addition reference count assigned to the caller, so the caller is
responsible for cleaning up the memory by calling
bt_gatt_async_req_unref.
---
 src/shared/gatt-helpers.c | 238 ++++++++++++++++++++++++++--------------------
 src/shared/gatt-helpers.h |  23 +++--
 2 files changed, 152 insertions(+), 109 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 2d07a83..e800fce 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -209,7 +209,7 @@ static bool convert_uuid_le(const uint8_t *src, size_t len, uint8_t dst[16])
 	return true;
 }
 
-struct discovery_op {
+struct bt_gatt_async_req {
 	struct bt_att *att;
 	unsigned int id;
 	uint16_t end_handle;
@@ -226,7 +226,7 @@ struct discovery_op {
 static struct bt_gatt_result *result_append(uint8_t opcode, const void *pdu,
 						uint16_t pdu_len,
 						uint16_t data_len,
-						struct discovery_op *op)
+						struct bt_gatt_async_req *op)
 {
 	struct bt_gatt_result *result;
 
@@ -249,7 +249,7 @@ bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
 				uint16_t *end_handle, uint8_t uuid[16])
 {
 	struct bt_gatt_result *read_result;
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 	const void *pdu_ptr;
 	int i = 0;
 
@@ -328,7 +328,7 @@ bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
 				uint16_t *start_handle, uint16_t *end_handle,
 				uint8_t uuid[16])
 {
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 	const void *pdu_ptr;
 	bt_uuid_t tmp;
 
@@ -370,7 +370,7 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 				uint16_t *value_handle, uint8_t *properties,
 				uint8_t uuid[16])
 {
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 	const void *pdu_ptr;
 
 	if (!iter || !iter->result || !start_handle || !end_handle ||
@@ -446,7 +446,7 @@ bool bt_gatt_iter_next_read_by_type(struct bt_gatt_iter *iter,
 				uint16_t *handle, uint16_t *length,
 				const uint8_t **value)
 {
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 	const void *pdu_ptr;
 
 	if (!iter || !iter->result || !handle || !length || !value)
@@ -535,13 +535,14 @@ done:
 		op->callback(success, att_ecode, op->user_data);
 }
 
-bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
+unsigned int bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 					bt_gatt_result_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
 	struct mtu_op *op;
 	uint8_t pdu[2];
+	unsigned int id;
 
 	if (!att || !client_rx_mtu)
 		return false;
@@ -558,14 +559,12 @@ bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 
 	put_le16(client_rx_mtu, pdu);
 
-	if (!bt_att_send(att, BT_ATT_OP_MTU_REQ, pdu, sizeof(pdu),
-							mtu_cb, op,
-							destroy_mtu_op)) {
+	id = bt_att_send(att, BT_ATT_OP_MTU_REQ, pdu, sizeof(pdu), mtu_cb, op,
+								destroy_mtu_op);
+	if (!id)
 		free(op);
-		return false;
-	}
 
-	return true;
+	return id;
 }
 
 static inline int get_uuid_len(const bt_uuid_t *uuid)
@@ -576,29 +575,54 @@ static inline int get_uuid_len(const bt_uuid_t *uuid)
 	return (uuid->type == BT_UUID16) ? 2 : 16;
 }
 
-static struct discovery_op* discovery_op_ref(struct discovery_op *op)
+struct bt_gatt_async_req* bt_gatt_async_req_ref(struct bt_gatt_async_req *req)
 {
-	__sync_fetch_and_add(&op->ref_count, 1);
+	if (!req)
+		return NULL;
+
+	__sync_fetch_and_add(&req->ref_count, 1);
 
-	return op;
+	return req;
 }
 
-static void discovery_op_unref(void *data)
+void bt_gatt_async_req_unref(struct bt_gatt_async_req *req)
 {
-	struct discovery_op *op = data;
+	if (!req)
+		return;
 
-	if (__sync_sub_and_fetch(&op->ref_count, 1))
+	if (__sync_sub_and_fetch(&req->ref_count, 1))
 		return;
 
-	if (op->destroy)
-		op->destroy(op->user_data);
+	bt_gatt_async_req_cancel(req);
 
-	result_destroy(op->result_head);
+	if (req->destroy)
+		req->destroy(req->user_data);
 
-	free(op);
+	result_destroy(req->result_head);
+
+	free(req);
+}
+
+void bt_gatt_async_req_cancel(struct bt_gatt_async_req *req)
+{
+	if (!req)
+		return;
+
+	if (!req->id)
+		return;
+
+	bt_att_cancel(req->att, req->id);
+	req->id = 0;
+}
+
+static void async_req_unref(void *data)
+{
+	struct bt_gatt_async_req *req = data;
+
+	bt_gatt_async_req_unref(req);
 }
 
-static void discovery_op_complete(struct discovery_op *op, bool success,
+static void discovery_op_complete(struct bt_gatt_async_req *op, bool success,
 								uint8_t ecode)
 {
 	if (op->callback)
@@ -606,13 +630,16 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
 								op->user_data);
 
 	if (!op->id)
-		discovery_op_unref(op);
+		async_req_unref(op);
+	else
+		op->id = 0;
+
 }
 
 static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_async_req *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	struct bt_gatt_result *cur_result;
@@ -673,8 +700,8 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
 							pdu, sizeof(pdu),
 							read_by_grp_type_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+							bt_gatt_async_req_ref(op),
+							async_req_unref);
 		if (op->id)
 			return;
 
@@ -701,7 +728,7 @@ done:
 static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_async_req *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	uint16_t last_end;
@@ -749,8 +776,8 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
 							pdu, sizeof(pdu),
 							find_by_type_val_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+							bt_gatt_async_req_ref(op),
+							async_req_unref);
 		if (op->id)
 			return;
 
@@ -765,21 +792,22 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
-static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
+static struct bt_gatt_async_req *discover_services(struct bt_att *att,
+					bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy,
 					bool primary)
 {
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 
 	if (!att)
-		return false;
+		return NULL;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_async_req, 1);
 	if (!op)
-		return false;
+		return NULL;
 
 	op->att = att;
 	op->end_handle = end;
@@ -798,16 +826,16 @@ static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
 		put_le16(op->service_type, pdu + 4);
 
 		op->id = bt_att_send(att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
-							pdu, sizeof(pdu),
-							read_by_grp_type_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+						pdu, sizeof(pdu),
+						read_by_grp_type_cb,
+						bt_gatt_async_req_ref(op),
+						async_req_unref);
 	} else {
 		uint8_t pdu[6 + get_uuid_len(uuid)];
 
 		if (uuid->type == BT_UUID_UNSPEC) {
 			free(op);
-			return false;
+			return NULL;
 		}
 
 		/* Discover by UUID */
@@ -819,21 +847,22 @@ static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
 		bt_uuid_to_le(&op->uuid, pdu + 6);
 
 		op->id = bt_att_send(att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
-							pdu, sizeof(pdu),
-							find_by_type_val_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+						pdu, sizeof(pdu),
+						find_by_type_val_cb,
+						bt_gatt_async_req_ref(op),
+						async_req_unref);
 	}
 
 	if (!op->id) {
 		free(op);
-		return false;
+		return NULL;
 	}
 
-	return true;
+	return bt_gatt_async_req_ref(op);
 }
 
-bool bt_gatt_discover_all_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_async_req *bt_gatt_discover_all_primary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
@@ -843,7 +872,8 @@ bool bt_gatt_discover_all_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 							destroy);
 }
 
-bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_async_req *bt_gatt_discover_primary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
@@ -853,7 +883,8 @@ bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 								destroy, true);
 }
 
-bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_async_req *bt_gatt_discover_secondary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
@@ -864,7 +895,7 @@ bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
 }
 
 struct read_incl_data {
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 	struct bt_gatt_result *result;
 	int pos;
 	int ref_count;
@@ -878,7 +909,7 @@ static struct read_incl_data *new_read_included(struct bt_gatt_result *res)
 	if (!data)
 		return NULL;
 
-	data->op = discovery_op_ref(res->op);
+	data->op = bt_gatt_async_req_ref(res->op);
 	data->result = res;
 
 	return data;
@@ -898,7 +929,7 @@ static void read_included_unref(void *data)
 	if (__sync_sub_and_fetch(&read_data->ref_count, 1))
 		return;
 
-	discovery_op_unref(read_data->op);
+	async_req_unref(read_data->op);
 
 	free(read_data);
 }
@@ -910,7 +941,7 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
 	struct read_incl_data *data = user_data;
-	struct discovery_op *op = data->op;
+	struct bt_gatt_async_req *op = data->op;
 	uint8_t att_ecode = 0;
 	uint8_t read_pdu[2];
 	bool success;
@@ -958,8 +989,8 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
 						pdu, sizeof(pdu),
 						discover_included_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
+						bt_gatt_async_req_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -985,7 +1016,7 @@ done:
 
 static void read_included(struct read_incl_data *data)
 {
-	struct discovery_op *op = data->op;
+	struct bt_gatt_async_req *op = data->op;
 	uint8_t pdu[2];
 
 	memcpy(pdu, data->result->pdu + 2, sizeof(uint16_t));
@@ -1007,7 +1038,7 @@ static void read_included(struct read_incl_data *data)
 static void discover_included_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_async_req *op = user_data;
 	struct bt_gatt_result *cur_result;
 	uint8_t att_ecode = 0;
 	uint16_t last_handle;
@@ -1076,10 +1107,10 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 		put_le16(GATT_INCLUDE_UUID, pdu + 4);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
-							pdu, sizeof(pdu),
-							discover_included_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+						pdu, sizeof(pdu),
+						discover_included_cb,
+						bt_gatt_async_req_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -1094,19 +1125,19 @@ failed:
 	discovery_op_complete(op, success, att_ecode);
 }
 
-bool bt_gatt_discover_included_services(struct bt_att *att,
+struct bt_gatt_async_req *bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 	uint8_t pdu[6];
 
 	if (!att)
 		return false;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_async_req, 1);
 	if (!op)
 		return false;
 
@@ -1121,19 +1152,20 @@ bool bt_gatt_discover_included_services(struct bt_att *att,
 	put_le16(GATT_INCLUDE_UUID, pdu + 4);
 
 	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
-				discover_included_cb, discovery_op_ref(op),
-				discovery_op_unref);
-	if (op->id)
-		return true;
+				discover_included_cb, bt_gatt_async_req_ref(op),
+				async_req_unref);
+	if (!op->id) {
+		free(op);
+		return NULL;
+	}
 
-	free(op);
-	return false;
+	return bt_gatt_async_req_ref(op);
 }
 
 static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_async_req *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	size_t data_length;
@@ -1187,8 +1219,8 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
 						pdu, sizeof(pdu),
 						discover_chrcs_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
+						bt_gatt_async_req_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -1203,19 +1235,19 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
-bool bt_gatt_discover_characteristics(struct bt_att *att,
+struct bt_gatt_async_req *bt_gatt_discover_characteristics(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 	uint8_t pdu[6];
 
 	if (!att)
 		return false;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_async_req, 1);
 	if (!op)
 		return false;
 
@@ -1230,19 +1262,20 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
 	put_le16(GATT_CHARAC_UUID, pdu + 4);
 
 	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
-				discover_chrcs_cb, discovery_op_ref(op),
-				discovery_op_unref);
-	if (op->id)
-		return true;
+				discover_chrcs_cb, bt_gatt_async_req_ref(op),
+				async_req_unref);
+	if (!op->id) {
+		free(op);
+		return NULL;
+	}
 
-	free(op);
-	return false;
+	return bt_gatt_async_req_ref(op);
 }
 
 static void read_by_type_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_async_req *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	size_t data_length;
@@ -1290,8 +1323,8 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
 						pdu, sizeof(pdu),
 						read_by_type_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
+						bt_gatt_async_req_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -1311,13 +1344,13 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 	uint8_t pdu[4 + get_uuid_len(uuid)];
 
 	if (!att || !uuid || uuid->type == BT_UUID_UNSPEC)
 		return false;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_async_req, 1);
 	if (!op)
 		return false;
 
@@ -1333,8 +1366,8 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 	bt_uuid_to_le(uuid, pdu + 4);
 
 	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
-					read_by_type_cb, discovery_op_ref(op),
-					discovery_op_unref);
+					read_by_type_cb, bt_gatt_async_req_ref(op),
+					async_req_unref);
 	if (op->id)
 		return true;
 
@@ -1345,7 +1378,7 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 static void discover_descs_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_async_req *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	uint8_t format;
@@ -1405,8 +1438,8 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_FIND_INFO_REQ,
 						pdu, sizeof(pdu),
 						discover_descs_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
+						bt_gatt_async_req_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -1421,19 +1454,19 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
-bool bt_gatt_discover_descriptors(struct bt_att *att,
+struct bt_gatt_async_req *bt_gatt_discover_descriptors(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discovery_op *op;
+	struct bt_gatt_async_req *op;
 	uint8_t pdu[4];
 
 	if (!att)
 		return false;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_async_req, 1);
 	if (!op)
 		return false;
 
@@ -1448,11 +1481,12 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 
 	op->id = bt_att_send(att, BT_ATT_OP_FIND_INFO_REQ, pdu, sizeof(pdu),
 						discover_descs_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
-	if (op->id)
-		return true;
+						bt_gatt_async_req_ref(op),
+						async_req_unref);
+	if (!op->id) {
+		free(op);
+		return NULL;
+	}
 
-	free(op);
-	return false;
+	return bt_gatt_async_req_ref(op);
 }
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 0217e82..034941e 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -65,36 +65,45 @@ typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
 
-bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
+struct bt_gatt_async_req;
+
+struct bt_gatt_async_req *bt_gatt_async_req_ref(struct bt_gatt_async_req *req);
+void bt_gatt_async_req_unref(struct bt_gatt_async_req *req);
+void bt_gatt_async_req_cancel(struct bt_gatt_async_req *req);
+
+unsigned int bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 					bt_gatt_result_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
 
-bool bt_gatt_discover_all_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_async_req *bt_gatt_discover_all_primary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_async_req *bt_gatt_discover_primary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_async_req *bt_gatt_discover_secondary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_included_services(struct bt_att *att,
+struct bt_gatt_async_req *bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_characteristics(struct bt_att *att,
+struct bt_gatt_async_req *bt_gatt_discover_characteristics(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_descriptors(struct bt_att *att,
+struct bt_gatt_async_req *bt_gatt_discover_descriptors(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
-- 
2.2.0.rc0.207.ga3a616c

