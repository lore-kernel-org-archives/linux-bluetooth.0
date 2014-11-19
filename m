Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] shared/gatt-helpers: Simplify appending gatt_results
Date: Wed, 19 Nov 2014 12:21:59 +0100
Message-Id: <1416396119-19441-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416396119-19441-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416396119-19441-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't duplicate appending gatt_results.
---
 src/shared/gatt-helpers.c | 91 ++++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 61 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 9c8a3ba..97e62fe 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -221,6 +221,27 @@ struct discovery_op {
 	bt_gatt_destroy_func_t destroy;
 };
 
+static struct bt_gatt_result *result_append(uint8_t opcode, const void *pdu,
+						uint16_t pdu_len,
+						uint16_t data_len,
+						struct discovery_op *op)
+{
+	struct bt_gatt_result *result;
+
+	result = result_create(opcode, pdu, pdu_len, data_len, op);
+	if (!result)
+		return NULL;
+
+	if (!op->result_head)
+		op->result_head = op->result_tail = result;
+	else {
+		op->result_tail->next = result;
+		op->result_tail = result;
+	}
+
+	return result;
+}
+
 bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
 				uint16_t *handle, uint16_t *start_handle,
 				uint16_t *end_handle, uint8_t uuid[16])
@@ -594,20 +615,13 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	/* PDU is correctly formatted. Get the last end handle to process the
 	 * next request and store the PDU.
 	 */
-	cur_result = result_create(opcode, pdu + 1, list_length,
-							data_length, op);
+	cur_result = result_append(opcode, pdu + 1, list_length, data_length,
+									op);
 	if (!cur_result) {
 		success = false;
 		goto done;
 	}
 
-	if (!op->result_head)
-		op->result_head = op->result_tail = cur_result;
-	else {
-		op->result_tail->next = cur_result;
-		op->result_tail = cur_result;
-	}
-
 	last_end = get_le16(pdu + length - data_length + 2);
 	if (last_end < op->end_handle) {
 		uint8_t pdu[6];
@@ -654,7 +668,6 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 	bool success;
 	uint8_t att_ecode = 0;
 	struct bt_gatt_result *final_result = NULL;
-	struct bt_gatt_result *cur_result;
 	uint16_t last_end;
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
@@ -677,19 +690,11 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	cur_result = result_create(opcode, pdu, length, 4, op);
-	if (!cur_result) {
+	if (!result_append(opcode, pdu, length, 4, op)) {
 		success = false;
 		goto done;
 	}
 
-	if (!op->result_head)
-		op->result_head = op->result_tail = cur_result;
-	else {
-		op->result_tail->next = cur_result;
-		op->result_tail = cur_result;
-	}
-
 	/*
 	 * Each data set contains:
 	 * 2 octets with start handle
@@ -873,7 +878,6 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 	struct read_incl_data *data = user_data;
 	struct bt_gatt_result *final_result = NULL;
 	struct discovery_op *op = data->op;
-	struct bt_gatt_result *cur_result;
 	uint8_t att_ecode = 0;
 	uint8_t read_pdu[2];
 	bool success;
@@ -898,19 +902,11 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	cur_result = result_create(opcode, pdu, length, length, op);
-	if (!cur_result) {
+	if (!result_append(opcode, pdu, length, length, op)) {
 		success = false;
 		goto done;
 	}
 
-	if (!op->result_head) {
-		op->result_head = op->result_tail = cur_result;
-	} else {
-		op->result_tail->next = cur_result;
-		op->result_tail = cur_result;
-	}
-
 	if (data->pos == data->result->pdu_len) {
 		uint16_t last_handle;
 		uint8_t pdu[6];
@@ -1019,20 +1015,13 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 		goto failed;
 	}
 
-	cur_result = result_create(opcode, pdu + 1, length - 1,
-							data_length, op);
+	cur_result = result_append(opcode, pdu + 1, length - 1, data_length,
+									op);
 	if (!cur_result) {
 		success = false;
 		goto failed;
 	}
 
-	if (!op->result_head) {
-		op->result_head = op->result_tail = cur_result;
-	} else {
-		op->result_tail->next = cur_result;
-		op->result_tail = cur_result;
-	}
-
 	if (data_length == 6) {
 		struct read_incl_data *data;
 
@@ -1120,7 +1109,6 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 	bool success;
 	uint8_t att_ecode = 0;
 	struct bt_gatt_result *final_result = NULL;
-	struct bt_gatt_result *cur_result;
 	size_t data_length;
 	uint16_t last_handle;
 
@@ -1156,20 +1144,11 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	cur_result = result_create(opcode, pdu + 1, length - 1,
-							data_length, op);
-	if (!cur_result) {
+	if (!result_append(opcode, pdu + 1, length - 1,
+							data_length, op)) {
 		success = false;
 		goto done;
 	}
-
-	if (!op->result_head)
-		op->result_head = op->result_tail = cur_result;
-	else {
-		op->result_tail->next = cur_result;
-		op->result_tail = cur_result;
-	}
-
 	last_handle = get_le16(pdu + length - data_length);
 	if (last_handle != op->end_handle) {
 		uint8_t pdu[6];
@@ -1245,7 +1224,6 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 	bool success;
 	uint8_t att_ecode = 0;
 	struct bt_gatt_result *final_result = NULL;
-	struct bt_gatt_result *cur_result;
 	uint8_t format;
 	uint16_t last_handle;
 	size_t data_length;
@@ -1288,20 +1266,11 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	cur_result = result_create(opcode, pdu + 1, length - 1,
-							data_length, op);
-	if (!cur_result) {
+	if (!result_append(opcode, pdu + 1, length - 1, data_length, op)) {
 		success = false;
 		goto done;
 	}
 
-	if (!op->result_head)
-		op->result_head = op->result_tail = cur_result;
-	else {
-		op->result_tail->next = cur_result;
-		op->result_tail = cur_result;
-	}
-
 	last_handle = get_le16(pdu + length - data_length);
 	if (last_handle != op->end_handle) {
 		uint8_t pdu[4];
-- 
1.9.3

