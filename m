Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 08/11] unit/test-hfp: Add init test for HFP HF
Date: Fri, 10 Oct 2014 01:50:08 +0200
Message-Id: <1412898611-12199-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1412898611-12199-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1412898611-12199-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds basic infrastruction for HFP HF test plus
init test.

It also moves send_pdu function in the file so it can be used by
test_hf_handler
---
 unit/test-hfp.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 18 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 4b3473b..274ee55 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -36,6 +36,7 @@ struct context {
 	int fd_server;
 	int fd_client;
 	struct hfp_gw *hfp;
+	struct hfp_hf *hfp_hf;
 	const struct test_data *data;
 	unsigned int pdu_offset;
 };
@@ -52,6 +53,8 @@ struct test_data {
 	char *test_name;
 	struct test_pdu *pdu_list;
 	hfp_result_func_t result_func;
+	hfp_response_func_t response_func;
+	hfp_hf_result_func_t hf_result_func;
 	GIOFunc test_handler;
 };
 
@@ -99,6 +102,22 @@ struct test_data {
 		data.test_handler = test_handler;			\
 	} while (0)
 
+#define define_hf_test(name, function, result_func, response_function,	\
+								args...)\
+	do {								\
+		const struct test_pdu pdus[] = {			\
+			args, { }					\
+		};							\
+		static struct test_data data;				\
+		data.test_name = g_strdup(name);			\
+		data.pdu_list = g_malloc(sizeof(pdus));			\
+		data.hf_result_func = result_func;			\
+		data.response_func = response_function;			\
+		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
+		g_test_add_data_func(name, &data, function);		\
+		data.test_handler = test_hf_handler;			\
+	} while (0)
+
 static void context_quit(struct context *context)
 {
 	g_main_loop_quit(context->main_loop);
@@ -128,6 +147,52 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	return FALSE;
 }
 
+static gboolean send_pdu(gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	ssize_t len;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	if (pdu && !pdu->valid)
+		return FALSE;
+
+	len = write(context->fd_server, pdu->data, pdu->size);
+	g_assert_cmpint(len, ==, pdu->size);
+
+	pdu = &context->data->pdu_list[context->pdu_offset];
+	if (pdu->fragmented)
+		g_idle_add(send_pdu, context);
+
+	return FALSE;
+}
+
+static gboolean test_hf_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct context *context = user_data;
+	gchar buf[60];
+	gsize bytes_read;
+	GError *error = NULL;
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
+		goto done;
+
+	/* dummy read */
+	g_io_channel_read_chars(channel, buf, 60, &bytes_read, &error);
+
+	send_pdu(context);
+
+	return TRUE;
+
+done:
+	context_quit(context);
+	context->watch_id = 0;
+
+	return FALSE;
+}
+
 static void cmd_handler(const char *command, void *user_data)
 {
 	struct context *context = user_data;
@@ -203,6 +268,9 @@ static void execute_context(struct context *context)
 	if (context->hfp)
 		hfp_gw_unref(context->hfp);
 
+	if (context->hfp_hf)
+		hfp_hf_unref(context->hfp_hf);
+
 	g_free(context);
 }
 
@@ -275,24 +343,6 @@ static void test_register(gconstpointer data)
 	execute_context(context);
 }
 
-static gboolean send_pdu(gpointer user_data)
-{
-	struct context *context = user_data;
-	const struct test_pdu *pdu;
-	ssize_t len;
-
-	pdu = &context->data->pdu_list[context->pdu_offset++];
-
-	len = write(context->fd_server, pdu->data, pdu->size);
-	g_assert_cmpint(len, ==, pdu->size);
-
-	pdu = &context->data->pdu_list[context->pdu_offset];
-	if (pdu->fragmented)
-		g_idle_add(send_pdu, context);
-
-	return FALSE;
-}
-
 static void test_fragmented(gconstpointer data)
 {
 	struct context *context = create_context(data);
@@ -404,6 +454,20 @@ static void check_string_2(struct hfp_gw_result *result,
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
+static void test_hf_init(gconstpointer data)
+{
+	struct context *context = create_context(data);
+
+	context->hfp_hf = hfp_hf_new(context->fd_client);
+	g_assert(context->hfp_hf);
+	g_assert(hfp_hf_set_close_on_unref(context->hfp_hf, true));
+
+	hfp_hf_unref(context->hfp_hf);
+	context->hfp_hf = NULL;
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -473,5 +537,7 @@ int main(int argc, char *argv[])
 			raw_pdu('\r'),
 			data_end());
 
+	define_hf_test("/hfp/test_init", test_hf_init, NULL, NULL, data_end());
+
 	return g_test_run();
 }
-- 
1.8.4

