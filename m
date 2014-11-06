Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/9] unit/test-gatt: Verify found services
Date: Thu,  6 Nov 2014 13:47:10 +0100
Message-Id: <1415278034-19223-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register ready_callback in bt_gatt_client to verify services,
characteristics and descriptors found during discovery.
---
 unit/test-gatt.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 712b117..c2544a5 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -53,11 +53,19 @@ enum context_type {
 	SERVER
 };
 
+struct gatt_service {
+	const bt_gatt_service_t *service;
+	int num_chars;
+	const bt_gatt_characteristic_t **chars;
+};
+
 struct test_data {
 	char *test_name;
 	struct test_pdu *pdu_list;
 	enum context_type context_type;
 	bt_uuid_t *uuid;
+	int num_services;
+	const struct gatt_service **services;
 };
 
 struct context {
@@ -80,7 +88,7 @@ struct context {
 		.size = sizeof(data(args)),			\
 	}
 
-#define define_test(name, function, type, bt_uuid, args...)		\
+#define define_test(name, function, type, bt_uuid, bt_services, args...)\
 	do {								\
 		const struct test_pdu pdus[] = {			\
 			args, { }					\
@@ -90,15 +98,18 @@ struct context {
 		data.context_type = type;				\
 		data.uuid = bt_uuid;					\
 		data.pdu_list = g_malloc(sizeof(pdus));			\
+		data.services = bt_services;				\
+		data.num_services = sizeof(bt_services) /		\
+				sizeof(bt_services[0]);			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, function);		\
 	} while (0)
 
 #define define_test_att(name, function, bt_uuid, args...)	\
-	define_test(name, function, ATT, bt_uuid, args)
+	define_test(name, function, ATT, bt_uuid, NULL, args)
 
-#define define_test_client(name, function, args...)		\
-	define_test(name, function, CLIENT, NULL, args)
+#define define_test_client(name, function, bt_services, args...)	\
+	define_test(name, function, CLIENT, NULL, bt_services, args)
 
 static bt_uuid_t uuid_16 = {
 	.type = BT_UUID16,
@@ -209,6 +220,75 @@ static void gatt_debug(const char *str, void *user_data)
 	g_print("%s%s\n", prefix, str);
 }
 
+static void compare_service(const bt_gatt_service_t *a,
+						const bt_gatt_service_t *b)
+{
+	g_assert(a->primary && b->primary);
+	g_assert(a->start_handle == b->start_handle);
+	g_assert(a->end_handle == b->end_handle);
+	g_assert(memcmp(a->uuid, b->uuid, sizeof(a->uuid)) == 0);
+}
+
+static void compare_descs(const bt_gatt_descriptor_t *a,
+						const bt_gatt_descriptor_t *b)
+{
+	g_assert(a->handle == b->handle);
+	g_assert(memcmp(a->uuid, b->uuid, sizeof(a->uuid)) == 0);
+}
+
+static void compare_chars(const bt_gatt_characteristic_t *a,
+					const bt_gatt_characteristic_t *b)
+{
+	unsigned int i;
+
+	g_assert(a->start_handle == b->start_handle);
+	g_assert(a->end_handle == b->end_handle);
+	g_assert(a->properties == b->properties);
+	g_assert(a->value_handle == b->value_handle);
+	g_assert(a->num_descs == b->num_descs);
+	g_assert(memcmp(a->uuid, b->uuid, sizeof(a->uuid)) == 0);
+
+	for (i = 0; i < a->num_descs; i++)
+		compare_descs(&a->descs[i], &b->descs[i]);
+}
+
+static void client_ready_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_data *data = context->data;
+	struct bt_gatt_characteristic_iter char_iter;
+	const bt_gatt_characteristic_t *charac;
+	const bt_gatt_service_t *service;
+	struct bt_gatt_service_iter iter;
+	int i, j;
+
+	g_assert(success);
+
+	if (!data->services) {
+		context_quit(context);
+		return;
+	}
+
+	g_assert(bt_gatt_service_iter_init(&iter, context->client));
+	for (i = 0; i < data->num_services; i++) {
+		g_assert(bt_gatt_service_iter_next(&iter, &service));
+		compare_service(service, data->services[i]->service);
+		g_assert(bt_gatt_characteristic_iter_init(&char_iter, service));
+
+		for (j = 0; j < data->services[i]->num_chars; j++) {
+			g_assert(bt_gatt_characteristic_iter_next(&char_iter,
+								&charac));
+			compare_chars(charac, data->services[i]->chars[j]);
+		}
+		g_assert(!bt_gatt_characteristic_iter_next(&char_iter,
+								&charac));
+	}
+
+	g_assert(!bt_gatt_service_iter_next(&iter, &service));
+
+	context_quit(context);
+}
+
 static struct context *create_context(uint16_t mtu, gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
@@ -240,6 +320,9 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 			bt_gatt_client_set_debug(context->client, gatt_debug,
 								"gatt:", NULL);
 
+		bt_gatt_client_set_ready_handler(context->client,
+						client_ready_cb, context, NULL);
+
 		bt_att_unref(att);
 		break;
 	default:
@@ -362,7 +445,7 @@ int main(int argc, char *argv[])
 	 * Server Configuration.
 	 */
 
-	define_test_client("/TP/GAC/CL/BV-01-C", test_client,
+	define_test_client("/TP/GAC/CL/BV-01-C", test_client, NULL,
 				raw_pdu(0x02, 0x00, 0x02));
 
 	/*
-- 
1.9.3

