Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 4/7] shared/gatt-client: Add write prepare and execute
Date: Fri,  6 Mar 2015 14:10:42 +0100
Message-Id: <1425647445-19722-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1425647445-19722-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1425647445-19722-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For Android we need explicit write prepare and execute commands in GATT
client. This patch adds that.

Note that till now prepare and execute has been used only in long
write.

With this patch it is possible to start reliable write session by
the gatt-client. First write prepare will return session ID which shall
be used in follow up write prepare request and write execute.
---
 src/shared/gatt-client.c | 261 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h |  13 +++
 2 files changed, 274 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index acb6200..6154dcf 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -77,6 +77,8 @@ struct bt_gatt_client {
 	struct queue *long_write_queue;
 	bool in_long_write;
 
+	unsigned int reliable_write_session_id;
+
 	/* List of registered disconnect/notification/indication callbacks */
 	struct queue *notify_list;
 	struct queue *notify_chrcs;
@@ -2211,6 +2213,7 @@ unsigned int bt_gatt_client_write_without_response(
 }
 
 struct write_op {
+	struct bt_gatt_client *client;
 	bt_gatt_client_callback_t callback;
 	void *user_data;
 	bt_gatt_destroy_func_t destroy;
@@ -2596,6 +2599,264 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 	return req->id;
 }
 
+struct prep_write_op {
+	bt_gatt_client_write_long_callback_t callback;
+	void *user_data;
+	bt_gatt_destroy_func_t destroy;
+	uint8_t *pdu;
+	uint16_t pdu_len;
+};
+
+static void destroy_prep_write_op(void *data)
+{
+	struct prep_write_op *op = data;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op->pdu);
+	free(op);
+}
+
+static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct request *req = user_data;
+	struct prep_write_op *op = req->data;
+	bool success;
+	uint8_t att_ecode;
+	bool reliable_error;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		reliable_error = false;
+		att_ecode = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_PREP_WRITE_RSP) {
+		success = false;
+		reliable_error = false;
+		att_ecode = 0;
+		goto done;
+	}
+
+	if (!pdu || length != op->pdu_len ||
+					memcmp(pdu, op->pdu, op->pdu_len)) {
+		success = false;
+		reliable_error = true;
+		att_ecode = 0;
+		goto done;
+	}
+
+	success = true;
+	reliable_error = false;
+	att_ecode = 0;
+
+done:
+	if (op->callback)
+		op->callback(success, reliable_error, att_ecode, op->user_data);
+}
+
+static struct request *get_reliable_request(struct bt_gatt_client *client,
+							unsigned int id)
+{
+	struct request *req;
+	struct prep_write_op *op;
+
+	op = new0(struct prep_write_op, 1);
+	if (!op)
+		return NULL;
+
+	/* Following prepare writes */
+	if (id != 0)
+		req = queue_find(client->pending_requests, match_req_id,
+							UINT_TO_PTR(id));
+	else
+		req = request_create(client);
+
+	if (!req) {
+		free(op);
+		return NULL;
+	}
+
+	req->data = op;
+
+	return req;
+}
+
+unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
+				unsigned int id, uint16_t value_handle,
+				uint16_t offset, uint8_t *value,
+				uint16_t length,
+				bt_gatt_client_write_long_callback_t callback,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy)
+{
+	struct request *req;
+	struct prep_write_op *op;
+	uint8_t pdu[4 + length];
+
+	if (!client)
+		return 0;
+
+	if (client->in_long_write)
+		return 0;
+
+	/*
+	 * Make sure that client who owns reliable session continues with
+	 * prepare writes or this is brand new reliable session (id == 0)
+	 */
+	if (id != client->reliable_write_session_id) {
+		util_debug(client->debug_callback, client->debug_data,
+			"There is other reliable write session ongoing %u",
+			client->reliable_write_session_id);
+
+		return 0;
+	}
+
+	req = get_reliable_request(client, id);
+	if (!req)
+		return 0;
+
+	op = (struct prep_write_op *)req->data;
+
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	req->destroy = destroy_prep_write_op;
+
+	put_le16(value_handle, pdu);
+	put_le16(offset, pdu + 2);
+	memcpy(pdu + 4, value, length);
+
+	/*
+	 * Before sending command we need to remember pdu as we need to validate
+	 * it in the response. Store handle, offset and value. Therefore
+	 * increase length by 4 (handle + offset) as we need it in couple places
+	 * below
+	 */
+	length += 4;
+
+	op->pdu = malloc(length);
+	if (!op->pdu) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
+	}
+
+	memcpy(op->pdu, pdu, length);
+	op->pdu_len = length;
+
+	/*
+	 * Now we are ready to send command
+	 * Note that request_unref will be done on write execute
+	 */
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ, pdu,
+					sizeof(pdu), prep_write_cb, req,
+					NULL);
+	if (!req->att_id) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
+	}
+
+	/*
+	 * Store first request id for prepare write and treat it as a session id
+	 * valid until write execute is done
+	 */
+	if (client->reliable_write_session_id == 0)
+		client->reliable_write_session_id = req->id;
+
+	return client->reliable_write_session_id;
+}
+
+static void exec_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct request *req = user_data;
+	struct write_op *op = req->data;
+	bool success;
+	uint8_t att_ecode;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length) {
+		success = false;
+		att_ecode = 0;
+		goto done;
+	}
+
+	success = true;
+	att_ecode = 0;
+
+done:
+	if (op->callback)
+		op->callback(success, att_ecode, op->user_data);
+
+	op->client->reliable_write_session_id = 0;
+
+	start_next_long_write(op->client);
+}
+
+unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
+					bool execute,
+					unsigned int id,
+					bt_gatt_client_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy)
+{
+	struct request *req;
+	struct write_op *op;
+	uint8_t pdu;
+
+	if (!client)
+		return 0;
+
+	if (client->in_long_write)
+		return 0;
+
+	if (client->reliable_write_session_id != id)
+		return 0;
+
+	op = new0(struct write_op, 1);
+	if (!op)
+		return 0;
+
+	req = queue_find(client->pending_requests, match_req_id,
+							UINT_TO_PTR(id));
+	if (!req) {
+		free(op);
+		return 0;
+	}
+
+	op->client = client;
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	pdu = execute ? 0x01 : 0x00;
+
+	req->data = op;
+	req->destroy = destroy_write_op;
+
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu,
+						sizeof(pdu), exec_write_cb,
+						req, request_unref);
+	if (!req->att_id) {
+		op->destroy = NULL;
+		request_unref(req);
+		return 0;
+	}
+
+	return id;
+}
+
 static bool match_notify_chrc_value_handle(const void *a, const void *b)
 {
 	const struct notify_chrc *chrc = a;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index d4358cf..27cf7cc 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -108,6 +108,19 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 				bt_gatt_client_write_long_callback_t callback,
 				void *user_data,
 				bt_gatt_client_destroy_func_t destroy);
+unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
+				unsigned int id,
+				uint16_t value_handle, uint16_t offset,
+				uint8_t *value, uint16_t length,
+				bt_gatt_client_write_long_callback_t callback,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy);
+unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
+					bool execute,
+					unsigned int id,
+					bt_gatt_client_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
 
 unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				uint16_t chrc_value_handle,
-- 
1.8.4

