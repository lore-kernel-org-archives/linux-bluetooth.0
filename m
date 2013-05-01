Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 6/6] unit: Get rid of gchar
Date: Wed,  1 May 2013 01:52:01 -0300
Message-Id: <1367383921-19129-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367383921-19129-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain char instead of gchar.
---
 unit/test-gobex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 74e7759..e7af4d8 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -402,7 +402,7 @@ static gboolean cancel_server(GIOChannel *io, GIOCondition cond,
 		goto failed;
 	}
 
-	g_io_channel_write_chars(io, (gchar *) pkt_abort_rsp,
+	g_io_channel_write_chars(io, (char *) pkt_abort_rsp,
 				sizeof(pkt_abort_rsp), &bytes_written, NULL);
 	if (bytes_written != sizeof(pkt_abort_rsp)) {
 		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -592,7 +592,7 @@ static void test_recv_unexpected(void)
 	g_obex_packet_free(req);
 	g_assert_cmpint(len, >=, 0);
 
-	g_io_channel_write_chars(io, (gchar *) buf, len, NULL, &err);
+	g_io_channel_write_chars(io, (char *) buf, len, NULL, &err);
 	g_assert_no_error(err);
 
 	mainloop = g_main_loop_new(NULL, FALSE);
@@ -727,7 +727,7 @@ static void recv_connect(int transport_type)
 						handle_connect_req, &gerr);
 	g_obex_set_disconnect_function(obex, handle_connect_err, &gerr);
 
-	status = g_io_channel_write_chars(io, (gchar *) pkt_connect_req,
+	status = g_io_channel_write_chars(io, (char *) pkt_connect_req,
 						sizeof(pkt_connect_req),
 						&bytes_written, NULL);
 	g_assert_cmpint(status, ==, G_IO_STATUS_NORMAL);
-- 
1.8.2.2

