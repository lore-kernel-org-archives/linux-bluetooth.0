Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH Bluez v1 1/2] unit/test-gatt: Add /TP/GAC/SR/BV-01-C test case.
Date: Fri, 21 Nov 2014 15:31:39 -0800
Message-Id: <1416612700-10283-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1416612700-10283-1-git-send-email-armansito@chromium.org>
References: <1416612700-10283-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the server configuration server test case for
bt_gatt_server.
---
 unit/test-gatt.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 7923c8b..d3fb4a0 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -40,6 +40,9 @@
 #include "src/shared/att.h"
 #include "src/shared/gatt-helpers.h"
 #include "src/shared/gatt-client.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
 
 struct test_pdu {
 	bool valid;
@@ -72,7 +75,9 @@ struct test_data {
 struct context {
 	GMainLoop *main_loop;
 	struct bt_gatt_client *client;
+	struct bt_gatt_server *server;
 	struct bt_att *att;
+	struct gatt_db *db;
 	guint source;
 	guint process;
 	int fd;
@@ -114,6 +119,9 @@ struct context {
 #define define_test_client(name, function, bt_services, test_step, args...)\
 	define_test(name, function, CLIENT, NULL, bt_services, test_step, args)
 
+#define define_test_server(name, function, bt_services, test_step, args...)\
+	define_test(name, function, SERVER, NULL, bt_services, test_step, args)
+
 #define SERVICE_DATA_1_PDU						\
 		raw_pdu(0x02, 0x00, 0x02),				\
 		raw_pdu(0x03, 0x00, 0x02),				\
@@ -144,6 +152,8 @@ struct context {
 		raw_pdu(0x04, 0x08, 0x00, 0x08, 0x00),			\
 		raw_pdu(0x05, 0x01, 0x08, 0x00, 0x01, 0x29)
 
+#define SERVER_MTU_EXCHANGE_PDU raw_pdu(0x02, 0x17, 0x00);
+
 static bt_uuid_t uuid_16 = {
 	.type = BT_UUID16,
 	.value.u16 = 0x1800
@@ -282,6 +292,7 @@ static gboolean send_pdu(gpointer user_data)
 
 static void context_process(struct context *context)
 {
+	/* Quit the context if we processed the last PDU */
 	if (!context->data->pdu_list[context->pdu_offset].valid) {
 		context_quit(context);
 		return;
@@ -447,6 +458,18 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 
 		bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
 		break;
+	case SERVER:
+		context->db = gatt_db_new();
+		g_assert(context->db);
+
+		context->server = bt_gatt_server_new(context->db, att, mtu);
+		g_assert(context->server);
+
+		if (g_test_verbose())
+			bt_gatt_server_set_debug(context->server, print_debug,
+						"bt_gatt_server:", NULL);
+		bt_att_unref(att);
+		break;
 	case CLIENT:
 		context->client = bt_gatt_client_new(att, mtu);
 		g_assert(context->client);
@@ -500,6 +523,8 @@ static void destroy_context(struct context *context)
 		g_source_remove(context->source);
 
 	bt_gatt_client_unref(context->client);
+	bt_gatt_server_unref(context->server);
+	gatt_db_destroy(context->db);
 
 	if (context->att)
 		bt_att_unref(context->att);
@@ -577,6 +602,22 @@ static void test_client(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_server(gconstpointer data)
+{
+	struct context *context = create_context(512, data);
+	const struct test_pdu pdu = SERVER_MTU_EXCHANGE_PDU;
+	ssize_t len;
+
+	len = write(context->fd, pdu.data, pdu.size);
+
+	if (g_test_verbose())
+		util_hexdump('<', pdu.data, len, test_debug, "GATT: ");
+
+	g_assert_cmpint(len, ==, pdu.size);
+
+	execute_context(context);
+}
+
 static void test_search_primary(gconstpointer data)
 {
 	struct context *context = create_context(512, data);
@@ -785,7 +826,10 @@ int main(int argc, char *argv[])
 	 */
 
 	define_test_client("/TP/GAC/CL/BV-01-C", test_client, NULL, NULL,
-				raw_pdu(0x02, 0x00, 0x02));
+						raw_pdu(0x02, 0x00, 0x02));
+
+	define_test_server("/TP/GAC/SR/BV-01-C", test_server, NULL, NULL,
+						raw_pdu(0x03, 0x00, 0x02));
 
 	/*
 	 * Discovery
-- 
2.1.0.rc2.206.gedb03e5

