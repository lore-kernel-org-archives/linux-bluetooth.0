Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  1/2] unit/test-hfp: Use tester framework
Date: Thu, 01 Oct 2015 18:21:42 +0530
Message-id: <1443703903-4546-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed mainloop dependency and updated with
tester framework.
---
 unit/test-hfp.c | 84 +++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 66966ce..509aaab 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -29,9 +29,9 @@
 
 #include <glib.h>
 #include "src/shared/hfp.h"
+#include "src/shared/tester.h"
 
 struct context {
-	GMainLoop *main_loop;
 	guint watch_id;
 	int fd_server;
 	int fd_client;
@@ -97,7 +97,7 @@ struct test_data {
 		data.test_name = g_strdup(name);			\
 		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		data.result_func = result_function;			\
-		g_test_add_data_func(name, &data, function);		\
+		tester_add(name, &data, NULL, function, NULL);		\
 		data.test_handler = test_handler;			\
 	} while (0)
 
@@ -112,15 +112,10 @@ struct test_data {
 		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
 		data.hf_result_func = result_func;			\
 		data.response_func = response_function;			\
-		g_test_add_data_func(name, &data, function);		\
+		tester_add(name, &data, NULL, function, NULL);		\
 		data.test_handler = test_hf_handler;			\
 	} while (0)
 
-static void context_quit(struct context *context)
-{
-	g_main_loop_quit(context->main_loop);
-}
-
 static void test_free(gconstpointer user_data)
 {
 	const struct test_data *data = user_data;
@@ -129,6 +124,34 @@ static void test_free(gconstpointer user_data)
 	g_free(data->pdu_list);
 }
 
+static void destroy_context(struct context *context)
+{
+	if (context->watch_id)
+		g_source_remove(context->watch_id);
+
+	test_free(context->data);
+
+	if (context->hfp)
+		hfp_gw_unref(context->hfp);
+
+	if (context->hfp_hf)
+		hfp_hf_unref(context->hfp_hf);
+
+	g_free(context);
+}
+
+static gboolean context_quit(gpointer user_data)
+{
+	struct context *context = user_data;
+
+	if(context == NULL)
+		return FALSE;
+
+	destroy_context(context);
+	tester_test_passed();
+	return FALSE;
+}
+
 static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -224,9 +247,6 @@ static struct context *create_context(gconstpointer data)
 	int err, sv[2];
 	const struct test_data *d = data;
 
-	context->main_loop = g_main_loop_new(NULL, FALSE);
-	g_assert(context->main_loop);
-
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
 	g_assert(err == 0);
 
@@ -251,26 +271,6 @@ static struct context *create_context(gconstpointer data)
 	return context;
 }
 
-static void execute_context(struct context *context)
-{
-	g_main_loop_run(context->main_loop);
-
-	if (context->watch_id)
-		g_source_remove(context->watch_id);
-
-	g_main_loop_unref(context->main_loop);
-
-	test_free(context->data);
-
-	if (context->hfp)
-		hfp_gw_unref(context->hfp);
-
-	if (context->hfp_hf)
-		hfp_hf_unref(context->hfp_hf);
-
-	g_free(context);
-}
-
 static void test_init(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -283,7 +283,7 @@ static void test_init(gconstpointer data)
 	hfp_gw_unref(context->hfp);
 	context->hfp = NULL;
 
-	execute_context(context);
+	context_quit(context);
 }
 
 static void test_command_handler(gconstpointer data)
@@ -308,7 +308,7 @@ static void test_command_handler(gconstpointer data)
 	len = write(context->fd_server, pdu->data, pdu->size);
 	g_assert_cmpint(len, ==, pdu->size);
 
-	execute_context(context);
+	context_quit(context);
 }
 
 static void test_register(gconstpointer data)
@@ -337,7 +337,7 @@ static void test_register(gconstpointer data)
 	len = write(context->fd_server, pdu->data, pdu->size);
 	g_assert_cmpint(len, ==, pdu->size);
 
-	execute_context(context);
+	context_quit(context);
 }
 
 static void test_fragmented(gconstpointer data)
@@ -352,8 +352,6 @@ static void test_fragmented(gconstpointer data)
 	g_assert(ret);
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 static void test_send_and_close(gconstpointer data)
@@ -372,7 +370,7 @@ static void test_send_and_close(gconstpointer data)
 	hfp_gw_unref(context->hfp);
 	context->hfp = NULL;
 
-	execute_context(context);
+	context_quit(context);
 }
 
 static void check_ustring_1(struct hfp_context *result,
@@ -494,7 +492,7 @@ static void test_hf_init(gconstpointer data)
 	hfp_hf_unref(context->hfp_hf);
 	context->hfp_hf = NULL;
 
-	execute_context(context);
+	context_quit(context);
 }
 
 static bool unsolicited_resp = false;
@@ -567,7 +565,7 @@ static void test_hf_send_command(gconstpointer data)
 		g_assert(ret);
 	}
 
-	execute_context(context);
+	context_quit(context);
 }
 static void hf_chld_result_handler(struct hfp_context *hf_context,
 							void *user_data)
@@ -667,8 +665,6 @@ static void test_hf_unsolicited(gconstpointer data)
 	}
 
 	send_pdu(context);
-
-	execute_context(context);
 }
 
 static void test_hf_robustness(gconstpointer data)
@@ -687,12 +683,12 @@ static void test_hf_robustness(gconstpointer data)
 	hfp_hf_unref(context->hfp_hf);
 	context->hfp_hf = NULL;
 
-	execute_context(context);
+	context_quit(context);
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
 	define_test("/hfp/test_init", test_init, NULL, data_end());
 	define_test("/hfp/test_cmd_handler_1", test_command_handler, NULL,
@@ -860,5 +856,5 @@ int main(int argc, char *argv[])
 			frg_pdu('1', ',', '2', 'x', '\r', '\n'),
 			data_end());
 
-	return g_test_run();
+	return tester_run();
 }
-- 
1.9.1

