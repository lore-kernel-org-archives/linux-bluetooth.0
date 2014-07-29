Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH] shared/gatt: Use iterator based discovery result structure.
Date: Tue, 29 Jul 2014 13:15:49 -0700
Message-Id: <1406664949-25196-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the GATT specific linked list structure in gatt-helpers to
bt_gatt_result and bt_gatt_iter. bt_gatt_result internally stores a linked list
of ATT response PDUs, which get decoded on-demand by the iterator functions.
Each iterator function operates on a specific ATT response PDU.
---
 src/shared/gatt-helpers.c | 577 +++++++++++++++++++++++-----------------------
 src/shared/gatt-helpers.h |  21 +-
 2 files changed, 309 insertions(+), 289 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 489b8c4..c237b00 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -36,69 +36,207 @@
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
-struct bt_gatt_list {
-	struct bt_gatt_list *next;
-	void *data;
-};
+struct bt_gatt_result {
+	uint8_t opcode;
+	void *pdu;
+	uint16_t pdu_len;
+	uint16_t data_len;
+
+	void *op;  /* Discovery operation data */
 
-struct list_ptrs {
-	struct bt_gatt_list *head;
-	struct bt_gatt_list *tail;
+	struct bt_gatt_result *next;
 };
 
-struct bt_gatt_list *bt_gatt_list_get_next(struct bt_gatt_list *list)
+static struct bt_gatt_result *result_create(uint8_t opcode, const void *pdu,
+							uint16_t pdu_len,
+							uint16_t data_len,
+							void *op)
 {
-	return list->next;
+	struct bt_gatt_result *result = new0(struct bt_gatt_result, 1);
+
+	if (!result)
+		return NULL;
+
+	result->pdu = malloc(pdu_len);
+	if (!result->pdu) {
+		free(result);
+		return NULL;
+	}
+
+	result->opcode = opcode;
+	result->pdu_len = pdu_len;
+	result->data_len = data_len;
+	result->op = op;
+
+	memcpy(result->pdu, pdu, pdu_len);
+
+	return result;
 }
 
-void *bt_gatt_list_get_data(struct bt_gatt_list *list)
+static void result_destroy(struct bt_gatt_result *result)
 {
-	return list->data;
+	struct bt_gatt_result *next;
+
+	while (result) {
+		next = result->next;
+
+		free(result->pdu);
+		free(result);
+
+		result = next;
+	}
 }
 
-static inline bool list_isempty(struct list_ptrs *list)
+bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct bt_gatt_result *result)
 {
-	return !list->head && !list->tail;
+	if (!iter || !result)
+		return false;
+
+	iter->result = result;
+	iter->pos = 0;
+
+	return true;
 }
 
-static bool list_add(struct list_ptrs *list, void *data)
+static const uint8_t bt_base_uuid[16] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+};
+
+static bool convert_uuid_le(const uint8_t *src, size_t len, uint8_t dst[16])
 {
-	struct bt_gatt_list *item = new0(struct bt_gatt_list, 1);
-	if (!item)
+	if (len == 16) {
+		bswap_128(src, dst);
+		return true;
+	}
+
+	if (len != 2)
 		return false;
 
-	item->data = data;
+	memcpy(dst, bt_base_uuid, sizeof(bt_base_uuid));
+	dst[2] = src[1];
+	dst[3] = src[0];
 
-	if (list_isempty(list)) {
-		list->head = list->tail = item;
-		return true;
+	return true;
+}
+
+struct result_ptrs {
+	struct bt_gatt_result *head;
+	struct bt_gatt_result *tail;
+};
+
+struct discovery_op {
+	struct bt_att *att;
+	uint16_t end_handle;
+	int ref_count;
+	bt_uuid_t uuid;
+	struct result_ptrs result;
+	bt_gatt_discovery_callback_t callback;
+	void *user_data;
+	bt_gatt_destroy_func_t destroy;
+};
+
+bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
+						struct bt_gatt_service *service)
+{
+	struct discovery_op *op;
+	const void *pdu_ptr;
+	bt_uuid_t uuid;
+
+	if (!iter->result || !service)
+		return false;
+
+	op = iter->result->op;
+	pdu_ptr = iter->result->pdu + iter->pos;
+
+	switch (iter->result->opcode) {
+	case BT_ATT_OP_READ_BY_GRP_TYPE_RSP:
+		service->start = get_le16(pdu_ptr);
+		service->end = get_le16(pdu_ptr + 2);
+		convert_uuid_le(pdu_ptr + 4, iter->result->data_len - 4,
+								service->uuid);
+		break;
+	case BT_ATT_OP_FIND_BY_TYPE_VAL_RSP:
+		service->start = get_le16(pdu_ptr);
+		service->end = get_le16(pdu_ptr + 2);
+
+		bt_uuid_to_uuid128(&op->uuid, &uuid);
+		memcpy(service->uuid, uuid.value.u128.data, 16);
+		break;
+	default:
+		return false;
 	}
 
-	list->tail->next = item;
-	list->tail = item;
+
+	iter->pos += iter->result->data_len;
+	if (iter->pos == iter->result->pdu_len) {
+		iter->result = iter->result->next;
+		iter->pos = 0;
+	}
 
 	return true;
 }
 
