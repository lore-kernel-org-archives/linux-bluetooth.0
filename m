Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/4] unit/avrcp: Add support for browsing AVCTP channel
Date: Thu, 20 Feb 2014 15:22:37 +0200
Message-Id: <1392902559-23987-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1392902559-23987-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1392902559-23987-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c |  6 ++++
 android/avrcp-lib.h |  2 ++
 unit/test-avrcp.c   | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index adb42be..13bfd79 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -94,6 +94,12 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 	return session;
 }
 
+int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
+								size_t omtu)
+{
+	return avctp_connect_browsing(session->session, fd, imtu, omtu);
+}
+
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 							void *user_data)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 4207cce..7b0aaef 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -27,6 +27,8 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 void avrcp_shutdown(struct avrcp *session);
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 							void *user_data);
+int avrcp_connect_browsing(struct avrcp *session, int fd, size_t imtu,
+								size_t omtu);
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address);
 int avrcp_set_addr_player(struct avrcp *avrcp_session, uint16_t id);
diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 9491631..9d4eede 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -45,6 +45,7 @@
 struct test_pdu {
 	bool valid;
 	bool fragmented;
+	bool browse;
 	const uint8_t *data;
 	size_t size;
 };
@@ -58,8 +59,10 @@ struct context {
 	GMainLoop *main_loop;
 	struct avrcp *session;
 	guint source;
+	guint browse_source;
 	guint process;
 	int fd;
+	int browse_fd;
 	unsigned int pdu_offset;
 	const struct test_data *data;
 };
@@ -73,6 +76,14 @@ struct context {
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
@@ -128,7 +139,10 @@ static gboolean send_pdu(gpointer user_data)
 
 	pdu = &context->data->pdu_list[context->pdu_offset++];
 
-	len = write(context->fd, pdu->data, pdu->size);
+	if (pdu->browse)
+		len = write(context->browse_fd, pdu->data, pdu->size);
+	else
+		len = write(context->fd, pdu->data, pdu->size);
 
 	if (g_test_verbose())
 		util_hexdump('<', pdu->data, len, test_debug, "AVCTP: ");
@@ -161,6 +175,8 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	ssize_t len;
 	int fd;
 
+	DBG("");
+
 	pdu = &context->data->pdu_list[context->pdu_offset++];
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
@@ -188,17 +204,58 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
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
 	GIOChannel *channel;
 	int err, sv[2];
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
 
 	context->session = avrcp_new(sv[0], 672, 672, version);
 	g_assert(context->session != NULL);
@@ -217,6 +274,30 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 	g_io_channel_unref(channel);
 
 	context->fd = sv[1];
+
+	/* Browsing channel setup */
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(!err);
+
+	ret = avrcp_connect_browsing(context->session, sv[0], 672, 672);
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
@@ -231,6 +312,9 @@ static void execute_context(struct context *context)
 
 	avrcp_shutdown(context->session);
 
+	if (context->browse_source > 0)
+		g_source_remove(context->browse_source);
+
 	g_main_loop_unref(context->main_loop);
 
 	test_free(context->data);
-- 
1.8.3.2

