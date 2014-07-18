Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 04/11] shared/gatt: Implement "Discover Primary Service by UUID" procedure.
Date: Fri, 18 Jul 2014 14:13:50 -0700
Message-Id: <1405718037-15401-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1405718037-15401-1-git-send-email-armansito@chromium.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_discover_primary_services for the case when a UUID
is provided.
---
 src/shared/gatt-helpers.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 4fbf2eb..fb5a7b6 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -164,6 +164,8 @@ static void put_uuid_le(const bt_uuid_t *src, void *dst)
 {
 	if (src->type == BT_UUID16)
 		put_le16(src->value.u16, dst);
+	else if (src->type == BT_UUID32)
+		put_le32(src->value.u32, dst);
 	else
 		bswap_128(&src->value.u128, dst);
 }
@@ -273,6 +275,82 @@ done:
 		op->callback(status, results, op->user_data);
 }
 
+static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct discovery_op *op = user_data;
+	uint16_t status = 0;
+	struct queue *results = NULL;
+	uint16_t last_end;
+	int i;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		status = process_error(pdu, length);
+
+		if (status == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
+						!queue_isempty(op->results))
+			goto success;
+
+		goto done;
+	}
+
+	/* PDU must contain 4 bytes and it must be a multiple of 4, where each
+	 * 4 bytes contain the 16-bit attribute and group end handles.
+	 */
+	if (opcode != BT_ATT_OP_FIND_BY_TYPE_VAL_RSP || !pdu || !length ||
+								length % 4) {
+		status = BT_GATT_ERROR_INVALID_RSP;
+		goto done;
+	}
+
+	for (i = 0; i < length; i += 4) {
+		struct bt_gatt_service *service;
+		bt_uuid_t uuid;
+
+		service = new0(struct bt_gatt_service, 1);
+		if (!service)
+			goto done;
+
+		service->start = get_le16(pdu + i);
+		last_end = get_le16(pdu + i + 2);
+		service->end = last_end;
+
+		bt_uuid_to_uuid128(&op->uuid, &uuid);
+		memcpy(service->uuid, uuid.value.u128.data, 16);
+
+		queue_push_tail(op->results, service);
+	}
+
+	if (last_end != 0xFFFF) {
+		uint8_t pdu[6 + bt_uuid_len(&op->uuid)];
+
+		put_le16(last_end + 1, pdu);
+		put_le16(0xFFFF, pdu + 2);
+		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
+		put_uuid_le(&op->uuid, pdu + 6);
+
+		if (bt_att_send(op->att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
+							pdu, sizeof(pdu),
+							find_by_type_val_cb,
+							discovery_op_ref(op),
+							discovery_op_unref))
+			return;
+
+		discovery_op_unref(op);
+		status = BT_GATT_ERROR_UNKNOWN;
+		goto done;
+	}
+
+success:
+	/* End of procedure */
+	results = op->results;
+	status = 0;
+
+done:
+	if (op->callback)
+		op->callback(status, results, op->user_data);
+}
+
 bool bt_gatt_discover_primary_services(struct bt_att *att,
 					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
@@ -314,8 +392,21 @@ bool bt_gatt_discover_primary_services(struct bt_att *att,
 							discovery_op_ref(op),
 							discovery_op_unref);
 	} else {
-		free(op);
-		return false;
+		uint8_t pdu[6 + bt_uuid_len(uuid)];
+
+		/* Discover by UUID */
+		op->uuid = *uuid;
+
+		put_le16(0x0001, pdu);
+		put_le16(0xFFFF, pdu + 2);
+		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
+		put_uuid_le(&op->uuid, pdu + 6);
+
+		result = bt_att_send(att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
+							pdu, sizeof(pdu),
+							find_by_type_val_cb,
+							discovery_op_ref(op),
+							discovery_op_unref);
 	}
 
 	if (!result) {
-- 
2.0.0.526.g5318336

