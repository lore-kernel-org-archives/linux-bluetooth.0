Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 11/13] shared/gatt-client: Implement characteristic discovery.
Date: Fri, 22 Aug 2014 17:47:45 -0700
Message-Id: <1408754867-13313-12-git-send-email-armansito@chromium.org>
In-Reply-To: <1408754867-13313-1-git-send-email-armansito@chromium.org>
References: <1408754867-13313-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements characteristic discovery as part of the client
initialization flow. The characteristics of each service are discovered in
order.
---
 src/shared/gatt-client.c | 142 ++++++++++++++++++++++++++++++++++++++++++-----
 src/shared/gatt-client.h |   3 +-
 2 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 17b2f56..6b18e91 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -107,6 +107,7 @@ static void gatt_client_clear_services(struct bt_gatt_client *client)
 
 struct async_op {
 	struct bt_gatt_client *client;
+	struct service_list *cur_service;
 	int ref_count;
 };
 
@@ -127,6 +128,113 @@ static void async_op_unref(void *data)
 	free(data);
 }
 
+static void async_op_complete(struct async_op *op, bool success,
+							uint8_t att_ecode)
+{
+	struct bt_gatt_client *client = op->client;
+
+	client->in_init = false;
+
+	if (success)
+		client->ready = true;
+	else
+		gatt_client_clear_services(client);
+
+	if (client->ready_callback)
+		client->ready_callback(success, att_ecode, client->ready_data);
+}
+
+static void uuid_to_string(const uint8_t uuid[BT_GATT_UUID_SIZE],
+						char str[MAX_LEN_UUID_STR])
+{
+	bt_uuid_t tmp;
+
+	tmp.type = BT_UUID128;
+	memcpy(tmp.value.u128.data, uuid, UUID_BYTES);
+	bt_uuid_to_string(&tmp, str, MAX_LEN_UUID_STR * sizeof(char));
+}
+
+static void discover_chrcs_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	struct async_op *op = user_data;
+	struct bt_gatt_client *client = op->client;
+	struct bt_gatt_iter iter;
+	char uuid_str[MAX_LEN_UUID_STR];
+	unsigned int chrc_count;
+	unsigned int i;
+	bt_gatt_characteristic_t *chrcs;
+
+	if (!success) {
+		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
+			success = true;
+			goto next;
+		}
+
+		goto done;
+	}
+
+	if (!result || !bt_gatt_iter_init(&iter, result)) {
+		success = false;
+		goto done;
+	}
+
+	chrc_count = bt_gatt_result_characteristic_count(result);
+	util_debug(client->debug_callback, client->debug_data,
+				"Characteristics found: %u", chrc_count);
+
+	if (chrc_count == 0)
+		goto next;
+
+	chrcs = new0(bt_gatt_characteristic_t, chrc_count);
+	if (!chrcs) {
+		success = false;
+		goto done;
+	}
+
+	i = 0;
+	while (bt_gatt_iter_next_characteristic(&iter, &chrcs[i].start_handle,
+							&chrcs[i].end_handle,
+							&chrcs[i].value_handle,
+							&chrcs[i].properties,
+							chrcs[i].uuid)) {
+		uuid_to_string(chrcs[i].uuid, uuid_str);
+		util_debug(client->debug_callback, client->debug_data,
+				"start: 0x%04x, end: 0x%04x, value: 0x%04x, "
+				"props: 0x%02x, uuid: %s",
+				chrcs[i].start_handle, chrcs[i].end_handle,
+				chrcs[i].value_handle, chrcs[i].properties,
+				uuid_str);
+		i++;
+	}
+
+	op->cur_service->service.chrcs = chrcs;
+	op->cur_service->service.num_chrcs = chrc_count;
+
+next:
+	if (!op->cur_service->next)
+		goto done;
+
+	/* Move on to the next service */
+	op->cur_service = op->cur_service->next;
+	if (bt_gatt_discover_characteristics(client->att,
+					op->cur_service->service.start_handle,
+					op->cur_service->service.end_handle,
+					discover_chrcs_cb,
+					async_op_ref(op),
+					async_op_unref))
+		return;
+
+	util_debug(client->debug_callback, client->debug_data,
+				"Failed to start characteristic discovery");
+	async_op_unref(op);
+	success = false;
+
+done:
+	async_op_complete(op, success, att_ecode);
+}
+
 static void discover_primary_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -137,7 +245,6 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 	uint16_t start, end;
 	uint8_t uuid[BT_GATT_UUID_SIZE];
 	char uuid_str[MAX_LEN_UUID_STR];
-	bt_uuid_t tmp;
 
 	if (!success) {
 		util_debug(client->debug_callback, client->debug_data,
@@ -148,7 +255,6 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 
 	if (!result || !bt_gatt_iter_init(&iter, result)) {
 		success = false;
-		att_ecode = 0;
 		goto done;
 	}
 
@@ -158,9 +264,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 
 	while (bt_gatt_iter_next_service(&iter, &start, &end, uuid)) {
 		/* Log debug message. */
-		tmp.type = BT_UUID128;
-		memcpy(tmp.value.u128.data, uuid, sizeof(uuid));
-		bt_uuid_to_string(&tmp, uuid_str, sizeof(uuid_str));
+		uuid_to_string(uuid, uuid_str);
 		util_debug(client->debug_callback, client->debug_data,
 				"start: 0x%04x, end: 0x%04x, uuid: %s",
 				start, end, uuid_str);
@@ -169,22 +273,32 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		if (!gatt_client_add_service(client, start, end, uuid)) {
 			util_debug(client->debug_callback, client->debug_data,
 						"Failed to store service");
-
-			gatt_client_clear_services(client);
-
 			success = false;
 			goto done;
 		}
 	}
 
-done:
-	client->in_init = false;
+	/* Complete the process if the service list is empty */
+	if (!client->svc_head)
+		goto done;
 
-	if (success)
-		client->ready = true;
+	/* Sequentially discover the characteristics of all services */
+	op->cur_service = client->svc_head;
+	if (bt_gatt_discover_characteristics(client->att,
+					op->cur_service->service.start_handle,
+					op->cur_service->service.end_handle,
+					discover_chrcs_cb,
+					async_op_ref(op),
+					async_op_unref))
+		return;
 
-	if (client->ready_callback)
-		client->ready_callback(success, att_ecode, client->ready_data);
+	util_debug(client->debug_callback, client->debug_data,
+				"Failed to start characteristic discovery");
+	async_op_unref(op);
+	success = false;
+
+done:
+	async_op_complete(op, success, att_ecode);
 }
 
 static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index f724c3c..b93836d 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -56,7 +56,8 @@ typedef struct {
 } bt_gatt_descriptor_t;
 
 typedef struct {
-	uint16_t handle;
+	uint16_t start_handle;
+	uint16_t end_handle;
 	uint16_t value_handle;
 	uint8_t properties;
 	uint8_t uuid[BT_GATT_UUID_SIZE];
-- 
2.1.0.rc2.206.gedb03e5

