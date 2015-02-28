Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 1/3] shared/gatt: Make discovery operations cancelable
Date: Fri, 27 Feb 2015 20:11:33 -0800
Message-Id: <1425096695-22608-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1425096695-22608-1-git-send-email-armansito@chromium.org>
References: <1425096695-22608-1-git-send-email-armansito@chromium.org>
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
 src/shared/gatt-helpers.c | 252 ++++++++++++++++++++++++++--------------------
 src/shared/gatt-helpers.h |  37 ++++---
 2 files changed, 167 insertions(+), 122 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index bad20d9..2d6088e 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -209,7 +209,7 @@ static bool convert_uuid_le(const uint8_t *src, size_t len, uint8_t dst[16])
 	return true;
 }
 
-struct discovery_op {
+struct bt_gatt_request {
 	struct bt_att *att;
 	unsigned int id;
 	uint16_t end_handle;
@@ -218,7 +218,7 @@ struct discovery_op {
 	uint16_t service_type;
 	struct bt_gatt_result *result_head;
 	struct bt_gatt_result *result_tail;
-	bt_gatt_discovery_callback_t callback;
+	bt_gatt_request_callback_t callback;
 	void *user_data;
 	bt_gatt_destroy_func_t destroy;
 };
@@ -226,7 +226,7 @@ struct discovery_op {
 static struct bt_gatt_result *result_append(uint8_t opcode, const void *pdu,
 						uint16_t pdu_len,
 						uint16_t data_len,
-						struct discovery_op *op)
+						struct bt_gatt_request *op)
 {
 	struct bt_gatt_result *result;
 
@@ -249,7 +249,7 @@ bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
 				uint16_t *end_handle, uint8_t uuid[16])
 {
 	struct bt_gatt_result *read_result;
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 	const void *pdu_ptr;
 	int i = 0;
 
@@ -328,7 +328,7 @@ bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
 				uint16_t *start_handle, uint16_t *end_handle,
 				uint8_t uuid[16])
 {
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 	const void *pdu_ptr;
 	bt_uuid_t tmp;
 
@@ -370,7 +370,7 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 				uint16_t *value_handle, uint8_t *properties,
 				uint8_t uuid[16])
 {
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 	const void *pdu_ptr;
 
 	if (!iter || !iter->result || !start_handle || !end_handle ||
@@ -446,7 +446,7 @@ bool bt_gatt_iter_next_read_by_type(struct bt_gatt_iter *iter,
 				uint16_t *handle, uint16_t *length,
 				const uint8_t **value)
 {
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 	const void *pdu_ptr;
 
 	if (!iter || !iter->result || !handle || !length || !value)
@@ -575,29 +575,54 @@ static inline int get_uuid_len(const bt_uuid_t *uuid)
 	return (uuid->type == BT_UUID16) ? 2 : 16;
 }
 
-static struct discovery_op* discovery_op_ref(struct discovery_op *op)
+struct bt_gatt_request *bt_gatt_request_ref(struct bt_gatt_request *req)
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
+void bt_gatt_request_unref(struct bt_gatt_request *req)
 {
-	struct discovery_op *op = data;
+	if (!req)
+		return;
 
-	if (__sync_sub_and_fetch(&op->ref_count, 1))
+	if (__sync_sub_and_fetch(&req->ref_count, 1))
 		return;
 
-	if (op->destroy)
-		op->destroy(op->user_data);
+	bt_gatt_request_cancel(req);
 
-	result_destroy(op->result_head);
+	if (req->destroy)
+		req->destroy(req->user_data);
 
-	free(op);
+	result_destroy(req->result_head);
+
+	free(req);
 }
 
-static void discovery_op_complete(struct discovery_op *op, bool success,
+void bt_gatt_request_cancel(struct bt_gatt_request *req)
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
+	struct bt_gatt_request *req = data;
+
+	bt_gatt_request_unref(req);
+}
+
+static void discovery_op_complete(struct bt_gatt_request *op, bool success,
 								uint8_t ecode)
 {
 	if (op->callback)
@@ -605,13 +630,16 @@ static void discovery_op_complete(struct discovery_op *op, bool success,
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
+	struct bt_gatt_request *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	struct bt_gatt_result *cur_result;
@@ -670,10 +698,10 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 		put_le16(op->service_type, pdu + 4);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
-							pdu, sizeof(pdu),
-							read_by_grp_type_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+						pdu, sizeof(pdu),
+						read_by_grp_type_cb,
+						bt_gatt_request_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -700,7 +728,7 @@ done:
 static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_request *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	uint16_t last_end;
@@ -746,10 +774,10 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 		bt_uuid_to_le(&op->uuid, pdu + 6);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
-							pdu, sizeof(pdu),
-							find_by_type_val_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+						pdu, sizeof(pdu),
+						find_by_type_val_cb,
+						bt_gatt_request_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -764,21 +792,22 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
-static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
+static struct bt_gatt_request *discover_services(struct bt_att *att,
+					bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy,
 					bool primary)
 {
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 
 	if (!att)
-		return false;
+		return NULL;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_request, 1);
 	if (!op)
-		return false;
+		return NULL;
 
 	op->att = att;
 	op->end_handle = end;
@@ -797,16 +826,16 @@ static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
 		put_le16(op->service_type, pdu + 4);
 
 		op->id = bt_att_send(att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
-							pdu, sizeof(pdu),
-							read_by_grp_type_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+						pdu, sizeof(pdu),
+						read_by_grp_type_cb,
+						bt_gatt_request_ref(op),
+						async_req_unref);
 	} else {
 		uint8_t pdu[6 + get_uuid_len(uuid)];
 
 		if (uuid->type == BT_UUID_UNSPEC) {
 			free(op);
-			return false;
+			return NULL;
 		}
 
 		/* Discover by UUID */
@@ -818,22 +847,23 @@ static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
 		bt_uuid_to_le(&op->uuid, pdu + 6);
 
 		op->id = bt_att_send(att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
-							pdu, sizeof(pdu),
-							find_by_type_val_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+						pdu, sizeof(pdu),
+						find_by_type_val_cb,
+						bt_gatt_request_ref(op),
+						async_req_unref);
 	}
 
 	if (!op->id) {
 		free(op);
-		return false;
+		return NULL;
 	}
 
-	return true;
+	return bt_gatt_request_ref(op);
 }
 
-bool bt_gatt_discover_all_primary_services(struct bt_att *att, bt_uuid_t *uuid,
-					bt_gatt_discovery_callback_t callback,
+struct bt_gatt_request *bt_gatt_discover_all_primary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
@@ -842,9 +872,10 @@ bool bt_gatt_discover_all_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 							destroy);
 }
 
-bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_request *bt_gatt_discover_primary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
@@ -852,9 +883,10 @@ bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 								destroy, true);
 }
 
-bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_request *bt_gatt_discover_secondary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
@@ -863,7 +895,7 @@ bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
 }
 
 struct read_incl_data {
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 	struct bt_gatt_result *result;
 	int pos;
 	int ref_count;
@@ -877,7 +909,7 @@ static struct read_incl_data *new_read_included(struct bt_gatt_result *res)
 	if (!data)
 		return NULL;
 
-	data->op = discovery_op_ref(res->op);
+	data->op = bt_gatt_request_ref(res->op);
 	data->result = res;
 
 	return data;
@@ -897,7 +929,7 @@ static void read_included_unref(void *data)
 	if (__sync_sub_and_fetch(&read_data->ref_count, 1))
 		return;
 
-	discovery_op_unref(read_data->op);
+	async_req_unref(read_data->op);
 
 	free(read_data);
 }
