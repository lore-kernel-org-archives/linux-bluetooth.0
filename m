Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 01/14] shared/gatt: Add discover_secondary_services()
Date: Fri, 10 Oct 2014 11:15:35 +0200
Message-Id: <1412932548-28363-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412932548-28363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412932548-28363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This pach implements searching Secondary Services in given range.
---
 src/shared/gatt-helpers.c | 56 +++++++++++++++++++++++++++++++++--------------
 src/shared/gatt-helpers.h |  5 +++++
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 55e6992..4dc787f 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -175,6 +175,7 @@ struct discovery_op {
 	uint16_t end_handle;
 	int ref_count;
 	bt_uuid_t uuid;
+	uint16_t service_type;
 	struct bt_gatt_result *result_head;
 	struct bt_gatt_result *result_tail;
 	bt_gatt_discovery_callback_t callback;
@@ -487,7 +488,7 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 
 		put_le16(last_end + 1, pdu);
 		put_le16(op->end_handle, pdu + 2);
-		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
+		put_le16(op->service_type, pdu + 4);
 
 		if (bt_att_send(op->att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
 							pdu, sizeof(pdu),
@@ -569,7 +570,7 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 
 		put_le16(last_end + 1, pdu);
 		put_le16(op->end_handle, pdu + 2);
-		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
+		put_le16(op->service_type, pdu + 4);
 		put_uuid_le(&op->uuid, pdu + 6);
 
 		if (bt_att_send(op->att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
@@ -594,21 +595,12 @@ done:
 		op->callback(success, att_ecode, final_result, op->user_data);
 }
 
-bool bt_gatt_discover_all_primary_services(struct bt_att *att, bt_uuid_t *uuid,
-					bt_gatt_discovery_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy)
-{
-	return bt_gatt_discover_primary_services(att, uuid, 0x0001, 0xffff,
-							callback, user_data,
-							destroy);
-}
-
-bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+static bool discover_services(struct bt_att *att, bt_uuid_t *uuid,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
-					bt_gatt_destroy_func_t destroy)
+					bt_gatt_destroy_func_t destroy,
+					bool primary)
 {
 	struct discovery_op *op;
 	bool result;
@@ -625,6 +617,8 @@ bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 	op->callback = callback;
 	op->user_data = user_data;
 	op->destroy = destroy;
+	/* set service uuid to primary or secondary */
+	op->service_type = primary ? GATT_PRIM_SVC_UUID : GATT_SND_SVC_UUID;
 
 	/* If UUID is NULL, then discover all primary services */
 	if (!uuid) {
@@ -632,7 +626,7 @@ bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 
 		put_le16(start, pdu);
 		put_le16(end, pdu + 2);
-		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
+		put_le16(op->service_type, pdu + 4);
 
 		result = bt_att_send(att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
 							pdu, sizeof(pdu),
@@ -652,7 +646,7 @@ bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 
 		put_le16(start, pdu);
 		put_le16(end, pdu + 2);
-		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
+		put_le16(op->service_type, pdu + 4);
 		put_uuid_le(&op->uuid, pdu + 6);
 
 		result = bt_att_send(att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
@@ -668,6 +662,36 @@ bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 	return result;
 }
 
+bool bt_gatt_discover_all_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	return bt_gatt_discover_primary_services(att, uuid, 0x0001, 0xffff,
+							callback, user_data,
+							destroy);
+}
+
+bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+					uint16_t start, uint16_t end,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	return discover_services(att, uuid, start, end, callback, user_data,
+								destroy, true);
+}
+
+bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
+					uint16_t start, uint16_t end,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	return discover_services(att, uuid, start, end, callback, user_data,
+								destroy, false);
+}
+
 bool bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_uuid_t *uuid,
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index f6f4b62..8a25dea 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -72,6 +72,11 @@ bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
+bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
+					uint16_t start, uint16_t end,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
 bool bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_uuid_t *uuid,
-- 
1.9.3