-static void list_free(struct list_ptrs *list, bt_gatt_destroy_func_t destroy)
+bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
+					struct bt_gatt_characteristic *chrc)
 {
-	struct bt_gatt_list *l, *tmp;
-	l = list->head;
+	struct discovery_op *op;
+	const void *pdu_ptr;
+
+	if (!iter->result || !chrc)
+		return false;
+
+	if (iter->result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
+		return false;
+
+	op = iter->result->op;
+	pdu_ptr = iter->result->pdu + iter->pos;
 
-	while (l) {
-		if (destroy)
-			destroy(l->data);
+	chrc->start = get_le16(pdu_ptr);
+	chrc->properties = ((uint8_t *) pdu_ptr)[2];
+	chrc->value = get_le16(pdu_ptr + 3);
+	convert_uuid_le(pdu_ptr + 5, iter->result->data_len - 5, chrc->uuid);
 
-		tmp = l->next;
-		free(l);
-		l = tmp;
+	iter->pos += iter->result->data_len;
+	if (iter->pos == iter->result->pdu_len) {
+		iter->result = iter->result->next;
+		iter->pos = 0;
 	}
+
+	if (!iter->result) {
+		chrc->end = op->end_handle;
+		return true;
+	}
+
+	chrc->end = get_le16(iter->result->pdu + iter->pos) - 1;
+
+	return true;
 }
 
-static const uint8_t bt_base_uuid[16] = {
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
-	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
-};
+bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter,
+						struct bt_gatt_descriptor *desc)
+{
+	const void *pdu_ptr;
+
+	if (!iter->result || !desc)
+		return false;
+
+	if (iter->result->opcode != BT_ATT_OP_FIND_INFO_RSP)
+		return false;
+
+	pdu_ptr = iter->result->pdu + iter->pos;
+
+	desc->handle = get_le16(pdu_ptr);
+	convert_uuid_le(pdu_ptr + 2, iter->result->data_len - 2, desc->uuid);
+
+	iter->pos += iter->result->data_len;
+	if (iter->pos == iter->result->pdu_len) {
+		iter->result = iter->result->next;
+		iter->pos = 0;
+	}
+
+	return true;
+}
 
 struct mtu_op {
 	struct bt_att *att;
@@ -186,38 +324,6 @@ bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 	return true;
 }
 
-struct discovery_op {
-	struct bt_att *att;
-	int ref_count;
-	bt_uuid_t uuid;
-	struct list_ptrs results;
-	bt_gatt_discovery_callback_t callback;
-	void *user_data;
-	bt_gatt_destroy_func_t destroy;
-};
-
-static struct discovery_op* discovery_op_ref(struct discovery_op *op)
-{
-	__sync_fetch_and_add(&op->ref_count, 1);
-
-	return op;
-}
-
-static void discovery_op_unref(void *data)
-{
-	struct discovery_op *op = data;
-
-	if (__sync_sub_and_fetch(&op->ref_count, 1))
-		return;
-
-	if (op->destroy)
-		op->destroy(op->user_data);
-
-	list_free(&op->results, free);
-
-	free(op);
-}
-
 static void put_uuid_le(const bt_uuid_t *src, void *dst)
 {
 	bt_uuid_t uuid;
@@ -243,21 +349,26 @@ static inline int get_uuid_len(const bt_uuid_t *uuid)
 	return (uuid->type == BT_UUID16) ? 2 : 16;
 }
 
-static bool convert_uuid_le(const uint8_t *src, size_t len, uint8_t dst[16])
+static struct discovery_op* discovery_op_ref(struct discovery_op *op)
 {
-	if (len == 16) {
-		bswap_128(src, dst);
-		return true;
-	}
+	__sync_fetch_and_add(&op->ref_count, 1);
 
-	if (len != 2)
-		return false;
+	return op;
+}
 
-	memcpy(dst, bt_base_uuid, sizeof(bt_base_uuid));
-	dst[2] = src[1];
-	dst[3] = src[0];
+static void discovery_op_unref(void *data)
+{
+	struct discovery_op *op = data;
 
-	return true;
+	if (__sync_sub_and_fetch(&op->ref_count, 1))
+		return;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	result_destroy(op->result.head);
+
+	free(op);
 }
 
 static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
@@ -266,18 +377,18 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	struct discovery_op *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
-	struct bt_gatt_list *results = NULL;
+	struct bt_gatt_result *final_result = NULL;
+	struct bt_gatt_result *cur_result;
 	size_t data_length;
 	size_t list_length;
 	uint16_t last_end;
-	int i;
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
 
 		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-						!list_isempty(&op->results))
