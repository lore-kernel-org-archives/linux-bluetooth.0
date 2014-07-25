Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 04/11] shared/gatt: Implement "Discover Primary Service by UUID" procedure.
Date: Fri, 25 Jul 2014 15:08:36 -0700
Message-Id: <1406326123-10564-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1406326123-10564-1-git-send-email-armansito@chromium.org>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_discover_primary_services for the case when a UUID
is provided.
---
 src/shared/gatt-helpers.c | 126 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index d427eaf..e3ca681 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -220,10 +220,27 @@ static void discovery_op_unref(void *data)
 
 static void put_uuid_le(const bt_uuid_t *src, void *dst)
 {
-	if (src->type == BT_UUID16)
+	bt_uuid_t uuid;
+
+	switch (src->type) {
+	case BT_UUID16:
 		put_le16(src->value.u16, dst);
-	else
+		break;
+	case BT_UUID128:
 		bswap_128(&src->value.u128, dst);
+		break;
+	case BT_UUID32:
+		bt_uuid_to_uuid128(src, &uuid);
+		bswap_128(&uuid.value.u128, dst);
+		break;
+	default:
+		break;
+	}
+}
+
+static inline int get_uuid_len(const bt_uuid_t *uuid)
+{
+	return (uuid->type == BT_UUID16) ? 2 : 16;
 }
 
 static bool convert_uuid_le(const uint8_t *src, size_t len, uint8_t dst[16])
@@ -336,6 +353,89 @@ done:
 		op->callback(success, att_ecode, results, op->user_data);
 }
 
+static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct discovery_op *op = user_data;
+	bool success;
+	uint8_t att_ecode = 0;
+	struct bt_gatt_list *results = NULL;
+	uint16_t last_end;
+	int i;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+
+		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
+						!list_isempty(&op->results))
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
+		success = false;
+		goto done;
+	}
+
+	for (i = 0; i < length; i += 4) {
+		struct bt_gatt_service *service;
+		bt_uuid_t uuid;
+
+		service = new0(struct bt_gatt_service, 1);
+		if (!service) {
+			success = false;
+			goto done;
+		}
+
+		service->start = get_le16(pdu + i);
+		last_end = get_le16(pdu + i + 2);
+		service->end = last_end;
+
+		bt_uuid_to_uuid128(&op->uuid, &uuid);
+		memcpy(service->uuid, uuid.value.u128.data, 16);
+
+		if (!list_add(&op->results, service)) {
+			success = false;
+			goto done;
+		}
+	}
+
+	if (last_end != 0xffff) {
+		uint8_t pdu[6 + get_uuid_len(&op->uuid)];
+
+		put_le16(last_end + 1, pdu);
+		put_le16(0xffff, pdu + 2);
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
+		success = false;
+		goto done;
+	}
+
+success:
+	/* End of procedure */
+	results = op->results.head;
+	success = true;
+
+done:
+	if (op->callback)
+		op->callback(success, att_ecode, results, op->user_data);
+}
+
 bool bt_gatt_discover_primary_services(struct bt_att *att,
 					bt_uuid_t *uuid,
 					bt_gatt_discovery_callback_t callback,
@@ -371,8 +471,26 @@ bool bt_gatt_discover_primary_services(struct bt_att *att,
 							discovery_op_ref(op),
 							discovery_op_unref);
 	} else {
-		free(op);
-		return false;
+		uint8_t pdu[6 + get_uuid_len(uuid)];
+
+		if (uuid->type == BT_UUID_UNSPEC) {
+			free(op);
+			return false;
+		}
+
+		/* Discover by UUID */
+		op->uuid = *uuid;
+
+		put_le16(0x0001, pdu);
+		put_le16(0xffff, pdu + 2);
+		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
+		put_uuid_le(&op->uuid, pdu + 6);
+
+		result = bt_att_send(att, BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
+							pdu, sizeof(pdu),
+							find_by_type_val_cb,
+							discovery_op_ref(op),
+							discovery_op_unref);
 	}
 
 	if (!result)
-- 
2.0.0.526.g5318336

