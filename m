Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] unit: Fix memory leaks in gobex tests
Date: Tue, 11 Feb 2014 14:16:31 -0400
Message-Id: <1392142591-10150-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gobex-apparam.c  |    2 ++
 unit/test-gobex-transfer.c |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/unit/test-gobex-apparam.c b/unit/test-gobex-apparam.c
index e6a42cc..976c541 100644
--- a/unit/test-gobex-apparam.c
+++ b/unit/test-gobex-apparam.c
@@ -250,6 +250,8 @@ static void test_apparam_get_multi(void)
 	g_assert(string != NULL);
 	g_assert_cmpstr(string, ==, "ABC");
 
+	g_free(string);
+
 	g_obex_apparam_free(apparam);
 }
 
diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 128a467..7c9fd43 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -511,6 +511,7 @@ static void test_stream_put_req_abort(void)
 	g_obex_unref(obex);
 
 	g_assert_error(d.err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED);
+	g_error_free(d.err);
 }
 
 static void test_stream_put_rsp_abort(void)
@@ -556,6 +557,7 @@ static void test_stream_put_rsp_abort(void)
 	g_obex_unref(obex);
 
 	g_assert_error(d.err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED);
+	g_error_free(d.err);
 }
 
 static void handle_put_seq_wait(GObex *obex, GObexPacket *req,
-- 
1.7.9.5