+								op->result.head)
 			goto success;
 
 		goto done;
@@ -304,26 +415,24 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	for (i = 1; i < length; i += data_length) {
-		struct bt_gatt_service *service;
-
-		service = new0(struct bt_gatt_service, 1);
-		if (!service) {
-			success = false;
-			goto done;
-		}
-
-		service->start = get_le16(pdu + i);
-		last_end = get_le16(pdu + i + 2);
-		service->end = last_end;
-		convert_uuid_le(pdu + i + 4, data_length - 4, service->uuid);
+	/* PDU is correctly formatted. Get the last end handle to process the
+	 * next request and store the PDU.
+	 */
+	cur_result = result_create(opcode, pdu + 1, list_length,
+							data_length, op);
+	if (!cur_result) {
+		success = false;
+		goto done;
+	}
 
-		if (!list_add(&op->results, service)) {
-			success = false;
-			goto done;
-		}
+	if (!op->result.head)
+		op->result.head = op->result.tail = cur_result;
+	else {
+		op->result.tail->next = cur_result;
+		op->result.tail = cur_result;
 	}
 
+	last_end = get_le16(pdu + length - data_length + 2);
 	if (last_end != 0xffff) {
 		uint8_t pdu[6];
 
@@ -345,12 +454,12 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 
 success:
 	/* End of procedure */
-	results = op->results.head;
+	final_result = op->result.head;
 	success = true;
 
 done:
 	if (op->callback)
-		op->callback(success, att_ecode, results, op->user_data);
+		op->callback(success, att_ecode, final_result, op->user_data);
 }
 
 static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
@@ -359,16 +468,16 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 	struct discovery_op *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
-	struct bt_gatt_list *results = NULL;
+	struct bt_gatt_result *final_result = NULL;
+	struct bt_gatt_result *cur_result;
 	uint16_t last_end;
-	int i;
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
 
 		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-						!list_isempty(&op->results))
+								op->result.head)
 			goto success;
 
 		goto done;
