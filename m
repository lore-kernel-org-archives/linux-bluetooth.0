Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/7] unit/test-gatt: Add TP/GAD/CL/BV-01-C test
Date: Fri, 31 Oct 2014 09:51:58 +0100
Message-Id: <1414745523-31699-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414745523-31699-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414745523-31699-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Verify that a Generic Attribute Profile client discovers
Primary Services in a GATT server.
---
 unit/test-gatt.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index bbbf9a5..f84b0fc 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -35,8 +35,10 @@
 
 #include <glib.h>
 
+#include "lib/uuid.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
+#include "src/shared/gatt-helpers.h"
 #include "src/shared/gatt-client.h"
 
 struct test_pdu {
@@ -45,14 +47,22 @@ struct test_pdu {
 	size_t size;
 };
 
+enum context_type {
+	ATT,
+	CLIENT,
+	SERVER
+};
+
 struct test_data {
 	char *test_name;
 	struct test_pdu *pdu_list;
+	enum context_type context_type;
 };
 
 struct context {
 	GMainLoop *main_loop;
 	struct bt_gatt_client *client;
+	struct bt_att *att;
 	guint source;
 	guint process;
 	int fd;
@@ -69,13 +79,14 @@ struct context {
 		.size = sizeof(data(args)),			\
 	}
 
-#define define_test(name, function, args...)				\
+#define define_test(name, function, type, args...)			\
 	do {								\
 		const struct test_pdu pdus[] = {			\
 			args, { }					\
 		};							\
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
+		data.context_type = type;				\
 		data.pdu_list = g_malloc(sizeof(pdus));			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
 		g_test_add_data_func(name, &data, function);		\
@@ -182,6 +193,7 @@ static void gatt_debug(const char *str, void *user_data)
 static struct context *create_context(uint16_t mtu, gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
+	const struct test_data *test_data = data;
 	GIOChannel *channel;
 	int err, sv[2];
 	struct bt_att *att;
@@ -195,12 +207,25 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 	att = bt_att_new(sv[0]);
 	g_assert(att);
 
-	context->client = bt_gatt_client_new(att, mtu);
-	g_assert(context->client);
+	switch (test_data->context_type) {
+	case ATT:
+		context->att = att;
 
-	if (g_test_verbose())
-		bt_gatt_client_set_debug(context->client, gatt_debug, "gatt:",
-									NULL);
+		bt_gatt_exchange_mtu(context->att, mtu, NULL, NULL, NULL);
+		break;
+	case CLIENT:
+		context->client = bt_gatt_client_new(att, mtu);
+		g_assert(context->client);
+
+		if (g_test_verbose())
+			bt_gatt_client_set_debug(context->client, gatt_debug,
+								"gatt:", NULL);
+
+		bt_att_unref(att);
+		break;
+	default:
+		break;
+	}
 
 	channel = g_io_channel_unix_new(sv[1]);
 
@@ -214,7 +239,6 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 	g_assert(context->source > 0);
 
 	g_io_channel_unref(channel);
-	bt_att_unref(att);
 
 	context->fd = sv[1];
 	context->data = data;
@@ -222,6 +246,17 @@ static struct context *create_context(uint16_t mtu, gconstpointer data)
 	return context;
 }
 
+static void primary_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	struct context *context = user_data;
+
+	g_assert(success);
+
+	context_quit(context);
+}
+
 static void destroy_context(struct context *context)
 {
 	if (context->source > 0)
@@ -229,6 +264,9 @@ static void destroy_context(struct context *context)
 
 	bt_gatt_client_unref(context->client);
 
+	if (context->att)
+		bt_att_unref(context->att);
+
 	g_main_loop_unref(context->main_loop);
 
 	test_free(context->data);
@@ -249,6 +287,16 @@ static void test_client(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_search_primary(gconstpointer data)
+{
+	struct context *context = create_context(512, data);
+
+	bt_gatt_discover_all_primary_services(context->att, NULL, primary_cb,
+								context, NULL);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -259,8 +307,29 @@ int main(int argc, char *argv[])
 	 * The test group objective is to verify Generic Attribute Profile
 	 * Server Configuration.
 	 */
-	define_test("/TP/GAC/CL/BV-01-C", test_client,
+	define_test("/TP/GAC/CL/BV-01-C", test_client, CLIENT,
 				raw_pdu(0x02, 0x00, 0x02));
 
+	/*
+	 * Discovery
+	 *
+	 * The test group objective is to verify Generic Attribute Profile
+	 * Discovery of Services and Service Characteristics.
+	 */
+	define_test("/TP/GAD/CL/BV-01-C", test_search_primary, ATT,
+			raw_pdu(0x02, 0x00, 0x02),
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x06, 0x10, 0x00, 0x13, 0x00, 0x00, 0x18,
+					0x20, 0x00, 0x29, 0x00, 0xb0, 0x68,
+					0x30, 0x00, 0x32, 0x00, 0x19, 0x18),
+			raw_pdu(0x10, 0x33, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x11, 0x14, 0x90, 0x00, 0x96, 0x00, 0xef, 0xcd,
+					0xab, 0x89, 0x67, 0x45, 0x23, 0x01,
+					0x00, 0x00, 0x00, 0x00, 0x85, 0x60,
+					0x00, 0x00),
+			raw_pdu(0x10, 0x97, 0x00, 0xff, 0xff, 0x00, 0x28),
+			raw_pdu(0x01, 0x10, 0x97, 0x00, 0x0a));
+
 	return g_test_run();
 }
-- 
1.9.3

