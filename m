Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/7] shared/gatt-client: Implement bt_gatt_client_register_notify.
Date: Mon,  8 Sep 2014 18:03:06 -0700
Message-Id: <1410224591-5402-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1410224591-5402-1-git-send-email-armansito@chromium.org>
References: <1410224591-5402-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the bt_gatt_client_register_notify and
bt_gatt_client_unregister_notify functions and implements the latter. The
bt_gatt_client_register_notify function does the following:

  - If the given characteristic has a CCC descriptor, it writes to it based on
    which notify/indicate properties are present in the characteristic
    properties bit field.

  - It maintains a per-characteristic count of how many callbacks have been
    registered, so that the CCC descriptor is written to only if the count is 0.

  - It stores the passed in callback and user data in bt_gatt_client, which will
    be invoked when a notification/indication is received from the corresponding
    characteristic.

  - It queues register requests if the count is 0 and a CCC write is pending,
    and processes them once the write request has completed.
---
 src/shared/gatt-client.c | 321 +++++++++++++++++++++++++++++++++++++++++++----
 src/shared/gatt-client.h |  25 ++++
 2 files changed, 323 insertions(+), 23 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index fd866b2..d1b5c12 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -28,6 +28,9 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 
+#include <assert.h>
+#include <limits.h>
+
 #ifndef MAX
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
 #endif
@@ -38,9 +41,21 @@
 
 #define UUID_BYTES (BT_GATT_UUID_SIZE * sizeof(uint8_t))
 
+struct chrc_data {
+	bt_gatt_characteristic_t chrc;
+	uint16_t ccc_handle;
+	int not_ref_count;
+
+	/* Pending calls to register_notify are queued here so that they can be
+	 * processed after a write that modifies the CCC descriptor.
+	 */
+	struct queue *register_not_queue;
+	unsigned int ccc_write_id;
+};
+
 struct service_list {
 	bt_gatt_service_t service;
-	bt_gatt_characteristic_t *chrcs;
+	struct chrc_data *chrcs;
 	size_t num_chrcs;
 	struct service_list *next;
 };
@@ -69,6 +84,10 @@ struct bt_gatt_client {
 	 */
 	struct queue *long_write_queue;
 	bool in_long_write;
+
+	/* List of registered notification/indication callbacks */
+	struct queue *notify_list;
+	int next_reg_id;
 };
 
 static bool gatt_client_add_service(struct bt_gatt_client *client,
@@ -95,12 +114,17 @@ static bool gatt_client_add_service(struct bt_gatt_client *client,
 	return true;
 }
 
+static void notify_data_unref(void *data);
+
 static void service_destroy_characteristics(struct service_list *service)
 {
 	unsigned int i;
 
-	for (i = 0; i < service->num_chrcs; i++)
-		free((bt_gatt_descriptor_t *) service->chrcs[i].descs);
+	for (i = 0; i < service->num_chrcs; i++) {
+		free((bt_gatt_descriptor_t *) service->chrcs[i].chrc.descs);
+		queue_destroy(service->chrcs[i].register_not_queue,
+							notify_data_unref);
+	}
 
 	free(service->chrcs);
 }
@@ -124,7 +148,7 @@ static void gatt_client_clear_services(struct bt_gatt_client *client)
 struct discovery_op {
 	struct bt_gatt_client *client;
 	struct service_list *cur_service;
-	bt_gatt_characteristic_t *cur_chrc;
+	struct chrc_data *cur_chrc;
 	int cur_chrc_index;
 	int ref_count;
 };
@@ -176,6 +200,20 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
 
+static int uuid_cmp(const uint8_t uuid128[16], uint16_t uuid16)
+{
+	uint16_t be16;
+	uint8_t rhs_uuid[16] = {
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+		0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
+	};
+
+	be16 = htons(uuid16);
+	memcpy(rhs_uuid + 2, &be16, sizeof(be16));
+
+	return memcmp(uuid128, rhs_uuid, sizeof(rhs_uuid));
+}
+
 static void discover_descs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -225,22 +263,26 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 		util_debug(client->debug_callback, client->debug_data,
 						"handle: 0x%04x, uuid: %s",
 						descs[i].handle, uuid_str);
+
+		if (uuid_cmp(descs[i].uuid, GATT_CLIENT_CHARAC_CFG_UUID) == 0)
+			op->cur_chrc->ccc_handle = descs[i].handle;
+
 		i++;
 	}
 
