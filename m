Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] unit/test-avdtp: Use tester framework
Date: Thu, 26 Mar 2015 16:20:22 +0200
Message-Id: <1427379625-20412-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com>
References: <1427379625-20412-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Our tester framework actually produces much better output.
---
 unit/test-avdtp.c | 104 +++++++++++++++++++++---------------------------------
 1 file changed, 40 insertions(+), 64 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 805f08d..58628a7 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -37,7 +37,9 @@
 
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/tester.h"
 #include "src/log.h"
+
 #include "android/avdtp.h"
 
 #define MAX_SEID 0x3E
@@ -80,11 +82,10 @@ struct test_data {
 		data.test_name = g_strdup(name);			\
 		data.pdu_list = g_malloc(sizeof(pdus));			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
-		g_test_add_data_func(name, &data, function);		\
+		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
 struct context {
-	GMainLoop *main_loop;
 	struct avdtp *session;
 	struct avdtp_local_sep *sep;
 	struct avdtp_stream *stream;
@@ -103,7 +104,7 @@ static void test_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	g_print("%s%s\n", prefix, str);
+	tester_debug("%s%s", prefix, str);
 }
 
 static void test_free(gconstpointer user_data)
@@ -114,6 +115,26 @@ static void test_free(gconstpointer user_data)
 	g_free(data->pdu_list);
 }
 
+static void unregister_sep(void *data)
+{
+	struct avdtp_local_sep *sep = data;
+
+	/* Removed from the queue by caller */
+	avdtp_unregister_sep(NULL, sep);
+}
+
+static void destroy_context(struct context *context)
+{
+	if (context->source > 0)
+		g_source_remove(context->source);
+	avdtp_unref(context->session);
+
+	test_free(context->data);
+	queue_destroy(context->lseps, unregister_sep);
+
+	g_free(context);
+}
+
 static gboolean context_quit(gpointer user_data)
 {
 	struct context *context = user_data;
@@ -121,7 +142,9 @@ static gboolean context_quit(gpointer user_data)
 	if (context->process > 0)
 		g_source_remove(context->process);
 
-	g_main_loop_quit(context->main_loop);
+	destroy_context(context);
+
+	tester_test_passed();
 
 	return FALSE;
 }
@@ -136,8 +159,7 @@ static gboolean send_pdu(gpointer user_data)
 
 	len = write(context->fd, pdu->data, pdu->size);
 
-	if (g_test_verbose())
-		util_hexdump('<', pdu->data, len, test_debug, "AVDTP: ");
+	util_hexdump('<', pdu->data, len, test_debug, "AVDTP: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -194,8 +216,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	if (g_test_verbose())
-		util_hexdump('>', buf, len, test_debug, "AVDTP: ");
+	util_hexdump('>', buf, len, test_debug, "AVDTP: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -227,9 +248,6 @@ static struct context *context_new(uint16_t version, uint16_t imtu,
 	GIOChannel *channel;
 	int err, sv[2];
 
-	context->main_loop = g_main_loop_new(NULL, FALSE);
-	g_assert(context->main_loop);
-
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
 	g_assert(err == 0);
 
@@ -264,35 +282,6 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 	return context_new(version, 672, 672, data);
 }
 
-static void unregister_sep(void *data)
-{
-	struct avdtp_local_sep *sep = data;
-
-	/* Removed from the queue by caller */
-	avdtp_unregister_sep(NULL, sep);
-}
-
-static void destroy_context(struct context *context)
-{
-	if (context->source > 0)
-		g_source_remove(context->source);
-	avdtp_unref(context->session);
-
-	g_main_loop_unref(context->main_loop);
-
-	test_free(context->data);
-	queue_destroy(context->lseps, unregister_sep);
-
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
 static gboolean sep_getcap_ind(struct avdtp *session,
 					struct avdtp_local_sep *sep,
 					GSList **caps, uint8_t *err,
@@ -424,6 +413,11 @@ static void sep_setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct context *context = user_data;
 	int ret;
 
+	if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-09-C")) {
+		context_quit(context);
+		return;
+	}
+
 	if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BI-07-C")) {
 		g_assert(err != NULL);
 		g_assert_cmpint(avdtp_error_error_code(err), ==, 0x13);
@@ -531,8 +525,6 @@ static void test_server(gconstpointer data)
 	g_assert(sep);
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 static void test_server_1_3(gconstpointer data)
@@ -546,8 +538,6 @@ static void test_server_1_3(gconstpointer data)
 	g_assert(sep);
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 static void test_server_1_3_sink(gconstpointer data)
@@ -561,8 +551,6 @@ static void test_server_1_3_sink(gconstpointer data)
 	g_assert(sep);
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 static void test_server_0_sep(gconstpointer data)
@@ -570,8 +558,6 @@ static void test_server_0_sep(gconstpointer data)
 	struct context *context = create_context(0x0100, data);
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 static void test_server_seid(gconstpointer data)
@@ -595,7 +581,7 @@ static void test_server_seid(gconstpointer data)
 						context);
 	g_assert(!sep);
 
-	destroy_context(context);
+	context_quit(context);
 }
 
 static void test_server_seid_duplicate(gconstpointer data)
@@ -628,8 +614,6 @@ static void test_server_seid_duplicate(gconstpointer data)
 	/* Check SEID ids with DISCOVER */
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 static gboolean sep_getcap_ind_frg(struct avdtp *session,
@@ -684,8 +668,6 @@ static void test_server_frg(gconstpointer data)
 	g_assert(sep);
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 static void discover_cb(struct avdtp *session, GSList *seps,
@@ -767,8 +749,6 @@ static void test_client(gconstpointer data)
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
-
-	execute_context(context);
 }
 
 static void test_client_1_3(gconstpointer data)
@@ -783,8 +763,6 @@ static void test_client_1_3(gconstpointer data)
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
-
-	execute_context(context);
 }
 
 static void test_client_frg(gconstpointer data)
@@ -799,16 +777,13 @@ static void test_client_frg(gconstpointer data)
 	context->sep = sep;
 
 	avdtp_discover(context->session, discover_cb, context);
-
-	execute_context(context);
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
-	if (g_test_verbose())
-		__btd_log_init("*", 0);
+	__btd_log_init("*", 0);
 
 	/*
 	 * Stream Management Service
@@ -843,7 +818,8 @@ int main(int argc, char *argv[])
 			raw_pdu(0x42, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
 				0xff, 0xff, 0x02, 0x40),
 			raw_pdu(0x50, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
-				0x00, 0x00, 0x21, 0x02, 0x02, 0x20));
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x52, 0x03));
 	define_test("/TP/SIG/SMG/BV-10-C", test_server,
 			raw_pdu(0x00, 0x01),
 			raw_pdu(0x02, 0x01, 0x04, 0x00),
@@ -1413,5 +1389,5 @@ int main(int argc, char *argv[])
 			raw_pdu(0x50, 0x0d, 0x04, 0x00, 0x00),
 			raw_pdu(0x52, 0x0d));
 
-	return g_test_run();
+	return tester_run();
 }
-- 
2.1.0

