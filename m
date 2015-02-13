Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 9/9] unit/avdtp: Refactor context destroy
Date: Fri, 13 Feb 2015 11:06:08 +0200
Message-Id: <1423818368-15899-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

destroy_context() function will be used for dummy_tests without
context_execute()
---
 unit/test-avdtp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index a76198a..afbe875 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -260,10 +260,8 @@ static struct context *create_context(uint16_t version, gconstpointer data)
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
@@ -274,6 +272,13 @@ static void execute_context(struct context *context)
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
@@ -600,6 +605,8 @@ static void test_server_seid(gconstpointer data)
 	/* Remove all SEPs */
 	g_slist_free_full(lseps, unregister_sep);
 	lseps = NULL;
+
+	destroy_context(context);
 }
 
 static void test_server_seid_duplicate(gconstpointer data)
-- 
2.1.0

