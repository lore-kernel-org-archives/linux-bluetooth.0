Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/19] unit/AVDTP: Add /TP/SIG/SMG/BV-18-C test
Date: Mon, 25 Nov 2013 15:11:04 +0200
Message-Id: <1385385070-21010-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
References: <1385385070-21010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify that the IUT (ACP) reports the reception of valid
AVDTP_START_CMD and replies the returned confirmation.
---
 unit/test-avdtp.c | 138 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 62 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 7d2c7bc..615df00 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -46,6 +46,7 @@ struct test_pdu {
 };
 
 struct test_data {
+	char *test_name;
 	struct test_pdu *pdu_list;
 };
 
@@ -64,20 +65,23 @@ struct test_data {
 			args, { }, { }					\
 		};							\
 		static struct test_data data;				\
+		data.test_name = g_strdup(name);			\
 		data.pdu_list = g_malloc(sizeof(pdus));			\
 		memcpy(data.pdu_list, pdus, sizeof(pdus));		\
-		g_test_add_data_func(name, &data, function);		\
+		g_test_add_data_func_full(name, &data, function, test_free); \
 	} while (0)
 
 struct context {
 	GMainLoop *main_loop;
 	struct avdtp *session;
 	struct avdtp_local_sep *sep;
+	struct avdtp_stream *stream;
 	guint source;
 	int fd;
 	int mtu;
+	gboolean pending_open;
 	unsigned int pdu_offset;
-	const struct test_pdu *pdu_list;
+	const struct test_data *data;
 };
 
 static void test_debug(const char *str, void *user_data)
@@ -87,6 +91,14 @@ static void test_debug(const char *str, void *user_data)
 	g_print("%s%s\n", prefix, str);
 }
 
+static void test_free(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	g_free(data->test_name);
+	g_free(data->pdu_list);
+}
+
 static void context_quit(struct context *context)
 {
 	g_main_loop_quit(context->main_loop);
@@ -98,7 +110,7 @@ static gboolean send_pdu(gpointer user_data)
 	const struct test_pdu *pdu;
 	ssize_t len;
 
-	pdu = &context->pdu_list[context->pdu_offset++];
+	pdu = &context->data->pdu_list[context->pdu_offset++];
 
 	len = write(context->fd, pdu->data, pdu->size);
 
@@ -112,7 +124,7 @@ static gboolean send_pdu(gpointer user_data)
 
 static void context_process(struct context *context)
 {
-	if (!context->pdu_list[context->pdu_offset].valid) {
+	if (!context->data->pdu_list[context->pdu_offset].valid) {
 		context_quit(context);
 		return;
 	}
@@ -120,6 +132,17 @@ static void context_process(struct context *context)
 	g_idle_add(send_pdu, context);
 }
 
+static gboolean transport_open(struct avdtp_stream *stream)
+{
+	int fd;
+
+	fd = open("/dev/null", O_RDWR, 0);
+	if (fd < 0)
+		g_assert_not_reached();
+
+	return avdtp_stream_set_transport(stream, fd, 672, 672);
+}
+
 static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -129,7 +152,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	ssize_t len;
 	int fd;
 
-	pdu = &context->pdu_list[context->pdu_offset++];
+	pdu = &context->data->pdu_list[context->pdu_offset++];
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
 		return FALSE;
@@ -147,12 +170,17 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	g_assert(memcmp(buf, pdu->data, pdu->size) == 0);
 
+	if (context->pending_open) {
+		context->pending_open = FALSE;
+		g_assert(transport_open(context->stream));
+	}
+
 	context_process(context);
 
 	return TRUE;
 }
 
-static struct context *create_context(uint16_t version)
+static struct context *create_context(uint16_t version, gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
 	GIOChannel *channel;
@@ -181,6 +209,7 @@ static struct context *create_context(uint16_t version)
 	g_io_channel_unref(channel);
 
 	context->fd = sv[1];
+	context->data = data;
 
 	return context;
 }
@@ -227,8 +256,21 @@ static gboolean sep_getcap_ind(struct avdtp *session,
 	return TRUE;
 }
 
+static gboolean sep_open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct context *context = user_data;
+
+	context->pending_open = TRUE;
+	context->stream = stream;
+
+	return TRUE;
+}
+
 static struct avdtp_sep_ind sep_ind = {
 	.get_capability		= sep_getcap_ind,
+	.open			= sep_open_ind,
 };
 
 static void sep_setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
@@ -244,21 +286,19 @@ static void sep_setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!context)
 		return;
 
-	pdu = &context->pdu_list[context->pdu_offset];
+	pdu = &context->data->pdu_list[context->pdu_offset];
 
 	if (pdu->size < 2)
 		return;
 
-	switch (pdu->data[1]) {
-	case 0x04:
+	if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-11-C"))
 		ret = avdtp_get_configuration(session, stream);
-		break;
-	case 0x06:
+	else if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-15-C"))
 		ret = avdtp_open(session, stream);
-		break;
-	default:
+	else if (g_str_equal(context->data->test_name, "/TP/SIG/SMG/BV-17-C"))
+		ret = avdtp_open(session, stream);
+	else
 		g_assert_not_reached();
-	}
 
 	g_assert_cmpint(ret, ==, 0);
 }
@@ -271,11 +311,7 @@ static void sep_open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 
 	g_assert(err == NULL);
 
