Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] unit/test-avctp: Use tester framework
Date: Thu, 26 Mar 2015 16:20:20 +0200
Message-Id: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Our tester framework actually produces much better output.
---
 unit/test-avctp.c | 63 ++++++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 40 deletions(-)

diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index 8f7d5ad..ce52222 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -36,6 +36,7 @@
 #include <glib.h>
 
 #include "src/shared/util.h"
+#include "src/shared/tester.h"
 #include "src/log.h"
 
 #include "android/avctp.h"
@@ -52,7 +53,6 @@ struct test_data {
 };
 
 struct context {
-	GMainLoop *main_loop;
 	struct avctp *session;
 	guint source;
 	guint process;
@@ -79,14 +79,14 @@ struct context {
 		data.test_name = g_strdup(name);			\
 		data.pdu_list = g_malloc(sizeof(pdus));			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
-		g_test_add_data_func(name, &data, function);		\
+		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
 static void test_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	g_print("%s%s\n", prefix, str);
+	tester_debug("%s%s", prefix, str);
 }
 
 static void test_free(gconstpointer user_data)
@@ -97,6 +97,17 @@ static void test_free(gconstpointer user_data)
 	g_free(data->pdu_list);
 }
 
+static void destroy_context(struct context *context)
+{
+	if (context->source > 0)
+		g_source_remove(context->source);
+
+	avctp_shutdown(context->session);
+
+	test_free(context->data);
+	g_free(context);
+}
+
 static gboolean context_quit(gpointer user_data)
 {
 	struct context *context = user_data;
@@ -104,7 +115,9 @@ static gboolean context_quit(gpointer user_data)
 	if (context->process > 0)
 		g_source_remove(context->process);
 
-	g_main_loop_quit(context->main_loop);
+	destroy_context(context);
+
+	tester_test_passed();
 
 	return FALSE;
 }
@@ -119,8 +132,7 @@ static gboolean send_pdu(gpointer user_data)
 
 	len = write(context->fd, pdu->data, pdu->size);
 
-	if (g_test_verbose())
-		util_hexdump('<', pdu->data, len, test_debug, "AVCTP: ");
+	util_hexdump('<', pdu->data, len, test_debug, "AVCTP: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -161,8 +173,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	if (g_test_verbose())
-		util_hexdump('>', buf, len, test_debug, "AVCTP: ");
+	util_hexdump('>', buf, len, test_debug, "AVCTP: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -179,9 +190,6 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 	GIOChannel *channel;
 	int err, sv[2];
 
-	context->main_loop = g_main_loop_new(NULL, FALSE);
-	g_assert(context->main_loop);
-
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
 	g_assert(err == 0);
 
@@ -207,26 +215,6 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 	return context;
 }
 
-static void destroy_context(struct context *context)
-{
-	if (context->source > 0)
-		g_source_remove(context->source);
-
-	avctp_shutdown(context->session);
-
-	g_main_loop_unref(context->main_loop);
-
-	test_free(context->data);
-	g_free(context);
-}
-
-static void execute_context(struct context *context)
-{
-	g_main_loop_run(context->main_loop);
-
-	destroy_context(context);
-}
-
 static ssize_t handler(struct avctp *session,
 					uint8_t transaction, uint8_t *code,
 					uint8_t *subunit, uint8_t *operands,
@@ -266,8 +254,6 @@ static void test_client(gconstpointer data)
 
 	avctp_send_vendor_req(context->session, AVC_CTYPE_CONTROL, 0, NULL,
 						0, handler_response, context);
-
-	execute_context(context);
 }
 
 static void test_server(gconstpointer data)
@@ -284,23 +270,20 @@ static void test_server(gconstpointer data)
 	}
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 static void test_dummy(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
 
-	destroy_context(context);
+	context_quit(context);
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
-	if (g_test_verbose())
-		__btd_log_init("*", 0);
+	__btd_log_init("*", 0);
 
 	/* Connection Channel Management tests */
 
@@ -335,5 +318,5 @@ int main(int argc, char *argv[])
 				raw_pdu(0x00, 0xff, 0xff, 0x00, 0x00, 0x00),
 				raw_pdu(0x03, 0xff, 0xff));
 
-	return g_test_run();
+	return tester_run();
 }
-- 
2.1.0

