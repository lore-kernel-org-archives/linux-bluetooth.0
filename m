Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/7] unit/test-gatt: Add search primary by 16 but UUID test case
Date: Tue, 28 Oct 2014 20:37:43 +0100
Message-Id: <1414525067-15076-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414525067-15076-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414525067-15076-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gatt.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index f84b0fc..1167d4d 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -57,6 +57,7 @@ struct test_data {
 	char *test_name;
 	struct test_pdu *pdu_list;
 	enum context_type context_type;
+	bt_uuid_t *uuid;
 };
 
 struct context {
@@ -79,7 +80,7 @@ struct context {
 		.size = sizeof(data(args)),			\
 	}
 
-#define define_test(name, function, type, args...)			\
+#define define_test(name, function, type, bt_uuid, args...)		\
 	do {								\
 		const struct test_pdu pdus[] = {			\
 			args, { }					\
@@ -87,11 +88,17 @@ struct context {
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
 		data.context_type = type;				\
+		data.uuid = bt_uuid;					\
 		data.pdu_list = g_malloc(sizeof(pdus));			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, function);		\
 	} while (0)
 
+static bt_uuid_t uuid_16 = {
+	.type = BT_UUID16,
+	.value.u16 = 0x1800
+};
+
 static void test_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
@@ -290,9 +297,10 @@ static void test_client(gconstpointer data)
 static void test_search_primary(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
+	const struct test_data *test_data = data;
 
-	bt_gatt_discover_all_primary_services(context->att, NULL, primary_cb,
-								context, NULL);
+	bt_gatt_discover_all_primary_services(context->att, test_data->uuid,
+						primary_cb, context, NULL);
 
 	execute_context(context);
 }
@@ -307,7 +315,7 @@ int main(int argc, char *argv[])
 	 * The test group objective is to verify Generic Attribute Profile
 	 * Server Configuration.
 	 */
-	define_test("/TP/GAC/CL/BV-01-C", test_client, CLIENT,
+	define_test("/TP/GAC/CL/BV-01-C", test_client, CLIENT, NULL,
 				raw_pdu(0x02, 0x00, 0x02));
 
 	/*
@@ -316,7 +324,7 @@ int main(int argc, char *argv[])
 	 * The test group objective is to verify Generic Attribute Profile
 	 * Discovery of Services and Service Characteristics.
 	 */
-	define_test("/TP/GAD/CL/BV-01-C", test_search_primary, ATT,
+	define_test("/TP/GAD/CL/BV-01-C", test_search_primary, ATT, NULL,
 			raw_pdu(0x02, 0x00, 0x02),
 			raw_pdu(0x03, 0x00, 0x02),
 			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
@@ -331,5 +339,15 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x97, 0x00, 0xff, 0xff, 0x00, 0x28),
 			raw_pdu(0x01, 0x10, 0x97, 0x00, 0x0a));
 
+	define_test("/TP/GAD/CL/BV-02-C-1", test_search_primary, ATT, &uuid_16,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x00,
+					0x18),
+			raw_pdu(0x07, 0x01, 0x00, 0x07, 0x00),
+			raw_pdu(0x06, 0x08, 0x00, 0xff, 0xff, 0x00, 0x28, 0x00,
+					0x18),
+			raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
+
 	return g_test_run();
 }
-- 
1.9.3

