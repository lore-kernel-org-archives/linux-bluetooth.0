Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] unit/test-gatt: Add /TP/GAR/CL/BV-01-C test
Date: Thu,  6 Nov 2014 13:47:11 +0100
Message-Id: <1415278034-19223-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can read
a Characteristic Value selected by handle.
---
 unit/test-gatt.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 156 insertions(+), 7 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c2544a5..861740b 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -66,6 +66,7 @@ struct test_data {
 	bt_uuid_t *uuid;
 	int num_services;
 	const struct gatt_service **services;
+	const void *step;
 };
 
 struct context {
@@ -88,7 +89,8 @@ struct context {
 		.size = sizeof(data(args)),			\
 	}
 
-#define define_test(name, function, type, bt_uuid, bt_services, args...)\
+#define define_test(name, function, type, bt_uuid, bt_services,		\
+		test_step, args...)					\
 	do {								\
 		const struct test_pdu pdus[] = {			\
 			args, { }					\
@@ -97,19 +99,20 @@ struct context {
 		data.test_name = g_strdup(name);			\
 		data.context_type = type;				\
 		data.uuid = bt_uuid;					\
-		data.pdu_list = g_malloc(sizeof(pdus));			\
+		data.step = test_step;					\
 		data.services = bt_services;				\
 		data.num_services = sizeof(bt_services) /		\
 				sizeof(bt_services[0]);			\
+		data.pdu_list = g_malloc(sizeof(pdus));			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, function);		\
 	} while (0)
 
-#define define_test_att(name, function, bt_uuid, args...)	\
-	define_test(name, function, ATT, bt_uuid, NULL, args)
+#define define_test_att(name, function, bt_uuid, args...)		\
+	define_test(name, function, ATT, bt_uuid, NULL, NULL, args)
 
-#define define_test_client(name, function, bt_services, args...)	\
-	define_test(name, function, CLIENT, NULL, bt_services, args)
+#define define_test_client(name, function, bt_services, test_step, args...)\
+	define_test(name, function, CLIENT, NULL, bt_services, test_step, args)
 
 static bt_uuid_t uuid_16 = {
 	.type = BT_UUID16,
@@ -122,6 +125,74 @@ static bt_uuid_t uuid_128 = {
 				0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
 };
 
+const bt_gatt_service_t service_1 = {
+	.primary = true,
+	.start_handle = 0x0001,
+	.end_handle = 0x0004,
+	.uuid = {0x00, 0x00, 0x18, 0x01, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
+};
+
+const bt_gatt_descriptor_t descriptor_1 = {
+	.handle = 0x0004,
+	.uuid = {0x00, 0x00, 0x29, 0x01, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
+};
+
+const bt_gatt_characteristic_t characteristic_1 = {
+	.start_handle = 0x0002,
+	.end_handle = 0x0004,
+	.value_handle = 0x0003,
+	.properties = 0x02,
+	.uuid = {0x00, 0x00, 0x2a, 0x00, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
+	.descs = &descriptor_1,
+	.num_descs = 1
+};
+
+const bt_gatt_service_t service_2 = {
+	.primary = true,
+	.start_handle = 0x0005,
+	.end_handle = 0x0008,
+	.uuid = {0x00, 0x00, 0x18, 0x0d, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
+};
+
+const bt_gatt_descriptor_t descriptor_2 = {
+	.handle = 0x0008,
+	.uuid = {0x00, 0x00, 0x29, 0x01, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb}
+};
+
+const bt_gatt_characteristic_t characteristic_2 = {
+	.start_handle = 0x0006,
+	.end_handle = 0x0008,
+	.value_handle = 0x0007,
+	.properties = 0x02,
+	.uuid = {0x00, 0x00, 0x2a, 0x29, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb},
+	.descs = &descriptor_2,
+	.num_descs = 1
+};
+
+const bt_gatt_characteristic_t *characteristics_1[] = {&characteristic_1};
+const bt_gatt_characteristic_t *characteristics_2[] = {&characteristic_2};
+
+const struct gatt_service gatt_service_1 = {
+	.service = &service_1,
+	.num_chars = sizeof(characteristics_1) / sizeof(characteristics_1[0]),
+	.chars = characteristics_1
+};
+
+const struct gatt_service gatt_service_2 = {
+	.service = &service_2,
+	.num_chars = sizeof(characteristics_2) / sizeof(characteristics_2[0]),
+	.chars = characteristics_2
+};
+
+const struct gatt_service *service_data_1[] = {&gatt_service_1,
+							&gatt_service_2};
+
 static void test_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -382,6 +453,51 @@ static void execute_context(struct context *context)
 	destroy_context(context);
 }
 
+typedef void (*test_step_t)(struct context *context);
+
+struct test_step {
+	test_step_t func;
+	uint16_t handle;
+	uint8_t expected_att_ecode;
+	const uint8_t *value;
+	uint16_t length;
+};
+
+static void test_read_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
+
+	g_assert(att_ecode == step->expected_att_ecode);
+
+	if (success) {
+		g_assert(length == step->length);
+		g_assert(memcmp(value, step->value, length) == 0);
+	}
+
+	context_quit(context);
+}
+
+static void test_read(struct context *context)
+{
+	const struct test_step *step = context->data->step;
+
+	g_assert(bt_gatt_client_read_value(context->client, step->handle,
+						test_read_cb, context, NULL));
+}
+
+const uint8_t read_data_1[] = {0x01, 0x02, 0x03};
+
+const struct test_step test_read_1 = {
+	.handle = 0x0003,
+	.func = test_read,
+	.expected_att_ecode = 0,
+	.value = read_data_1,
+	.length = 0x03
+};
+
 static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
@@ -445,7 +561,7 @@ int main(int argc, char *argv[])
 	 * Server Configuration.
 	 */
 
-	define_test_client("/TP/GAC/CL/BV-01-C", test_client, NULL,
+	define_test_client("/TP/GAC/CL/BV-01-C", test_client, NULL, NULL,
 				raw_pdu(0x02, 0x00, 0x02));
 
 	/*
@@ -540,5 +656,38 @@ int main(int argc, char *argv[])
 			raw_pdu(0x05, 0x01, 0x15, 0x00, 0x04, 0x29, 0x16, 0x00,
 					0x05, 0x29));
 
+	define_test_client("/TP/GAR/CL/BV-01-C", test_client, service_data_1,
+			&test_read_1,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18),
+			raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x05, 0x00, 0x08, 0x00, 0x0d, 0x18),
+			raw_pdu(0x10, 0x09, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x09, 0x00, 0x0a),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),
+			raw_pdu(0x01, 0x10, 0x01, 0x00, 0x0a),
+			raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x02, 0x28),
+			raw_pdu(0x01, 0x08, 0x01, 0x00, 0x0a),
+			raw_pdu(0x08, 0x05, 0x00, 0x08, 0x00, 0x02, 0x28),
+			raw_pdu(0x01, 0x08, 0x05, 0x00, 0x0a),
+			raw_pdu(0x08, 0x01, 0x00, 0x04, 0x00, 0x03, 0x28),
+			raw_pdu(0x09, 0x07, 0x02, 0x00, 0x02, 0x03, 0x00, 0x00,
+					0x2a),
+			raw_pdu(0x08, 0x03, 0x00, 0x04, 0x00, 0x03, 0x28),
+			raw_pdu(0x01, 0x08, 0x03, 0x00, 0x0a),
+			raw_pdu(0x04, 0x04, 0x00, 0x04, 0x00),
+			raw_pdu(0x05, 0x01, 0x04, 0x00, 0x01, 0x29),
+			raw_pdu(0x08, 0x05, 0x00, 0x08, 0x00, 0x03, 0x28),
+			raw_pdu(0x09, 0x07, 0x06, 0x00, 0x02, 0x07, 0x00, 0x29,
+					0x2a),
+			raw_pdu(0x08, 0x07, 0x00, 0x08, 0x00, 0x03, 0x28),
+			raw_pdu(0x01, 0x08, 0x07, 0x00, 0x0a),
+			raw_pdu(0x04, 0x08, 0x00, 0x08, 0x00),
+			raw_pdu(0x05, 0x01, 0x08, 0x00, 0x01, 0x29),
+			raw_pdu(0x0a, 0x03, 0x00),
+			raw_pdu(0x0b, 0x01, 0x02, 0x03));
+
 	return g_test_run();
 }
-- 
1.9.3

