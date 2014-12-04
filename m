Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 1/2] unit/gatt: Use gatt_db for test data
Date: Thu,  4 Dec 2014 09:03:54 -0800
Message-Id: <1417712635-12428-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1417712635-12428-1-git-send-email-jamuraa@chromium.org>
References: <1417712635-12428-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

using gatt_db for test data makes tests clearer and
is a step towards adding server tests from the spec by
that must be run against multiple databases easily.
---
 unit/test-gatt.c | 342 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 226 insertions(+), 116 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 12b1919..ff3dbba 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -86,8 +86,7 @@ struct test_data {
 	struct test_pdu *pdu_list;
 	enum context_type context_type;
 	bt_uuid_t *uuid;
-	size_t num_services;
-	const struct gatt_service **services;
+	struct gatt_db *source_db;
 	const void *step;
 };
 
@@ -114,7 +113,7 @@ struct context {
 		.size = sizeof(data(args)),			\
 	}
 
-#define define_test(name, function, type, bt_uuid, bt_services,		\
+#define define_test(name, function, type, bt_uuid, db,			\
 		test_step, args...)					\
 	do {								\
 		const struct test_pdu pdus[] = {			\
@@ -125,9 +124,7 @@ struct context {
 		data.context_type = type;				\
 		data.uuid = bt_uuid;					\
 		data.step = test_step;					\
-		data.services = bt_services;				\
-		data.num_services = sizeof(bt_services) /		\
-				sizeof(bt_services[0]);			\
+		data.source_db = db;					\
 		data.pdu_list = g_malloc(sizeof(pdus));			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, function);		\
@@ -136,11 +133,11 @@ struct context {
 #define define_test_att(name, function, bt_uuid, test_step, args...)	\
 	define_test(name, function, ATT, bt_uuid, NULL, test_step, args)
 
-#define define_test_client(name, function, bt_services, test_step, args...)\
-	define_test(name, function, CLIENT, NULL, bt_services, test_step, args)
+#define define_test_client(name, function, source_db, test_step, args...)\
+	define_test(name, function, CLIENT, NULL, source_db, test_step, args)
 
-#define define_test_server(name, function, bt_services, test_step, args...)\
-	define_test(name, function, SERVER, NULL, bt_services, test_step, args)
+#define define_test_server(name, function, source_db, test_step, args...)\
+	define_test(name, function, SERVER, NULL, source_db, test_step, args)
 
 #define SERVICE_DATA_1_PDU						\
 		raw_pdu(0x02, 0x00, 0x02),				\
@@ -353,145 +350,166 @@ static void print_debug(const char *str, void *user_data)
 	g_print("%s%s\n", prefix, str);
 }
 
-static void assert_service(const struct gatt_service *a,
-						struct gatt_db_attribute *attr)
+typedef void (*test_step_t)(struct context *context);
+
+struct test_step {
+	test_step_t func;
+	uint16_t handle;
+	uint16_t end_handle;
+	uint8_t uuid[16];
+	uint8_t expected_att_ecode;
+	const uint8_t *value;
+	uint16_t length;
+};
+
+struct db_attribute_test_data {
+	struct gatt_db_attribute *match;
+	bool found;
+};
+
+static bool matching_desc_data(struct gatt_db_attribute *a,
+						struct gatt_db_attribute *b)
 {
-	uint16_t start_handle, end_handle;
-	bool primary;
-	bt_uuid_t uuid;
-	uint128_t u128;
+	uint16_t a_handle, b_handle;
+	const bt_uuid_t *a_uuid, *b_uuid;
 
-	g_assert(gatt_db_attribute_get_service_data(attr, &start_handle,
-							&end_handle,
-							&primary, &uuid));
+	a_handle = gatt_db_attribute_get_handle(a);
+	b_handle = gatt_db_attribute_get_handle(b);
 
-	u128 = uuid.value.u128;
+	a_uuid = gatt_db_attribute_get_type(a);
+	b_uuid = gatt_db_attribute_get_type(b);
 
-	g_assert(a->primary && primary);
-	g_assert(a->start_handle == start_handle);
-	g_assert(a->end_handle == end_handle);
-	g_assert(memcmp(a->uuid, u128.data, sizeof(u128.data)) == 0);
+	return a_handle == b_handle && !bt_uuid_cmp(a_uuid, b_uuid);
 }
 
-static void assert_chrc(const struct gatt_chrc *a,
-						struct gatt_db_attribute *attr)
+static void find_matching_desc(struct gatt_db_attribute *source_desc_attr,
+								void *user_data)
 {
-	uint16_t handle, value_handle;
-	uint8_t properties;
-	bt_uuid_t uuid;
-	uint128_t u128;
-
-	g_assert(gatt_db_attribute_get_char_data(attr, &handle,
-							&value_handle,
-							&properties, &uuid));
+	struct db_attribute_test_data *desc_test_data = user_data;
 
-	u128 = uuid.value.u128;
+	if (desc_test_data->found)
+		return;
 
-	g_assert(a->handle == handle);
-	g_assert(a->value_handle == value_handle);
-	g_assert(a->properties == properties);
-	g_assert(memcmp(a->uuid, u128.data, sizeof(u128.data)) == 0);
+	desc_test_data->found = matching_desc_data(desc_test_data->match,
+							source_desc_attr);
 }
 
-static void assert_desc(const struct gatt_desc *a,
-						struct gatt_db_attribute *attr)
+static void match_descs(struct gatt_db_attribute *client_desc_attr,
+								void *user_data)
 {
-	uint16_t handle;
-	const bt_uuid_t *uuid;
-	uint128_t u128;
+	struct gatt_db_attribute *source_char_attr = user_data;
+	struct db_attribute_test_data desc_test_data;
 
-	handle = gatt_db_attribute_get_handle(attr);
-	uuid = gatt_db_attribute_get_type(attr);
+	desc_test_data.match = client_desc_attr;
+	desc_test_data.found = false;
 
-	u128 = uuid->value.u128;
+	gatt_db_service_foreach_desc(source_char_attr, find_matching_desc,
+							&desc_test_data);
 
-	g_assert(a->handle == handle);
-	g_assert(memcmp(a->uuid, u128.data, sizeof(u128.data)) == 0);
+	g_assert(desc_test_data.found);
 }
 
-typedef void (*test_step_t)(struct context *context);
-
-struct test_step {
-	test_step_t func;
-	uint16_t handle;
-	uint16_t end_handle;
-	uint8_t uuid[16];
-	uint8_t expected_att_ecode;
-	const uint8_t *value;
-	uint16_t length;
-};
-
-struct service_test_data {
-	const struct test_data *data;
-	size_t svc_index;
-	size_t chrc_index;
-	size_t desc_index;
-};
+static bool matching_char_data(struct gatt_db_attribute *a,
+						struct gatt_db_attribute *b)
+{
+	uint16_t a_handle, b_handle, a_value_handle, b_value_handle;
+	uint8_t a_properties, b_properties;
+	bt_uuid_t a_uuid, b_uuid;
+
+	gatt_db_attribute_get_char_data(a, &a_handle, &a_value_handle,
+							&a_properties, &a_uuid);
+	gatt_db_attribute_get_char_data(b, &b_handle, &b_value_handle,
+							&b_properties, &b_uuid);
+
+	return a_handle == b_handle && a_value_handle == b_value_handle &&
+						a_properties == b_properties &&
+						!bt_uuid_cmp(&a_uuid, &b_uuid);
+}
 
-static void compare_desc(struct gatt_db_attribute *attr, void *user_data)
+static void find_matching_char(struct gatt_db_attribute *source_char_attr,
+								void *user_data)
 {
-	struct service_test_data *test_data = user_data;
-	const struct gatt_service *svc;
-	const struct gatt_chrc *chrc;
+	struct db_attribute_test_data *char_test_data = user_data;
 
-	svc = test_data->data->services[test_data->svc_index];
-	chrc = svc->chars[test_data->chrc_index];
-	g_assert(test_data->desc_index < chrc->num_descs);
+	if (char_test_data->found)
+		return;
 
-	assert_desc(&chrc->descs[test_data->desc_index], attr);
+	if (matching_char_data(char_test_data->match, source_char_attr)) {
 
-	test_data->desc_index++;
+		gatt_db_service_foreach_desc(char_test_data->match, match_descs,
+							source_char_attr);
+		char_test_data->found = true;
+	}
 }
 
-static void compare_chrc(struct gatt_db_attribute *attr, void *user_data)
+static void match_chars(struct gatt_db_attribute *client_char_attr,
+								void *user_data)
 {
-	struct service_test_data *test_data = user_data;
-	const struct gatt_service *svc;
-	const struct gatt_chrc *chrc;
+	struct gatt_db_attribute *source_serv_attr = user_data;
+	struct db_attribute_test_data char_test_data;
 
-	svc = test_data->data->services[test_data->svc_index];
-	g_assert(test_data->chrc_index < svc->num_chars);
-	chrc = svc->chars[test_data->chrc_index];
+	char_test_data.match = client_char_attr;
+	char_test_data.found = false;
 
-	assert_chrc(chrc, attr);
+	gatt_db_service_foreach_char(source_serv_attr, find_matching_char,
+							&char_test_data);
 
-	test_data->desc_index = 0;
+	g_assert(char_test_data.found);
+}
+
+static bool matching_service_data(struct gatt_db_attribute *a,
+						struct gatt_db_attribute *b)
+{
+	uint16_t a_start, b_start, a_end, b_end;
+	bool a_primary, b_primary;
+	bt_uuid_t a_uuid, b_uuid;
 
-	gatt_db_service_foreach_desc(attr, compare_desc, test_data);
-	g_assert(test_data->desc_index == chrc->num_descs);
+	gatt_db_attribute_get_service_data(a, &a_start, &a_end, &a_primary,
+								&a_uuid);
+	gatt_db_attribute_get_service_data(b, &b_start, &b_end, &b_primary,
+								&b_uuid);
 
-	test_data->chrc_index++;
+	return a_start == b_start && a_end == b_end && a_primary == b_primary &&
+						!bt_uuid_cmp(&a_uuid, &b_uuid);
 }
 
-static void compare_service(struct gatt_db_attribute *attr, void *user_data)
+static void find_matching_service(struct gatt_db_attribute *source_serv_attr,
+								void *user_data)
 {
-	struct service_test_data *test_data = user_data;
-	const struct gatt_service *svc;
+	struct db_attribute_test_data *serv_test_data = user_data;
 
-	g_assert(test_data->svc_index < test_data->data->num_services);
-	svc = test_data->data->services[test_data->svc_index];
+	if (serv_test_data->found)
+		return;
+
+	if (matching_service_data(serv_test_data->match, source_serv_attr)) {
+		gatt_db_service_foreach_char(serv_test_data->match, match_chars,
+							source_serv_attr);
+		serv_test_data->found = true;
+	}
+}
 
-	assert_service(test_data->data->services[test_data->svc_index], attr);
+static void match_services(struct gatt_db_attribute *client_serv_attr,
+								void *user_data)
+{
+	struct gatt_db *source_db = user_data;
+	struct db_attribute_test_data serv_test_data;
 
-	test_data->chrc_index = 0;
+	serv_test_data.match = client_serv_attr;
+	serv_test_data.found = false;
 
-	gatt_db_service_foreach_char(attr, compare_chrc, test_data);
-	g_assert(test_data->chrc_index == svc->num_chars);
+	gatt_db_foreach_service(source_db,
+					find_matching_service, &serv_test_data);
 
-	test_data->svc_index++;
+	g_assert(serv_test_data.found);
 }
 
 static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 {
 	struct context *context = user_data;
-	struct service_test_data test_data;
 
 	g_assert(success);
 
-	test_data.data = context->data;
-	test_data.svc_index = 0;
-
-	if (!test_data.data->services) {
+	if (!context->data->source_db) {
 		context_quit(context);
 		return;
 	}
@@ -499,9 +517,8 @@ static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
 	g_assert(context->client);
 	g_assert(context->client_db);
 
-	gatt_db_foreach_service(context->client_db, compare_service,
-								&test_data);
-	g_assert(test_data.svc_index == test_data.data->num_services);
+	gatt_db_foreach_service(context->client_db, match_services,
+						context->data->source_db);
 
 	if (context->data->step) {
 		const struct test_step *step = context->data->step;
@@ -721,6 +738,95 @@ const struct test_step test_read_4 = {
 	.expected_att_ecode = 0x08,
 };
 
+static void att_write_cb(struct gatt_db_attribute *att, int err,
+								void *user_data)
+{
+	g_assert(!err);
+}
+
+static struct gatt_db_attribute *add_char_with_value(struct gatt_db *db,
+					struct gatt_db_attribute *service_att,
+					bt_uuid_t *uuid,
+					uint32_t att_permissions,
+					uint8_t char_properties,
+					const void *value, size_t len)
+{
+	struct gatt_db_attribute *chrc_att, *value_att;
+	uint16_t value_handle;
+
+	chrc_att = gatt_db_service_add_characteristic(service_att, uuid,
+								att_permissions,
+								char_properties,
+								NULL, NULL,
+								NULL);
+
+	gatt_db_attribute_get_char_data(chrc_att, NULL, &value_handle, NULL,
+					NULL);
+
+	value_att = gatt_db_get_attribute(db, value_handle);
+
+	gatt_db_attribute_write(value_att, 0, value, len, 0x00, NULL,
+				att_write_cb, NULL);
+
+	return chrc_att;
+}
+
+static struct gatt_db_attribute *
+add_user_description(struct gatt_db_attribute *chrc_att, const char *desc,
+								bool writable)
+{
+	struct gatt_db_attribute *desc_att;
+	bt_uuid_t uuid;
+	uint32_t permissions = BT_ATT_PERM_READ;
+
+	if (writable)
+		permissions |= BT_ATT_PERM_WRITE;
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
+	desc_att = gatt_db_service_add_descriptor(chrc_att, &uuid, permissions,
+							NULL, NULL, NULL);
+
+	gatt_db_attribute_write(desc_att, 0, (uint8_t *)desc, strlen(desc),
+						0x00, NULL, att_write_cb, NULL);
+
+	return desc_att;
+}
+
+
+typedef struct gatt_db_attribute (*add_service_func) (struct gatt_db *db,
+							uint16_t handle,
+							bool primary,
+							uint16_t extra_handles);
+
+static struct gatt_db *make_service_data_1_db(void)
+{
+	struct gatt_db *db = gatt_db_new();
+	struct gatt_db_attribute *serv_att, *chrc_att;
+	bt_uuid_t uuid;
+
+	bt_string_to_uuid(&uuid, GATT_UUID);
+	serv_att = gatt_db_insert_service(db, 0x0001, &uuid, true, 4);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
+	chrc_att = add_char_with_value(db, serv_att, &uuid, BT_ATT_PERM_READ,
+					BT_GATT_CHRC_PROP_READ, "BlueZ", 5);
+
+	add_user_description(chrc_att, "Device Name", false);
+
+	bt_string_to_uuid(&uuid, HEART_RATE_UUID);
+	serv_att = gatt_db_insert_service(db, 0x0005, &uuid, true, 4);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_MANUFACTURER_NAME_STRING);
+	chrc_att = gatt_db_service_add_characteristic(serv_att, &uuid,
+							BT_ATT_PERM_READ,
+							BT_GATT_CHRC_PROP_READ,
+							NULL, NULL, NULL);
+
+	add_user_description(chrc_att, "Manufacturer Name", false);
+
+	return db;
+}
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
@@ -942,8 +1048,12 @@ static void test_read_by_type(gconstpointer data)
 
 int main(int argc, char *argv[])
 {
+	struct gatt_db *service_db_1;
+
 	g_test_init(&argc, &argv, NULL);
 
+	service_db_1 = make_service_data_1_db();
+
 	/*
 	 * Server Configuration
 	 *
@@ -1067,25 +1177,25 @@ int main(int argc, char *argv[])
 			raw_pdu(0x05, 0x01, 0x15, 0x00, 0x04, 0x29, 0x16, 0x00,
 					0x05, 0x29));
 
-	define_test_client("/TP/GAR/CL/BV-01-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BV-01-C", test_client, service_db_1,
 			&test_read_1,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x0b, 0x01, 0x02, 0x03));
 
-	define_test_client("/TP/GAR/CL/BI-01-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BI-01-C", test_client, service_db_1,
 			&test_read_2,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0a, 0x00, 0x00),
 			raw_pdu(0x01, 0x0a, 0x00, 0x00, 0x01));
 
-	define_test_client("/TP/GAR/CL/BI-02-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BI-02-C", test_client, service_db_1,
 			&test_read_3,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x02));
 
-	define_test_client("/TP/GAR/CL/BI-03-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BI-03-C", test_client, service_db_1,
 			&test_read_4,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0a, 0x03, 0x00),
@@ -1150,37 +1260,37 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
 			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0c));
 
-	define_test_client("/TP/GAR/CL/BV-05-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BV-05-C", test_client, service_db_1,
 			&test_multiple_read_1,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x0f, 0x01, 0x02, 0x03));
 
-	define_test_client("/TP/GAR/CL/BI-18-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BI-18-C", test_client, service_db_1,
 			&test_multiple_read_2,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x02));
 
-	define_test_client("/TP/GAR/CL/BI-19-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BI-19-C", test_client, service_db_1,
 			&test_multiple_read_3,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x01));
 
-	define_test_client("/TP/GAR/CL/BI-20-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BI-20-C", test_client, service_db_1,
 			&test_multiple_read_4,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x08));
 
-	define_test_client("/TP/GAR/CL/BI-21-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BI-21-C", test_client, service_db_1,
 			&test_multiple_read_5,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
 			raw_pdu(0x01, 0x0e, 0x03, 0x00, 0x05));
 
-	define_test_client("/TP/GAR/CL/BI-21-C", test_client, service_data_1,
+	define_test_client("/TP/GAR/CL/BI-21-C", test_client, service_db_1,
 			&test_multiple_read_6,
 			SERVICE_DATA_1_PDU,
 			raw_pdu(0x0e, 0x03, 0x00, 0x07, 0x00),
-- 
2.2.0.rc0.207.ga3a616c

