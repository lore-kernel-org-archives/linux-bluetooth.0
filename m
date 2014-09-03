Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 04/10] shared/gatt-client: Added bt_gatt_client_write_long_value.
Date: Wed,  3 Sep 2014 12:46:05 -0700
Message-Id: <1409773571-28417-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moved the bt_gatt_write_long_value function from shared/gatt-helpers to
shared/gatt-client as bt_gatt_client_write_long_value.

Multiple requests to start a long write operation are queued by bt_gatt_client.
This is to avoid canceling a prepared write to an unintended handle as well as
to prevent multiple long write requests to the same handle from resulting in an
unintended attribute value due to interleaving.
---
 src/shared/gatt-client.c  | 318 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h  |  10 ++
 src/shared/gatt-helpers.c | 247 -----------------------------------
 src/shared/gatt-helpers.h |  10 --
 4 files changed, 328 insertions(+), 257 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 764cc75..101e47e 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -32,6 +32,10 @@
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
 #endif
 
+#ifndef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 #define UUID_BYTES (BT_GATT_UUID_SIZE * sizeof(uint8_t))
 
 struct service_list {
@@ -54,6 +58,15 @@ struct bt_gatt_client {
 	struct service_list *svc_head, *svc_tail;
 	bool in_init;
 	bool ready;
+
+	/* Queue of long write requests. An error during "prepare write"
+	 * requests can result in a cancel through "execute write". To prevent
+	 * cancelation of prepared writes to the wrong attribute and multiple
+	 * requests to the same attribute that may result in a corrupted final
+	 * value, we avoid interleaving prepared writes.
+	 */
+	struct queue *long_write_queue;
+	bool in_long_write;
 };
 
 static bool gatt_client_add_service(struct bt_gatt_client *client,
@@ -513,6 +526,12 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 	if (!client)
 		return NULL;
 
+	client->long_write_queue = queue_new();
+	if (!client->long_write_queue) {
+		free(client);
+		return NULL;
+	}
+
 	client->att = bt_att_ref(att);
 
 	gatt_client_init(client, mtu);
@@ -530,6 +549,8 @@ struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client)
 	return client;
 }
 
+static void long_write_op_unref(void *data);
+
 void bt_gatt_client_unref(struct bt_gatt_client *client)
 {
 	if (!client)
@@ -544,6 +565,7 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 	if (client->debug_destroy)
 		client->debug_destroy(client->debug_data);
 
+	queue_destroy(client->long_write_queue, long_write_op_unref);
 	bt_att_unref(client->att);
 	free(client);
 }
@@ -1038,3 +1060,299 @@ bool bt_gatt_client_write_value(struct bt_gatt_client *client,
 
 	return true;
 }
