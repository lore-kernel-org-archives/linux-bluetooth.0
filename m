Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 3/3] unit/test-gatt: Unref pending discovery requests
Date: Fri, 27 Feb 2015 16:44:47 -0800
Message-Id: <1425084287-9974-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1425084287-9974-1-git-send-email-armansito@chromium.org>
References: <1425084287-9974-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds code to clean up pending discovery requests in
unit/test-gatt, since the recent API changes will cause memory leaks
otherwise.
---
 unit/test-gatt.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 9fa301b..11ecebe 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -78,6 +78,7 @@ struct context {
 	int fd;
 	unsigned int pdu_offset;
 	const struct test_data *data;
+	struct bt_gatt_async_req *req;
 };
 
 #define data(args...) ((const unsigned char[]) { args })
@@ -277,6 +278,9 @@ static void destroy_context(struct context *context)
 	if (context->source > 0)
 		g_source_remove(context->source);
 
+	if (context->req)
+		bt_gatt_async_req_unref(context->req);
+
 	bt_gatt_client_unref(context->client);
 	bt_gatt_server_unref(context->server);
 	gatt_db_unref(context->client_db);
@@ -645,6 +649,9 @@ static void generic_search_cb(bool success, uint8_t att_ecode,
 {
 	struct context *context = user_data;
 
+	bt_gatt_async_req_unref(context->req);
+	context->req = NULL;
+
 	g_assert(success);
 
 	context_quit(context);
@@ -1481,7 +1488,8 @@ static void test_search_primary(gconstpointer data)
 	struct context *context = create_context(512, data);
 	const struct test_data *test_data = data;
 
-	bt_gatt_discover_all_primary_services(context->att, test_data->uuid,
+	context->req = bt_gatt_discover_all_primary_services(context->att,
+							test_data->uuid,
 							generic_search_cb,
 							context, NULL);
 }
@@ -1490,7 +1498,8 @@ static void test_search_included(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
 
-	bt_gatt_discover_included_services(context->att, 0x0001, 0xffff,
+	context->req = bt_gatt_discover_included_services(context->att,
+							0x0001, 0xffff,
 							generic_search_cb,
 							context, NULL);
 }
@@ -1499,18 +1508,22 @@ static void test_search_chars(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
 
-	g_assert(bt_gatt_discover_characteristics(context->att, 0x0010, 0x0020,
+	context->req = bt_gatt_discover_characteristics(context->att,
+							0x0010, 0x0020,
 							generic_search_cb,
-							context, NULL));
+							context, NULL);
+	g_assert(context->req);
 }
 
 static void test_search_descs(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
 
-	g_assert(bt_gatt_discover_descriptors(context->att, 0x0013, 0x0016,
+	context->req = bt_gatt_discover_descriptors(context->att,
+							0x0013, 0x0016,
 							generic_search_cb,
-							context, NULL));
+							context, NULL);
+	g_assert(context->req);
 }
 
 static const struct test_step test_read_by_type_1 = {
-- 
2.2.0.rc0.207.ga3a616c

