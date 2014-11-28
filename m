Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 7/8] unit/test-gatt: Use gatt-db for CLIENT tests
Date: Fri, 28 Nov 2014 09:49:21 -0800
Message-Id: <1417196962-3876-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1417196962-3876-1-git-send-email-armansito@chromium.org>
References: <1417196962-3876-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch rewrites parts of unit/test-gatt that verify the contents
of a shared/gatt-client to use the client's gatt-db instead of the
service iterators.
---
 unit/test-gatt.c | 241 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 162 insertions(+), 79 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 703430c..7c61083 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -56,10 +56,29 @@ enum context_type {
 	SERVER
 };
 
+struct gatt_desc {
+	uint16_t handle;
+	uint8_t uuid[16];
+};
+
+struct gatt_chrc {
+	uint16_t handle;
+	uint16_t value_handle;
+	uint8_t properties;
+	uint8_t uuid[16];
+
+	const struct gatt_desc *descs;
+	size_t num_descs;
+};
+
 struct gatt_service {
-	const bt_gatt_service_t *service;
-	int num_chars;
-	const bt_gatt_characteristic_t **chars;
+	bool primary;
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint8_t uuid[16];
+
+	const struct gatt_chrc **chars;
+	size_t num_chars;
 };
 
 struct test_data {
@@ -67,7 +86,7 @@ struct test_data {
 	struct test_pdu *pdu_list;
 	enum context_type context_type;
 	bt_uuid_t *uuid;
-	int num_services;
+	size_t num_services;
 	const struct gatt_service **services;
 	const void *step;
 };
@@ -176,23 +195,14 @@ static bt_uuid_t uuid_char_128 = {
 			0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f}
 };
 
