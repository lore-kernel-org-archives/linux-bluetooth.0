Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 03/11] shared/gatt: Implement "Discover All Primary Services" procedure.
Date: Fri, 25 Jul 2014 15:08:35 -0700
Message-Id: <1406326123-10564-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1406326123-10564-1-git-send-email-armansito@chromium.org>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_discover_primary_services for the case when no
UUID is provided.
---
 src/shared/gatt-helpers.c | 253 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 251 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 96137bf..d427eaf 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -36,6 +36,70 @@
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+struct bt_gatt_list {
+	struct bt_gatt_list *next;
+	void *data;
+};
+
+struct list_ptrs {
+	struct bt_gatt_list *head;
+	struct bt_gatt_list *tail;
+};
+
+struct bt_gatt_list *bt_gatt_list_get_next(struct bt_gatt_list *list)
+{
+	return list->next;
+}
+
+void *bt_gatt_list_get_data(struct bt_gatt_list *list)
+{
+	return list->data;
+}
+
+static inline bool list_isempty(struct list_ptrs *list)
+{
+	return !list->head && !list->tail;
+}
+
+static bool list_add(struct list_ptrs *list, void *data)
+{
+	struct bt_gatt_list *item = new0(struct bt_gatt_list, 1);
+	if (!item)
+		return false;
+
+	item->data = data;
+
+	if (list_isempty(list)) {
+		list->head = list->tail = item;
+		return true;
+	}
+
+	list->tail->next = item;
+	list->tail = item;
+
+	return true;
+}
+
+static void list_free(struct list_ptrs *list, bt_gatt_destroy_func_t destroy)
+{
+	struct bt_gatt_list *l, *tmp;
+	l = list->head;
+
+	while (l) {
+		if (destroy)
+			destroy(l->data);
+
+		tmp = l->next;
+		free(l);
+		l = tmp;
+	}
+}
+
+static const uint8_t bt_base_uuid[16] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+	0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+};
+
 struct mtu_op {
 	struct bt_att *att;
 	uint16_t client_rx_mtu;
@@ -122,14 +186,199 @@ bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 	return true;
 }
 
+struct discovery_op {
+	struct bt_att *att;
+	int ref_count;
+	bt_uuid_t uuid;
+	struct list_ptrs results;
+	bt_gatt_discovery_callback_t callback;
+	void *user_data;
+	bt_gatt_destroy_func_t destroy;
+};
+
+static struct discovery_op* discovery_op_ref(struct discovery_op *op)
+{
+	__sync_fetch_and_add(&op->ref_count, 1);
+
+	return op;
+}
+
+static void discovery_op_unref(void *data)
+{
+	struct discovery_op *op = data;
+
+	if (__sync_sub_and_fetch(&op->ref_count, 1))
+		return;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	list_free(&op->results, free);
+
+	free(op);
+}
+
+static void put_uuid_le(const bt_uuid_t *src, void *dst)
+{
+	if (src->type == BT_UUID16)
+		put_le16(src->value.u16, dst);
+	else
+		bswap_128(&src->value.u128, dst);
+}
+
+static bool convert_uuid_le(const uint8_t *src, size_t len, uint8_t dst[16])
+{
+	if (len == 16) {
+		bswap_128(src, dst);
+		return true;
+	}
+
+	if (len != 2)
+		return false;
+
+	memcpy(dst, bt_base_uuid, sizeof(bt_base_uuid));
+	dst[2] = src[1];
+	dst[3] = src[0];
+
+	return true;
+}
+
+static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct discovery_op *op = user_data;
+	bool success;
+	uint8_t att_ecode = 0;
+	struct bt_gatt_list *results = NULL;
+	size_t data_length;
+	size_t list_length;
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
+	/* PDU must contain at least the following (sans opcode):
+	 * - Attr Data Length (1 octet)
+	 * - Attr Data List (at least 6 octets):
+	 *   -- 2 octets: Attribute handle
+	 *   -- 2 octets: End group handle
+	 *   -- 2 or 16 octets: service UUID
+	 */
+	if (opcode != BT_ATT_OP_READ_BY_GRP_TYPE_RSP || !pdu || length < 7) {
+		success = false;
+		goto done;
+	}
+
+	data_length = ((uint8_t *) pdu)[0];
+	list_length = length - 1;
+
+	if ((list_length % data_length) ||
+				(data_length != 6 && data_length != 20)) {
+		success = false;
+		goto done;
+	}
+
+	for (i = 1; i < length; i += data_length) {
+		struct bt_gatt_service *service;
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
+		convert_uuid_le(pdu + i + 4, data_length - 4, service->uuid);
+
+		if (!list_add(&op->results, service)) {
+			success = false;
+			goto done;
+		}
+	}
+
+	if (last_end != 0xffff) {
+		uint8_t pdu[6];
+
+		put_le16(last_end + 1, pdu);
+		put_le16(0xffff, pdu + 2);
+		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
+
+		if (bt_att_send(op->att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
+							pdu, sizeof(pdu),
+							read_by_grp_type_cb,
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
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	struct discovery_op *op;
+	bool result;
+
+	if (!att)
+		return false;
+
+	op = new0(struct discovery_op, 1);
+	if (!op)
+		return false;
+
+	op->att = att;
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	/* If UUID is NULL, then discover all primary services */
+	if (!uuid) {
+		uint8_t pdu[6];
+
+		put_le16(0x0001, pdu);
+		put_le16(0xffff, pdu + 2);
+		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
+
+		result = bt_att_send(att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
+							pdu, sizeof(pdu),
+							read_by_grp_type_cb,
+							discovery_op_ref(op),
+							discovery_op_unref);
+	} else {
+		free(op);
+		return false;
+	}
+
+	if (!result)
+		free(op);
+
+	return result;
 }
 
 bool bt_gatt_discover_included_services(struct bt_att *att,
-- 
2.0.0.526.g5318336

