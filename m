Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 09/11] shared/gatt-client: Add service iterator functions.
Date: Wed, 20 Aug 2014 13:15:35 -0700
Message-Id: <1408565737-8187-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1408565737-8187-1-git-send-email-armansito@chromium.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces high-level structures and functions for iterating through,
and storing, data about the discovered services.
---
 src/shared/TODO          |   1 -
 src/shared/gatt-client.c | 153 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/gatt-client.h |  42 +++++++++++++
 3 files changed, 191 insertions(+), 5 deletions(-)

diff --git a/src/shared/TODO b/src/shared/TODO
index 6f51890..8ffaacf 100644
--- a/src/shared/TODO
+++ b/src/shared/TODO
@@ -1,6 +1,5 @@
 TODOs for shared/gatt-client
 
-* Add high-level abstraction for services, characteristics, and descriptors.
 * Implement characteristic discovery.
 * Implement descriptor discovery.
 * Handle request timeouts.
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a46ff4e..f25b5b7 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -31,6 +31,13 @@
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
 #endif
 
+#define UUID_BYTES BT_GATT_UUID_SIZE * sizeof(uint8_t)
+
+struct service_list {
+	bt_gatt_service_t service;
+	struct service_list *next;
+};
+
 struct bt_gatt_client {
 	struct bt_att *att;
 	bool persist;
@@ -39,9 +46,66 @@ struct bt_gatt_client {
 	bt_gatt_client_destroy_func_t debug_destroy;
 	void *debug_data;
 
+	struct service_list *svc_head, *svc_tail;
 	bool in_init;
+	bool initialized;
+
+	/* GATT service handles */
+	uint16_t gatt_sv_handle;
+	uint16_t svcc_handle;
+	uint16_t svc_ccc_handle;
 };
 
+static bool gatt_client_add_service(struct bt_gatt_client *client,
+						uint16_t start, uint16_t end,
+						uint8_t uuid[BT_GATT_UUID_SIZE])
+{
+	struct service_list *list;
+
+	list = new0(struct service_list, 1);
+	if (!list)
+		return false;
+
+	list->service.start_handle = start;
+	list->service.end_handle = end;
+	memcpy(list->service.uuid, uuid, UUID_BYTES);
+
+	if (!client->svc_head)
+		client->svc_head = client->svc_tail = list;
+	else {
+		client->svc_tail->next = list;
+		client->svc_tail = list;
+	}
+
+	return true;
+}
+
+static void service_destroy_characteristics(bt_gatt_service_t *service)
+{
+	unsigned int i;
+
+	for (i = 0; i < service->num_chrcs; i++)
+		free((bt_gatt_descriptor_t *) service->chrcs[i].descs);
+
+	free((bt_gatt_characteristic_t *) service->chrcs);
+}
+
+static void gatt_client_clear_services(struct bt_gatt_client *client)
+{
+	struct service_list *l, *tmp;
+
+	l = client->svc_head;
+
+	while (l) {
+		service_destroy_characteristics(&l->service);
+		tmp = l;
+		l = tmp->next;
+		free(tmp);
+	}
+
+	client->svc_head = client->svc_tail = NULL;
+}
+
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att)
 {
 	struct bt_gatt_client *client;
@@ -142,7 +206,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 	struct bt_gatt_client *client = op->client;
 	struct bt_gatt_iter iter;
 	uint16_t start, end;
-	uint8_t uuid[16];
+	uint8_t uuid[BT_GATT_UUID_SIZE];
 	char uuid_str[MAX_LEN_UUID_STR];
 	bt_uuid_t tmp;
 
@@ -164,8 +228,6 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 					bt_gatt_result_service_count(result));
 
 	while (bt_gatt_iter_next_service(&iter, &start, &end, uuid)) {
-		/* TODO: discover characteristics and store the service. */
-
 		/* Log debug message. */
 		tmp.type = BT_UUID128;
 		memcpy(tmp.value.u128.data, uuid, sizeof(uuid));
@@ -173,11 +235,25 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 		util_debug(client->debug_callback, client->debug_data,
 				"start: 0x%04x, end: 0x%04x, uuid: %s",
 				start, end, uuid_str);
+
+		/* Store the service */
+		if (!gatt_client_add_service(client, start, end, uuid)) {
+			util_debug(client->debug_callback, client->debug_data,
+						"Failed to store service");
+
+			gatt_client_clear_services(client);
+
+			success = false;
+			goto done;
+		}
 	}
 
 done:
 	client->in_init = false;
 
