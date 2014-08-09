Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH] shared/gatt-helpers: Remove service, characteristic, descriptor structures.
Date: Fri,  8 Aug 2014 19:56:38 -0700
Message-Id: <1407552998-20606-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the service, characteristic, and descriptor structures
declared in gatt-helpers.h. These aren't really necessary, especially since
there will be another higher-level version of these for shared/gatt-client.
---
 src/shared/gatt-helpers.c | 51 +++++++++++++++++++++++++----------------------
 src/shared/gatt-helpers.h | 30 +++++++---------------------
 2 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 047f64c..ff49867 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -134,13 +134,14 @@ struct discovery_op {
 };
 
 bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
-						struct bt_gatt_service *service)
+				uint16_t *start_handle, uint16_t *end_handle,
+				uint8_t uuid[16])
 {
 	struct discovery_op *op;
 	const void *pdu_ptr;
-	bt_uuid_t uuid;
+	bt_uuid_t tmp;
 
-	if (!iter->result || !service)
+	if (!iter || !iter->result || !start_handle || !end_handle || !uuid)
 		return false;
 
 	op = iter->result->op;
@@ -148,17 +149,16 @@ bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
 
 	switch (iter->result->opcode) {
 	case BT_ATT_OP_READ_BY_GRP_TYPE_RSP:
-		service->start = get_le16(pdu_ptr);
-		service->end = get_le16(pdu_ptr + 2);
-		convert_uuid_le(pdu_ptr + 4, iter->result->data_len - 4,
-								service->uuid);
+		*start_handle = get_le16(pdu_ptr);
+		*end_handle = get_le16(pdu_ptr + 2);
+		convert_uuid_le(pdu_ptr + 4, iter->result->data_len - 4, uuid);
 		break;
 	case BT_ATT_OP_FIND_BY_TYPE_VAL_RSP:
-		service->start = get_le16(pdu_ptr);
-		service->end = get_le16(pdu_ptr + 2);
+		*start_handle = get_le16(pdu_ptr);
+		*end_handle = get_le16(pdu_ptr + 2);
 
-		bt_uuid_to_uuid128(&op->uuid, &uuid);
-		memcpy(service->uuid, uuid.value.u128.data, 16);
+		bt_uuid_to_uuid128(&op->uuid, &tmp);
+		memcpy(uuid, tmp.value.u128.data, 16);
 		break;
 	default:
 		return false;
@@ -175,12 +175,15 @@ bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
 }
 
 bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
-					struct bt_gatt_characteristic *chrc)
+				uint16_t *start_handle, uint16_t *end_handle,
+				uint16_t *value_handle, uint8_t *properties,
+				uint8_t uuid[16])
 {
 	struct discovery_op *op;
 	const void *pdu_ptr;
 
-	if (!iter->result || !chrc)
+	if (!iter || !iter->result || !start_handle || !end_handle ||
+					!value_handle || !properties || !uuid)
 		return false;
 
 	if (iter->result->opcode != BT_ATT_OP_READ_BY_TYPE_RSP)
@@ -189,10 +192,10 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 	op = iter->result->op;
 	pdu_ptr = iter->result->pdu + iter->pos;
 
-	chrc->start = get_le16(pdu_ptr);
-	chrc->properties = ((uint8_t *) pdu_ptr)[2];
-	chrc->value = get_le16(pdu_ptr + 3);
-	convert_uuid_le(pdu_ptr + 5, iter->result->data_len - 5, chrc->uuid);
+	*start_handle = get_le16(pdu_ptr);
+	*properties = ((uint8_t *) pdu_ptr)[2];
+	*value_handle = get_le16(pdu_ptr + 3);
+	convert_uuid_le(pdu_ptr + 5, iter->result->data_len - 5, uuid);
 
 	iter->pos += iter->result->data_len;
 	if (iter->pos == iter->result->pdu_len) {
@@ -201,21 +204,21 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 	}
 
 	if (!iter->result) {
-		chrc->end = op->end_handle;
+		*end_handle = op->end_handle;
 		return true;
 	}
 
-	chrc->end = get_le16(iter->result->pdu + iter->pos) - 1;
+	*end_handle = get_le16(iter->result->pdu + iter->pos) - 1;
 
 	return true;
 }
 
-bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter,
-						struct bt_gatt_descriptor *desc)
+bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter, uint16_t *handle,
+							uint8_t uuid[16])
 {
 	const void *pdu_ptr;
 
-	if (!iter->result || !desc)
+	if (!iter || !iter->result || !handle || !uuid)
 		return false;
 
 	if (iter->result->opcode != BT_ATT_OP_FIND_INFO_RSP)
@@ -223,8 +226,8 @@ bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter,
 
 	pdu_ptr = iter->result->pdu + iter->pos;
 
-	desc->handle = get_le16(pdu_ptr);
-	convert_uuid_le(pdu_ptr + 2, iter->result->data_len - 2, desc->uuid);
+	*handle = get_le16(pdu_ptr);
+	convert_uuid_le(pdu_ptr + 2, iter->result->data_len - 2, uuid);
 
 	iter->pos += iter->result->data_len;
 	if (iter->pos == iter->result->pdu_len) {
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 95dd8b7..cdf83ba 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -28,25 +28,6 @@
 #include <stdbool.h>
 #include <stdint.h>
 
-struct bt_gatt_service {
-	uint16_t start;
-	uint16_t end;
-	uint8_t uuid[16];
-};
-
-struct bt_gatt_characteristic {
-	uint16_t start;
-	uint16_t end;
-	uint16_t value;
-	uint8_t properties;
-	uint8_t uuid[16];
-};
-
-struct bt_gatt_descriptor {
-	uint16_t handle;
-	uint8_t uuid[16];
-};
-
 struct bt_gatt_result;
 
 struct bt_gatt_iter {
@@ -56,11 +37,14 @@ struct bt_gatt_iter {
 
 bool bt_gatt_iter_init(struct bt_gatt_iter *iter, struct bt_gatt_result *result);
 bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
-					struct bt_gatt_service *service);
+				uint16_t *start_handle, uint16_t *end_handle,
+				uint8_t uuid[16]);
 bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
-				struct bt_gatt_characteristic *characteristic);
-bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter,
-					struct bt_gatt_descriptor *descriptor);
+				uint16_t *start_handle, uint16_t *end_handle,
+				uint16_t *value_handle, uint8_t *properties,
+				uint8_t uuid[16]);
+bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter, uint16_t *handle,
+							uint8_t uuid[16]);
 
 typedef void (*bt_gatt_destroy_func_t)(void *user_data);
 
-- 
2.0.0.526.g5318336

