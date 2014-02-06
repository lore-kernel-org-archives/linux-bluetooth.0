Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] unit/avrcp: Add support for browsing AVCTP channel
Date: Thu,  6 Feb 2014 18:06:13 +0200
Message-Id: <1391702774-18972-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391702774-18972-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391702774-18972-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-avrcp.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 7efdaea..58e4c15 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -47,6 +47,7 @@
 struct test_pdu {
 	bool valid;
 	bool fragmented;
+	bool browse;
 	const uint8_t *data;
 	size_t size;
 };
@@ -60,8 +61,10 @@ struct context {
 	GMainLoop *main_loop;
 	struct avrcp_device *dev;
 	guint source;
+	guint browse_source;
 	guint process;
 	int fd;
+	int browse_fd;
 	unsigned int pdu_offset;
 	const struct test_data *data;
 };
@@ -75,6 +78,14 @@ struct context {
 		.size = sizeof(data(args)),			\
 	}
 
+#define brs_pdu(args...)					\
+	{							\
+		.valid = true,					\
+		.browse = true,					\
+		.data = data(args),				\
+		.size = sizeof(data(args)),			\
+	}
+
 #define frg_pdu(args...)					\
 	{							\
 		.valid = true,					\
@@ -130,7 +141,10 @@ static gboolean send_pdu(gpointer user_data)
 
 	pdu = &context->data->pdu_list[context->pdu_offset++];
 
-	len = write(context->fd, pdu->data, pdu->size);
+	if (pdu->browse)
+		len = write(context->browse_fd, pdu->data, pdu->size);
+	else
+		len = write(context->fd, pdu->data, pdu->size);
 
 	if (g_test_verbose())
 		util_hexdump('<', pdu->data, len, test_debug, "AVCTP: ");
@@ -163,6 +177,8 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	ssize_t len;
 	int fd;
 
+	DBG("");
+
 	pdu = &context->data->pdu_list[context->pdu_offset++];
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
@@ -190,23 +206,68 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	return TRUE;
 }
 
+static gboolean browse_test_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	unsigned char buf[512];
+	ssize_t len;
+	int fd;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		context->browse_source = 0;
+		g_print("%s: cond %x\n", __func__, cond);
+		return FALSE;
+	}
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	len = read(fd, buf, sizeof(buf));
+
+	g_assert(len > 0);
+
+	if (g_test_verbose())
+		util_hexdump('>', buf, len, test_debug, "AVCTP: ");
+
+	g_assert_cmpint(len, ==, pdu->size);
+
+	g_assert(memcmp(buf, pdu->data, pdu->size) == 0);
+
+	if (!pdu->fragmented)
+		context_process(context);
+
+	return TRUE;
+}
+
 static struct context *create_context(uint16_t version, gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
+	struct avctp *session;
 	GIOChannel *channel;
 	int err, sv[2];
 	bdaddr_t dst = {};
+	int ret;
+
+	DBG("");
 
 	context->main_loop = g_main_loop_new(NULL, FALSE);
 	g_assert(context->main_loop);
 
+	/* Control channel setup */
+
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
-	g_assert(err == 0);
+	g_assert(!err);
 
 	context->dev = avrcp_device_new(&dst);
-	context->dev->session = avctp_new(sv[0], 672, 672, version);
-	g_assert(context->dev->session != NULL);
+	g_assert(context->dev);
 
+	session = avctp_new(sv[0], 672, 672, version);
+	g_assert(session);
+
+	context->dev->session = session;
 	channel = g_io_channel_unix_new(sv[1]);
 
 	g_io_channel_set_close_on_unref(channel, TRUE);
@@ -221,6 +282,30 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 	g_io_channel_unref(channel);
 
 	context->fd = sv[1];
+
+	/* Browsing channel setup */
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(!err);
+
+	ret = avctp_connect_browsing(session, sv[0], 672, 672);
+	g_assert(!ret);
+
+	channel = g_io_channel_unix_new(sv[1]);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	context->browse_source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				browse_test_handler, context);
+	g_assert(context->browse_source > 0);
+
+	g_io_channel_unref(channel);
+
+	context->browse_fd = sv[1];
+
 	context->data = data;
 
 	return context;
@@ -233,6 +318,9 @@ static void execute_context(struct context *context)
 	if (context->source > 0)
 		g_source_remove(context->source);
 
+	if (context->browse_source > 0)
+		g_source_remove(context->browse_source);
+
 	avrcp_device_free(context->dev);
 
 	g_main_loop_unref(context->main_loop);
-- 
1.8.3.2