@@ -383,29 +492,20 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	for (i = 0; i < length; i += 4) {
-		struct bt_gatt_service *service;
-		bt_uuid_t uuid;
-
-		service = new0(struct bt_gatt_service, 1);
-		if (!service) {
-			success = false;
-			goto done;
-		}
-
-		service->start = get_le16(pdu + i);
-		last_end = get_le16(pdu + i + 2);
-		service->end = last_end;
-
-		bt_uuid_to_uuid128(&op->uuid, &uuid);
-		memcpy(service->uuid, uuid.value.u128.data, 16);
+	cur_result = result_create(opcode, pdu, length, 4, op);
+	if (!cur_result) {
+		success = false;
+		goto done;
+	}
 
-		if (!list_add(&op->results, service)) {
-			success = false;
-			goto done;
-		}
+	if (!op->result.head)
+		op->result.head = op->result.tail = cur_result;
+	else {
+		op->result.tail->next = cur_result;
+		op->result.tail = cur_result;
 	}
 
+	last_end = get_le16(pdu + length - 6);
 	if (last_end != 0xffff) {
 		uint8_t pdu[6 + get_uuid_len(&op->uuid)];
 
@@ -428,12 +528,12 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 
 success:
 	/* End of procedure */
-	results = op->results.head;
+	final_result = op->result.head;
 	success = true;
 
 done:
 	if (op->callback)
-		op->callback(success, att_ecode, results, op->user_data);
+		op->callback(success, att_ecode, final_result, op->user_data);
 }
 
 bool bt_gatt_discover_primary_services(struct bt_att *att,
@@ -510,53 +610,23 @@ bool bt_gatt_discover_included_services(struct bt_att *att,
 	return false;
 }
 
-struct discover_chrcs_op {
-	struct discovery_op data;
-	bool by_uuid;
-	uint16_t end;
-	struct bt_gatt_characteristic *prev_chrc;
-};
-
-static struct discover_chrcs_op *discover_chrcs_op_ref(
-						struct discover_chrcs_op *op)
-{
-	__sync_fetch_and_add(&op->data.ref_count, 1);
-
-	return op;
-}
-
-static void discover_chrcs_op_unref(void *data)
-{
-	struct discover_chrcs_op *op = data;
-
-	if (__sync_sub_and_fetch(&op->data.ref_count, 1))
-		return;
-
-	if (op->data.destroy)
-		op->data.destroy(op->data.user_data);
-
-	list_free(&op->data.results, free);
-
-	free(op);
-}
-
 static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discover_chrcs_op *op = user_data;
+	struct discovery_op *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
-	struct bt_gatt_list *results = NULL;
+	struct bt_gatt_result *final_result = NULL;
+	struct bt_gatt_result *cur_result;
 	size_t data_length;
 	uint16_t last_handle;
-	int i;
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
 
 		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-					!list_isempty(&op->data.results))
+							op->result.head)
 			goto success;
 
 		goto done;