-	ret = open("/dev/null", O_RDWR, 0);
-	if (ret < 0)
-		g_assert_not_reached();
-
-	avdtp_stream_set_transport(stream, ret, 672, 672);
+	g_assert(transport_open(stream));
 
 	ret = avdtp_start(session, stream);
 	g_assert_cmpint(ret, ==, 0);
@@ -288,22 +324,17 @@ static struct avdtp_sep_cfm sep_cfm = {
 
 static void test_server(gconstpointer data)
 {
-	const struct test_data *test = data;
-	struct context *context = create_context(0x0100);
+	struct context *context = create_context(0x0100, data);
 	struct avdtp_local_sep *sep;
 
-	context->pdu_list = test->pdu_list;
-
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO,
-					0x00, TRUE, &sep_ind, NULL, NULL);
+					0x00, TRUE, &sep_ind, NULL, context);
 
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
 
 	avdtp_unregister_sep(sep);
-
-	g_free(test->pdu_list);
 }
 
 static void discover_cb(struct avdtp *session, GSList *seps,
@@ -352,40 +383,27 @@ static void discover_cb(struct avdtp *session, GSList *seps,
 
 static void test_discover(gconstpointer data)
 {
-	const struct test_data *test = data;
-	struct context *context = create_context(0x0100);
-
-	context->pdu_list = test->pdu_list;
+	struct context *context = create_context(0x0100, data);
 
 	avdtp_discover(context->session, discover_cb, NULL);
 
 	execute_context(context);
-
-	g_free(test->pdu_list);
 }
 
 static void test_get_capabilities(gconstpointer data)
 {
-	const struct test_data *test = data;
-	struct context *context = create_context(0x0100);
-
-	context->pdu_list = test->pdu_list;
+	struct context *context = create_context(0x0100, data);
 
 	avdtp_discover(context->session, discover_cb, NULL);
 
 	execute_context(context);
-
-	g_free(test->pdu_list);
 }
 
 static void test_set_configuration(gconstpointer data)
 {
-	const struct test_data *test = data;
-	struct context *context = create_context(0x0100);
+	struct context *context = create_context(0x0100, data);
 	struct avdtp_local_sep *sep;
 
-	context->pdu_list = test->pdu_list;
-
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, FALSE, NULL, NULL, NULL);
 	context->sep = sep;
@@ -395,18 +413,13 @@ static void test_set_configuration(gconstpointer data)
 	execute_context(context);
 
 	avdtp_unregister_sep(sep);
-
-	g_free(test->pdu_list);
 }
 
 static void test_get_configuration(gconstpointer data)
 {
-	const struct test_data *test = data;
-	struct context *context = create_context(0x0100);
+	struct context *context = create_context(0x0100, data);
 	struct avdtp_local_sep *sep;
 
-	context->pdu_list = test->pdu_list;
-
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, FALSE, NULL, &sep_cfm,
 					context);
@@ -417,18 +430,13 @@ static void test_get_configuration(gconstpointer data)
 	execute_context(context);
 
 	avdtp_unregister_sep(sep);
-
-	g_free(test->pdu_list);
 }
 
 static void test_open(gconstpointer data)
 {
-	const struct test_data *test = data;
-	struct context *context = create_context(0x0100);
+	struct context *context = create_context(0x0100, data);
 	struct avdtp_local_sep *sep;
 
-	context->pdu_list = test->pdu_list;
-
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, FALSE, NULL, &sep_cfm,
 					context);
@@ -439,18 +447,13 @@ static void test_open(gconstpointer data)
 	execute_context(context);
 
 	avdtp_unregister_sep(sep);
-
-	g_free(test->pdu_list);
 }
 
 static void test_start(gconstpointer data)
 {
-	const struct test_data *test = data;
-	struct context *context = create_context(0x0100);
+	struct context *context = create_context(0x0100, data);
 	struct avdtp_local_sep *sep;
 
-	context->pdu_list = test->pdu_list;
-
 	sep = avdtp_register_sep(AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, FALSE, NULL, &sep_cfm,
 					context);
@@ -461,8 +464,6 @@ static void test_start(gconstpointer data)
 	execute_context(context);
 
 	avdtp_unregister_sep(sep);
-
-	g_free(test->pdu_list);
 }
 
 int main(int argc, char *argv[])
@@ -565,6 +566,19 @@ int main(int argc, char *argv[])
 			raw_pdu(0x10, 0x06, 0x04),
 			raw_pdu(0x12, 0x06),
 			raw_pdu(0x20, 0x07, 0x04));
+	define_test("/TP/SIG/SMG/BV-18-C", test_server,
+			raw_pdu(0x00, 0x01),
+			raw_pdu(0x02, 0x01, 0x04, 0x00),
+			raw_pdu(0x10, 0x02, 0x04),
+			raw_pdu(0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00, 0x00,
+				0xff, 0xff, 0x02, 0x40),
+			raw_pdu(0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07, 0x06,
+				0x00, 0x00, 0x21, 0x02, 0x02, 0x20),
+			raw_pdu(0x22, 0x03),
+			raw_pdu(0x30, 0x06, 0x04),
+			raw_pdu(0x32, 0x06),
+			raw_pdu(0x40, 0x07, 0x04),
+			raw_pdu(0x42, 0x07));
 
 	return g_test_run();
 }
-- 
1.8.3.1

