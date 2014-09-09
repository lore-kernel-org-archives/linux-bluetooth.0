Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/7] shared/gatt-client: Introduce struct bt_gatt_characteristic_iter.
Date: Mon,  8 Sep 2014 18:03:05 -0700
Message-Id: <1410224591-5402-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1410224591-5402-1-git-send-email-armansito@chromium.org>
References: <1410224591-5402-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

shared/gatt-client currently defines a service iterator which returns service
data in a copy. The user then accesses the service's characteristics by manually
going through an array of bt_gatt_characteristic_t.

This patch changes this by restricting access to individual characteristic
entries via a new characteristic iterator. This is done so that gatt-client code
can internally store private data on each characteristic (e.g. reference count
for notification sessions) which shouldn't be exposed to external code.

The code also changes the service iterator functions to return a pointer to an
internally stored bt_gatt_service_t structure rather than returning its contents
in a copy.
---
 src/shared/gatt-client.c | 59 ++++++++++++++++++++++++++++++++++++------------
 src/shared/gatt-client.h | 32 ++++++++++++++++----------
 tools/btgatt-client.c    | 31 ++++++++++++++-----------
 3 files changed, 83 insertions(+), 39 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1a157ec..fd866b2 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -40,6 +40,8 @@
 
 struct service_list {
 	bt_gatt_service_t service;
+	bt_gatt_characteristic_t *chrcs;
+	size_t num_chrcs;
 	struct service_list *next;
 };
 
@@ -93,14 +95,14 @@ static bool gatt_client_add_service(struct bt_gatt_client *client,
 	return true;
 }
 
-static void service_destroy_characteristics(bt_gatt_service_t *service)
+static void service_destroy_characteristics(struct service_list *service)
 {
 	unsigned int i;
 
 	for (i = 0; i < service->num_chrcs; i++)
 		free((bt_gatt_descriptor_t *) service->chrcs[i].descs);
 
-	free((bt_gatt_characteristic_t *) service->chrcs);
+	free(service->chrcs);
 }
 
 static void gatt_client_clear_services(struct bt_gatt_client *client)
