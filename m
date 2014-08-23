Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 10/13] shared/gatt-client: Add service iterator functions.
Date: Fri, 22 Aug 2014 17:47:44 -0700
Message-Id: <1408754867-13313-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1408754867-13313-1-git-send-email-armansito@chromium.org>
References: <1408754867-13313-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces high-level structures and functions for iterating through,
and storing, data about the discovered services.
---
 src/shared/gatt-client.c | 148 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/gatt-client.h |  41 +++++++++++++
 2 files changed, 185 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 7a76234..17b2f56 100644
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
 	int ref_count;
@@ -43,9 +50,61 @@ struct bt_gatt_client {
 	bt_gatt_client_destroy_func_t debug_destroy;
 	void *debug_data;
 
+	struct service_list *svc_head, *svc_tail;
 	bool in_init;
+	bool ready;
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
 struct async_op {
 	struct bt_gatt_client *client;
 	int ref_count;
@@ -76,7 +135,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 	struct bt_gatt_client *client = op->client;
 	struct bt_gatt_iter iter;
 	uint16_t start, end;
-	uint8_t uuid[16];
+	uint8_t uuid[BT_GATT_UUID_SIZE];
 	char uuid_str[MAX_LEN_UUID_STR];
 	bt_uuid_t tmp;
 
@@ -98,8 +157,6 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 					bt_gatt_result_service_count(result));
 
 	while (bt_gatt_iter_next_service(&iter, &start, &end, uuid)) {
-		/* TODO: discover characteristics and store the service. */
-
 		/* Log debug message. */
 		tmp.type = BT_UUID128;
 		memcpy(tmp.value.u128.data, uuid, sizeof(uuid));
@@ -107,11 +164,25 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
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
+		client->ready = true;
+
 	if (client->ready_callback)
 		client->ready_callback(success, att_ecode, client->ready_data);
 }
@@ -160,7 +231,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 {
 	struct async_op *op;
 
-	if (client->in_init)
+	if (client->in_init || client->ready)
 		return false;
 
 	op = new0(struct async_op, 1);
@@ -231,6 +302,11 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 	free(client);
 }
 
+bool bt_gatt_client_is_ready(struct bt_gatt_client *client)
+{
+	return (client && client->ready);
+}
+
 bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
@@ -265,3 +341,67 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 
 	return true;
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
index 45c6010..f724c3c 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -23,6 +23,9 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#include <stddef.h>
+
+#define BT_GATT_UUID_SIZE 16
 
 struct bt_gatt_client;
 
@@ -36,6 +39,7 @@ typedef void (*bt_gatt_client_callback_t)(bool success, uint8_t att_ecode,
 							void *user_data);
 typedef void (*bt_gatt_client_debug_func_t)(const char *str, void *user_data);
 
+bool bt_gatt_client_is_ready(struct bt_gatt_client *client);
 bool bt_gatt_client_set_ready_handler(struct bt_gatt_client *client,
 					bt_gatt_client_callback_t callback,
 					void *user_data,
@@ -46,3 +50,40 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
 
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