+
+struct long_write_op {
+	struct bt_gatt_client *client;
+	int ref_count;
+	bool reliable;
+	bool success;
+	uint8_t att_ecode;
+	bool reliable_error;
+	uint16_t value_handle;
+	uint8_t *value;
+	uint16_t length;
+	uint16_t offset;
+	uint16_t index;
+	uint16_t cur_length;
+	bt_gatt_client_write_long_callback_t callback;
+	void *user_data;
+	bt_gatt_client_destroy_func_t destroy;
+};
+
+static struct long_write_op *long_write_op_ref(struct long_write_op *op)
+{
+	__sync_fetch_and_add(&op->ref_count, 1);
+
+	return op;
+}
+
+static void long_write_op_unref(void *data)
+{
+	struct long_write_op *op = data;
+
+	if (__sync_sub_and_fetch(&op->ref_count, 1))
+		return;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op->value);
+	free(op);
+}
+
+static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
+							void *user_data);
+static void complete_write_long_op(struct long_write_op *op, bool success,
+					uint8_t att_ecode, bool reliable_error);
+
+static void handle_next_prep_write(struct long_write_op *op)
+{
+	bool success = true;
+	uint8_t *pdu;
+
+	pdu = malloc(op->cur_length + 4);
+	if (!pdu) {
+		success = false;
+		goto done;
+	}
+
+	put_le16(op->value_handle, pdu);
+	put_le16(op->offset + op->index, pdu + 2);
+	memcpy(pdu + 4, op->value + op->index, op->cur_length);
+
+	if (!bt_att_send(op->client->att, BT_ATT_OP_PREP_WRITE_REQ,
+							pdu, op->cur_length + 4,
+							prepare_write_cb,
+							long_write_op_ref(op),
+							long_write_op_unref)) {
+		long_write_op_unref(op);
+		success = false;
+	}
+
+	free(pdu);
+
+	/* If so far successful, then the operation should continue.
+	 * Otherwise, there was an error and the procedure should be
+	 * completed.
+	 */
+	if (success)
+		return;
+
+done:
+	complete_write_long_op(op, success, 0, false);
+}
+
+static void start_next_long_write(struct bt_gatt_client *client)
+{
+	struct long_write_op *op;
+
+	if (queue_isempty(client->long_write_queue)) {
+		client->in_long_write = false;
+		return;
+	}
+
+	op = queue_pop_head(client->long_write_queue);
+	if (!op)
+		return;
+
+	handle_next_prep_write(op);
+
+	/* send_next_prep_write adds an extra ref. Unref here to clean up if
+	 * necessary, since we also added a ref before pushing to the queue.
+	 */
+	long_write_op_unref(op);
+}
+
+static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct long_write_op *op = user_data;
+	bool success = op->success;
+	uint8_t att_ecode = op->att_ecode;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+	} else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
+		success = false;
+
+	if (op->callback)
+		op->callback(success, op->reliable_error, att_ecode,
+								op->user_data);
+
+	start_next_long_write(op->client);
+}
+
+static void complete_write_long_op(struct long_write_op *op, bool success,
+					uint8_t att_ecode, bool reliable_error)
+{
+	uint8_t pdu;
+
+	op->success = success;
+	op->att_ecode = att_ecode;
+	op->reliable_error = reliable_error;
+
+	if (success)
+		pdu = 0x01;  /* Write */
+	else
+		pdu = 0x00;  /* Cancel */
+
+	if (bt_att_send(op->client->att, BT_ATT_OP_EXEC_WRITE_REQ,
+							&pdu, sizeof(pdu),
+							execute_write_cb,
+							long_write_op_ref(op),
+							long_write_op_unref))
+		return;
+
+	long_write_op_unref(op);
+	success = false;
+
+	if (op->callback)
+		op->callback(success, reliable_error, att_ecode, op->user_data);
+
+	start_next_long_write(op->client);
+}
+
+static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct long_write_op *op = user_data;
+	bool success = true;
+	bool reliable_error = false;
+	uint8_t att_ecode = 0;
+	uint16_t next_index;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_PREP_WRITE_RSP) {
+		success = false;
+		goto done;
+	}
+
+	if (op->reliable) {
+		if (!pdu || length != (op->cur_length + 4)) {
+			success = false;
+			reliable_error = true;
+			goto done;
+		}
+
+		if (get_le16(pdu) != op->value_handle ||
+				get_le16(pdu + 2) != (op->offset + op->index)) {
+			success = false;
+			reliable_error = true;
+			goto done;
+		}
+
+		if (memcmp(pdu + 4, op->value + op->index, op->cur_length)) {
+			success = false;
+			reliable_error = true;
+			goto done;
+		}
+	}
+
+	next_index = op->index + op->cur_length;
+	if (next_index == op->length) {
+		/* All bytes written */
+		goto done;
+	}
+
+	/* If the last written length was greater than or equal to what can fit
+	 * inside a PDU, then there is more data to send.
+	 */
+	if (op->cur_length >= bt_att_get_mtu(op->client->att) - 5) {
+		op->index = next_index;
+		op->cur_length = MIN(op->length - op->index,
+					bt_att_get_mtu(op->client->att) - 5);
+		handle_next_prep_write(op);
+		return;
+	}
+
+done:
+	complete_write_long_op(op, success, att_ecode, reliable_error);
+}
+
+bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
+				bool reliable,
+				uint16_t value_handle, uint16_t offset,
+				uint8_t *value, uint16_t length,
+				bt_gatt_client_write_long_callback_t callback,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy)
+{
+	struct long_write_op *op;
+	uint8_t *pdu;
+	bool status;
+
+	if (!client)
+		return false;
+
+	if ((size_t)(length + offset) > UINT16_MAX)
+		return false;
+
+	/* Don't allow writing a 0-length value using this procedure. The
+	 * upper-layer should use bt_gatt_write_value for that instead.
+	 */
+	if (!length || !value)
+		return false;
+
+	op = new0(struct long_write_op, 1);
+	if (!op)
+		return false;
+
+	op->value = malloc(length);
+	if (!op->value) {
+		free(op);
+		return false;
+	}
+
+	memcpy(op->value, value, length);
+
+	op->client = client;
+	op->reliable = reliable;
+	op->value_handle = value_handle;
+	op->length = length;
+	op->offset = offset;
+	op->cur_length = MIN(length, bt_att_get_mtu(client->att) - 5);
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	if (client->in_long_write) {
+		queue_push_tail(client->long_write_queue,
+						long_write_op_ref(op));
+		return true;
+	}
+
+	pdu = malloc(op->cur_length + 4);
+	if (!pdu) {
+		free(op->value);
+		free(op);
+		return false;
+	}
+
+	put_le16(value_handle, pdu);
+	put_le16(offset, pdu + 2);
+	memcpy(pdu + 4, op->value, op->cur_length);
+
+	status = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ,
+							pdu, op->cur_length + 4,
+							prepare_write_cb,
+							long_write_op_ref(op),
+							long_write_op_unref);
+
+	free(pdu);
+
+	if (!status) {
+		free(op->value);
+		free(op);
+		return false;
+	}
+
+	client->in_long_write = true;
+
+	return true;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index c3b3e20..8b0d334 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -38,6 +38,9 @@ typedef void (*bt_gatt_client_destroy_func_t)(void *user_data);
 typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
 typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_gatt_client_write_long_callback_t)(bool success,
+					bool reliable_error, uint8_t att_ecode,
+					void *user_data);
 
 bool bt_gatt_client_is_ready(struct bt_gatt_client *client);
 bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