+	if (success)
+		client->initialized = true;
+
 	if (op->callback)
 		op->callback(success, att_ecode, op->user_data);
 }
@@ -228,7 +304,7 @@ bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
 {
 	struct async_op *op;
 
-	if (!client || client->in_init)
+	if (!client || client->in_init || client->initialized)
 		return false;
 
 	op = new0(struct async_op, 1);
@@ -254,6 +330,11 @@ bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
 	return true;
 }
 
+bool bt_gatt_client_is_initialized(struct bt_gatt_client *client)
+{
+	return (client && client->initialized);
+}
+
 unsigned int bt_gatt_client_register_service_changed(
 				struct bt_gatt_client *client,
 				uint16_t handle,
@@ -271,3 +352,67 @@ bool bt_gatt_client_unregister_service_changed(struct bt_gatt_client *client,
 	// TODO
 	return false;
 }
+
+bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
+						struct bt_gatt_client *client)
+{
+	if (!iter || !client)
+		return false;
+
+	if (client->in_init)
+		return false;
+
+	memset(iter, 0, sizeof(*iter));
+	iter->client = client;
+	iter->ptr = NULL;
+
+	return true;
+}
+
+bool bt_gatt_service_iter_next(struct bt_gatt_service_iter *iter,
+						bt_gatt_service_t *service)
+{
+	struct service_list *l;
+
+	if (!iter || !service)
+		return false;
+
+	l = iter->ptr;
+
+	if (!l)
+		l = iter->client->svc_head;
+	else
+		l = l->next;
+
+	if (!l)
+		return false;
+
+	*service = l->service;
+	iter->ptr = l;
+
+	return true;
+}
+
+bool bt_gatt_service_iter_next_by_handle(struct bt_gatt_service_iter *iter,
+						uint16_t start_handle,
+						bt_gatt_service_t *service)
+{
+	while (bt_gatt_service_iter_next(iter, service)) {
+		if (service->start_handle == start_handle)
+			return true;
+	}
+
+	return false;
+}
+
+bool bt_gatt_service_iter_next_by_uuid(struct bt_gatt_service_iter *iter,
+					const uint8_t uuid[BT_GATT_UUID_SIZE],
+					bt_gatt_service_t *service)
+{
+	while (bt_gatt_service_iter_next(iter, service)) {
+		if (memcmp(service->uuid, uuid, UUID_BYTES) == 0)
+			return true;
+	}
+
+	return false;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 7a46cca..97033f8 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -23,6 +23,9 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#include <stddef.h>
+
+#define BT_GATT_UUID_SIZE 16
 
 struct bt_gatt_client;
 
@@ -50,6 +53,7 @@ bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
+bool bt_gatt_client_is_initialized(struct bt_gatt_client *client);
 
 unsigned int bt_gatt_client_register_service_changed(
 				struct bt_gatt_client *client,
@@ -59,3 +63,41 @@ unsigned int bt_gatt_client_register_service_changed(
 				bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_unregister_service_changed(struct bt_gatt_client *client,
 							unsigned int id);
+
+typedef struct {
+	uint16_t handle;
+	uint8_t uuid[BT_GATT_UUID_SIZE];
+} bt_gatt_descriptor_t;
+
+typedef struct {
+	uint16_t handle;
+	uint16_t value_handle;
+	uint8_t properties;
+	uint8_t uuid[BT_GATT_UUID_SIZE];
+	const bt_gatt_descriptor_t *descs;
+	size_t num_descs;
+} bt_gatt_characteristic_t;
+
+typedef struct {
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint8_t uuid[BT_GATT_UUID_SIZE];
+	const bt_gatt_characteristic_t *chrcs;
+	size_t num_chrcs;
+} bt_gatt_service_t;
+
+struct bt_gatt_service_iter {
+	struct bt_gatt_client *client;
+	void *ptr;
+};
+
+bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
+						struct bt_gatt_client *client);
+bool bt_gatt_service_iter_next(struct bt_gatt_service_iter *iter,
+						bt_gatt_service_t *service);
+bool bt_gatt_service_iter_next_by_handle(struct bt_gatt_service_iter *iter,
+						uint16_t start_handle,
+						bt_gatt_service_t *service);
+bool bt_gatt_service_iter_next_by_uuid(struct bt_gatt_service_iter *iter,
+					const uint8_t uuid[BT_GATT_UUID_SIZE],
+					bt_gatt_service_t *service);
-- 
2.1.0.rc2.206.gedb03e5

