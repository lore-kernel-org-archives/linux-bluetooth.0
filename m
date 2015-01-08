Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 03/14] shared/gatt-client: Make long-write cancelable
Date: Wed,  7 Jan 2015 21:48:17 -0800
Message-Id: <1420696108-29699-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends the GATT request ids in bt_gatt_client to
bt_gatt_client_write_long_value.
---
 src/shared/gatt-client.c | 162 ++++++++++++++++++++++++++++++-----------------
 src/shared/gatt-client.h |   2 +-
 2 files changed, 104 insertions(+), 60 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 362fc32..083bcd2 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -101,6 +101,7 @@ struct bt_gatt_client {
 
 struct request {
 	struct bt_gatt_client *client;
+	bool long_write;
 	bool removed;
 	int ref_count;
 	unsigned int id;
@@ -1473,8 +1474,6 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	bt_gatt_client_unref(client);
 }
 
-static void long_write_op_unref(void *data);
-
 static void bt_gatt_client_free(struct bt_gatt_client *client)
 {
 	bt_gatt_client_cancel_all(client);
@@ -1495,7 +1494,7 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 	gatt_db_unref(client->db);
 
 	queue_destroy(client->svc_chngd_queue, free);
-	queue_destroy(client->long_write_queue, long_write_op_unref);
+	queue_destroy(client->long_write_queue, request_unref);
 	queue_destroy(client->notify_list, notify_data_unref);
 	queue_destroy(client->notify_chrcs, notify_chrc_free);
 	queue_destroy(client->pending_requests, request_unref);
@@ -1676,9 +1675,16 @@ static bool match_req_id(const void *a, const void *b)
 	return req->id == id;
 }
 
+static void cancel_long_write_cb(uint8_t opcode, const void *pdu, uint16_t len,
+								void *user_data)
+{
+	/* Do nothing */
+}
+
 bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
 {
 	struct request *req;
+	uint8_t pdu = 0x00;
 
 	if (!client || !id || !client->att)
 		return false;
@@ -1690,15 +1696,48 @@ bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
 
 	req->removed = true;
 
-	return bt_att_cancel(client->att, req->att_id);
+	if (!bt_att_cancel(client->att, req->att_id) && !req->long_write)
+		return false;
+
+	/* If this was a long-write, we need to abort all prepared writes */
+	if (!req->long_write)
+		return true;
+
+	if (!req->att_id)
+		queue_remove(client->long_write_queue, req);
+	else
+		bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ,
+							&pdu, sizeof(pdu),
+							cancel_long_write_cb,
+							NULL, NULL);
+
+	if (queue_isempty(client->long_write_queue))
+		client->in_long_write = false;
+
+	return true;
 }
 
 static void cancel_request(void *data)
 {
 	struct request *req = data;
+	uint8_t pdu = 0x00;
 
 	req->removed = true;
 	bt_att_cancel(req->client->att, req->att_id);
+
+	if (!req->long_write)
+		return;
+
+	if (!req->att_id)
+		queue_remove(req->client->long_write_queue, req);
+
+	if (queue_isempty(req->client->long_write_queue))
+		req->client->in_long_write = false;
+
+	bt_att_send(req->client->att, BT_ATT_OP_EXEC_WRITE_REQ,
+							&pdu, sizeof(pdu),
+							cancel_long_write_cb,
+							NULL, NULL);
 }
 
 bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
