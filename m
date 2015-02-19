Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 2/5] unit/avdtp: Refactor context destroy
Date: Thu, 19 Feb 2015 17:46:44 +0200
Message-Id: <1424360807-14402-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424360807-14402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424360807-14402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

destroy_context() function will be used for dummy_tests without
context_execute()
---
 unit/test-avdtp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index a293a1d..5018350 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -264,10 +264,8 @@ static struct context *create_context(uint16_t version, gconstpointer data)
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
@@ -278,6 +276,13 @@ static void execute_context(struct context *context)
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
@@ -596,6 +601,7 @@ static void test_server_seid(gconstpointer data)
 
 	/* Remove all SEPs */
 	queue_destroy(context->lseps, unregister_sep);
+	destroy_context(context);
 }
 
 static void test_server_seid_duplicate(gconstpointer data)
-- 
2.1.0