@@ -909,7 +941,7 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
 	struct read_incl_data *data = user_data;
-	struct discovery_op *op = data->op;
+	struct bt_gatt_request *op = data->op;
 	uint8_t att_ecode = 0;
 	uint8_t read_pdu[2];
 	bool success;
@@ -957,8 +989,8 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
 						pdu, sizeof(pdu),
 						discover_included_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
+						bt_gatt_request_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -984,7 +1016,7 @@ done:
 
 static void read_included(struct read_incl_data *data)
 {
-	struct discovery_op *op = data->op;
+	struct bt_gatt_request *op = data->op;
 	uint8_t pdu[2];
 
 	memcpy(pdu, data->result->pdu + 2, sizeof(uint16_t));
@@ -1006,7 +1038,7 @@ static void read_included(struct read_incl_data *data)
 static void discover_included_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_request *op = user_data;
 	struct bt_gatt_result *cur_result;
 	uint8_t att_ecode = 0;
 	uint16_t last_handle;
@@ -1075,10 +1107,10 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 		put_le16(GATT_INCLUDE_UUID, pdu + 4);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
-							pdu, sizeof(pdu),
-							discover_included_cb,
-							discovery_op_ref(op),
-							discovery_op_unref);
+						pdu, sizeof(pdu),
+						discover_included_cb,
+						bt_gatt_request_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -1093,19 +1125,19 @@ failed:
 	discovery_op_complete(op, success, att_ecode);
 }
 
-bool bt_gatt_discover_included_services(struct bt_att *att,
+struct bt_gatt_request *bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 	uint8_t pdu[6];
 
 	if (!att)
 		return false;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_request, 1);
 	if (!op)
 		return false;
 
@@ -1120,19 +1152,20 @@ bool bt_gatt_discover_included_services(struct bt_att *att,
 	put_le16(GATT_INCLUDE_UUID, pdu + 4);
 
 	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
-				discover_included_cb, discovery_op_ref(op),
-				discovery_op_unref);
-	if (op->id)
-		return true;
+				discover_included_cb, bt_gatt_request_ref(op),
+				async_req_unref);
+	if (!op->id) {
+		free(op);
+		return NULL;
+	}
 
-	free(op);
-	return false;
+	return bt_gatt_request_ref(op);
 }
 
 static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_request *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	size_t data_length;