@@ -583,97 +653,71 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	for (i = 1; i < length; i += data_length) {
-		struct bt_gatt_characteristic *chrc;
-		bt_uuid_t uuid;
-
-		chrc = new0(struct bt_gatt_characteristic, 1);
-		if (!chrc) {
-			success = false;
-			goto done;
-		}
-
-		last_handle = get_le16(pdu + i);
-		chrc->start = last_handle;
-		chrc->properties = ((uint8_t *) pdu)[i + 2];
-		chrc->value = get_le16(pdu + i + 3);
-		convert_uuid_le(pdu + i + 5, data_length - 5, chrc->uuid);
-
-		uuid.type = BT_UUID128;
-		memcpy(&uuid.value.u128, chrc->uuid, 16);
-
-		if (op->prev_chrc)
-			op->prev_chrc->end = chrc->start - 1;
-
-		op->prev_chrc = chrc;
+	cur_result = result_create(opcode, pdu + 1, length - 1,
+							data_length, op);
+	if (!cur_result) {
+		success = false;
+		goto done;
+	}
 
-		if (!op->by_uuid || !bt_uuid_cmp(&uuid, &op->data.uuid)) {
-			if (!list_add(&op->data.results, chrc)) {
-				success = false;
-				goto done;
-			}
-		}
+	if (!op->result.head)
+		op->result.head = op->result.tail = cur_result;
+	else {
+		op->result.tail->next = cur_result;
+		op->result.tail = cur_result;
 	}
 
-	if (last_handle != op->end) {
+	last_handle = get_le16(pdu + length - data_length);
+	if (last_handle != op->end_handle) {
 		uint8_t pdu[6];
 
 		put_le16(last_handle + 1, pdu);
-		put_le16(op->end, pdu + 2);
+		put_le16(op->end_handle, pdu + 2);
 		put_le16(GATT_CHARAC_UUID, pdu + 4);
 
-		if (bt_att_send(op->data.att, BT_ATT_OP_READ_BY_TYPE_REQ,
+		if (bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
 						pdu, sizeof(pdu),
 						discover_chrcs_cb,
-						discover_chrcs_op_ref(op),
-						discover_chrcs_op_unref))
+						discovery_op_ref(op),
+						discovery_op_unref))
 			return;
 
-		discover_chrcs_op_unref(op);
+		discovery_op_unref(op);
 		success = false;
 		goto done;
 	}
 
 success:
-	results = op->data.results.head;
+	final_result = op->result.head;
 	success = true;
 
-	if (op->prev_chrc)
-		op->prev_chrc->end = op->end - 1;
-
 done:
-	if (op->data.callback)
-		op->data.callback(success, att_ecode, results,
-							op->data.user_data);
+	if (op->callback)
+		op->callback(success, att_ecode, final_result,
+							op->user_data);
 }
 
 bool bt_gatt_discover_characteristics(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discover_chrcs_op *op;
+	struct discovery_op *op;
 	uint8_t pdu[6];
 
 	if (!att)
 		return false;
 
-	op = new0(struct discover_chrcs_op, 1);
+	op = new0(struct discovery_op, 1);
 	if (!op)
 		return false;
 
-	if (uuid) {
-		op->by_uuid = true;
-		op->data.uuid = *uuid;
-	}
-
-	op->data.att = att;
-	op->data.callback = callback;
-	op->data.user_data = user_data;
-	op->data.destroy = destroy;
-	op->end = end;
+	op->att = att;
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+	op->end_handle = end;
 
 	put_le16(start, pdu);
 	put_le16(end, pdu + 2);
@@ -682,8 +726,8 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
 	if (!bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ,
 					pdu, sizeof(pdu),
 					discover_chrcs_cb,
-					discover_chrcs_op_ref(op),
-					discover_chrcs_op_unref)) {
+					discovery_op_ref(op),
+					discovery_op_unref)) {
 		free(op);
 		return false;
 	}
@@ -691,52 +735,24 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
 	return true;
 }
 
-struct discover_descs_op {
-	struct discovery_op data;
-	uint16_t end;
-};
-
-static struct discover_descs_op *discover_descs_op_ref(
-						struct discover_descs_op *op)
-{
-	__sync_fetch_and_add(&op->data.ref_count, 1);
-
-	return op;
-}
-
-static void discover_descs_op_unref(void *data)
-{
-	struct discover_descs_op *op = data;
-
-	if (__sync_sub_and_fetch(&op->data.ref_count, 1))
-		return;
-
-	if (op->data.destroy)
-		op->data.destroy(op->data.user_data);
-
-	list_free(&op->data.results, free);
-
-	free(op);
-}
-
 static void discover_descs_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct discover_descs_op *op = user_data;
+	struct discovery_op *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
-	struct bt_gatt_list *results = NULL;
+	struct bt_gatt_result *final_result = NULL;
+	struct bt_gatt_result *cur_result;
 	uint8_t format;
 	uint16_t last_handle;
 	size_t data_length;
-	int i;
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		success = false;
 		att_ecode = process_error(pdu, length);
 
 		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
-					!list_isempty(&op->data.results))
+								op->result.head)
 			goto success;
 
 		goto done;
