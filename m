Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 02/14] shared/gatt-client: Make read/write cancelable
Date: Wed,  7 Jan 2015 21:48:16 -0800
Message-Id: <1420696108-29699-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The shared/gatt-client functions for initiating read/write procedures
currently have no way to cancel them. The functions simple return a
boolean result to indicate success/failure. This patch fixes this by
returning a request id from these methods and adds the bt_gatt_cancel_*
functions to cancel a request with one of these ids.

bt_gatt_client internally manages its own set of request ids and maps
them to the underlying ATT request id returned by bt_att_send to
correctly cancel GATT procedures that span across multiple ATT protocol
PDUs.
---
 src/shared/gatt-client.c | 298 +++++++++++++++++++++++++++++++++++++----------
 src/shared/gatt-client.h |  14 ++-
 2 files changed, 244 insertions(+), 68 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 10dfcbb..362fc32 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -65,7 +65,8 @@ struct bt_gatt_client {
 	bool in_init;
 	bool ready;
 
-	/* Queue of long write requests. An error during "prepare write"
+	/*
+	 * Queue of long write requests. An error during "prepare write"
 	 * requests can result in a cancel through "execute write". To prevent
 	 * cancelation of prepared writes to the wrong attribute and multiple
 	 * requests to the same attribute that may result in a corrupted final
@@ -80,15 +81,75 @@ struct bt_gatt_client {
 	int next_reg_id;
 	unsigned int disc_id, notify_id, ind_id;
 
-	/* Handles of the GATT Service and the Service Changed characteristic
+	/*
+	 * Handles of the GATT Service and the Service Changed characteristic
 	 * value handle. These will have the value 0 if they are not present on
 	 * the remote peripheral.
 	 */
 	unsigned int svc_chngd_ind_id;
 	struct queue *svc_chngd_queue;  /* Queued service changed events */
 	bool in_svc_chngd;
+
+	/*
+	 * List of pending read/write operations. For operations that span
+	 * across multiple PDUs, this list provides a mapping from an operation
+	 * id to an ATT request id.
+	 */
+	struct queue *pending_requests;
+	unsigned int next_request_id;
+};
+
+struct request {
+	struct bt_gatt_client *client;
+	bool removed;
+	int ref_count;
+	unsigned int id;
+	unsigned int att_id;
+	void *data;
+	void (*destroy)(void *);
 };
 
+static struct request *request_ref(struct request *req)
+{
+	__sync_fetch_and_add(&req->ref_count, 1);
+
+	return req;
+}
+
+static struct request *request_create(struct bt_gatt_client *client)
+{
+	struct request *req;
+
+	req = new0(struct request, 1);
+	if (!req)
+		return NULL;
+
+	if (client->next_request_id < 1)
+		client->next_request_id = 1;
+
+	queue_push_tail(client->pending_requests, req);
+	req->client = client;
+	req->id = client->next_request_id++;
+
+	return request_ref(req);
+}
+
+static void request_unref(void *data)
+{
+	struct request *req = data;
+
+	if (__sync_sub_and_fetch(&req->ref_count, 1))
+		return;
+
+	if (req->destroy)
+		req->destroy(req->data);
+
+	if (!req->removed)
+		queue_remove(req->client->pending_requests, req);
+
+	free(req);
+}
+
 struct notify_chrc {
 	uint16_t value_handle;
 	uint16_t ccc_handle;
@@ -1416,6 +1477,8 @@ static void long_write_op_unref(void *data);
 
 static void bt_gatt_client_free(struct bt_gatt_client *client)
 {
+	bt_gatt_client_cancel_all(client);
+
 	if (client->ready_destroy)
 		client->ready_destroy(client->ready_data);
 
@@ -1435,6 +1498,7 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 	queue_destroy(client->long_write_queue, long_write_op_unref);
 	queue_destroy(client->notify_list, notify_data_unref);
 	queue_destroy(client->notify_chrcs, notify_chrc_free);
+	queue_destroy(client->pending_requests, request_unref);
 
 	free(client);
 }
@@ -1490,6 +1554,10 @@ struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 	if (!client->notify_chrcs)
 		goto fail;
 
+	client->pending_requests = queue_new();
+	if (!client->pending_requests)
+		goto fail;
+
 	client->notify_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_NOT,
 						notify_cb, client, NULL);
 	if (!client->notify_id)
@@ -1600,6 +1668,49 @@ uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client *client)
 	return bt_att_get_mtu(client->att);
 }
 
