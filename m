Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/9] shared/gatt-helpers: Add iterator to read_by_type results
Date: Wed, 19 Nov 2014 12:26:26 +0100
Message-Id: <1416396393-19997-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add iterator to get handle and value from read-by-type responses.
Also avoid using other iterator (characteristics and include services
iterators) with read-by-type results.
---
 src/shared/gatt-helpers.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-helpers.h |  3 +++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 0c3fd34..d0bee3f 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -247,6 +247,7 @@ bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
 				uint16_t *end_handle, uint8_t uuid[16])
 {
 	struct bt_gatt_result *read_result;
+	struct discovery_op *op;
 	const void *pdu_ptr;
 	int i = 0;
 
@@ -254,9 +255,14 @@ bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
 								|| !uuid)
 		return false;
 
+
 	if (iter->result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
 		return false;
 
+	/* UUID in discovery_op is set in read_by_type and service_discovery */
+	op = iter->result->op;
+	if (op->uuid.type != BT_UUID_UNSPEC)
+		return false;
 	/*
 	 * iter->result points to READ_BY_TYPE_RSP with data length containing:
 	 * 2 octets - include service handle
@@ -372,6 +378,10 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 	if (iter->result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
 		return false;
 
+	/* UUID in discovery_op is set in read_by_type and service_discovery */
+	op = iter->result->op;
+	if (op->uuid.type != BT_UUID_UNSPEC)
+		return false;
 	/*
 	 * Data length contains 7 or 21 octets:
 	 * 2 octets: Attribute handle
@@ -382,7 +392,6 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 	if (iter->result->data_len != 21 && iter->result->data_len != 7)
 		return false;
 
-	op = iter->result->op;
 	pdu_ptr = iter->result->pdu + iter->pos;
 
 	*start_handle = get_le16(pdu_ptr);
@@ -431,6 +440,42 @@ bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter, uint16_t *handle,
 	return true;
 }
 
+bool bt_gatt_iter_next_read_by_type(struct bt_gatt_iter *iter,
+				uint16_t *handle, uint16_t *length,
+				const uint8_t **value)
+{
+	struct discovery_op *op;
+	const void *pdu_ptr;
+
+	if (!iter || !iter->result || !handle || !length || !value)
+		return false;
+
+	if (iter->result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
+		return false;
+
+	/*
+	 * Check if UUID is set, otherwise results can contain characteristic
+	 * discovery service or included service discovery results
+	 */
+	op = iter->result->op;
+	if (op->uuid.type == BT_UUID_UNSPEC)
+		return false;
+
+	pdu_ptr = iter->result->pdu + iter->pos;
+
+	*handle = get_le16(pdu_ptr);
+	*length = iter->result->data_len - 2;
+	*value = pdu_ptr + 2;
+
+	iter->pos += iter->result->data_len;
+	if (iter->pos == iter->result->pdu_len) {
+		iter->result = iter->result->next;
+		iter->pos = 0;
+	}
+
+	return true;
+}
+
 struct mtu_op {
 	struct bt_att *att;
 	uint16_t client_rx_mtu;
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 2cc37c6..0217e82 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -53,6 +53,9 @@ bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter, uint16_t *handle,
 bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
 				uint16_t *handle, uint16_t *start_handle,
 				uint16_t *end_handle, uint8_t uuid[16]);
+bool bt_gatt_iter_next_read_by_type(struct bt_gatt_iter *iter,
+				uint16_t *handle, uint16_t *length,
+				const uint8_t **value);
 
 typedef void (*bt_gatt_destroy_func_t)(void *user_data);
 
-- 
1.9.3

