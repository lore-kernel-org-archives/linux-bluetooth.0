Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] unit/avrcp: Refactor tests to use destroy_context()
Date: Mon, 24 Feb 2014 15:25:16 +0200
Message-Id: <1393248318-5188-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-avrcp.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 381e7cb..e9fe7e3 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -246,15 +246,7 @@ static void execute_context(struct context *context)
 {
 	g_main_loop_run(context->main_loop);
 
-	if (context->source > 0)
-		g_source_remove(context->source);
-
-	avrcp_shutdown(context->session);
-
-	g_main_loop_unref(context->main_loop);
-
-	test_free(context->data);
-	g_free(context);
+	destroy_context(context);
 }
 
 static void test_server(gconstpointer data)
-- 
1.8.3.2