@@ -769,51 +785,46 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	for (i = 1; i < length; i += data_length) {
-		struct bt_gatt_descriptor *descr;
-
-		descr = new0(struct bt_gatt_descriptor, 1);
-		if (!descr) {
-			success = false;
-			goto done;
-		}
-
-		last_handle = get_le16(pdu + i);
-		descr->handle = last_handle;
-		convert_uuid_le(pdu + i + 2, data_length - 2, descr->uuid);
+	cur_result = result_create(opcode, pdu + 1, length - 1,
+							data_length, op);
+	if (!cur_result) {
+		success = false;
+		goto done;
+	}
 
-		if (!list_add(&op->data.results, descr)) {
-			success = false;
-			goto done;
-		}
+	if (!op->result.head)
+		op->result.head = op->result.tail = cur_result;
+	else {
+		op->result.tail->next = cur_result;
+		op->result.tail = cur_result;
 	}
 
-	if (last_handle != op->end) {
+	last_handle = get_le16(pdu + length - data_length);
+	if (last_handle != op->end_handle) {
 		uint8_t pdu[4];
 
 		put_le16(last_handle + 1, pdu);
-		put_le16(op->end, pdu + 2);
+		put_le16(op->end_handle, pdu + 2);
 
-		if (bt_att_send(op->data.att, BT_ATT_OP_FIND_INFO_REQ,
+		if (bt_att_send(op->att, BT_ATT_OP_FIND_INFO_REQ,
 						pdu, sizeof(pdu),
 						discover_descs_cb,
-						discover_descs_op_ref(op),
-						discover_descs_op_unref))
+						discovery_op_ref(op),
+						discovery_op_unref))
 			return;
 
-		discover_descs_op_unref(op);
+		discovery_op_unref(op);
 		success = false;
 		goto done;
 	}
 
 success:
-	results = op->data.results.head;
+	final_result = op->result.head;
 	success = true;
 
 done:
-	if (op->data.callback)
-		op->data.callback(success, att_ecode, results,
-							op->data.user_data);
+	if (op->callback)
+		op->callback(success, att_ecode, final_result, op->user_data);
 }
 
 bool bt_gatt_discover_descriptors(struct bt_att *att,
@@ -822,29 +833,29 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	struct discover_descs_op *op;
+	struct discovery_op *op;
 	uint8_t pdu[4];
 
 	if (!att)
 		return false;
 
-	op = new0(struct discover_descs_op, 1);
+	op = new0(struct discovery_op, 1);
 	if (!op)
 		return false;
 
-	op->data.att = att;
-	op->data.callback = callback;
-	op->data.user_data = user_data;
-	op->data.destroy = destroy;
-	op->end = end;
+	op->att = att;
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+	op->end_handle = end;
 
 	put_le16(start, pdu);
 	put_le16(end, pdu + 2);
 
 	if (!bt_att_send(att, BT_ATT_OP_FIND_INFO_REQ, pdu, sizeof(pdu),
 						discover_descs_cb,
-						discover_descs_op_ref(op),
-						discover_descs_op_unref)) {
+						discovery_op_ref(op),
+						discovery_op_unref)) {
 		free(op);
 		return false;
 	}
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index d3a95ae..95dd8b7 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -47,17 +47,27 @@ struct bt_gatt_descriptor {
 	uint8_t uuid[16];
 };
 
-struct bt_gatt_list;
+struct bt_gatt_result;
 
-struct bt_gatt_list *bt_gatt_list_get_next(struct bt_gatt_list *l);
-void *bt_gatt_list_get_data(struct bt_gatt_list *l);
+struct bt_gatt_iter {
+	struct bt_gatt_result *result;
+	uint16_t pos;
+};
+
+bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct bt_gatt_result *result);
+bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
+					struct bt_gatt_service *service);
+bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
+				struct bt_gatt_characteristic *characteristic);
+bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter,
+					struct bt_gatt_descriptor *descriptor);
 
 typedef void (*bt_gatt_destroy_func_t)(void *user_data);
 
 typedef void (*bt_gatt_result_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
-typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_ecode,
-						struct bt_gatt_list *results,
+typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_code,
+						struct bt_gatt_result *result,
 						void *user_data);
 typedef void (*bt_gatt_read_callback_t)(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
@@ -86,7 +96,6 @@ bool bt_gatt_discover_included_services(struct bt_att *att,
 					bt_gatt_destroy_func_t destroy);
 bool bt_gatt_discover_characteristics(struct bt_att *att,
 					uint16_t start, uint16_t end,
-					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-- 
2.0.0.526.g5318336

