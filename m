Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 12/13] shared/gatt-client: Implement descriptor discovery.
Date: Fri, 22 Aug 2014 17:47:46 -0700
Message-Id: <1408754867-13313-13-git-send-email-armansito@chromium.org>
In-Reply-To: <1408754867-13313-1-git-send-email-armansito@chromium.org>
References: <1408754867-13313-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements characteristic descriptor discovery as part of the client
initialization flow.
---
 src/shared/gatt-client.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 6b18e91..ba27224 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -108,6 +108,8 @@ static void gatt_client_clear_services(struct bt_gatt_client *client)
 struct async_op {
 	struct bt_gatt_client *client;
 	struct service_list *cur_service;
+	bt_gatt_characteristic_t *cur_chrc;
+	int cur_chrc_index;
 	int ref_count;
 };
 
@@ -156,6 +158,112 @@ static void uuid_to_string(const uint8_t uuid[BT_GATT_UUID_SIZE],
 
 static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
+						void *user_data);
+
+static void discover_descs_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	struct async_op *op = user_data;
+	struct bt_gatt_client *client = op->client;
+	struct bt_gatt_iter iter;
+	char uuid_str[MAX_LEN_UUID_STR];
+	unsigned int desc_count;
+	uint16_t desc_start;
+	unsigned int i;
+	bt_gatt_descriptor_t *descs;
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
+	desc_count = bt_gatt_result_descriptor_count(result);
+	if (desc_count == 0) {
+		success = false;
+		goto done;
+	}
+
+	util_debug(client->debug_callback, client->debug_data,
+					"Descriptors found: %u", desc_count);
+
+	descs = new0(bt_gatt_descriptor_t, desc_count);
+	if (!descs) {
+		success = false;
+		goto done;
+	}
+
+	i = 0;
+	while (bt_gatt_iter_next_descriptor(&iter, &descs[i].handle,
+							descs[i].uuid)) {
+		uuid_to_string(descs[i].uuid, uuid_str);
+		util_debug(client->debug_callback, client->debug_data,
+						"handle: 0x%04x, uuid: %s",
+						descs[i].handle, uuid_str);
+		i++;
+	}
+
+	op->cur_chrc->num_descs = desc_count;
+	op->cur_chrc->descs = descs;
+
+	for (i = op->cur_chrc_index;
+				i < op->cur_service->service.num_chrcs; i++) {
+		op->cur_chrc_index = i;
+		op->cur_chrc++;
+		desc_start = op->cur_chrc->value_handle + 1;
+		if (desc_start > op->cur_chrc->end_handle)
+			continue;
+
+		if (bt_gatt_discover_descriptors(client->att,
+						desc_start,
+						op->cur_chrc->end_handle,
+						discover_descs_cb,
+						async_op_ref(op),
+						async_op_unref))
+			return;
+
+		util_debug(client->debug_callback, client->debug_data,
+					"Failed to start descriptor discovery");
+		async_op_unref(op);
+		success = false;
+
+		goto done;
+	}
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
+static void discover_chrcs_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
 						void *user_data)
 {
 	struct async_op *op = user_data;
@@ -164,6 +272,7 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	char uuid_str[MAX_LEN_UUID_STR];
 	unsigned int chrc_count;
 	unsigned int i;
+	uint16_t desc_start;
 	bt_gatt_characteristic_t *chrcs;
 
 	if (!success) {
@@ -212,6 +321,28 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	op->cur_service->service.chrcs = chrcs;
 	op->cur_service->service.num_chrcs = chrc_count;
 
+	for (i = 0; i < chrc_count; i++) {
+		op->cur_chrc_index = i;
+		op->cur_chrc = chrcs + i;
+		desc_start = chrcs[i].value_handle + 1;
+		if (desc_start > chrcs[i].end_handle)
+			continue;
+
+		if (bt_gatt_discover_descriptors(client->att,
+						desc_start, chrcs[i].end_handle,
+						discover_descs_cb,
+						async_op_ref(op),
+						async_op_unref))
+			return;
+
+		util_debug(client->debug_callback, client->debug_data,
+					"Failed to start descriptor discovery");
+		async_op_unref(op);
+		success = false;
+
+		goto done;
+	}
+
 next:
 	if (!op->cur_service->next)
 		goto done;
-- 
2.1.0.rc2.206.gedb03e5

