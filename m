Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd v2 3/3] gobex: Remove g_idle_add to exit main loop in
 test_stream_put_req_abort()
Date: Fri, 04 May 2012 15:27:06 +0530
Message-id: <1336125426-30445-3-git-send-email-jaganath.k@samsung.com>
In-reply-to: <1336125426-30445-1-git-send-email-jaganath.k@samsung.com>
References: <1336125426-30445-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A callback is provided in g_obex_cancel_transfer() which will be called
when abort completes which exists the mail loop as well
---
 unit/test-gobex-transfer.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 85ba6fa..2f05784 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -456,12 +456,8 @@ static gboolean cancel_transfer(gpointer user_data)
 {
 	struct test_data *d = user_data;
 
-	if (d->id > 0) {
-		g_obex_cancel_transfer(d->id);
-		d->id = 0;
-		g_idle_add(cancel_transfer, user_data);
-	} else
-		g_main_loop_quit(d->mainloop);
+	if (d->id > 0)
+		g_obex_cancel_transfer(d->id, transfer_complete, user_data);
 
 	return FALSE;
 }
@@ -509,7 +505,7 @@ static void test_stream_put_req_abort(void)
 	g_source_remove(io_id);
 	g_obex_unref(obex);
 
-	g_assert_no_error(d.err);
+	g_assert_error(d.err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED);
 }
 
 static void test_stream_put_rsp_abort(void)
-- 
1.7.1