@@ -110,7 +112,7 @@ static void gatt_client_clear_services(struct bt_gatt_client *client)
 	l = client->svc_head;
 
 	while (l) {
-		service_destroy_characteristics(&l->service);
+		service_destroy_characteristics(l);
 		tmp = l;
 		l = tmp->next;
 		free(tmp);
@@ -229,8 +231,7 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 	op->cur_chrc->num_descs = desc_count;
 	op->cur_chrc->descs = descs;
 
-	for (i = op->cur_chrc_index + 1;
-				i < op->cur_service->service.num_chrcs; i++) {
+	for (i = op->cur_chrc_index + 1; i < op->cur_service->num_chrcs; i++) {
 		op->cur_chrc_index = i;
 		op->cur_chrc++;
 		desc_start = op->cur_chrc->value_handle + 1;
@@ -332,8 +333,8 @@ static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 		i++;
 	}
 
-	op->cur_service->service.chrcs = chrcs;
-	op->cur_service->service.num_chrcs = chrc_count;
+	op->cur_service->chrcs = chrcs;
+	op->cur_service->num_chrcs = chrc_count;
 
 	for (i = 0; i < chrc_count; i++) {
 		op->cur_chrc_index = i;
@@ -627,7 +628,7 @@ bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
 }
 
 bool bt_gatt_service_iter_next(struct bt_gatt_service_iter *iter,
-						bt_gatt_service_t *service)
+					const bt_gatt_service_t **service)
 {
 	struct service_list *l;
 
@@ -644,18 +645,18 @@ bool bt_gatt_service_iter_next(struct bt_gatt_service_iter *iter,
 	if (!l)
 		return false;
 
-	*service = l->service;
+	*service = &l->service;
 	iter->ptr = l;
 
 	return true;
 }
 
 bool bt_gatt_service_iter_next_by_handle(struct bt_gatt_service_iter *iter,
-						uint16_t start_handle,
-						bt_gatt_service_t *service)
+					uint16_t start_handle,
+					const bt_gatt_service_t **service)
 {
 	while (bt_gatt_service_iter_next(iter, service)) {
-		if (service->start_handle == start_handle)
+		if ((*service)->start_handle == start_handle)
 			return true;
 	}
 
@@ -664,16 +665,46 @@ bool bt_gatt_service_iter_next_by_handle(struct bt_gatt_service_iter *iter,
 
 bool bt_gatt_service_iter_next_by_uuid(struct bt_gatt_service_iter *iter,
 					const uint8_t uuid[BT_GATT_UUID_SIZE],
-					bt_gatt_service_t *service)
+					const bt_gatt_service_t **service)
 {
 	while (bt_gatt_service_iter_next(iter, service)) {
-		if (memcmp(service->uuid, uuid, UUID_BYTES) == 0)
+		if (memcmp((*service)->uuid, uuid, UUID_BYTES) == 0)
 			return true;
 	}
 
 	return false;
 }
 
+bool bt_gatt_characteristic_iter_init(struct bt_gatt_characteristic_iter *iter,
+					const bt_gatt_service_t *service)
+{
+	if (!iter || !service)
+		return false;
+
+	memset(iter, 0, sizeof(*iter));
+	iter->service = (struct service_list *) service;
+
+	return true;
+}
+
+bool bt_gatt_characteristic_iter_next(struct bt_gatt_characteristic_iter *iter,
+					const bt_gatt_characteristic_t **chrc)
+{
+	struct service_list *service;
+
+	if (!iter || !chrc)
+		return false;
+
+	service = iter->service;
+
+	if (iter->pos >= service->num_chrcs)
+		return false;
+
+	*chrc = service->chrcs + iter->pos++;
+
+	return true;
+}
+
 struct read_op {
 	bt_gatt_client_read_callback_t callback;
 	void *user_data;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 8b0d334..417d964 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -53,6 +53,12 @@ bool bt_gatt_client_set_debug(struct bt_gatt_client *client,
 					bt_gatt_client_destroy_func_t destroy);
 
 typedef struct {
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint8_t uuid[BT_GATT_UUID_SIZE];
+} bt_gatt_service_t;
+
+typedef struct {
 	uint16_t handle;
 	uint8_t uuid[BT_GATT_UUID_SIZE];
 } bt_gatt_descriptor_t;
@@ -67,29 +73,31 @@ typedef struct {
 	size_t num_descs;
 } bt_gatt_characteristic_t;
 
-typedef struct {
-	uint16_t start_handle;
-	uint16_t end_handle;
-	uint8_t uuid[BT_GATT_UUID_SIZE];
-	const bt_gatt_characteristic_t *chrcs;
-	size_t num_chrcs;
-} bt_gatt_service_t;
-
 struct bt_gatt_service_iter {
 	struct bt_gatt_client *client;
 	void *ptr;
 };
 
+struct bt_gatt_characteristic_iter {
+	void *service;
+	size_t pos;
+};
+
 bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
 						struct bt_gatt_client *client);
 bool bt_gatt_service_iter_next(struct bt_gatt_service_iter *iter,
-						bt_gatt_service_t *service);
+					const bt_gatt_service_t **service);
 bool bt_gatt_service_iter_next_by_handle(struct bt_gatt_service_iter *iter,
-						uint16_t start_handle,
-						bt_gatt_service_t *service);
+					uint16_t start_handle,
+					const bt_gatt_service_t **service);
 bool bt_gatt_service_iter_next_by_uuid(struct bt_gatt_service_iter *iter,
 					const uint8_t uuid[BT_GATT_UUID_SIZE],
-					bt_gatt_service_t *service);
+					const bt_gatt_service_t **service);
+
+bool bt_gatt_characteristic_iter_init(struct bt_gatt_characteristic_iter *iter,
+					const bt_gatt_service_t *service);
+bool bt_gatt_characteristic_iter_next(struct bt_gatt_characteristic_iter *iter,
+					const bt_gatt_characteristic_t **chrc);
 
 typedef void (*bt_gatt_client_read_callback_t)(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index d1395b2..8bde1ee 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -169,16 +169,21 @@ static void print_uuid(const uint8_t uuid[16])
 
 static void print_service(const bt_gatt_service_t *service)
 {
+	struct bt_gatt_characteristic_iter iter;
 	const bt_gatt_characteristic_t *chrc;
-	size_t i, j;
+	size_t i;
+
+	if (!bt_gatt_characteristic_iter_init(&iter, service)) {
+		PRLOG("Failed to initialize characteristic iterator\n");
+		return;
+	}
 
 	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
 				"end: 0x%04x, uuid: ",
 				service->start_handle, service->end_handle);
 	print_uuid(service->uuid);
 
-	for (i = 0; i < service->num_chrcs; i++) {
-		chrc = service->chrcs + i;
+	while (bt_gatt_characteristic_iter_next(&iter, &chrc)) {
 		printf("\t  " COLOR_YELLOW "charac" COLOR_OFF
 				" - start: 0x%04x, end: 0x%04x, "
 				"value: 0x%04x, props: 0x%02x, uuid: ",
@@ -186,13 +191,13 @@ static void print_service(const bt_gatt_service_t *service)
 				chrc->end_handle,
 				chrc->value_handle,
 				chrc->properties);
-		print_uuid(service->chrcs[i].uuid);
+		print_uuid(chrc->uuid);
 
-		for (j = 0; j < chrc->num_descs; j++) {
+		for (i = 0; i < chrc->num_descs; i++) {
 			printf("\t\t  " COLOR_MAGENTA "descr" COLOR_OFF
 						" - handle: 0x%04x, uuid: ",
-						chrc->descs[j].handle);
-			print_uuid(chrc->descs[j].uuid);
+						chrc->descs[i].handle);
+			print_uuid(chrc->descs[i].uuid);
 		}
 	}
 
@@ -202,7 +207,7 @@ static void print_service(const bt_gatt_service_t *service)
 static void print_services(struct client *cli)
 {
 	struct bt_gatt_service_iter iter;
-	bt_gatt_service_t service;
+	const bt_gatt_service_t *service;
 
 	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
 		PRLOG("Failed to initialize service iterator\n");
@@ -212,13 +217,13 @@ static void print_services(struct client *cli)
 	printf("\n");
 
 	while (bt_gatt_service_iter_next(&iter, &service))
-		print_service(&service);
+		print_service(service);
 }
 
 static void print_services_by_uuid(struct client *cli, const bt_uuid_t *uuid)
 {
 	struct bt_gatt_service_iter iter;
-	bt_gatt_service_t service;
+	const bt_gatt_service_t *service;
 
 	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
 		PRLOG("Failed to initialize service iterator\n");
@@ -229,13 +234,13 @@ static void print_services_by_uuid(struct client *cli, const bt_uuid_t *uuid)
 
 	while (bt_gatt_service_iter_next_by_uuid(&iter, uuid->value.u128.data,
 								&service))
-		print_service(&service);
+		print_service(service);
 }
 
 static void print_services_by_handle(struct client *cli, uint16_t handle)
 {
 	struct bt_gatt_service_iter iter;
-	bt_gatt_service_t service;
+	const bt_gatt_service_t *service;
 
 	if (!bt_gatt_service_iter_init(&iter, cli->gatt)) {
 		PRLOG("Failed to initialize service iterator\n");
@@ -245,7 +250,7 @@ static void print_services_by_handle(struct client *cli, uint16_t handle)
 	printf("\n");
 
 	while (bt_gatt_service_iter_next_by_handle(&iter, handle, &service))
-		print_service(&service);
+		print_service(service);
 }
 
 static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
-- 
2.1.0.rc2.206.gedb03e5

