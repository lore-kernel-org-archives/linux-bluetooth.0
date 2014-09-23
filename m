Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/9] shared/gatt-helpers: Allow service discovery by handle range.
Date: Tue, 23 Sep 2014 13:47:09 -0700
Message-Id: <1411505237-10932-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the "start" and "end" parameters to
bt_gatt_discover_primary_services to allow restricting the service discovery
procedure to a handle range. Also added the
bt_gatt_discover_all_primary_services function which internally calls
bt_gatt_discover_primary_services within the handles 0x0001 and 0xffff.
---
 src/shared/gatt-client.c  |  2 +-
 src/shared/gatt-helpers.c | 40 ++++++++++++++++++++++++++++++----------
 src/shared/gatt-helpers.h |  5 +++++
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index ab8da6a..997a280 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -530,7 +530,7 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 					"MTU exchange complete, with MTU: %u",
 					bt_att_get_mtu(client->att));
 
-	if (bt_gatt_discover_primary_services(client->att, NULL,
+	if (bt_gatt_discover_all_primary_services(client->att, NULL,
 							discover_primary_cb,
 							discovery_op_ref(op),
 							discovery_op_unref))
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 54876bc..55e6992 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -482,11 +482,11 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	}
 
 	last_end = get_le16(pdu + length - data_length + 2);
-	if (last_end != 0xffff) {
+	if (last_end < op->end_handle) {
 		uint8_t pdu[6];
 
 		put_le16(last_end + 1, pdu);
-		put_le16(0xffff, pdu + 2);
+		put_le16(op->end_handle, pdu + 2);
 		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
 
 		if (bt_att_send(op->att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
@@ -501,6 +501,15 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
+	/* Some devices incorrectly return 0xffff as the end group handle when
+	 * the read-by-group-type request is performed within a smaller range.
+	 * Manually set the end group handle that we report in the result to the
+	 * end handle in the original request.
+	 */
+	if (last_end == 0xffff && last_end != op->end_handle)
+		put_le16(op->end_handle,
+				cur_result->pdu + length - data_length + 1);
+
 success:
 	/* End of procedure */
 	final_result = op->result_head;
@@ -555,11 +564,11 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 	}
 
 	last_end = get_le16(pdu + length - 6);
-	if (last_end != 0xffff) {
+	if (last_end < op->end_handle) {
 		uint8_t pdu[6 + get_uuid_len(&op->uuid)];
 
 		put_le16(last_end + 1, pdu);
-		put_le16(0xffff, pdu + 2);
+		put_le16(op->end_handle, pdu + 2);
 		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
 		put_uuid_le(&op->uuid, pdu + 6);
 
@@ -585,8 +594,18 @@ done:
 		op->callback(success, att_ecode, final_result, op->user_data);
 }
 
-bool bt_gatt_discover_primary_services(struct bt_att *att,
-					bt_uuid_t *uuid,
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
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
@@ -602,6 +621,7 @@ bool bt_gatt_discover_primary_services(struct bt_att *att,
 		return false;
 
 	op->att = att;
+	op->end_handle = end;
 	op->callback = callback;
 	op->user_data = user_data;
 	op->destroy = destroy;
@@ -610,8 +630,8 @@ bool bt_gatt_discover_primary_services(struct bt_att *att,
 	if (!uuid) {
 		uint8_t pdu[6];
 
-		put_le16(0x0001, pdu);
-		put_le16(0xffff, pdu + 2);
+		put_le16(start, pdu);
+		put_le16(end, pdu + 2);
 		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
 
 		result = bt_att_send(att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
@@ -630,8 +650,8 @@ bool bt_gatt_discover_primary_services(struct bt_att *att,
 		/* Discover by UUID */
 		op->uuid = *uuid;
 
-		put_le16(0x0001, pdu);
-		put_le16(0xffff, pdu + 2);
+		put_le16(start, pdu);
+		put_le16(end, pdu + 2);
 		put_le16(GATT_PRIM_SVC_UUID, pdu + 4);
 		put_uuid_le(&op->uuid, pdu + 6);
 
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index c4a6578..f6f4b62 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -63,7 +63,12 @@ bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
 
+bool bt_gatt_discover_all_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
 bool bt_gatt_discover_primary_services(struct bt_att *att, bt_uuid_t *uuid,
+					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-- 
2.1.0.rc2.206.gedb03e5

