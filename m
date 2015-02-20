Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 2/9] unit/avdtp: Refactor context destroy
Date: Fri, 20 Feb 2015 14:43:16 +0200
Message-Id: <1424436203-28935-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

destroy_context() function will be used for dummy_tests without
context_execute()
---
 unit/test-avdtp.c | 58 +++++++++++++++++++++----------------------------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/unit/test-avdtp.c b/unit/test-avdtp.c
index a293a1d..805f08d 100644
--- a/unit/test-avdtp.c
+++ b/unit/test-avdtp.c
@@ -264,10 +264,16 @@ static struct context *create_context(uint16_t version, gconstpointer data)
 	return context_new(version, 672, 672, data);
 }
 
-static void execute_context(struct context *context)
+static void unregister_sep(void *data)
 {
-	g_main_loop_run(context->main_loop);
+	struct avdtp_local_sep *sep = data;
+
+	/* Removed from the queue by caller */
+	avdtp_unregister_sep(NULL, sep);
+}
 
+static void destroy_context(struct context *context)
+{
 	if (context->source > 0)
 		g_source_remove(context->source);
 	avdtp_unref(context->session);
@@ -275,9 +281,18 @@ static void execute_context(struct context *context)
 	g_main_loop_unref(context->main_loop);
 
 	test_free(context->data);
+	queue_destroy(context->lseps, unregister_sep);
+
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
@@ -513,13 +528,11 @@ static void test_server(gconstpointer data)
 					AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, FALSE, &sep_ind, &sep_cfm,
 					context);
+	g_assert(sep);
 
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
-
-	avdtp_unregister_sep(context->lseps, sep);
-	queue_destroy(context->lseps, NULL);
 }
 
 static void test_server_1_3(gconstpointer data)
@@ -530,13 +543,11 @@ static void test_server_1_3(gconstpointer data)
 	sep = avdtp_register_sep(context->lseps, AVDTP_SEP_TYPE_SOURCE,
 					AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, TRUE, &sep_ind, NULL, context);
+	g_assert(sep);
 
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
-
-	avdtp_unregister_sep(context->lseps, sep);
-	queue_destroy(context->lseps, NULL);
 }
 
 static void test_server_1_3_sink(gconstpointer data)
@@ -547,13 +558,11 @@ static void test_server_1_3_sink(gconstpointer data)
 	sep = avdtp_register_sep(context->lseps, AVDTP_SEP_TYPE_SINK,
 					AVDTP_MEDIA_TYPE_AUDIO,
 					0x00, TRUE, &sep_ind, NULL, context);
+	g_assert(sep);
 
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
-
-	avdtp_unregister_sep(context->lseps, sep);
-	queue_destroy(context->lseps, NULL);
 }
 
 static void test_server_0_sep(gconstpointer data)
@@ -565,14 +574,6 @@ static void test_server_0_sep(gconstpointer data)
 	execute_context(context);
 }
 
-static void unregister_sep(void *data)
-{
-	struct avdtp_local_sep *sep = data;
-
-	/* Removed from the queue by caller */
-	avdtp_unregister_sep(NULL, sep);
-}
-
 static void test_server_seid(gconstpointer data)
 {
 	struct context *context = create_context(0x0103, data);
@@ -594,8 +595,7 @@ static void test_server_seid(gconstpointer data)
 						context);
 	g_assert(!sep);
 
-	/* Remove all SEPs */
-	queue_destroy(context->lseps, unregister_sep);
+	destroy_context(context);
 }
 
 static void test_server_seid_duplicate(gconstpointer data)
@@ -630,9 +630,6 @@ static void test_server_seid_duplicate(gconstpointer data)
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
-
-	/* Remove all SEPs */
-	queue_destroy(context->lseps, unregister_sep);
 }
 
 static gboolean sep_getcap_ind_frg(struct avdtp *session,
@@ -684,13 +681,11 @@ static void test_server_frg(gconstpointer data)
 						AVDTP_MEDIA_TYPE_AUDIO,
 						0x00, TRUE, &sep_ind_frg,
 						NULL, context);
+	g_assert(sep);
 
 	g_idle_add(send_pdu, context);
 
 	execute_context(context);
-
-	avdtp_unregister_sep(context->lseps, sep);
-	queue_destroy(context->lseps, NULL);
 }
 
 static void discover_cb(struct avdtp *session, GSList *seps,
@@ -774,9 +769,6 @@ static void test_client(gconstpointer data)
 	avdtp_discover(context->session, discover_cb, context);
 
 	execute_context(context);
-
-	avdtp_unregister_sep(context->lseps, sep);
-	queue_destroy(context->lseps, NULL);
 }
 
 static void test_client_1_3(gconstpointer data)
@@ -793,9 +785,6 @@ static void test_client_1_3(gconstpointer data)
 	avdtp_discover(context->session, discover_cb, context);
 
 	execute_context(context);
-
-	avdtp_unregister_sep(context->lseps, sep);
-	queue_destroy(context->lseps, NULL);
 }
 
 static void test_client_frg(gconstpointer data)
@@ -812,9 +801,6 @@ static void test_client_frg(gconstpointer data)
 	avdtp_discover(context->session, discover_cb, context);
 
 	execute_context(context);
-
-	avdtp_unregister_sep(context->lseps, sep);
-	queue_destroy(context->lseps, NULL);
 }
 
 int main(int argc, char *argv[])
-- 
2.1.0

