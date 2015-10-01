Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  3/3] unit/test-uhid: Use tester framework
Date: Thu, 01 Oct 2015 20:02:23 +0530
Message-id: <1443709943-29957-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1443709943-29957-1-git-send-email-gowtham.ab@samsung.com>
References: <1443709943-29957-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-uhid.c | 62 ++++++++++++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/unit/test-uhid.c b/unit/test-uhid.c
index b48e0fa..320cd54 100644
--- a/unit/test-uhid.c
+++ b/unit/test-uhid.c
@@ -38,6 +38,8 @@
 #include "src/shared/uhid.h"
 #include "src/shared/util.h"
 
+#include "src/shared/tester.h"
+
 struct test_pdu {
 	bool valid;
 	const uint8_t *data;
@@ -50,7 +52,6 @@ struct test_data {
 };
 
 struct context {
-	GMainLoop *main_loop;
 	struct bt_uhid *uhid;
 	guint source;
 	guint process;
@@ -74,14 +75,14 @@ struct context {
 		static struct test_data data;				\
 		data.test_name = g_strdup(name);			\
 		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
-		g_test_add_data_func(name, &data, function);		\
+		tester_add(name, &data, NULL, function, NULL);		\
 	} while (0)
 
 static void test_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	g_print("%s%s\n", prefix, str);
+	tester_debug("%s%s\n", prefix, str);
 }
 
 static void test_free(gconstpointer user_data)
@@ -92,14 +93,29 @@ static void test_free(gconstpointer user_data)
 	g_free(data->pdu_list);
 }
 
+static void destroy_context(struct context *context)
+{
+	if (context->source > 0)
+		g_source_remove(context->source);
+
+	bt_uhid_unref(context->uhid);
+
+	test_free(context->data);
+	g_free(context);
+}
+
 static gboolean context_quit(gpointer user_data)
 {
 	struct context *context = user_data;
 
+	if (context == NULL)
+		return FALSE;
+
 	if (context->process > 0)
 		g_source_remove(context->process);
 
-	g_main_loop_quit(context->main_loop);
+	destroy_context(context);
+	tester_test_passed();
 
 	return FALSE;
 }
@@ -114,8 +130,8 @@ static gboolean send_pdu(gpointer user_data)
 
 	len = write(context->fd, pdu->data, pdu->size);
 
-	if (g_test_verbose())
-		util_hexdump('<', pdu->data, len, test_debug, "uHID: ");
+
+	util_hexdump('<', pdu->data, len, test_debug, "uHID: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -156,8 +172,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(len > 0);
 
-	if (g_test_verbose())
-		util_hexdump('>', buf, len, test_debug, "uHID: ");
+	util_hexdump('>', buf, len, test_debug, "uHID: ");
 
 	g_assert_cmpint(len, ==, pdu->size);
 
@@ -174,9 +189,6 @@ static struct context *create_context(gconstpointer data)
 	GIOChannel *channel;
 	int err, sv[2];
 
-	context->main_loop = g_main_loop_new(NULL, FALSE);
-	g_assert(context->main_loop);
-
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
 	g_assert(err == 0);
 
@@ -202,26 +214,6 @@ static struct context *create_context(gconstpointer data)
 	return context;
 }
 
-static void destroy_context(struct context *context)
-{
-	if (context->source > 0)
-		g_source_remove(context->source);
-
-	bt_uhid_unref(context->uhid);
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
 static const struct uhid_event ev_create = {
 	.type = UHID_CREATE,
 };
@@ -263,7 +255,7 @@ static void test_client(gconstpointer data)
 	if (g_str_equal(context->data->test_name, "/uhid/command/input"))
 		bt_uhid_send(context->uhid, &ev_input);
 
-	execute_context(context);
+	context_quit(context);
 }
 
 static void handle_output(struct uhid_event *ev, void *user_data)
@@ -288,13 +280,11 @@ static void test_server(gconstpointer data)
 	bt_uhid_register(context->uhid, UHID_FEATURE, handle_feature, context);
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
 	define_test("/uhid/command/create", test_client, event(&ev_create));
 	define_test("/uhid/command/destroy", test_client, event(&ev_destroy));
@@ -305,5 +295,5 @@ int main(int argc, char *argv[])
 	define_test("/uhid/event/output", test_server, event(&ev_output));
 	define_test("/uhid/event/feature", test_server, event(&ev_feature));
 
-	return g_test_run();
+	return tester_run();
 }
-- 
1.9.1