-const bt_gatt_service_t service_1 = {
-	.primary = true,
-	.start_handle = 0x0001,
-	.end_handle = 0x0004,
-	.uuid = {0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
-};
-
-const bt_gatt_descriptor_t descriptor_1 = {
+const struct gatt_desc descriptor_1 = {
 	.handle = 0x0004,
 	.uuid = {0x00, 0x00, 0x29, 0x01, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
 };
 
-const bt_gatt_characteristic_t characteristic_1 = {
-	.start_handle = 0x0002,
-	.end_handle = 0x0004,
+const struct gatt_chrc characteristic_1 = {
+	.handle = 0x0002,
 	.value_handle = 0x0003,
 	.properties = 0x02,
 	.uuid = {0x00, 0x00, 0x2a, 0x00, 0x00, 0x00, 0x10, 0x00,
@@ -201,23 +211,14 @@ const bt_gatt_characteristic_t characteristic_1 = {
 	.num_descs = 1
 };
 
-const bt_gatt_service_t service_2 = {
-	.primary = true,
-	.start_handle = 0x0005,
-	.end_handle = 0x0008,
-	.uuid = {0x00, 0x00, 0x18, 0x0d, 0x00, 0x00, 0x10, 0x00,
-			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
-};
-
-const bt_gatt_descriptor_t descriptor_2 = {
+const struct gatt_desc descriptor_2 = {
 	.handle = 0x0008,
 	.uuid = {0x00, 0x00, 0x29, 0x01, 0x00, 0x00, 0x10, 0x00,
 			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
 };
 
-const bt_gatt_characteristic_t characteristic_2 = {
-	.start_handle = 0x0006,
-	.end_handle = 0x0008,
+const struct gatt_chrc characteristic_2 = {
+	.handle = 0x0006,
 	.value_handle = 0x0007,
 	.properties = 0x02,
 	.uuid = {0x00, 0x00, 0x2a, 0x29, 0x00, 0x00, 0x10, 0x00,
@@ -226,19 +227,27 @@ const bt_gatt_characteristic_t characteristic_2 = {
 	.num_descs = 1
 };
 
-const bt_gatt_characteristic_t *characteristics_1[] = {&characteristic_1};
-const bt_gatt_characteristic_t *characteristics_2[] = {&characteristic_2};
+const struct gatt_chrc *characteristics_1[] = {&characteristic_1};
+const struct gatt_chrc *characteristics_2[] = {&characteristic_2};
 
 const struct gatt_service gatt_service_1 = {
-	.service = &service_1,
-	.num_chars = sizeof(characteristics_1) / sizeof(characteristics_1[0]),
-	.chars = characteristics_1
+	.primary = true,
+	.start_handle = 0x0001,
+	.end_handle = 0x0004,
+	.uuid = {0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
+	.chars = characteristics_1,
+	.num_chars = sizeof(characteristics_1) / sizeof(characteristics_1[0])
 };
 
 const struct gatt_service gatt_service_2 = {
-	.service = &service_2,
-	.num_chars = sizeof(characteristics_2) / sizeof(characteristics_2[0]),
-	.chars = characteristics_2
+	.primary = true,
+	.start_handle = 0x0005,
+	.end_handle = 0x0008,
+	.uuid = {0x00, 0x00, 0x18, 0x0d, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
+	.chars = characteristics_2,
+	.num_chars = sizeof(characteristics_2) / sizeof(characteristics_2[0])
 };
 
 const struct gatt_service *service_data_1[] = {&gatt_service_1,
@@ -343,36 +352,60 @@ static void print_debug(const char *str, void *user_data)
 	g_print("%s%s\n", prefix, str);
 }
 
-static void compare_service(const bt_gatt_service_t *a,
-						const bt_gatt_service_t *b)
+static void assert_service(const struct gatt_service *a,
+						struct gatt_db_attribute *attr)
 {
-	g_assert(a->primary && b->primary);
-	g_assert(a->start_handle == b->start_handle);
-	g_assert(a->end_handle == b->end_handle);
-	g_assert(memcmp(a->uuid, b->uuid, sizeof(a->uuid)) == 0);
+	uint16_t start_handle, end_handle;
+	bool primary;
+	bt_uuid_t uuid;
+	uint128_t u128;
+
+	g_assert(gatt_db_attribute_get_service_data(attr, &start_handle,
+							&end_handle,
+							&primary, &uuid));
+
+	u128 = uuid.value.u128;
+
+	g_assert(a->primary && primary);
+	g_assert(a->start_handle == start_handle);
+	g_assert(a->end_handle == end_handle);
+	g_assert(memcmp(a->uuid, u128.data, sizeof(u128.data)) == 0);
 }
 
-static void compare_descs(const bt_gatt_descriptor_t *a,
-						const bt_gatt_descriptor_t *b)
+static void assert_chrc(const struct gatt_chrc *a,
+						struct gatt_db_attribute *attr)
 {
-	g_assert(a->handle == b->handle);
-	g_assert(memcmp(a->uuid, b->uuid, sizeof(a->uuid)) == 0);
+	uint16_t handle, value_handle;
+	uint8_t properties;
+	bt_uuid_t uuid;
+	uint128_t u128;
+
+	g_assert(gatt_db_attribute_get_char_data(attr, &handle,
+							&value_handle,
+							&properties, &uuid));
+
+	u128 = uuid.value.u128;
+
+	g_assert(a->handle == handle);
+	g_assert(a->value_handle == value_handle);
+	g_assert(a->properties == properties);
+	g_assert(memcmp(a->uuid, u128.data, sizeof(u128.data)) == 0);
 }
 
-static void compare_chars(const bt_gatt_characteristic_t *a,
-					const bt_gatt_characteristic_t *b)
+static void assert_desc(const struct gatt_desc *a,
+						struct gatt_db_attribute *attr)
 {
-	unsigned int i;
+	uint16_t handle;
+	const bt_uuid_t *uuid;
+	uint128_t u128;
 
-	g_assert(a->start_handle == b->start_handle);
-	g_assert(a->end_handle == b->end_handle);
-	g_assert(a->properties == b->properties);
-	g_assert(a->value_handle == b->value_handle);
-	g_assert(a->num_descs == b->num_descs);
-	g_assert(memcmp(a->uuid, b->uuid, sizeof(a->uuid)) == 0);
+	handle = gatt_db_attribute_get_handle(attr);
+	uuid = gatt_db_attribute_get_type(attr);
 
-	for (i = 0; i < a->num_descs; i++)
-		compare_descs(&a->descs[i], &b->descs[i]);
+	u128 = uuid->value.u128;
+
+	g_assert(a->handle == handle);
+	g_assert(memcmp(a->uuid, u128.data, sizeof(u128.data)) == 0);
 }
 
 typedef void (*test_step_t)(struct context *context);
@@ -387,39 +420,89 @@ struct test_step {
 	uint16_t length;
 };
 
+struct service_test_data {
+	const struct test_data *data;
+	size_t svc_index;
+	size_t chrc_index;
+	size_t desc_index;
+};
+
+static void compare_desc(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct service_test_data *test_data = user_data;
+	const struct gatt_service *svc;
+	const struct gatt_chrc *chrc;
+
+	svc = test_data->data->services[test_data->svc_index];
+	chrc = svc->chars[test_data->chrc_index];
+	g_assert(test_data->desc_index < chrc->num_descs);
+
+	assert_desc(&chrc->descs[test_data->desc_index], attr);
+
+	test_data->desc_index++;
+}
+
+static void compare_chrc(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct service_test_data *test_data = user_data;
+	const struct gatt_service *svc;
+	const struct gatt_chrc *chrc;
+
+	svc = test_data->data->services[test_data->svc_index];
+	g_assert(test_data->chrc_index < svc->num_chars);
+	chrc = svc->chars[test_data->chrc_index];
+
+	assert_chrc(chrc, attr);
+
+	test_data->desc_index = 0;
+
+	gatt_db_service_foreach_desc(attr, compare_desc, test_data);
+	g_assert(test_data->desc_index == chrc->num_descs);
+
+	test_data->chrc_index++;
+}
+
+static void compare_service(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct service_test_data *test_data = user_data;
+	const struct gatt_service *svc;
+
+	g_assert(test_data->svc_index < test_data->data->num_services);
+	svc = test_data->data->services[test_data->svc_index];
+
+	assert_service(test_data->data->services[test_data->svc_index], attr);
+
+	test_data->chrc_index = 0;
+
+	gatt_db_service_foreach_char(attr, compare_chrc, test_data);
+	g_assert(test_data->chrc_index == svc->num_chars);
+
+	test_data->svc_index++;
+}
+
 static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 {
 	struct context *context = user_data;
-	const struct test_data *data = context->data;
-	struct bt_gatt_characteristic_iter char_iter;
-	const bt_gatt_characteristic_t *charac;
-	const bt_gatt_service_t *service;
-	struct bt_gatt_service_iter iter;
-	int i, j;
+	struct service_test_data test_data;
+	struct gatt_db *db;
 
 	g_assert(success);
 
-	if (!data->services) {
+	test_data.data = context->data;
+	test_data.svc_index = 0;
+
+	if (!test_data.data->services) {
 		context_quit(context);
 		return;
 	}
 
-	g_assert(bt_gatt_service_iter_init(&iter, context->client));
-	for (i = 0; i < data->num_services; i++) {
-		g_assert(bt_gatt_service_iter_next(&iter, &service));
-		compare_service(service, data->services[i]->service);
-		g_assert(bt_gatt_characteristic_iter_init(&char_iter, service));
-
-		for (j = 0; j < data->services[i]->num_chars; j++) {
-			g_assert(bt_gatt_characteristic_iter_next(&char_iter,
-								&charac));
-			compare_chars(charac, data->services[i]->chars[j]);
-		}
-		g_assert(!bt_gatt_characteristic_iter_next(&char_iter,
-								&charac));
-	}
+	g_assert(context->client);
+
+	db = bt_gatt_client_get_db(context->client);
+	g_assert(db);
 
-	g_assert(!bt_gatt_service_iter_next(&iter, &service));
+	gatt_db_foreach_service(db, compare_service, &test_data);
+	g_assert(test_data.svc_index == test_data.data->num_services);
 
 	if (context->data->step) {
 		const struct test_step *step = context->data->step;
-- 
2.2.0.rc0.207.ga3a616c

