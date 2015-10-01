Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/3] unit/test-sdp: Use tester framework
Date: Thu, 01 Oct 2015 20:02:22 +0530
Message-id: <1443709943-29957-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1443709943-29957-1-git-send-email-gowtham.ab@samsung.com>
References: <1443709943-29957-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-sdp.c | 91 +++++++++++++++++++++++++--------------------------------
 1 file changed, 40 insertions(+), 51 deletions(-)

diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index b4ef4d1..ac921a9 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -37,6 +37,7 @@
 #include "lib/sdp_lib.h"
 
 #include "src/shared/util.h"
+#include "src/shared/tester.h"
 #include "src/log.h"
 #include "src/sdpd.h"
 
@@ -78,7 +79,7 @@ struct test_data {
 		static struct test_data data;				\
 		data.mtu = _mtu;					\
 		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
-		g_test_add_data_func(name, &data, test_sdp);		\
+		tester_add(name, &data, NULL, test_sdp, NULL);		\
 	} while (0)
 
 #define define_ss(name, args...) define_test("/TP/SERVER/SS/" name, 48, args)
@@ -105,32 +106,48 @@ struct test_data_de {
 		data.input_data = input;				\
 		data.input_size = sizeof(input);			\
 		data.expected = exp;					\
-		g_test_add_data_func("/sdp/DE/ATTR/" name, &data,	\
-						test_sdp_de_attr);	\
+		tester_add("/sdp/DE/ATTR/" name, &data,	NULL,		\
+					test_sdp_de_attr, NULL);	\
 	} while (0)
 
 struct context {
-	GMainLoop *main_loop;
 	guint server_source;
 	guint client_source;
 	int fd;
-	int mtu;
 	uint8_t cont_data[16];
 	uint8_t cont_size;
 	unsigned int pdu_offset;
-	const struct sdp_pdu *pdu_list;
+	const struct test_data *data;
 };
 
 static void sdp_debug(const char *str, void *user_data)
 {
 	const char *prefix = user_data;
 
-	g_print("%s%s\n", prefix, str);
+	tester_debug("%s%s\n", prefix, str);
+}
+
+static void destroy_context(struct context *context)
+{
+	sdp_svcdb_collect_all(context->fd);
+	sdp_svcdb_reset();
+
+	g_source_remove(context->server_source);
+	g_source_remove(context->client_source);
+
+	g_free(context);
 }
 
-static void context_quit(struct context *context)
+static gboolean context_quit(gpointer user_data)
 {
-	g_main_loop_quit(context->main_loop);
+	struct context *context = user_data;
+	if (context == NULL)
+		return FALSE;
+
+	destroy_context(context);
+	tester_test_passed();
+
+	return FALSE;
 }
 
 static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
@@ -169,10 +186,9 @@ static gboolean server_handler(GIOChannel *channel, GIOCondition cond,
 		return FALSE;
 	}
 
-	if (g_test_verbose() == TRUE)
-		util_hexdump('<', buf, len, sdp_debug, "SDP: ");
+	util_hexdump('<', buf, len, sdp_debug, "SDP: ");
 
-	handle_internal_request(fd, context->mtu, buf, len);
+	handle_internal_request(fd, context->data->mtu, buf, len);
 
 	return TRUE;
 }
@@ -185,7 +201,7 @@ static gboolean send_pdu(gpointer user_data)
 	unsigned char *buf;
 	ssize_t len;
 
-	req_pdu = &context->pdu_list[context->pdu_offset];
+	req_pdu = &context->data->pdu_list[context->pdu_offset];
 
 	pdu_len = req_pdu->raw_size + context->cont_size;
 
@@ -210,7 +226,7 @@ static void context_increment(struct context *context)
 {
 	context->pdu_offset += 2;
 
-	if (!context->pdu_list[context->pdu_offset].valid) {
+	if (!context->data->pdu_list[context->pdu_offset].valid) {
 		context_quit(context);
 		return;
 	}
@@ -227,7 +243,7 @@ static gboolean client_handler(GIOChannel *channel, GIOCondition cond,
 	ssize_t len;
 	int fd;
 
-	rsp_pdu = &context->pdu_list[context->pdu_offset + 1];
+	rsp_pdu = &context->data->pdu_list[context->pdu_offset + 1];
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
 		return FALSE;
@@ -238,8 +254,7 @@ static gboolean client_handler(GIOChannel *channel, GIOCondition cond,
 	if (len < 0)
 		return FALSE;
 
-	if (g_test_verbose() == TRUE)
-		util_hexdump('>', buf, len, sdp_debug, "SDP: ");
+	util_hexdump('>', buf, len, sdp_debug, "SDP: ");
 
 	g_assert(len > 0);
 	g_assert((size_t) len == rsp_pdu->raw_size + rsp_pdu->cont_len);
@@ -638,15 +653,12 @@ static void register_file_transfer(void)
 	update_db_timestamp();
 }
 
-static struct context *create_context(void)
+static struct context *create_context(gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
 	GIOChannel *channel;
 	int err, sv[2];
 
-	context->main_loop = g_main_loop_new(NULL, FALSE);
-	g_assert(context->main_loop);
-
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
 	g_assert(err == 0);
 
@@ -677,6 +689,7 @@ static struct context *create_context(void)
 	g_io_channel_unref(channel);
 
 	context->fd = sv[1];
+	context->data = data;
 
 	set_fixed_db_timestamp(0x496f0654);
 
@@ -695,34 +708,11 @@ static struct context *create_context(void)
 	return context;
 }
 
-static void execute_context(struct context *context)
-{
-	g_main_loop_run(context->main_loop);
-
-	sdp_svcdb_collect_all(context->fd);
-	sdp_svcdb_reset();
-
-	g_source_remove(context->server_source);
-	g_source_remove(context->client_source);
-
-	g_main_loop_unref(context->main_loop);
-
-	g_free(context);
-}
-
 static void test_sdp(gconstpointer data)
 {
-	const struct test_data *test = data;
-	struct context *context = create_context();
-
-	context->mtu = test->mtu;
-	context->pdu_list = test->pdu_list;
+	struct context *context = create_context(data);
 
 	g_idle_add(send_pdu, context);
-
-	execute_context(context);
-
-	g_free(test->pdu_list);
 }
 
 static void test_sdp_de_attr(gconstpointer data)
@@ -737,8 +727,7 @@ static void test_sdp_de_attr(gconstpointer data)
 	g_assert_cmpuint(test->input_size, ==, size);
 	g_assert_cmpuint(test->expected.dtd, ==, d->dtd);
 
-	if (g_test_verbose() == TRUE)
-		g_print("DTD=0x%02x\n", d->dtd);
+	tester_debug("DTD=0x%02x\n", d->dtd);
 
 	switch (d->dtd) {
 	case SDP_TEXT_STR8:
@@ -785,14 +774,14 @@ static void test_sdp_de_attr(gconstpointer data)
 	}
 
 	sdp_data_free(d);
+	tester_test_passed();
 }
 
 int main(int argc, char *argv[])
 {
-	g_test_init(&argc, &argv, NULL);
+	tester_init(&argc, &argv);
 
-	if (g_test_verbose())
-		__btd_log_init("*", 0);
+	__btd_log_init("*", 0);
 
 	/*
 	 * Service Search Request
@@ -2821,5 +2810,5 @@ int main(int argc, char *argv[])
 						0x00, 0x00, 0x00, 0x00, 0x00,
 						0x00, 0x00, 0x00, 0x00, 0x00)));
 
-	return g_test_run();
+	return tester_run();
 }
-- 
1.9.1

