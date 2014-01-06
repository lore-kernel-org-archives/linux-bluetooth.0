Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jan 2014 12:07:00 +0000
From: Colin Watson <cjwatson@ubuntu.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] unit: Fix test failures with glib 2.39.0
Message-ID: <20140106120700.GZ5883@riva.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

glib 2.39.0 made this change:

   - g_source_remove() will now throw a critical in the case that you
     try to remove a non-existent source.  We expect that there is some
     code in the wild that will fall afoul of this new critical but
     considering that we now reuse source IDs, this code is already
     broken and should probably be fixed.

This patch fixes the test suite to keep better track of whether sources have
already been removed and avoid double-removals.
---
 unit/test-avdtp.c          |  8 ++++++--
 unit/test-gobex-transfer.c |  6 ++++--
 unit/test-gobex.c          | 13 ++++++++-----
 unit/util.c                |  1 +
 unit/util.h                |  1 +
 5 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 66c45f3..6e51313 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -143,6 +143,7 @@ static gboolean send_pdu(gpointer user_data)
 	if (pdu->fragmented)
 		return send_pdu(user_data);
 
+	context->process = 0;
 	return FALSE;
 }
 
@@ -178,8 +179,10 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	pdu = &context->data->pdu_list[context->pdu_offset++];
 
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		context->source = 0;
 		return FALSE;
+	}
 
 	fd = g_io_channel_unix_get_fd(channel);
 
@@ -258,7 +261,8 @@ static void execute_context(struct context *context)
 {
 	g_main_loop_run(context->main_loop);
 
-	g_source_remove(context->source);
+	if (context->source > 0)
+		g_source_remove(context->source);
 	avdtp_unref(context->session);
 
 	g_main_loop_unref(context->main_loop);
diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index ef05047..128a467 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -1805,7 +1805,8 @@ static void test_conn_rsp(void)
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
+	if (!d.io_completed)
+		g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -2060,7 +2061,8 @@ static void test_conn_get_wrg_rsp(void)
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
+	if (!d.io_completed)
+		g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 66307c2..ded83dd 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -235,7 +235,7 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
 	GError *gerr = NULL;
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id, test_time;
+	guint timer_id, test_time;
 	GObex *obex;
 
 	create_endpoints(&obex, &io, transport_type);
@@ -244,7 +244,7 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
 	g_assert_no_error(gerr);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, send_rsp_func, &gerr);
+	g_io_add_watch(io, cond, send_rsp_func, &gerr);
 
 	mainloop = g_main_loop_new(NULL, FALSE);
 
@@ -262,7 +262,6 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(gerr);
@@ -466,6 +465,7 @@ struct rcv_buf_info {
 	GError *err;
 	const guint8 *buf;
 	gsize len;
+	gboolean completed;
 };
 
 static gboolean rcv_data(GIOChannel *io, GIOCondition cond, gpointer user_data)
@@ -505,6 +505,7 @@ static gboolean rcv_data(GIOChannel *io, GIOCondition cond, gpointer user_data)
 
 done:
 	g_main_loop_quit(mainloop);
+	r->completed = TRUE;
 	return FALSE;
 }
 
@@ -546,7 +547,8 @@ static void test_send_connect(int transport_type)
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
+	if (!r.completed)
+		g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(r.err);
@@ -661,7 +663,8 @@ static void test_send_on_demand(int transport_type, GObexDataProducer func)
 
 	g_source_remove(timer_id);
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
+	if (!r.completed)
+		g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(r.err);
diff --git a/unit/util.c b/unit/util.c
index c76acdf..71fe7ca 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -193,5 +193,6 @@ send:
 
 failed:
 	g_main_loop_quit(d->mainloop);
+	d->io_completed = TRUE;
 	return FALSE;
 }
diff --git a/unit/util.h b/unit/util.h
index 752ce61..96528a6 100644
--- a/unit/util.h
+++ b/unit/util.h
@@ -41,6 +41,7 @@ struct test_data {
 	guint id;
 	gsize total;
 	GMainLoop *mainloop;
+	gboolean io_completed;
 };
 
 #define TEST_ERROR test_error_quark()
-- 
1.8.5.2
