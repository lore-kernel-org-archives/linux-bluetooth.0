Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 05/14] shared/gatt: Add included service iterator
Date: Thu, 16 Oct 2014 12:17:17 +0200
Message-Id: <1413454646-23076-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
References: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will fetch included services from result.
---
 src/shared/gatt-helpers.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-helpers.h |  3 +++
 2 files changed, 61 insertions(+)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 58104d9..fd8d06c 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -186,6 +186,64 @@ struct discovery_op {
 	bt_gatt_destroy_func_t destroy;
 };
 
+bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
+				uint16_t *handle, uint16_t *start_handle,
+				uint16_t *end_handle, uint8_t uuid[16])
+{
+	struct bt_gatt_result *read_result;
+	const void *pdu_ptr;
+	int i = 0;
+
+	if (!iter || !iter->result || !handle || !start_handle || !end_handle
+								|| !uuid)
+		return false;
+
+	if (iter->result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
+		return false;
+
+	if (iter->result->data_len != 8 && iter->result->data_len != 6)
+		return false;
+
+	pdu_ptr = iter->result->pdu + iter->pos;
+
+	if (iter->result->data_len == 8) {
+		*handle = get_le16(pdu_ptr);
+		*start_handle = get_le16(pdu_ptr + 2);
+		*end_handle = get_le16(pdu_ptr + 4);
+		convert_uuid_le(pdu_ptr + 6, 2, uuid);
+
+		iter->pos += iter->result->data_len;
+
+		if (iter->pos == iter->result->pdu_len) {
+			iter->result = iter->result->next;
+			iter->pos = 0;
+		}
+
+		return true;
+	}
+
+	*handle = get_le16(pdu_ptr);
+	*start_handle = get_le16(pdu_ptr + 2);
+	*end_handle = get_le16(pdu_ptr + 4);
+	read_result = iter->result;
+
+	do {
+		read_result = read_result->next;
+	} while (read_result && i++ < (iter->pos / iter->result->data_len));
+
+	if (!read_result)
+		return false;
+
+	convert_uuid_le(read_result->pdu, read_result->data_len, uuid);
+	iter->pos += iter->result->data_len;
+	if (iter->pos == iter->result->pdu_len) {
+		iter->result = read_result->next;
+		iter->pos = 0;
+	}
+
+	return true;
+}
+
 bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
 				uint16_t *start_handle, uint16_t *end_handle,
 				uint8_t uuid[16])
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 8a25dea..8c434c1 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -49,6 +49,9 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 				uint8_t uuid[16]);
 bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter, uint16_t *handle,
 							uint8_t uuid[16]);
+bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
+				uint16_t *handle, uint16_t *start_handle,
+				uint16_t *end_handle, uint8_t uuid[16]);
 
 typedef void (*bt_gatt_destroy_func_t)(void *user_data);
 
-- 
1.9.3

