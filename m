Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/2] unit/test-gatt: Add SERVER and COEX test types and MTU tests.
Date: Wed, 19 Nov 2014 21:03:41 -0800
Message-Id: <1416459821-16478-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1416459821-16478-1-git-send-email-armansito@chromium.org>
References: <1416459821-16478-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the following two features:

  1. SERVER: The test context creates a bt_gatt_server.
  2. COEX: The test context creates a bt_gatt_server AND a bt_gatt_client.

Also added 4 new test cases for the "Server Configuration" category, with two
new client-role and two new server-role tests which exercise the following:

/TP/GAC/CL/BV-01-C:
  1. CLIENT test with incoming "Exchange MTU" request. bt_att automatically
  responds with "ERROR_NOT_SUPPORTED".
  2. COEX test. The "DUT" sends "Exchange MTU" request first and the "tester"
  sends it right after.

/TP/GAC/SR/BV-01-C:
  1. SERVER test with incoming "Exchange MTU" request. No outgoing request.
  2. COEX test. The "tester" sends "Exchange MTU" request first and the "DUT"
  sends it right after.
---
 unit/test-gatt.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 6 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 900f5e3..7ab7780 100644
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
@@ -50,7 +53,8 @@ struct test_pdu {
 enum context_type {
 	ATT,
 	CLIENT,
-	SERVER
+	SERVER,
+	COEX
 };
 
 struct gatt_service {
@@ -72,7 +76,9 @@ struct test_data {
 struct context {
 	GMainLoop *main_loop;
 	struct bt_gatt_client *client;
+	struct bt_gatt_server *server;
 	struct bt_att *att;
+	struct gatt_db *db;
 	guint source;
 	guint process;
 	int fd;
@@ -114,9 +120,13 @@ struct context {
 #define define_test_client(name, function, bt_services, test_step, args...)\
 	define_test(name, function, CLIENT, NULL, bt_services, test_step, args)
 
-#define SERVICE_DATA_1_PDU						\
-		raw_pdu(0x02, 0x00, 0x02),				\
-		raw_pdu(0x03, 0x00, 0x02),				\
+#define define_test_server(name, function, bt_services, test_step, args...)\
+	define_test(name, function, SERVER, NULL, bt_services, test_step, args)
+
+#define define_test_coex(name, function, bt_services, test_step, args...)\
+	define_test(name, function, COEX, NULL, bt_services, test_step, args)
+
+#define SERVICE_DATA_1_DISCOVERY_PDU					\
 		raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),	\
 		raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00, 0x01, 0x18),\
 		raw_pdu(0x10, 0x05, 0x00, 0xff, 0xff, 0x00, 0x28),	\
@@ -144,6 +154,11 @@ struct context {
 		raw_pdu(0x04, 0x08, 0x00, 0x08, 0x00),			\
 		raw_pdu(0x05, 0x01, 0x08, 0x00, 0x01, 0x29)
 
+#define SERVICE_DATA_1_PDU						\
+		raw_pdu(0x02, 0x00, 0x02),				\
+		raw_pdu(0x03, 0x00, 0x02),				\
+		SERVICE_DATA_1_DISCOVERY_PDU
+
 static bt_uuid_t uuid_16 = {
 	.type = BT_UUID16,
 	.value.u16 = 0x1800
@@ -282,11 +297,18 @@ static gboolean send_pdu(gpointer user_data)
 
 static void context_process(struct context *context)
 {
+	/* Quit the context if we processed the last PDU */
 	if (!context->data->pdu_list[context->pdu_offset].valid) {
 		context_quit(context);
 		return;
 	}
 
+	/* Skip the PDU, if it's empty */
+	if (!context->data->pdu_list[context->pdu_offset].size) {
+		context->pdu_offset++;
+		return;
+	}
+
 	context->process = g_idle_add(send_pdu, context);
 }
 
@@ -427,6 +449,7 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 	GIOChannel *channel;
 	int err, sv[2];
 	struct bt_att *att;
+	bool coex = false;
 
 	context->main_loop = g_main_loop_new(NULL, FALSE);
 	g_assert(context->main_loop);
@@ -447,6 +470,22 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 
 		bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
 		break;
+	case COEX:
+		coex = true;
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
+		if (!coex) {
+			bt_att_unref(att);
+			break;
+		}
 	case CLIENT:
 		context->client = bt_gatt_client_new(att, mtu, NULL);
 		g_assert(context->client);
@@ -500,6 +539,8 @@ static void destroy_context(struct context *context)
 		g_source_remove(context->source);
 
 	bt_gatt_client_unref(context->client);
+	bt_gatt_server_unref(context->server);
+	gatt_db_destroy(context->db);
 
 	if (context->att)
 		bt_att_unref(context->att);
@@ -577,6 +618,22 @@ static void test_client(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_server(gconstpointer data)
+{
+	struct context *context = create_context(512, data);
+	const struct test_pdu pdu = raw_pdu(0x02, 0x17, 0x00);
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
@@ -708,11 +765,43 @@ int main(int argc, char *argv[])
 	 * Server Configuration
 	 *
 	 * The test group objective is to verify Generic Attribute Profile
-	 * Server Configuration.
+	 * Server Configuration. The tested configurations are:
+	 *
+	 *   1. Client-role only.
+	 *   2. Server-role only.
+	 *   3. Both roles with only bt_gatt_client.
+	 *   4. Both roles with bt_gatt_client and bt_gatt_server (client
+	 *      request first).
+	 *   5. Both roles with bt_gatt_client and bt_gatt_server (server
+	 *      response first).
 	 */
 
 	define_test_client("/TP/GAC/CL/BV-01-C", test_client, NULL, NULL,
-				raw_pdu(0x02, 0x00, 0x02));
+						raw_pdu(0x02, 0x00, 0x02));
+
+	define_test_server("/TP/GAC/SR/BV-01-C", test_server, NULL, NULL,
+						raw_pdu(0x03, 0x00, 0x02));
+
+	define_test_client("/TP/GAC/CL/BV-01-C", test_client, NULL, NULL,
+					raw_pdu(0x02, 0x00, 0x02),
+					raw_pdu(0x02, 0x17, 0x00),
+					raw_pdu(0x01, 0x02, 0x00, 0x00, 0x06),
+					raw_pdu(0x03, 0x17, 0x00),
+					SERVICE_DATA_1_DISCOVERY_PDU);
+
+	define_test_coex("/TP/GAC/CL/BV-01-C", test_client, NULL, NULL,
+						raw_pdu(0x02, 0x00, 0x02),
+						raw_pdu(0x02, 0x17, 0x00),
+						raw_pdu(0x03, 0x00, 0x02),
+						raw_pdu(0x03, 0x17, 0x00),
+						SERVICE_DATA_1_DISCOVERY_PDU);
+
+	define_test_coex("/TP/GAC/SR/BV-01-C", test_server, NULL, NULL,
+						raw_pdu(0x03, 0x00, 0x02),
+						raw_pdu(),  /* wait */
+						raw_pdu(0x02, 0x00, 0x02),
+						raw_pdu(0x03, 0x17, 0x00),
+						SERVICE_DATA_1_DISCOVERY_PDU);
 
 	/*
 	 * Discovery
-- 
2.1.0.rc2.206.gedb03e5

