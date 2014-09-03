Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 02/10] shared/gatt-client: Added bt_gatt_client_read_long_value.
Date: Wed,  3 Sep 2014 12:46:03 -0700
Message-Id: <1409773571-28417-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moved the bt_gatt_read_long_value function from shared/gatt-helpers to
shared/gatt-client as bt_gatt_client_read_long_value.
---
 src/shared/gatt-client.c  | 211 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h  |   5 ++
 src/shared/gatt-helpers.c | 210 ---------------------------------------------
 src/shared/gatt-helpers.h |   9 --
 4 files changed, 216 insertions(+), 219 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 45ea2c3..b839db1 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -26,6 +26,7 @@
 #include "lib/uuid.h"
 #include "src/shared/gatt-helpers.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #ifndef MAX
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
@@ -736,3 +737,213 @@ bool bt_gatt_client_read_value(struct bt_gatt_client *client,
 
 	return true;
 }
+
+struct read_long_op {
+	struct bt_gatt_client *client;
+	int ref_count;
+	uint16_t value_handle;
+	size_t orig_offset;
+	size_t offset;
+	struct queue *blobs;
+	bt_gatt_client_read_callback_t callback;
+	void *user_data;
+	bt_gatt_client_destroy_func_t destroy;
+};
+
+struct blob {
+	uint8_t *data;
+	uint16_t offset;
+	uint16_t length;
+};
+
+static struct blob *create_blob(const uint8_t *data, uint16_t len,
+								uint16_t offset)
+{
+	struct blob *blob;
+
+	blob = new0(struct blob, 1);
+	if (!blob)
+		return NULL;
+
+	blob->data = malloc(len);
+	if (!blob->data) {
+		free(blob);
+		return NULL;
+	}
+
+	memcpy(blob->data, data, len);
+	blob->length = len;
+	blob->offset = offset;
+
+	return blob;
+}
+
+static void destroy_blob(void *data)
+{
+	struct blob *blob = data;
+
+	free(blob->data);
+	free(blob);
+}
+
+static struct read_long_op *read_long_op_ref(struct read_long_op *op)
+{
+	__sync_fetch_and_add(&op->ref_count, 1);
+
+	return op;
+}
+
+static void read_long_op_unref(void *data)
+{
+	struct read_long_op *op = data;
+
+	if (__sync_sub_and_fetch(&op->ref_count, 1))
+		return;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	queue_destroy(op->blobs, destroy_blob);
+
+	free(op);
+}
+
+static void append_blob(void *data, void *user_data)
+{
+	struct blob *blob = data;
+	uint8_t *value = user_data;
+
+	memcpy(value + blob->offset, blob->data, blob->length);
+}
+
+static void complete_read_long_op(struct read_long_op *op, bool success,
+							uint8_t att_ecode)
+{
+	uint8_t *value = NULL;
+	uint16_t length = 0;
+
+	if (!success)
+		goto done;
+
+	length = op->offset - op->orig_offset;
+
+	if (!length)
+		goto done;
+
+	value = malloc(length);
+	if (!value) {
+		success = false;
+		goto done;
+	}
+
+	queue_foreach(op->blobs, append_blob, value - op->orig_offset);
+
+done:
+	if (op->callback)
+		op->callback(success, att_ecode, value, length, op->user_data);
+
+	free(value);
+}
+
+static void read_long_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct read_long_op *op = user_data;
+	struct blob *blob;
+	bool success;
+	uint8_t att_ecode = 0;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_READ_BLOB_RSP || (!pdu && length)) {
+		success = false;
+		goto done;
+	}
+
+	if (!length)
+		goto success;
+
+	blob = create_blob(pdu, length, op->offset);
+	if (!blob) {
+		success = false;
+		goto done;
+	}
+
+	queue_push_tail(op->blobs, blob);
+	op->offset += length;
+	if (op->offset > UINT16_MAX)
+		goto success;
+
+	if (length >= bt_att_get_mtu(op->client->att) - 1) {
+		uint8_t pdu[4];
+
+		put_le16(op->value_handle, pdu);
+		put_le16(op->offset, pdu + 2);
+
+		if (bt_att_send(op->client->att, BT_ATT_OP_READ_BLOB_REQ,
+							pdu, sizeof(pdu),
+							read_long_cb,
+							read_long_op_ref(op),
+							read_long_op_unref))
+			return;
+
+		read_long_op_unref(op);
+		success = false;
+		goto done;
+	}
+
+success:
+	success = true;
+
+done:
+	complete_read_long_op(op, success, att_ecode);
+}
+
+bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
+					uint16_t value_handle, uint16_t offset,
+					bt_gatt_client_read_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy)
+{
+	struct read_long_op *op;
+	uint8_t pdu[4];
+
+	if (!client)
+		return false;
+
+	op = new0(struct read_long_op, 1);
+	if (!op)
+		return false;
+
+	op->blobs = queue_new();
+	if (!op->blobs) {
+		free(op);
+		return false;
+	}
+
+	op->client = client;
+	op->value_handle = value_handle;
+	op->orig_offset = offset;
+	op->offset = offset;
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	put_le16(value_handle, pdu);
+	put_le16(offset, pdu + 2);
+
+	if (!bt_att_send(client->att, BT_ATT_OP_READ_BLOB_REQ, pdu, sizeof(pdu),
+							read_long_cb,
+							read_long_op_ref(op),
+							read_long_op_unref)) {
+		queue_destroy(op->blobs, free);
+		free(op);
+		return false;
+	}
+
+	return true;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index b7ec84a..bcb8ab1 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -97,3 +97,8 @@ bool bt_gatt_client_read_value(struct bt_gatt_client *client,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
+bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
+					uint16_t value_handle, uint16_t offset,
+					bt_gatt_client_read_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 763292f..81fb039 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -912,216 +912,6 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 	return true;
 }
 
-struct read_long_op {
-	struct bt_att *att;
-	int ref_count;
-	uint16_t value_handle;
-	size_t orig_offset;
-	size_t offset;
-	struct queue *blobs;
-	bt_gatt_read_callback_t callback;
-	void *user_data;
-	bt_gatt_destroy_func_t destroy;
-};
-
-struct blob {
-	uint8_t *data;
-	uint16_t offset;
-	uint16_t length;
-};
-
-static struct blob *create_blob(const uint8_t *data, uint16_t len,
-								uint16_t offset)
-{
-	struct blob *blob;
-
-	blob = new0(struct blob, 1);
-	if (!blob)
-		return NULL;
-
-	blob->data = malloc(len);
-	if (!blob->data) {
-		free(blob);
-		return NULL;
-	}
-
-	memcpy(blob->data, data, len);
-	blob->length = len;
-	blob->offset = offset;
-
-	return blob;
-}
-
-static void destroy_blob(void *data)
-{
-	struct blob *blob = data;
-
-	free(blob->data);
-	free(blob);
-}
-
-static struct read_long_op *read_long_op_ref(struct read_long_op *op)
-{
-	__sync_fetch_and_add(&op->ref_count, 1);
-
-	return op;
-}
-
-static void read_long_op_unref(void *data)
-{
-	struct read_long_op *op = data;
-
-	if (__sync_sub_and_fetch(&op->ref_count, 1))
-		return;
-
-	if (op->destroy)
-		op->destroy(op->user_data);
-
-	queue_destroy(op->blobs, destroy_blob);
-
-	free(op);
-}
-
-static void append_blob(void *data, void *user_data)
-{
-	struct blob *blob = data;
-	uint8_t *value = user_data;
-
-	memcpy(value + blob->offset, blob->data, blob->length);
-}
-
-static void complete_read_long_op(struct read_long_op *op, bool success,
-							uint8_t att_ecode)
-{
-	uint8_t *value = NULL;
-	uint16_t length = 0;
-
-	if (!success)
-		goto done;
-
-	length = op->offset - op->orig_offset;
-
-	if (!length)
-		goto done;
-
-	value = malloc(length);
-	if (!value) {
-		success = false;
-		goto done;
-	}
-
-	queue_foreach(op->blobs, append_blob, value - op->orig_offset);
-
-done:
-	if (op->callback)
-		op->callback(success, att_ecode, value, length, op->user_data);
-
-	free(value);
-}
-
-static void read_long_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
-{
-	struct read_long_op *op = user_data;
-	struct blob *blob;
-	bool success;
-	uint8_t att_ecode = 0;
-
-	if (opcode == BT_ATT_OP_ERROR_RSP) {
-		success = false;
-		att_ecode = process_error(pdu, length);
-		goto done;
-	}
-
-	if (opcode != BT_ATT_OP_READ_BLOB_RSP || (!pdu && length)) {
-		success = false;
-		goto done;
-	}
-
-	if (!length)
-		goto success;
-
-	blob = create_blob(pdu, length, op->offset);
-	if (!blob) {
-		success = false;
-		goto done;
-	}
-
-	queue_push_tail(op->blobs, blob);
-	op->offset += length;
-	if (op->offset > UINT16_MAX)
-		goto success;
-
-	if (length >= bt_att_get_mtu(op->att) - 1) {
-		uint8_t pdu[4];
-
-		put_le16(op->value_handle, pdu);
-		put_le16(op->offset, pdu + 2);
-
-		if (bt_att_send(op->att, BT_ATT_OP_READ_BLOB_REQ,
-							pdu, sizeof(pdu),
-							read_long_cb,
-							read_long_op_ref(op),
-							read_long_op_unref))
-			return;
-
-		read_long_op_unref(op);
-		success = false;
-		goto done;
-	}
-
-success:
-	success = true;
-
-done:
-	complete_read_long_op(op, success, att_ecode);
-}
-
-bool bt_gatt_read_long_value(struct bt_att *att,
-					uint16_t value_handle, uint16_t offset,
-					bt_gatt_read_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy)
-{
-	struct read_long_op *op;
-	uint8_t pdu[4];
-
-	if (!att)
-		return false;
-
-	op = new0(struct read_long_op, 1);
-	if (!op)
-		return false;
-
-	op->blobs = queue_new();
-	if (!op->blobs) {
-		free(op);
-		return false;
-	}
-
-	op->att = att;
-	op->value_handle = value_handle;
-	op->orig_offset = offset;
-	op->offset = offset;
-	op->callback = callback;
-	op->user_data = user_data;
-	op->destroy = destroy;
-
-	put_le16(value_handle, pdu);
-	put_le16(offset, pdu + 2);
-
-	if (!bt_att_send(att, BT_ATT_OP_READ_BLOB_REQ, pdu, sizeof(pdu),
-							read_long_cb,
-							read_long_op_ref(op),
-							read_long_op_unref)) {
-		queue_destroy(op->blobs, free);
-		free(op);
-		return false;
-	}
-
-	return true;
-}
-
 bool bt_gatt_write_without_response(struct bt_att *att,
 					uint16_t value_handle,
 					bool signed_write,
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 1433a68..60feeaa 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -57,9 +57,6 @@ typedef void (*bt_gatt_result_callback_t)(bool success, uint8_t att_ecode,
 typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
-typedef void (*bt_gatt_read_callback_t)(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
-					void *user_data);
 typedef void (*bt_gatt_write_long_callback_t)(bool success, bool reliable_error,
 					uint8_t att_ecode, void *user_data);
 
@@ -93,12 +90,6 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
 
-bool bt_gatt_read_long_value(struct bt_att *att,
-					uint16_t value_handle, uint16_t offset,
-					bt_gatt_read_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy);
-
 bool bt_gatt_write_without_response(struct bt_att *att, uint16_t value_handle,
 					bool signed_write,
 					uint8_t *value, uint16_t length);
-- 
2.1.0.rc2.206.gedb03e5

