Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 8/8] unit/avdtp: Refactor context destroy
Date: Mon, 16 Feb 2015 10:50:01 +0200
Message-Id: <1424076601-22177-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424076601-22177-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424076601-22177-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

destroy_context() function will be used for dummy_tests without
context_execute()
---
 unit/test-avdtp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index 0f59061..e4d8bb2 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -259,10 +259,8 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 	return context_new(version, 672, 672, data);
 }
 
-static void execute_context(struct context *context)
+static void destroy_context(struct context *context)
 {
-	g_main_loop_run(context->main_loop);
-
 	if (context->source > 0)
 		g_source_remove(context->source);
 	avdtp_unref(context->session);
@@ -273,6 +271,13 @@ static void execute_context(struct context *context)
 	g_free(context);
 }
 
+static void execute_context(struct context *context)
+{
+	g_main_loop_run(context->main_loop);
+
+	destroy_context(context);
+}
+
 static gboolean sep_getcap_ind(struct avdtp *session,
 					struct avdtp_local_sep *sep,
 					GSList **caps, uint8_t *err,
@@ -601,6 +606,7 @@ static void test_server_seid(gconstpointer data)
 
 	/* Remove all SEPs */
 	queue_destroy(lseps, unregister_sep);
+	destroy_context(context);
 }
 
 static void test_server_seid_duplicate(gconstpointer data)
-- 
2.1.0