@@ -113,3 +116,10 @@ bool bt_gatt_client_write_value(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
+bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
+				bool reliable,
+				uint16_t value_handle, uint16_t offset,
+				uint8_t *value, uint16_t length,
+				bt_gatt_client_write_long_callback_t callback,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy);
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 0331851..ede6a67 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -912,253 +912,6 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 	return true;
 }
 
-struct write_long_op {
-	struct bt_att *att;
-	int ref_count;
-	bool reliable;
-	bool success;
-	uint8_t att_ecode;
-	bool reliable_error;
-	uint16_t value_handle;
-	uint8_t *value;
-	uint16_t length;
-	uint16_t offset;
-	uint16_t index;
-	uint16_t cur_length;
-	bt_gatt_write_long_callback_t callback;
-	void *user_data;
-	bt_gatt_destroy_func_t destroy;
-};
-
-static struct write_long_op *write_long_op_ref(struct write_long_op *op)
-{
-	__sync_fetch_and_add(&op->ref_count, 1);
-
-	return op;
-}
-
-static void write_long_op_unref(void *data)
-{
-	struct write_long_op *op = data;
-
-	if (__sync_sub_and_fetch(&op->ref_count, 1))
-		return;
-
-	if (op->destroy)
-		op->destroy(op->user_data);
-
-	free(op->value);
-	free(op);
-}
-
-static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
-								void *user_data)
-{
-	struct write_long_op *op = user_data;
-	bool success = op->success;
-	uint8_t att_ecode = op->att_ecode;
-
-	if (opcode == BT_ATT_OP_ERROR_RSP) {
-		success = false;
-		att_ecode = process_error(pdu, length);
-	} else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
-		success = false;
-
-	if (op->callback)
-		op->callback(success, op->reliable_error, att_ecode,
-								op->user_data);
-}
-
-static void complete_write_long_op(struct write_long_op *op, bool success,
-					uint8_t att_ecode, bool reliable_error)
-{
-	uint8_t pdu;
-
-	op->success = success;
-	op->att_ecode = att_ecode;
-	op->reliable_error = reliable_error;
-
-	if (success)
-		pdu = 0x01;  /* Write */
-	else
-		pdu = 0x00;  /* Cancel */
-
-	if (bt_att_send(op->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu, sizeof(pdu),
-						execute_write_cb,
-						write_long_op_ref(op),
-						write_long_op_unref))
-		return;
-
-	write_long_op_unref(op);
-	success = false;
-
-	if (op->callback)
-		op->callback(success, reliable_error, att_ecode, op->user_data);
-}
-
-static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
-								void *user_data)
-{
-	struct write_long_op *op = user_data;
-	bool success = true;
-	bool reliable_error = false;
-	uint8_t att_ecode = 0;
-	uint16_t next_index;
-
-	if (opcode == BT_ATT_OP_ERROR_RSP) {
-		success = false;
-		att_ecode = process_error(pdu, length);
-		goto done;
-	}
-
-	if (opcode != BT_ATT_OP_PREP_WRITE_RSP) {
-		success = false;
-		goto done;
-	}
-
-	if (op->reliable) {
-		if (!pdu || length != (op->cur_length + 4)) {
-			success = false;
-			reliable_error = true;
-			goto done;
-		}
-
-		if (get_le16(pdu) != op->value_handle ||
-				get_le16(pdu + 2) != (op->offset + op->index)) {
-			success = false;
-			reliable_error = true;
-			goto done;
-		}
-
-		if (memcmp(pdu + 4, op->value + op->index, op->cur_length)) {
-			success = false;
-			reliable_error = true;
-			goto done;
-		}
-	}
-
-	next_index = op->index + op->cur_length;
-	if (next_index == op->length) {
-		/* All bytes written */
-		goto done;
-	}
-
-	/* If the last written length greater than or equal to what can fit
-	 * inside a PDU, then there is more data to send.
-	 */
-	if (op->cur_length >= bt_att_get_mtu(op->att) - 5) {
-		uint8_t *pdu;
-
-		op->index = next_index;
-		op->cur_length = MIN(op->length - op->index,
-						bt_att_get_mtu(op->att) - 5);
-
-		pdu = malloc(op->cur_length + 4);
-		if (!pdu) {
-			success = false;
-			goto done;
-		}
-
-		put_le16(op->value_handle, pdu);
-		put_le16(op->offset + op->index, pdu + 2);
-		memcpy(pdu + 4, op->value + op->index, op->cur_length);
-
-		if (!bt_att_send(op->att, BT_ATT_OP_PREP_WRITE_REQ,
-							pdu, op->cur_length + 4,
-							prepare_write_cb,
-							write_long_op_ref(op),
-							write_long_op_unref)) {
-			write_long_op_unref(op);
-			success = false;
-		}
-
-		free(pdu);
-
-		/* If so far successful, then the operation should continue.
-		 * Otherwise, there was an error and the procedure should be
-		 * completed.
-		 */
-		if (success)
-			return;
-	}
-
-done:
-	complete_write_long_op(op, success, att_ecode, reliable_error);
-}
-
-bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
-					uint16_t value_handle, uint16_t offset,
-					uint8_t *value, uint16_t length,
-					bt_gatt_write_long_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy)
-{
-	struct write_long_op *op;
-	uint8_t *pdu;
-	bool status;
-
-	if (!att)
-		return false;
-
-	if ((size_t)(length + offset) > UINT16_MAX)
-		return false;
-
-	/* Don't allow riting a 0-length value using this procedure. The
-	 * upper-layer should use bt_gatt_write_value for that instead.
-	 */
-	if (!length || !value)
-		return false;
-
-	op = new0(struct write_long_op, 1);
-	if (!op)
-		return false;
-
-	op->value = malloc(length);
-	if (!op->value) {
-		free(op);
-		return false;
-	}
-
-	memcpy(op->value, value, length);
-
-	op->att = att;
-	op->reliable = reliable;
-	op->value_handle = value_handle;
-	op->length = length;
-	op->offset = offset;
-	op->cur_length = MIN(length, bt_att_get_mtu(att) - 5);
-	op->callback = callback;
-	op->user_data = user_data;
-	op->destroy = destroy;
-
-	pdu = malloc(op->cur_length + 4);
-	if (!pdu) {
-		free(op->value);
-		free(op);
-		return false;
-	}
-
-	put_le16(value_handle, pdu);
-	put_le16(offset, pdu + 2);
-	memcpy(pdu + 4, op->value, op->cur_length);
-
-	status = bt_att_send(att, BT_ATT_OP_PREP_WRITE_REQ,
-							pdu, op->cur_length + 4,
-							prepare_write_cb,
-							write_long_op_ref(op),
-							write_long_op_unref);
-
-	free(pdu);
-
-	if (!status) {
-		free(op->value);
-		free(op);
-		return false;
-	}
-
-	return true;
-}
-
 struct notify_data {
 	struct bt_att *att;
 	bt_gatt_notify_callback_t callback;
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index a8e5f98..75ad4b0 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -57,8 +57,6 @@ typedef void (*bt_gatt_result_callback_t)(bool success, uint8_t att_ecode,
 typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
-typedef void (*bt_gatt_write_long_callback_t)(bool success, bool reliable_error,
-					uint8_t att_ecode, void *user_data);
 
 typedef void (*bt_gatt_notify_callback_t)(uint16_t value_handle,
 					const uint8_t *value, uint16_t length,
@@ -90,14 +88,6 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
 
-
-bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
-					uint16_t value_handle, uint16_t offset,
-					uint8_t *value, uint16_t length,
-					bt_gatt_write_long_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy);
-
 unsigned int bt_gatt_register(struct bt_att *att, bool indications,
 					bt_gatt_notify_callback_t callback,
 					void *user_data,
-- 
2.1.0.rc2.206.gedb03e5

