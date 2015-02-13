Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] uuid: Add bt_uuid_to_le
Date: Fri, 13 Feb 2015 15:41:41 +0200
Message-Id: <1423834901-7139-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_uuid_to_le and replace the use of put_uuid_le.
---
 lib/uuid.c                | 21 +++++++++++++++++++++
 lib/uuid.h                |  2 ++
 src/shared/gatt-helpers.c | 29 ++++-------------------------
 src/shared/gatt-helpers.h |  2 --
 src/shared/gatt-server.c  |  2 +-
 5 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index e3f31df..97b2d9d 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -290,3 +290,24 @@ int bt_uuid_strcmp(const void *a, const void *b)
 {
 	return strcasecmp(a, b);
 }
+
+int bt_uuid_to_le(const bt_uuid_t *src, void *dst)
+{
+	bt_uuid_t uuid;
+
+	switch (src->type) {
+	case BT_UUID16:
+		bt_put_le16(src->value.u16, dst);
+		return 0;
+	case BT_UUID32:
+		bt_uuid_to_uuid128(src, &uuid);
+		ntoh128(&uuid.value.u128, dst);
+		return 0;
+	case BT_UUID128:
+		ntoh128(&src->value.u128, dst);
+		return 0;
+	case BT_UUID_UNSPEC:
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/lib/uuid.h b/lib/uuid.h
index 8303772..142c979 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -168,6 +168,8 @@ void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst);
 int bt_uuid_to_string(const bt_uuid_t *uuid, char *str, size_t n);
 int bt_string_to_uuid(bt_uuid_t *uuid, const char *string);
 
+int bt_uuid_to_le(const bt_uuid_t *uuid, void *dst);
+
 static inline int bt_uuid_len(const bt_uuid_t *uuid)
 {
 	return uuid->type / 8;
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 6dfc24f..7f95dbe 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -567,27 +567,6 @@ bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 	return true;
 }
 
-void put_uuid_le(const bt_uuid_t *src, void *dst)
-{
-	bt_uuid_t uuid;
-
-	switch (src->type) {
-	case BT_UUID16:
-		put_le16(src->value.u16, dst);
-		break;
-	case BT_UUID128:
-		bswap_128(&src->value.u128, dst);
-		break;
-	case BT_UUID32:
-		bt_uuid_to_uuid128(src, &uuid);
-		bswap_128(&uuid.value.u128, dst);
-		break;
-	case BT_UUID_UNSPEC:
-	default:
-		break;
-	}
-}
-
 static inline int get_uuid_len(const bt_uuid_t *uuid)
 {
 	if (!uuid)
@@ -764,7 +743,7 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 		put_le16(last_end + 1, pdu);
 		put_le16(op->end_handle, pdu + 2);
 		put_le16(op->service_type, pdu + 4);
-		put_uuid_le(&op->uuid, pdu + 6);
+		bt_uuid_to_le(&op->uuid, pdu + 6);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
 							pdu, sizeof(pdu),
@@ -836,7 +815,7 @@ static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
 		put_le16(start, pdu);
 		put_le16(end, pdu + 2);
 		put_le16(op->service_type, pdu + 4);
-		put_uuid_le(&op->uuid, pdu + 6);
+		bt_uuid_to_le(&op->uuid, pdu + 6);
 
 		op->id = bt_att_send(att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
 							pdu, sizeof(pdu),
@@ -1305,7 +1284,7 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 
 		put_le16(last_handle + 1, pdu);
 		put_le16(op->end_handle, pdu + 2);
-		put_uuid_le(&op->uuid, pdu + 4);
+		bt_uuid_to_le(&op->uuid, pdu + 4);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
 						pdu, sizeof(pdu),
@@ -1350,7 +1329,7 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 
 	put_le16(start, pdu);
 	put_le16(end, pdu + 2);
-	put_uuid_le(uuid, pdu + 4);
+	bt_uuid_to_le(uuid, pdu + 4);
 
 	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
 					read_by_type_cb, discovery_op_ref(op),
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 7a2076b..0217e82 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -105,5 +105,3 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-
-void put_uuid_le(const bt_uuid_t *src, void *dst);
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 0652d3d..0623fce 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -543,7 +543,7 @@ static bool encode_find_info_rsp(struct gatt_db *db, struct queue *q,
 			break;
 
 		put_le16(handle, pdu + iter);
-		put_uuid_le(type, pdu + iter + 2);
+		bt_uuid_to_le(type, pdu + iter + 2);
 
 		iter += uuid_len + 2;
 	}
-- 
2.1.0