@@ -2218,7 +2257,6 @@ unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 
 struct long_write_op {
 	struct bt_gatt_client *client;
-	int ref_count;
 	bool reliable;
 	bool success;
 	uint8_t att_ecode;
@@ -2234,20 +2272,10 @@ struct long_write_op {
 	bt_gatt_client_destroy_func_t destroy;
 };
 
-static struct long_write_op *long_write_op_ref(struct long_write_op *op)
-{
-	__sync_fetch_and_add(&op->ref_count, 1);
-
-	return op;
-}
-
-static void long_write_op_unref(void *data)
+static void long_write_op_free(void *data)
 {
 	struct long_write_op *op = data;
 
-	if (__sync_sub_and_fetch(&op->ref_count, 1))
-		return;
-
 	if (op->destroy)
 		op->destroy(op->user_data);
 
@@ -2257,11 +2285,12 @@ static void long_write_op_unref(void *data)
 
 static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 							void *user_data);
-static void complete_write_long_op(struct long_write_op *op, bool success,
+static void complete_write_long_op(struct request *req, bool success,
 					uint8_t att_ecode, bool reliable_error);
 
-static void handle_next_prep_write(struct long_write_op *op)
+static void handle_next_prep_write(struct request *req)
 {
+	struct long_write_op *op = req->data;
 	bool success = true;
 	uint8_t *pdu;
 
@@ -2275,12 +2304,13 @@ static void handle_next_prep_write(struct long_write_op *op)
 	put_le16(op->offset + op->index, pdu + 2);
 	memcpy(pdu + 4, op->value + op->index, op->cur_length);
 
-	if (!bt_att_send(op->client->att, BT_ATT_OP_PREP_WRITE_REQ,
+	req->att_id = bt_att_send(op->client->att, BT_ATT_OP_PREP_WRITE_REQ,
 							pdu, op->cur_length + 4,
 							prepare_write_cb,
-							long_write_op_ref(op),
-							long_write_op_unref)) {
-		long_write_op_unref(op);
+							request_ref(req),
+							request_unref);
+	if (!req->att_id) {
+		request_unref(req);
 		success = false;
 	}
 
@@ -2294,34 +2324,36 @@ static void handle_next_prep_write(struct long_write_op *op)
 		return;
 
 done:
-	complete_write_long_op(op, success, 0, false);
+	complete_write_long_op(req, success, 0, false);
 }
 
 static void start_next_long_write(struct bt_gatt_client *client)
 {
-	struct long_write_op *op;
+	struct request *req;
 
 	if (queue_isempty(client->long_write_queue)) {
 		client->in_long_write = false;
 		return;
 	}
 
-	op = queue_pop_head(client->long_write_queue);
-	if (!op)
+	req  = queue_pop_head(client->long_write_queue);
+	if (!req)
 		return;
 
-	handle_next_prep_write(op);
+	handle_next_prep_write(req);
 
-	/* send_next_prep_write adds an extra ref. Unref here to clean up if
+	/*
+	 * send_next_prep_write adds an extra ref. Unref here to clean up if
 	 * necessary, since we also added a ref before pushing to the queue.
 	 */
-	long_write_op_unref(op);
+	request_unref(req);
 }
 
 static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 								void *user_data)
 {
-	struct long_write_op *op = user_data;
+	struct request *req = user_data;
+	struct long_write_op *op = req->data;
 	bool success = op->success;
 	uint8_t att_ecode = op->att_ecode;
 
@@ -2338,9 +2370,10 @@ static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	start_next_long_write(op->client);
 }
 
-static void complete_write_long_op(struct long_write_op *op, bool success,
+static void complete_write_long_op(struct request *req, bool success,
 					uint8_t att_ecode, bool reliable_error)
 {
+	struct long_write_op *op = req->data;
 	uint8_t pdu;
 
 	op->success = success;
@@ -2352,14 +2385,16 @@ static void complete_write_long_op(struct long_write_op *op, bool success,
 	else
 		pdu = 0x00;  /* Cancel */
 
-	if (bt_att_send(op->client->att, BT_ATT_OP_EXEC_WRITE_REQ,
+	req->att_id = bt_att_send(op->client->att, BT_ATT_OP_EXEC_WRITE_REQ,
 							&pdu, sizeof(pdu),
 							execute_write_cb,
-							long_write_op_ref(op),
-							long_write_op_unref))
+							request_ref(req),
+							request_unref);
+	if (req->att_id)
 		return;
 
-	long_write_op_unref(op);
+
+	request_unref(req);
 	success = false;
 
 	if (op->callback)
@@ -2371,7 +2406,8 @@ static void complete_write_long_op(struct long_write_op *op, bool success,
 static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 								void *user_data)
 {
-	struct long_write_op *op = user_data;
+	struct request *req = user_data;
+	struct long_write_op *op = req->data;
 	bool success = true;
 	bool reliable_error = false;
 	uint8_t att_ecode = 0;
@@ -2422,15 +2458,15 @@ static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		op->index = next_index;
 		op->cur_length = MIN(op->length - op->index,
 					bt_att_get_mtu(op->client->att) - 5);
-		handle_next_prep_write(op);
+		handle_next_prep_write(req);
 		return;
 	}
 
 done:
-	complete_write_long_op(op, success, att_ecode, reliable_error);
+	complete_write_long_op(req, success, att_ecode, reliable_error);
 }
 
-bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 				bool reliable,
 				uint16_t value_handle, uint16_t offset,
 				const uint8_t *value, uint16_t length,
@@ -2438,30 +2474,37 @@ bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 				void *user_data,
 				bt_gatt_client_destroy_func_t destroy)
 {
+	struct request *req;
 	struct long_write_op *op;
 	uint8_t *pdu;
-	bool status;
 
 	if (!client)
-		return false;
+		return 0;
 
 	if ((size_t)(length + offset) > UINT16_MAX)
-		return false;
+		return 0;
 
 	/* Don't allow writing a 0-length value using this procedure. The
 	 * upper-layer should use bt_gatt_write_value for that instead.
 	 */
 	if (!length || !value)
-		return false;
+		return 0;
 
 	op = new0(struct long_write_op, 1);
 	if (!op)
-		return false;
+		return 0;
 
 	op->value = malloc(length);
 	if (!op->value) {
 		free(op);
-		return false;
+		return 0;
+	}
+
+	req = request_create(client);
+	if (!req) {
+		free(op->value);
+		free(op);
+		return 0;
 	}
 
 	memcpy(op->value, value, length);
@@ -2476,40 +2519,41 @@ bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 	op->user_data = user_data;
 	op->destroy = destroy;
 
+	req->data = op;
+	req->destroy = long_write_op_free;
+	req->long_write = true;
+
 	if (client->in_long_write) {
-		queue_push_tail(client->long_write_queue,
-						long_write_op_ref(op));
-		return true;
+		queue_push_tail(client->long_write_queue, req);
+		return req->id;
 	}
 
 	pdu = malloc(op->cur_length + 4);
 	if (!pdu) {
 		free(op->value);
 		free(op);
-		return false;
+		return 0;
 	}
 
 	put_le16(value_handle, pdu);
 	put_le16(offset, pdu + 2);
 	memcpy(pdu + 4, op->value, op->cur_length);
 
-	status = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ,
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ,
 							pdu, op->cur_length + 4,
-							prepare_write_cb,
-							long_write_op_ref(op),
-							long_write_op_unref);
-
+							prepare_write_cb, req,
+							request_unref);
 	free(pdu);
 
-	if (!status) {
-		free(op->value);
-		free(op);
-		return false;
+	if (!req->att_id) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
 	}
 
 	client->in_long_write = true;
 
-	return true;
+	return req->id;
 }
 
 static bool match_notify_chrc_value_handle(const void *a, const void *b)
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 74d781c..9a00feb 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -102,7 +102,7 @@ unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
-bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 				bool reliable,
 				uint16_t value_handle, uint16_t offset,
 				const uint8_t *value, uint16_t length,
-- 
2.2.0.rc0.207.ga3a616c

