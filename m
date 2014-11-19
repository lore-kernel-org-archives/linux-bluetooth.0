Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/9] unit/test-gatt: Add /TP/GAR/CL/BV-03-C-1 test
Date: Wed, 19 Nov 2014 12:26:27 +0100
Message-Id: <1416396393-19997-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client can read a
Characteristic Value selected by UUID using a 16-bit UUID.
---
 unit/test-gatt.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 9917ec9..72cfbf6 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -108,8 +108,8 @@ struct context {
 		g_test_add_data_func(name, &data, function);		\
 	} while (0)
 
-#define define_test_att(name, function, bt_uuid, args...)		\
-	define_test(name, function, ATT, bt_uuid, NULL, NULL, args)
+#define define_test_att(name, function, bt_uuid, test_step, args...)	\
+	define_test(name, function, ATT, bt_uuid, NULL, test_step, args)
 
 #define define_test_client(name, function, bt_services, test_step, args...)\
 	define_test(name, function, CLIENT, NULL, bt_services, test_step, args)
@@ -149,6 +149,11 @@ static bt_uuid_t uuid_16 = {
 	.value.u16 = 0x1800
 };
 
+static bt_uuid_t uuid_char_16 = {
+	.type = BT_UUID16,
+	.value.u16 = 0x2a0d
+};
+
 static bt_uuid_t uuid_128 = {
 	.type = BT_UUID128,
 	.value.u128.data = {0x00, 0x00, 0x18, 0x0d, 0x00, 0x00, 0x10, 0x00,
@@ -611,6 +616,54 @@ static void test_search_descs(gconstpointer data)
 	execute_context(context);
 }
 
+const struct test_step test_read_by_type_1 = {
+	.handle = 0x0001,
+	.end_handle = 0xffff,
+	.expected_att_ecode = 0x0a,
+	.value = read_data_1,
+	.length = 0x03
+};
+
+static void read_by_type_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
+	struct bt_gatt_iter iter;
+
+	g_assert(att_ecode == step->expected_att_ecode);
+
+	if (success) {
+		uint16_t length, handle;
+		const uint8_t *value;
+
+		g_assert(bt_gatt_iter_init(&iter, result));
+		g_assert(bt_gatt_iter_next_read_by_type(&iter, &handle, &length,
+								&value));
+		g_assert(length == step->length);
+		g_assert(!memcmp(value, step->value, length));
+
+		g_assert(!bt_gatt_iter_next_read_by_type(&iter, &handle,
+							&length, &value));
+	}
+
+	context_quit(context);
+}
+
+static void test_read_by_type(gconstpointer data)
+{
+	struct context *context = create_context(512, data);
+	const struct test_data *test_data = data;
+	const struct test_step *step = context->data->step;
+
+	g_assert(bt_gatt_read_by_type(context->att, step->handle,
+					step->end_handle, test_data->uuid,
+					read_by_type_cb, context, NULL));
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -631,7 +684,7 @@ int main(int argc, char *argv[])
 	 * The test group objective is to verify Generic Attribute Profile
 	 * Discovery of Services and Service Characteristics.
 	 */
-	define_test_att("/TP/GAD/CL/BV-01-C", test_search_primary, NULL,
+	define_test_att("/TP/GAD/CL/BV-01-C", test_search_primary, NULL, NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -647,6 +700,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x01, 0x10, 0x97, 0x00, 0x0a));
 
 	define_test_att("/TP/GAD/CL/BV-02-C-1", test_search_primary, &uuid_16,
+			NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x00,
@@ -657,6 +711,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
 
 	define_test_att("/TP/GAD/CL/BV-02-C-2", test_search_primary, &uuid_128,
+			NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0xfb,
@@ -671,6 +726,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
 
 	define_test_att("/TP/GAD/CL/BV-03-C", test_search_included, NULL,
+			NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x02, 0x28),
@@ -694,6 +750,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x01, 0x08, 0x06, 0x00, 0x0a));
 
 	define_test_att("/TP/GAD/CL/BV-04-C", test_search_chars, NULL,
+			NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x08, 0x10, 0x00, 0x20, 0x00, 0x03, 0x28),
@@ -707,7 +764,7 @@ int main(int argc, char *argv[])
 			raw_pdu(0x08, 0x14, 0x00, 0x20, 0x00, 0x03, 0x28),
 			raw_pdu(0x01, 0x08, 0x12, 0x00, 0x0a));
 
-	define_test_att("/TP/GAD/CL/BV-06-C", test_search_descs, NULL,
+	define_test_att("/TP/GAD/CL/BV-06-C", test_search_descs, NULL, NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x04, 0x13, 0x00, 0x16, 0x00),
@@ -741,5 +798,14 @@ int main(int argc, char *argv[])
 			raw_pdu(0x0a, 0x03, 0x00),
 			raw_pdu(0x01, 0x0a, 0x03, 0x00, 0x08));
 
+	define_test_att("/TP/GAR/CL/BV-03-C-1", test_read_by_type,
+			&uuid_char_16, &test_read_by_type_1,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x09, 0x05, 0x0a, 0x00, 0x01, 0x02, 0x03),
+			raw_pdu(0x08, 0x0b, 0x00, 0xff, 0xff, 0x0d, 0x2a),
+			raw_pdu(0x01, 0x08, 0x0b, 0x00, 0x0a));
+
 	return g_test_run();
 }
-- 
1.9.3