-	op->cur_chrc->num_descs = desc_count;
-	op->cur_chrc->descs = descs;
+	op->cur_chrc->chrc.num_descs = desc_count;
+	op->cur_chrc->chrc.descs = descs;
 
 	for (i = op->cur_chrc_index + 1; i < op->cur_service->num_chrcs; i++) {
 		op->cur_chrc_index = i;
 		op->cur_chrc++;
-		desc_start = op->cur_chrc->value_handle + 1;
-		if (desc_start > op->cur_chrc->end_handle)
+		desc_start = op->cur_chrc->chrc.value_handle + 1;
+		if (desc_start > op->cur_chrc->chrc.end_handle)
 			continue;
 
 		if (bt_gatt_discover_descriptors(client->att,
 						desc_start,
-						op->cur_chrc->end_handle,
+						op->cur_chrc->chrc.end_handle,
 						discover_descs_cb,
 						discovery_op_ref(op),
 						discovery_op_unref))
@@ -288,7 +330,7 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	unsigned int chrc_count;
 	unsigned int i;
 	uint16_t desc_start;
-	bt_gatt_characteristic_t *chrcs;
+	struct chrc_data *chrcs;
 
 	if (!success) {
 		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
@@ -311,25 +353,35 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	if (chrc_count == 0)
 		goto next;
 
-	chrcs = new0(bt_gatt_characteristic_t, chrc_count);
+	chrcs = new0(struct chrc_data, chrc_count);
 	if (!chrcs) {
 		success = false;
 		goto done;
 	}
 
 	i = 0;
-	while (bt_gatt_iter_next_characteristic(&iter, &chrcs[i].start_handle,
-							&chrcs[i].end_handle,
-							&chrcs[i].value_handle,
-							&chrcs[i].properties,
-							chrcs[i].uuid)) {
-		uuid_to_string(chrcs[i].uuid, uuid_str);
+	while (bt_gatt_iter_next_characteristic(&iter,
+						&chrcs[i].chrc.start_handle,
+						&chrcs[i].chrc.end_handle,
+						&chrcs[i].chrc.value_handle,
+						&chrcs[i].chrc.properties,
+						chrcs[i].chrc.uuid)) {
+		uuid_to_string(chrcs[i].chrc.uuid, uuid_str);
 		util_debug(client->debug_callback, client->debug_data,
 				"start: 0x%04x, end: 0x%04x, value: 0x%04x, "
 				"props: 0x%02x, uuid: %s",
-				chrcs[i].start_handle, chrcs[i].end_handle,
-				chrcs[i].value_handle, chrcs[i].properties,
+				chrcs[i].chrc.start_handle,
+				chrcs[i].chrc.end_handle,
+				chrcs[i].chrc.value_handle,
+				chrcs[i].chrc.properties,
 				uuid_str);
+
+		chrcs[i].register_not_queue = queue_new();
+		if (!chrcs[i].register_not_queue) {
+			success = false;
+			goto done;
+		}
+
 		i++;
 	}
 
@@ -339,12 +391,13 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 	for (i = 0; i < chrc_count; i++) {
 		op->cur_chrc_index = i;
 		op->cur_chrc = chrcs + i;
-		desc_start = chrcs[i].value_handle + 1;
-		if (desc_start > chrcs[i].end_handle)
+		desc_start = chrcs[i].chrc.value_handle + 1;
+		if (desc_start > chrcs[i].chrc.end_handle)
 			continue;
 
 		if (bt_gatt_discover_descriptors(client->att,
-						desc_start, chrcs[i].end_handle,
+						desc_start,
+						chrcs[i].chrc.end_handle,
 						discover_descs_cb,
 						discovery_op_ref(op),
 						discovery_op_unref))
@@ -533,6 +586,13 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 		return NULL;
 	}
 
+	client->notify_list = queue_new();
+	if (!client->notify_list) {
+		queue_destroy(client->long_write_queue, NULL);
+		free(client);
+		return NULL;
+	}
+
 	client->att = bt_att_ref(att);
 
 	gatt_client_init(client, mtu);
@@ -567,6 +627,7 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 		client->debug_destroy(client->debug_data);
 
 	queue_destroy(client->long_write_queue, long_write_op_unref);
+	queue_destroy(client->notify_list, notify_data_unref);
 	bt_att_unref(client->att);
 	free(client);
 }
@@ -700,7 +761,7 @@ bool bt_gatt_characteristic_iter_next(struct bt_gatt_characteristic_iter *iter,
 	if (iter->pos >= service->num_chrcs)
 		return false;
 
-	*chrc = service->chrcs + iter->pos++;
+	*chrc = &service->chrcs[iter->pos++].chrc;
 
 	return true;
 }
@@ -1387,3 +1448,217 @@ bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 
 	return true;
 }
+
+struct notify_data {
+	struct bt_gatt_client *client;
+	unsigned int id;
+	int ref_count;
+	struct chrc_data *chrc;
+	bt_gatt_client_notify_id_callback_t callback;
+	bt_gatt_client_notify_callback_t notify;
+	void *user_data;
+	bt_gatt_client_destroy_func_t destroy;
+};
+
+static struct notify_data *notify_data_ref(struct notify_data *notd)
+{
+	__sync_fetch_and_add(&notd->ref_count, 1);
+
+	return notd;
+}
+
+static void notify_data_unref(void *data)
+{
+	struct notify_data *notd = data;
+
+	if (__sync_sub_and_fetch(&notd->ref_count, 1))
+		return;
+
+	if (notd->destroy)
+		notd->destroy(notd->user_data);
+
+	free(notd);
+}
+
+static void complete_notify_request(void *data)
+{
+	struct notify_data *notd = data;
+
+	/* Increment the per-characteristic ref count of notify handlers */
+	__sync_fetch_and_add(&notd->chrc->not_ref_count, 1);
+
+	/* Add the handler to the bt_gatt_client's general list */
+	queue_push_tail(notd->client->notify_list, notify_data_ref(notd));
+
+	/* Assign an ID to the handler and notify the caller that it was
+	 * successfully registered.
+	 */
+	if (notd->client->next_reg_id < 1)
+		notd->client->next_reg_id = 1;
+
+	notd->id = notd->client->next_reg_id++;
+	notd->callback(notd->id, 0, notd->user_data);
+}
+
+static bool notify_data_write_ccc(struct notify_data *notd, bool enable);
+
+static void enable_ccc_callback(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct notify_data *notd = user_data;
+	uint16_t att_ecode;
+
+	assert(!notd->chrc->not_ref_count);
+	assert(notd->chrc->ccc_write_id);
+
+	notd->chrc->ccc_write_id = 0;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		att_ecode = process_error(pdu, length);
+
+		/* Failed to enable. Complete the current request and move on to
+		 * the next one in the queue. If there was an error sending the
+		 * write request, then just move on to the next queued entry.
+		 */
+		notd->callback(0, att_ecode, notd->user_data);
+
+		while ((notd = queue_pop_head(
+					notd->chrc->register_not_queue))) {
+
+			if (notify_data_write_ccc(notd, true))
+				return;
+		}
+
+		return;
+	}
+
+	/* Success! Report success for all remaining requests. */
+	complete_notify_request(notd);
+	queue_remove_all(notd->chrc->register_not_queue, NULL, NULL,
+						complete_notify_request);
+}
+
+static void disable_ccc_callback(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	/* TODO */
+}
+
+static bool notify_data_write_ccc(struct notify_data *notd, bool enable)
+{
+	uint8_t pdu[4];
+
+	memset(pdu, 0, sizeof(pdu));
+	put_le16(notd->chrc->ccc_handle, pdu);
+
+	if (enable) {
+		/* Try to enable notifications and/or indications based on
+		 * whatever the characteristic supports.
+		 */
+		if (notd->chrc->chrc.properties & BT_GATT_CHRC_PROP_NOTIFY)
+			pdu[2] = 0x01;
+
+		if (notd->chrc->chrc.properties & BT_GATT_CHRC_PROP_INDICATE)
+			pdu[2] |= 0x02;
+
+		if (!pdu[2])
+			return false;
+	}
+
+	notd->chrc->ccc_write_id = bt_att_send(notd->client->att,
+			BT_ATT_OP_WRITE_REQ,
+			pdu, sizeof(pdu),
+			(enable ? enable_ccc_callback : disable_ccc_callback),
+			notd, notify_data_unref);
+
+	return !!notd->chrc->ccc_write_id;
+}
+
+bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
+				uint16_t chrc_value_handle,
+				bt_gatt_client_notify_id_callback_t callback,
+				bt_gatt_client_notify_callback_t notify,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy)
+{
+	struct notify_data *notd;
+	struct service_list *svc_data = NULL;
+	struct chrc_data *chrc = NULL;
+	struct bt_gatt_service_iter iter;
+	const bt_gatt_service_t *service;
+	size_t i;
+
+	if (!client || !chrc_value_handle || !callback)
+		return false;
+
+	if (!bt_gatt_client_is_ready(client))
+		return false;
+
+	/* Check that chrc_value_handle belongs to a known characteristic */
+	if (!bt_gatt_service_iter_init(&iter, client))
+		return false;
+
+	while (bt_gatt_service_iter_next(&iter, &service)) {
+		if (chrc_value_handle >= service->start_handle &&
+				chrc_value_handle <= service->end_handle) {
+			svc_data = (struct service_list *) service;
+			break;
+		}
+	}
+
+	if (!svc_data)
+		return false;
+
+	for (i = 0; i < svc_data->num_chrcs; i++) {
+		if (svc_data->chrcs[i].chrc.value_handle == chrc_value_handle) {
+			chrc = svc_data->chrcs + i;
+			break;
+		}
+	}
+
+	/* Check that the characteristic supports notifications/indications */
+	if (!chrc || !chrc->ccc_handle || chrc->not_ref_count == INT_MAX)
+		return false;
+
+	notd = new0(struct notify_data, 1);
+	if (!notd)
+		return false;
+
+	notd->client = client;
+	notd->ref_count = 1;
+	notd->chrc = chrc;
+	notd->callback = callback;
+	notd->notify = notify;
+	notd->user_data = user_data;
+	notd->destroy = destroy;
+
+	/* If a write to the CCC descriptor is in progress, then queue this
+	 * request.
+	 */
+	if (chrc->ccc_write_id) {
+		queue_push_tail(chrc->register_not_queue, notd);
+		return true;
+	}
+
+	/* If the ref count is not zero, then notifications are already enabled.
+	 */
+	if (chrc->not_ref_count > 0) {
+		complete_notify_request(notd);
+		return true;
+	}
+
+	/* Write to the CCC descriptor */
+	if (!notify_data_write_ccc(notd, true)) {
+		free(notd);
+		return false;
+	}
+
+	return true;
+}
+
+bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
+							unsigned int id)
+{
+	/* TODO */
+	return false;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 417d964..7612a6e 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -27,6 +27,16 @@
 
 #define BT_GATT_UUID_SIZE 16
 
+#define BT_GATT_CHRC_PROP_BROADCAST			0x01
+#define BT_GATT_CHRC_PROP_READ				0x02
+#define BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP		0x04
+#define BT_GATT_CHRC_PROP_WRITE				0x08
+#define BT_GATT_CHRC_PROP_NOTIFY			0x10
+#define BT_GATT_CHRC_PROP_INDICATE			0x20
+#define BT_GATT_CHRC_PROP_AUTH				0x40
+#define BT_GATT_CHRC_PROP_EXT_PROP			0x80
+
+/* Client Characteristic Configuration bit field */
 struct bt_gatt_client;
 
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu);
@@ -41,6 +51,12 @@ typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_gatt_client_write_long_callback_t)(bool success,
 					bool reliable_error, uint8_t att_ecode,
 					void *user_data);
+typedef void (*bt_gatt_client_notify_callback_t)(uint16_t value_handle,
+					const uint8_t *value, uint16_t length,
+					void *user_data);
+typedef void (*bt_gatt_client_notify_id_callback_t)(unsigned int id,
+							uint16_t att_ecode,
+							void *user_data);
 
 bool bt_gatt_client_is_ready(struct bt_gatt_client *client);
 bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
@@ -131,3 +147,12 @@ bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 				bt_gatt_client_write_long_callback_t callback,
 				void *user_data,
 				bt_gatt_client_destroy_func_t destroy);
+
+bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
+				uint16_t chrc_value_handle,
+				bt_gatt_client_notify_id_callback_t callback,
+				bt_gatt_client_notify_callback_t notify,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy);
+bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
+							unsigned int id);
-- 
2.1.0.rc2.206.gedb03e5