+static bool match_req_id(const void *a, const void *b)
+{
+	const struct request *req = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return req->id == id;
+}
+
+bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id)
+{
+	struct request *req;
+
+	if (!client || !id || !client->att)
+		return false;
+
+	req = queue_remove_if(client->pending_requests, match_req_id,
+							UINT_TO_PTR(id));
+	if (!req)
+		return false;
+
+	req->removed = true;
+
+	return bt_att_cancel(client->att, req->att_id);
+}
+
+static void cancel_request(void *data)
+{
+	struct request *req = data;
+
+	req->removed = true;
+	bt_att_cancel(req->client->att, req->att_id);
+}
+
+bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
+{
+	if (!client || !client->att)
+		return false;
+
+	queue_remove_all(client->pending_requests, NULL, NULL, cancel_request);
+
+	return true;
+}
+
 struct read_op {
 	bt_gatt_client_read_callback_t callback;
 	void *user_data;
@@ -1619,7 +1730,8 @@ static void destroy_read_op(void *data)
 static void read_cb(uint8_t opcode, const void *pdu, uint16_t length,
 								void *user_data)
 {
-	struct read_op *op = user_data;
+	struct request *req = user_data;
+	struct read_op *op = req->data;
 	bool success;
 	uint8_t att_ecode = 0;
 	const uint8_t *value = NULL;
@@ -1646,42 +1758,56 @@ done:
 		op->callback(success, att_ecode, value, length, op->user_data);
 }
 
-bool bt_gatt_client_read_value(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_read_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy)
 {
+	struct request *req;
 	struct read_op *op;
 	uint8_t pdu[2];
 
 	if (!client)
-		return false;
+		return 0;
 
 	op = new0(struct read_op, 1);
 	if (!op)
-		return false;
+		return 0;
+
+	req = request_create(client);
+	if (!req) {
+		free(op);
+		return 0;
+	}
 
 	op->callback = callback;
 	op->user_data = user_data;
 	op->destroy = destroy;
 
+	req->data = op;
+	req->destroy = destroy_read_op;
+
 	put_le16(value_handle, pdu);
 
-	if (!bt_att_send(client->att, BT_ATT_OP_READ_REQ, pdu, sizeof(pdu),
-							read_cb, op,
-							destroy_read_op)) {
-		free(op);
-		return false;
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_REQ,
+							pdu, sizeof(pdu),
+							read_cb, req,
+							request_unref);
+	if (!req->att_id) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
 	}
 
-	return true;
+	return req->id;
 }
 
 static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 								void *user_data)
 {
-	struct read_op *op = user_data;
+	struct request *req = user_data;
+	struct read_op *op = req->data;
 	uint8_t att_ecode;
 	bool success;
 
@@ -1704,43 +1830,57 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		op->callback(success, att_ecode, pdu, length, op->user_data);
 }
 
-bool bt_gatt_client_read_multiple(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 					uint16_t *handles, uint8_t num_handles,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy)
 {
 	uint8_t pdu[num_handles * 2];
+	struct request *req;
 	struct read_op *op;
 	int i;
 
 	if (!client)
-		return false;
+		return 0;
 
 	if (num_handles < 2)
-		return false;
+		return 0;
 
 	if (num_handles * 2 > bt_att_get_mtu(client->att) - 1)
-		return false;
+		return 0;
 
 	op = new0(struct read_op, 1);
 	if (!op)
-		return false;
+		return 0;
+
+	req = request_create(client);
+	if (!client) {
+		free(op);
+		return 0;
+	}
 
 	op->callback = callback;
 	op->user_data = user_data;
 	op->destroy = destroy;
 
+	req->data = op;
+	req->destroy = destroy_read_op;
+
 	for (i = 0; i < num_handles; i++)
 		put_le16(handles[i], pdu + (2 * i));
 
-	if (!bt_att_send(client->att, BT_ATT_OP_READ_MULT_REQ, pdu, sizeof(pdu),
-				read_multiple_cb, op, destroy_read_op)) {
-		free(op);
-		return false;
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_MULT_REQ,
+							pdu, sizeof(pdu),
+							read_multiple_cb, req,
+							request_unref);
+	if (!req->att_id) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
 	}
 
-	return true;
+	return req->id;
 }
 
 struct read_long_op {
@@ -1791,20 +1931,10 @@ static void destroy_blob(void *data)
 	free(blob);
 }
 
-static struct read_long_op *read_long_op_ref(struct read_long_op *op)
-{
-	__sync_fetch_and_add(&op->ref_count, 1);
-
-	return op;
-}
-
-static void read_long_op_unref(void *data)
+static void destroy_read_long_op(void *data)
 {
 	struct read_long_op *op = data;
 
-	if (__sync_sub_and_fetch(&op->ref_count, 1))
-		return;
-
 	if (op->destroy)
 		op->destroy(op->user_data);
 
@@ -1853,7 +1983,8 @@ done:
 static void read_long_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	struct read_long_op *op = user_data;
+	struct request *req = user_data;
+	struct read_long_op *op = req->data;
 	struct blob *blob;
 	bool success;
 	uint8_t att_ecode = 0;
@@ -1889,14 +2020,16 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
 		put_le16(op->value_handle, pdu);
 		put_le16(op->offset, pdu + 2);
 
-		if (bt_att_send(op->client->att, BT_ATT_OP_READ_BLOB_REQ,
+		req->att_id = bt_att_send(op->client->att,
+							BT_ATT_OP_READ_BLOB_REQ,
 							pdu, sizeof(pdu),
 							read_long_cb,
-							read_long_op_ref(op),
-							read_long_op_unref))
+							request_ref(req),
+							request_unref);
+		if (req->att_id)
 			return;
 
-		read_long_op_unref(op);
+		request_unref(req);
 		success = false;
 		goto done;
 	}
