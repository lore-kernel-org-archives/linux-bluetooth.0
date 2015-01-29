Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Simplify read long value
Date: Thu, 29 Jan 2015 17:09:33 +0200
Message-Id: <1422544173-7729-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes the extra queue that acts as intermediate storage, instead
the code will now storage everything in a single buffer and just realloc
while appending new chunks.
---
 src/shared/gatt-client.c | 107 ++++++++++-------------------------------------
 1 file changed, 21 insertions(+), 86 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 04fb4cb..a78e209 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -31,6 +31,7 @@
 
 #include <assert.h>
 #include <limits.h>
+#include <sys/uio.h>
 
 #ifndef MAX
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
@@ -1927,54 +1928,13 @@ struct read_long_op {
 	struct bt_gatt_client *client;
 	int ref_count;
 	uint16_t value_handle;
-	uint16_t orig_offset;
 	uint16_t offset;
-	struct queue *blobs;
+	struct iovec iov;
 	bt_gatt_client_read_callback_t callback;
 	void *user_data;
 	bt_gatt_client_destroy_func_t destroy;
 };
 
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
-	/* Truncate if the data would exceed maximum length */
-	if (offset + len > BT_ATT_MAX_VALUE_LEN)
-		len = BT_ATT_MAX_VALUE_LEN - offset;
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
 static void destroy_read_long_op(void *data)
 {
 	struct read_long_op *op = data;
@@ -1982,46 +1942,31 @@ static void destroy_read_long_op(void *data)
 	if (op->destroy)
 		op->destroy(op->user_data);
 
-	queue_destroy(op->blobs, destroy_blob);
-
+	free(op->iov.iov_base);
 	free(op);
 }
 
-static void append_blob(void *data, void *user_data)
+static bool append_chunk(struct read_long_op *op, const uint8_t *data,
+								uint16_t len)
 {
-	struct blob *blob = data;
-	uint8_t *value = user_data;
-
-	memcpy(value + blob->offset, blob->data, blob->length);
-}
+	void *buf;
 
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
+	/* Truncate if the data would exceed maximum length */
+	if (op->offset + len > BT_ATT_MAX_VALUE_LEN)
+		len = BT_ATT_MAX_VALUE_LEN - op->offset;
 
-	if (!length)
-		goto done;
+	buf = realloc(op->iov.iov_base, op->iov.iov_len + len);
+	if (!buf)
+		return false;
 
-	value = malloc(length);
-	if (!value) {
-		success = false;
-		goto done;
-	}
+	op->iov.iov_base = buf;
 
-	queue_foreach(op->blobs, append_blob, value - op->orig_offset);
+	memcpy(op->iov.iov_base + op->iov.iov_len, data, len);
 
-done:
-	if (op->callback)
-		op->callback(success, att_ecode, value, length, op->user_data);
+	op->iov.iov_len += len;
+	op->offset += len;
 
-	free(value);
+	return true;
 }
 
 static void read_long_cb(uint8_t opcode, const void *pdu,
@@ -2029,7 +1974,6 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
 {
 	struct request *req = user_data;
 	struct read_long_op *op = req->data;
-	struct blob *blob;
 	bool success;
 	uint8_t att_ecode = 0;
 
@@ -2047,14 +1991,11 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
 	if (!length)
 		goto success;
 
-	blob = create_blob(pdu, length, op->offset);
-	if (!blob) {
+	if (!append_chunk(op, pdu, length)) {
 		success = false;
 		goto done;
 	}
 
-	queue_push_tail(op->blobs, blob);
-	op->offset += blob->length;
 	if (op->offset >= BT_ATT_MAX_VALUE_LEN)
 		goto success;
 
@@ -2082,7 +2023,9 @@ success:
 	success = true;
 
 done:
-	complete_read_long_op(op, success, att_ecode);
+	if (op->callback)
+		op->callback(success, att_ecode, op->iov.iov_base,
+						op->iov.iov_len, op->user_data);
 }
 
 unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
@@ -2102,22 +2045,14 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 	if (!op)
 		return 0;
 
-	op->blobs = queue_new();
-	if (!op->blobs) {
-		free(op);
-		return 0;
-	}
-
 	req = request_create(client);
 	if (!req) {
-		queue_destroy(op->blobs, free);
 		free(op);
 		return 0;
 	}
 
 	op->client = client;
 	op->value_handle = value_handle;
-	op->orig_offset = offset;
 	op->offset = offset;
 	op->callback = callback;
 	op->user_data = user_data;
-- 
2.1.0

