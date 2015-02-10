Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 5/8] unit/gatt: add support for post-tests
Date: Tue, 10 Feb 2015 12:16:21 -0800
Message-Id: <1423599385-36295-6-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
References: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sometimes a check must be made that something happened after all data is
transferred.  A post function on the test step can check.
---
 unit/test-gatt.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 44be64c..520b546 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -265,15 +265,32 @@ static void test_free(gconstpointer user_data)
 	g_free(data->pdu_list);
 }
 
+typedef void (*test_step_t)(struct context *context);
+
+struct test_step {
+	test_step_t func;
+	test_step_t post_func;
+	uint16_t handle;
+	uint16_t end_handle;
+	uint8_t uuid[16];
+	uint8_t expected_att_ecode;
+	const uint8_t *value;
+	uint16_t length;
+};
+
 static gboolean context_quit(gpointer user_data)
 {
 	struct context *context = user_data;
+	const struct test_step *step = context->data->step;
 
 	if (context->process > 0)
 		g_source_remove(context->process);
 
 	g_main_loop_quit(context->main_loop);
 
+	if (step && step->post_func)
+		step->post_func(context);
+
 	return FALSE;
 }
 
@@ -316,18 +333,6 @@ static void context_process(struct context *context)
 	context->process = g_idle_add(send_pdu, context);
 }
 
-typedef void (*test_step_t)(struct context *context);
-
-struct test_step {
-	test_step_t func;
-	uint16_t handle;
-	uint16_t end_handle;
-	uint8_t uuid[16];
-	uint8_t expected_att_ecode;
-	const uint8_t *value;
-	uint16_t length;
-};
-
 static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -364,7 +369,7 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 
 	if (pdu->valid && (pdu->size == 0)) {
 		context->pdu_offset++;
-		printf("empty client pdu, triggering\r\n");
+		printf("empty client pdu, triggering server action\r\n");
 		g_assert(step && step->func);
 		step->func(context);
 		return TRUE;
-- 
2.2.0.rc0.207.ga3a616c

