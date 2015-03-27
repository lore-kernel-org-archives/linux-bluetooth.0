Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] unit/test-avrcp: Use tester framework
Date: Fri, 27 Mar 2015 10:49:51 +0200
Message-Id: <1427446194-5646-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
References: <1427446194-5646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Our tester framework actually produces much better output.
---
 unit/test-avrcp.c | 73 +++++++++++++++++++++----------------------------------
 1 file changed, 28 insertions(+), 45 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index cffba78..b0404c9 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -37,6 +37,7 @@
 #include <glib.h>
 
 #include "src/shared/util.h"
+#include "src/shared/tester.h"
 #include "src/log.h"
 #include "lib/bluetooth.h"
 
@@ -58,7 +59,6 @@ struct test_data {
 };
 
 struct context {
-	GMainLoop *main_loop;
 	struct avrcp *session;
 	guint source;
 	guint browse_source;
@@ -111,14 +111,14 @@ struct context {
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
@@ -129,6 +129,20 @@ static void test_free(gconstpointer user_data)
 	g_free(data->pdu_list);
 }
 
+static void destroy_context(struct context *context)
+{
+	if (context->source > 0)
+		g_source_remove(context->source);
+
+	if (context->browse_source > 0)
+		g_source_remove(context->browse_source);
+
+	avrcp_shutdown(context->session);
+
+	test_free(context->data);
+	g_free(context);
+}
+
 static gboolean context_quit(gpointer user_data)
 {
 	struct context *context = user_data;
@@ -136,7 +150,9 @@ static gboolean context_quit(gpointer user_data)
 	if (context->process > 0)
 		g_source_remove(context->process);
 
-	g_main_loop_quit(context->main_loop);
+	destroy_context(context);
+
+	tester_test_passed();
 
 	return FALSE;
 }
@@ -154,8 +170,7 @@ static gboolean send_pdu(gpointer user_data)
 	else
 		len = write(context->fd, pdu->data, pdu->size);
 
-	if (g_test_verbose())
-		util_hexdump('<', pdu->data, len, test_debug, "AVRCP: ");
+	util_hexdump('<', pdu->data, len, test_debug, "AVRCP: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -193,7 +208,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		context->source = 0;
-		g_print("%s: cond %x\n", __func__, cond);
+		tester_debug("%s: cond %x\n", __func__, cond);
 		return FALSE;
 	}
 
@@ -234,7 +249,7 @@ static gboolean browse_test_handler(GIOChannel *channel, GIOCondition cond,
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		context->browse_source = 0;
-		g_print("%s: cond %x\n", __func__, cond);
+		tester_debug("%s: cond %x\n", __func__, cond);
 		return FALSE;
 	}
 
@@ -244,8 +259,7 @@ static gboolean browse_test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	if (g_test_verbose())
-		util_hexdump('>', buf, len, test_debug, "AVRCP: ");
+	util_hexdump('>', buf, len, test_debug, "AVRCP: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -265,9 +279,6 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 
 	DBG("");
 
-	context->main_loop = g_main_loop_new(NULL, FALSE);
-	g_assert(context->main_loop);
-
 	/* Control channel setup */
 
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
@@ -319,34 +330,11 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 	return context;
 }
 
-static void destroy_context(struct context *context)
-{
-	if (context->source > 0)
-		g_source_remove(context->source);
-
-	avrcp_shutdown(context->session);
-
-	if (context->browse_source > 0)
-		g_source_remove(context->browse_source);
-
-	g_main_loop_unref(context->main_loop);
-
-	test_free(context->data);
-	g_free(context);
-}
-
 static void test_dummy(gconstpointer data)
 {
 	struct context *context =  create_context(0x0100, data);
 
-	destroy_context(context);
-}
-
-static void execute_context(struct context *context)
-{
-	g_main_loop_run(context->main_loop);
-
-	destroy_context(context);
+	context_quit(context);
 }
 
 static bool handle_play(struct avrcp *session, bool pressed, void *user_data)
@@ -877,8 +865,6 @@ static void test_server(gconstpointer data)
 	avrcp_register_player(context->session, &control_ind, NULL, context);
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 static void get_folder_items_rsp(struct avrcp *session, int err,
@@ -1083,16 +1069,13 @@ static void test_client(gconstpointer data)
 
 	if (g_str_equal(context->data->test_name, "/TP/PTH/BV-02-C"))
 		avrcp_send_passthrough(context->session, 0, AVC_FAST_FORWARD);
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
 
 	/* Media Player Selection Commands and Notifications */
 
@@ -2182,5 +2165,5 @@ int main(int argc, char *argv[])
 				0x00, 0x19, 0x58, AVRCP_ABORT_CONTINUING,
 				0x00, 0x00, 0x00));
 
-	return g_test_run();
+	return tester_run();
 }
-- 
2.1.0

