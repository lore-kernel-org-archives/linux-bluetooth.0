Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ v6 5/5] gatt-client: Read extended props on service discovery
Date: Wed, 13 Apr 2016 23:09:57 +0200
Message-Id: <1460581797-3541-6-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1460581797-3541-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1460581797-3541-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now once extended props can be taken with characteristic data
we need to makes sure that after discovery correct value is in
database.

With this patch, value of all the extended properties descriptors
are read during discovery just after discover of descriptors
---
 src/shared/gatt-client.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++
 unit/test-gatt.c         |   2 +
 2 files changed, 116 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index ff49be1..84689f6 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -316,6 +316,7 @@ struct discovery_op {
 	struct queue *pending_svcs;
 	struct queue *pending_chrcs;
 	struct queue *svcs;
+	struct queue *ext_prop_desc;
 	struct gatt_db_attribute *cur_svc;
 	bool success;
 	uint16_t start;
@@ -331,6 +332,7 @@ static void discovery_op_free(struct discovery_op *op)
 	queue_destroy(op->pending_svcs, NULL);
 	queue_destroy(op->pending_chrcs, free);
 	queue_destroy(op->svcs, NULL);
+	queue_destroy(op->ext_prop_desc, NULL);
 	free(op);
 }
 
@@ -360,6 +362,7 @@ static struct discovery_op *discovery_op_create(struct bt_gatt_client *client,
 	op->pending_svcs = queue_new();
 	op->pending_chrcs = queue_new();
 	op->svcs = queue_new();
+	op->ext_prop_desc = queue_new();
 	op->client = client;
 	op->complete_func = complete_func;
 	op->failure_func = failure_func;
@@ -604,6 +607,107 @@ failed:
 	return false;
 }
 
+static void ext_prop_write_cb(struct gatt_db_attribute *attrib,
+						int err, void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+
+	util_debug(client->debug_callback, client->debug_data,
+						"Value set status: %d", err);
+}
+
+static void ext_prop_read_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
+
+static bool read_ext_prop_desc(struct discovery_op *op)
+{
+	struct bt_gatt_client *client = op->client;
+	uint16_t handle;
+	struct gatt_db_attribute *attr;
+
+	attr = queue_peek_head(op->ext_prop_desc);
+	if (!attr)
+		return false;
+
+	handle = gatt_db_attribute_get_handle(attr);
+	bt_gatt_client_read_value(client, handle, ext_prop_read_cb,
+							discovery_op_ref(op),
+							discovery_op_unref);
+
+	return true;
+}
+
+static void ext_prop_read_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct discovery_op *op = user_data;
+	struct bt_gatt_client *client = op->client;
+	bool discovering;
+	struct gatt_db_attribute *desc_attr = NULL;
+	struct gatt_db_attribute *next_srv;
+	uint16_t start, end;
+
+	util_debug(client->debug_callback, client->debug_data,
+				"Ext. prop value: 0x%04x", (uint16_t)value[0]);
+
+	desc_attr = queue_pop_head(op->ext_prop_desc);
+	if (!desc_attr)
+		goto failed;
+
+	if (!gatt_db_attribute_write(desc_attr, 0, value, length, 0, NULL,
+						ext_prop_write_cb, client))
+		goto failed;
+
+	/* Any other descriptor to read? */
+	if (read_ext_prop_desc(op))
+		return;
+
+	/* Continue with discovery */
+	do {
+		if (!discover_descs(op, &discovering))
+			goto failed;
+
+		if (discovering)
+			return;
+
+		/* Done with the current service */
+		gatt_db_service_set_active(op->cur_svc, true);
+
+		next_srv = queue_pop_head(op->svcs);
+		if (!next_srv)
+			goto done;
+
+		if (!gatt_db_attribute_get_service_handles(next_srv, &start,
+									&end))
+			goto failed;
+
+	} while (start == end);
+
+	/* Move on to the next service */
+	op->cur_svc = next_srv;
+
+	client->discovery_req = bt_gatt_discover_characteristics(client->att,
+							start, end,
+							discover_chrcs_cb,
+							discovery_op_ref(op),
+							discovery_op_unref);
+	if (client->discovery_req)
+		return;
+
+	util_debug(client->debug_callback, client->debug_data,
+				"Failed to start characteristic discovery");
+
+	discovery_op_unref(op);
+
+failed:
+	success = false;
+
+done:
+	discovery_op_complete(op, success, att_ecode);
+}
+
 static void discover_descs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -618,6 +722,7 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 	char uuid_str[MAX_LEN_UUID_STR];
 	unsigned int desc_count;
 	bool discovering;
+	bt_uuid_t ext_prop_uuid;
 
 	discovery_req_clear(client);
 
@@ -640,6 +745,8 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 	util_debug(client->debug_callback, client->debug_data,
 					"Descriptors found: %u", desc_count);
 
+	bt_uuid16_create(&ext_prop_uuid, GATT_CHARAC_EXT_PROPER_UUID);
+
 	while (bt_gatt_iter_next_descriptor(&iter, &handle, u128.data)) {
 		bt_uuid128_create(&uuid, u128);
 
@@ -657,8 +764,15 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 
 		if (gatt_db_attribute_get_handle(attr) != handle)
 			goto failed;
+
+		if (!bt_uuid_cmp(&ext_prop_uuid, &uuid))
+			queue_push_tail(op->ext_prop_desc, attr);
 	}
 
+	/* If we got extended prop descriptor, lets read it right away */
+	if (read_ext_prop_desc(op))
+		return;
+
 next:
 	if (!discover_descs(op, &discovering))
 		goto failed;
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 6e4dcee..8129719 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -267,6 +267,8 @@ struct context {
 		raw_pdu(0x01, 0x08, 0x18, 0xf0, 0x0a),			\
 		raw_pdu(0x04, 0x16, 0xf0, 0x16, 0xf0),			\
 		raw_pdu(0x05, 0x01, 0x16, 0xf0, 0x00, 0x29),		\
+		raw_pdu(0x0a, 0x16, 0xf0),				\
+		raw_pdu(0x0b, 0x01, 0x00),				\
 		raw_pdu(0x08, 0x01, 0x00, 0x10, 0x00, 0x03, 0x28),	\
 		raw_pdu(0x09, 0x07, 0x02, 0x00, 0xb2, 0x03, 0x00, 0x29,	\
 			0x2a),						\
-- 
2.5.0