@@ -1908,26 +2041,34 @@ done:
 	complete_read_long_op(op, success, att_ecode);
 }
 
-bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 					uint16_t value_handle, uint16_t offset,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy)
 {
+	struct request *req;
 	struct read_long_op *op;
 	uint8_t pdu[4];
 
 	if (!client)
-		return false;
+		return 0;
 
 	op = new0(struct read_long_op, 1);
 	if (!op)
-		return false;
+		return 0;
 
 	op->blobs = queue_new();
 	if (!op->blobs) {
 		free(op);
-		return false;
+		return 0;
+	}
+
+	req = request_create(client);
+	if (!req) {
+		queue_destroy(op->blobs, free);
+		free(op);
+		return 0;
 	}
 
 	op->client = client;
@@ -1938,26 +2079,32 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 	op->user_data = user_data;
 	op->destroy = destroy;
 
+	req->data = op;
+	req->destroy = destroy_read_long_op;
+
 	put_le16(value_handle, pdu);
 	put_le16(offset, pdu + 2);
 
-	if (!bt_att_send(client->att, BT_ATT_OP_READ_BLOB_REQ, pdu, sizeof(pdu),
-							read_long_cb,
-							read_long_op_ref(op),
-							read_long_op_unref)) {
-		queue_destroy(op->blobs, free);
-		free(op);
-		return false;
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_BLOB_REQ,
+							pdu, sizeof(pdu),
+							read_long_cb, req,
+							request_unref);
+	if (!req->att_id) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
 	}
 
-	return true;
+	return req->id;
 }
 
-bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_write_without_response(
+					struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bool signed_write,
 					const uint8_t *value, uint16_t length) {
 	uint8_t pdu[2 + length];
+	struct request *req;
 
 	if (!client)
 		return 0;
@@ -1966,11 +2113,22 @@ bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
 	if (signed_write)
 		return 0;
 
+	req = request_create(client);
+	if (!req)
+		return 0;
+
 	put_le16(value_handle, pdu);
 	memcpy(pdu + 2, value, length);
 
-	return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_WRITE_CMD,
+							pdu, sizeof(pdu),
 							NULL, NULL, NULL);
+	if (!req->att_id) {
+		request_unref(req);
+		return 0;
+	}
+
+	return req->id;
 }
 
 struct write_op {
@@ -1992,7 +2150,8 @@ static void destroy_write_op(void *data)
 static void write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 								void *user_data)
 {
-	struct write_op *op = user_data;
+	struct request *req = user_data;
+	struct write_op *op = req->data;
 	bool success = true;
 	uint8_t att_ecode = 0;
 
@@ -2010,38 +2169,51 @@ done:
 		op->callback(success, att_ecode, op->user_data);
 }
 
-bool bt_gatt_client_write_value(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					const uint8_t *value, uint16_t length,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy)
 {
+	struct request *req;
 	struct write_op *op;
 	uint8_t pdu[2 + length];
 
 	if (!client)
-		return false;
+		return 0;
 
 	op = new0(struct write_op, 1);
 	if (!op)
-		return false;
+		return 0;
+
+	req = request_create(client);
+	if (!req) {
+		free(op);
+		return 0;
+	}
 
 	op->callback = callback;
 	op->user_data = user_data;
 	op->destroy = destroy;
 
+	req->data = op;
+	req->destroy = destroy_write_op;
+
 	put_le16(value_handle, pdu);
 	memcpy(pdu + 2, value, length);
 
-	if (!bt_att_send(client->att, BT_ATT_OP_WRITE_REQ, pdu, sizeof(pdu),
-							write_cb, op,
-							destroy_write_op)) {
-		free(op);
-		return false;
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_WRITE_REQ,
+							pdu, sizeof(pdu),
+							write_cb, req,
+							request_unref);
+	if (!req->att_id) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
 	}
 
-	return true;
+	return req->id;
 }
 
 struct long_write_op {
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 42eeaec..74d781c 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -72,27 +72,31 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 
 uint16_t bt_gatt_client_get_mtu(struct bt_gatt_client *client);
 
-bool bt_gatt_client_read_value(struct bt_gatt_client *client,
+bool bt_gatt_client_cancel(struct bt_gatt_client *client, unsigned int id);
+bool bt_gatt_client_cancel_all(struct bt_gatt_client *client);
+
+unsigned int bt_gatt_client_read_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
-bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 					uint16_t value_handle, uint16_t offset,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
-bool bt_gatt_client_read_multiple(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 					uint16_t *handles, uint8_t num_handles,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
 
-bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_write_without_response(
+					struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bool signed_write,
 					const uint8_t *value, uint16_t length);
-bool bt_gatt_client_write_value(struct bt_gatt_client *client,
+unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					const uint8_t *value, uint16_t length,
 					bt_gatt_client_callback_t callback,
-- 
2.2.0.rc0.207.ga3a616c

