Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 01/10] shared/gatt-client: Added bt_gatt_client_read_value.
Date: Wed,  3 Sep 2014 12:46:02 -0700
Message-Id: <1409773571-28417-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moved the bt_gatt_read_value function from shared/gatt-helpers to
shared/gatt-client as bt_gatt_client_read_value.
---
 src/shared/gatt-client.c  | 154 ++++++++++++++++++++++++++++++++++++----------
 src/shared/gatt-client.h  |  10 +++
 src/shared/gatt-helpers.c |  77 -----------------------
 src/shared/gatt-helpers.h |   4 --
 4 files changed, 130 insertions(+), 115 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index afd84eb..45ea2c3 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -105,7 +105,7 @@ static void gatt_client_clear_services(struct bt_gatt_client *client)
 	client->svc_head = client->svc_tail = NULL;
 }
 
-struct async_op {
+struct discovery_op {
 	struct bt_gatt_client *client;
 	struct service_list *cur_service;
 	bt_gatt_characteristic_t *cur_chrc;
@@ -113,16 +113,16 @@ struct async_op {
 	int ref_count;
 };
 
-static struct async_op *async_op_ref(struct async_op *op)
+static struct discovery_op *discovery_op_ref(struct discovery_op *op)
 {
 	__sync_fetch_and_add(&op->ref_count, 1);
 
 	return op;
 }
 
-static void async_op_unref(void *data)
+static void discovery_op_unref(void *data)
 {
-	struct async_op *op = data;
+	struct discovery_op *op = data;
 
 	if (__sync_sub_and_fetch(&op->ref_count, 1))
 		return;
@@ -130,7 +130,7 @@ static void async_op_unref(void *data)
 	free(data);
 }
 
-static void async_op_complete(struct async_op *op, bool success,
+static void discovery_op_complete(struct discovery_op *op, bool success,
 							uint8_t att_ecode)
 {
 	struct bt_gatt_client *client = op->client;
@@ -164,7 +164,7 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
 {
-	struct async_op *op = user_data;
+	struct discovery_op *op = user_data;
 	struct bt_gatt_client *client = op->client;
 	struct bt_gatt_iter iter;
 	char uuid_str[MAX_LEN_UUID_STR];
@@ -227,13 +227,13 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 						desc_start,
 						op->cur_chrc->end_handle,
 						discover_descs_cb,
-						async_op_ref(op),
-						async_op_unref))
+						discovery_op_ref(op),
+						discovery_op_unref))
 			return;
 
 		util_debug(client->debug_callback, client->debug_data,
 					"Failed to start descriptor discovery");
-		async_op_unref(op);
+		discovery_op_unref(op);
 		success = false;
 
 		goto done;
@@ -249,24 +249,24 @@ next:
 					op->cur_service->service.start_handle,
 					op->cur_service->service.end_handle,
 					discover_chrcs_cb,
-					async_op_ref(op),
-					async_op_unref))
+					discovery_op_ref(op),
+					discovery_op_unref))
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
 				"Failed to start characteristic discovery");
-	async_op_unref(op);
+	discovery_op_unref(op);
 	success = false;
 
 done:
-	async_op_complete(op, success, att_ecode);
+	discovery_op_complete(op, success, att_ecode);
 }
 
 static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
 {
-	struct async_op *op = user_data;
+	struct discovery_op *op = user_data;
 	struct bt_gatt_client *client = op->client;
 	struct bt_gatt_iter iter;
 	char uuid_str[MAX_LEN_UUID_STR];
@@ -331,13 +331,13 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 		if (bt_gatt_discover_descriptors(client->att,
 						desc_start, chrcs[i].end_handle,
 						discover_descs_cb,
-						async_op_ref(op),
-						async_op_unref))
+						discovery_op_ref(op),
+						discovery_op_unref))
 			return;
 
 		util_debug(client->debug_callback, client->debug_data,
 					"Failed to start descriptor discovery");
-		async_op_unref(op);
+		discovery_op_unref(op);
 		success = false;
 
 		goto done;
@@ -353,24 +353,24 @@ next:
 					op->cur_service->service.start_handle,
 					op->cur_service->service.end_handle,
 					discover_chrcs_cb,
-					async_op_ref(op),
-					async_op_unref))
+					discovery_op_ref(op),
+					discovery_op_unref))
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
 				"Failed to start characteristic discovery");
-	async_op_unref(op);
+	discovery_op_unref(op);
 	success = false;
 
 done:
-	async_op_complete(op, success, att_ecode);
+	discovery_op_complete(op, success, att_ecode);
 }
 
 static void discover_primary_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
 {
-	struct async_op *op = user_data;
+	struct discovery_op *op = user_data;
 	struct bt_gatt_client *client = op->client;
 	struct bt_gatt_iter iter;
 	uint16_t start, end;
@@ -419,22 +419,22 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 					op->cur_service->service.start_handle,
 					op->cur_service->service.end_handle,
 					discover_chrcs_cb,
-					async_op_ref(op),
-					async_op_unref))
+					discovery_op_ref(op),
+					discovery_op_unref))
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
 				"Failed to start characteristic discovery");
-	async_op_unref(op);
+	discovery_op_unref(op);
 	success = false;
 
 done:
-	async_op_complete(op, success, att_ecode);
+	discovery_op_complete(op, success, att_ecode);
 }
 
 static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 {
-	struct async_op *op = user_data;
+	struct discovery_op *op = user_data;
 	struct bt_gatt_client *client = op->client;
 
 	if (!success) {
@@ -457,8 +457,8 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 
 	if (bt_gatt_discover_primary_services(client->att, NULL,
 							discover_primary_cb,
-							async_op_ref(op),
-							async_op_unref))
+							discovery_op_ref(op),
+							discovery_op_unref))
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
@@ -469,17 +469,17 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 	if (client->ready_callback)
 		client->ready_callback(success, att_ecode, client->ready_data);
 