@@ -1186,8 +1219,8 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
 						pdu, sizeof(pdu),
 						discover_chrcs_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
+						bt_gatt_request_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -1202,19 +1235,19 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
-bool bt_gatt_discover_characteristics(struct bt_att *att,
+struct bt_gatt_request *bt_gatt_discover_characteristics(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 	uint8_t pdu[6];
 
 	if (!att)
 		return false;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_request, 1);
 	if (!op)
 		return false;
 
@@ -1229,19 +1262,20 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
 	put_le16(GATT_CHARAC_UUID, pdu + 4);
 
 	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
-				discover_chrcs_cb, discovery_op_ref(op),
-				discovery_op_unref);
-	if (op->id)
-		return true;
+				discover_chrcs_cb, bt_gatt_request_ref(op),
+				async_req_unref);
+	if (!op->id) {
+		free(op);
+		return NULL;
+	}
 
-	free(op);
-	return false;
+	return bt_gatt_request_ref(op);
 }
 
 static void read_by_type_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_request *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	size_t data_length;
@@ -1289,8 +1323,8 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
 						pdu, sizeof(pdu),
 						read_by_type_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
+						bt_gatt_request_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -1306,17 +1340,17 @@ done:
 
 bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 					const bt_uuid_t *uuid,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 	uint8_t pdu[4 + get_uuid_len(uuid)];
 
 	if (!att || !uuid || uuid->type == BT_UUID_UNSPEC)
 		return false;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_request, 1);
 	if (!op)
 		return false;
 
@@ -1332,8 +1366,9 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 	bt_uuid_to_le(uuid, pdu + 4);
 
 	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
-					read_by_type_cb, discovery_op_ref(op),
-					discovery_op_unref);
+						read_by_type_cb,
+						bt_gatt_request_ref(op),
+						async_req_unref);
 	if (op->id)
 		return true;
 
@@ -1344,7 +1379,7 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 static void discover_descs_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discovery_op *op = user_data;
+	struct bt_gatt_request *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	uint8_t format;
@@ -1404,8 +1439,8 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 		op->id = bt_att_send(op->att, BT_ATT_OP_FIND_INFO_REQ,
 						pdu, sizeof(pdu),
 						discover_descs_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
+						bt_gatt_request_ref(op),
+						async_req_unref);
 		if (op->id)
 			return;
 
@@ -1420,19 +1455,19 @@ done:
 	discovery_op_complete(op, success, att_ecode);
 }
 
-bool bt_gatt_discover_descriptors(struct bt_att *att,
+struct bt_gatt_request *bt_gatt_discover_descriptors(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discovery_op *op;
+	struct bt_gatt_request *op;
 	uint8_t pdu[4];
 
 	if (!att)
 		return false;
 
-	op = new0(struct discovery_op, 1);
+	op = new0(struct bt_gatt_request, 1);
 	if (!op)
 		return false;
 
@@ -1447,11 +1482,12 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 
 	op->id = bt_att_send(att, BT_ATT_OP_FIND_INFO_REQ, pdu, sizeof(pdu),
 						discover_descs_cb,
-						discovery_op_ref(op),
-						discovery_op_unref);
-	if (op->id)
-		return true;
+						bt_gatt_request_ref(op),
+						async_req_unref);
+	if (!op->id) {
+		free(op);
+		return NULL;
+	}
 
-	free(op);
-	return false;
+	return bt_gatt_request_ref(op);
 }
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index cf92075..dd9dd1c 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -61,47 +61,56 @@ typedef void (*bt_gatt_destroy_func_t)(void *user_data);
 
 typedef void (*bt_gatt_result_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
-typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_ecode,
+typedef void (*bt_gatt_request_callback_t)(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
 
+struct bt_gatt_request;
+
+struct bt_gatt_request *bt_gatt_request_ref(struct bt_gatt_request *req);
+void bt_gatt_request_unref(struct bt_gatt_request *req);
+void bt_gatt_request_cancel(struct bt_gatt_request *req);
+
 unsigned int bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 					bt_gatt_result_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
 
-bool bt_gatt_discover_all_primary_services(struct bt_att *att, bt_uuid_t *uuid,
-					bt_gatt_discovery_callback_t callback,
+struct bt_gatt_request *bt_gatt_discover_all_primary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_request *bt_gatt_discover_primary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
+struct bt_gatt_request *bt_gatt_discover_secondary_services(
+					struct bt_att *att, bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_included_services(struct bt_att *att,
+struct bt_gatt_request *bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_characteristics(struct bt_att *att,
+struct bt_gatt_request *bt_gatt_discover_characteristics(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-bool bt_gatt_discover_descriptors(struct bt_att *att,
+struct bt_gatt_request *bt_gatt_discover_descriptors(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
 
 bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 					const bt_uuid_t *uuid,
-					bt_gatt_discovery_callback_t callback,
+					bt_gatt_request_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-- 
2.2.0.rc0.207.ga3a616c