-	async_op_unref(op);
+	discovery_op_unref(op);
 }
 
 static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 {
-	struct async_op *op;
+	struct discovery_op *op;
 
 	if (client->in_init || client->ready)
 		return false;
 
-	op = new0(struct async_op, 1);
+	op = new0(struct discovery_op, 1);
 	if (!op)
 		return false;
 
@@ -488,8 +488,8 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 	/* Configure the MTU */
 	if (!bt_gatt_exchange_mtu(client->att, MAX(BT_ATT_DEFAULT_LE_MTU, mtu),
 							exchange_mtu_cb,
-							async_op_ref(op),
-							async_op_unref)) {
+							discovery_op_ref(op),
+							discovery_op_unref)) {
 		if (client->ready_callback)
 			client->ready_callback(false, 0, client->ready_data);
 
@@ -650,3 +650,89 @@ bool bt_gatt_service_iter_next_by_uuid(struct bt_gatt_service_iter *iter,
 
 	return false;
 }
+
+struct read_op {
+	bt_gatt_client_read_callback_t callback;
+	void *user_data;
+	bt_gatt_client_destroy_func_t destroy;
+};
+
+static void destroy_read_op(void *data)
+{
+	struct read_op *op = data;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op);
+}
+
+static uint8_t process_error(const void *pdu, uint16_t length)
+{
+	if (!pdu || length != 4)
+		return 0;
+
+	return ((uint8_t *) pdu)[3];
+}
+
+static void read_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct read_op *op = user_data;
+	bool success;
+	uint8_t att_ecode = 0;
+	const uint8_t *value = NULL;
+	uint16_t value_len = 0;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_READ_RSP || (!pdu && length)) {
+		success = false;
+		goto done;
+	}
+
+	success = true;
+	value_len = length;
+	if (value_len)
+		value = pdu;
+
+done:
+	if (op->callback)
+		op->callback(success, att_ecode, value, length, op->user_data);
+}
+
+bool bt_gatt_client_read_value(struct bt_gatt_client *client,
+					uint16_t value_handle,
+					bt_gatt_client_read_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy)
+{
+	struct read_op *op;
+	uint8_t pdu[2];
+
+	if (!client)
+		return false;
+
+	op = new0(struct read_op, 1);
+	if (!op)
+		return false;
+
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	put_le16(value_handle, pdu);
+
+	if (!bt_att_send(client->att, BT_ATT_OP_READ_REQ, pdu, sizeof(pdu),
+							read_cb, op,
+							destroy_read_op)) {
+		free(op);
+		return false;
+	}
+
+	return true;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index e4a4312..b7ec84a 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -87,3 +87,13 @@ bool bt_gatt_service_iter_next_by_handle(struct bt_gatt_service_iter *iter,
 bool bt_gatt_service_iter_next_by_uuid(struct bt_gatt_service_iter *iter,
 					const uint8_t uuid[BT_GATT_UUID_SIZE],
 					bt_gatt_service_t *service);
+
+typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
+
+bool bt_gatt_client_read_value(struct bt_gatt_client *client,
+					uint16_t value_handle,
+					bt_gatt_client_read_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 00813f5..763292f 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -912,83 +912,6 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 	return true;
 }
 
-struct read_op {
-	bt_gatt_read_callback_t callback;
-	void *user_data;
-	bt_gatt_destroy_func_t destroy;
-};
-
-static void destroy_read_op(void *data)
-{
-	struct read_op *op = data;
-
-	if (op->destroy)
-		op->destroy(op->user_data);
-
-	free(op);
-}
-
-static void read_cb(uint8_t opcode, const void *pdu, uint16_t length,
-								void *user_data)
-{
-	struct read_op *op = user_data;
-	bool success;
-	uint8_t att_ecode = 0;
-	const uint8_t *value = NULL;
-	uint16_t value_len = 0;
-
-	if (opcode == BT_ATT_OP_ERROR_RSP) {
-		success = false;
-		att_ecode = process_error(pdu, length);
-		goto done;
-	}
-
-	if (opcode != BT_ATT_OP_READ_RSP || (!pdu && length)) {
-		success = false;
-		goto done;
-	}
-
-	success = true;
-	value_len = length;
-	if (value_len)
-		value = pdu;
-
-done:
-	if (op->callback)
-		op->callback(success, att_ecode, value, length, op->user_data);
-}
-
-bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
-					bt_gatt_read_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy)
-{
-	struct read_op *op;
-	uint8_t pdu[2];
-
-	if (!att)
-		return false;
-
-	op = new0(struct read_op, 1);
-	if (!op)
-		return false;
-
-	op->callback = callback;
-	op->user_data = user_data;
-	op->destroy = destroy;
-
-	put_le16(value_handle, pdu);
-
-	if (!bt_att_send(att, BT_ATT_OP_READ_REQ, pdu, sizeof(pdu),
-							read_cb, op,
-							destroy_read_op)) {
-		free(op);
-		return false;
-	}
-
-	return true;
-}
-
 struct read_long_op {
 	struct bt_att *att;
 	int ref_count;
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 443e6c5..1433a68 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -93,10 +93,6 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
 
-bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
-					bt_gatt_read_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy);
 bool bt_gatt_read_long_value(struct bt_att *att,
 					uint16_t value_handle, uint16_t offset,
 					bt_gatt_read_callback_t callback,
-- 
2.1.0.rc2.206.gedb03e5

