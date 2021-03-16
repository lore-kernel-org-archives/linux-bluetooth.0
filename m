Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1911C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE70B65026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhCPO06 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbhCPO0m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:26:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD24C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:26:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id C83E91F44BCD
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH Bluez v3 1/4] shared/timeout: Add timeout_add_seconds abstraction
Date:   Tue, 16 Mar 2021 15:26:24 +0100
Message-Id: <20210316142627.23692-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210316142627.23692-1-frederic.danis@collabora.com>
References: <20210316142627.23692-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

g_timeout_add_seconds() call doesn't ensure the time for the first call of
the timer if the delay is less or equal to 1 second.
In case of a 0 delay call g_idle_add() instead of g_timeout_add_seconds().
---
 src/shared/tester.c           | 16 +++++++++-------
 src/shared/timeout-ell.c      |  6 ++++++
 src/shared/timeout-glib.c     | 27 +++++++++++++++++++++++++++
 src/shared/timeout-mainloop.c |  6 ++++++
 src/shared/timeout.h          |  3 +++
 5 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index af33a79cd..c07cbc11c 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -36,6 +36,7 @@
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
 #include "src/shared/log.h"
+#include "src/shared/timeout.h"
 
 #define COLOR_OFF	"\x1B[0m"
 #define COLOR_BLACK	"\x1B[0;30m"
@@ -126,7 +127,7 @@ static void test_destroy(gpointer data)
 	struct test_case *test = data;
 
 	if (test->timeout_id > 0)
-		g_source_remove(test->timeout_id);
+		timeout_remove(test->timeout_id);
 
 	if (test->teardown_id > 0)
 		g_source_remove(test->teardown_id);
@@ -429,7 +430,7 @@ static gboolean teardown_callback(gpointer user_data)
 	return FALSE;
 }
 
-static gboolean test_timeout(gpointer user_data)
+static bool test_timeout(gpointer user_data)
 {
 	struct test_case *test = user_data;
 
@@ -470,8 +471,9 @@ static void next_test_case(void)
 	test->start_time = g_timer_elapsed(test_timer, NULL);
 
 	if (test->timeout > 0)
-		test->timeout_id = g_timeout_add_seconds(test->timeout,
-							test_timeout, test);
+		test->timeout_id = timeout_add_seconds(test->timeout,
+							test_timeout, test,
+							NULL);
 
 	test->stage = TEST_STAGE_PRE_SETUP;
 
@@ -542,7 +544,7 @@ void tester_pre_setup_failed(void)
 		return;
 
 	if (test->timeout_id > 0) {
-		g_source_remove(test->timeout_id);
+		timeout_remove(test->timeout_id);
 		test->timeout_id = 0;
 	}
 
@@ -583,7 +585,7 @@ void tester_setup_failed(void)
 	test->stage = TEST_STAGE_POST_TEARDOWN;
 
 	if (test->timeout_id > 0) {
-		g_source_remove(test->timeout_id);
+		timeout_remove(test->timeout_id);
 		test->timeout_id = 0;
 	}
 
@@ -606,7 +608,7 @@ static void test_result(enum test_result result)
 		return;
 
 	if (test->timeout_id > 0) {
-		g_source_remove(test->timeout_id);
+		timeout_remove(test->timeout_id);
 		test->timeout_id = 0;
 	}
 
diff --git a/src/shared/timeout-ell.c b/src/shared/timeout-ell.c
index 023364069..6416d8590 100644
--- a/src/shared/timeout-ell.c
+++ b/src/shared/timeout-ell.c
@@ -101,3 +101,9 @@ void timeout_remove(unsigned int id)
 	if (to)
 		l_timeout_remove(to);
 }
+
+unsigned int timeout_add_seconds(unsigned int timeout, timeout_func_t func,
+			void *user_data, timeout_destroy_func_t destroy)
+{
+	return timeout_add(timeout * 1000, func, user_data, destroy);
+}
diff --git a/src/shared/timeout-glib.c b/src/shared/timeout-glib.c
index 8bdb7a662..3268d480c 100644
--- a/src/shared/timeout-glib.c
+++ b/src/shared/timeout-glib.c
@@ -71,3 +71,30 @@ void timeout_remove(unsigned int id)
 	if (source)
 		g_source_destroy(source);
 }
+
+unsigned int timeout_add_seconds(unsigned int timeout, timeout_func_t func,
+			void *user_data, timeout_destroy_func_t destroy)
+{
+	struct timeout_data *data;
+	guint id;
+
+	data = g_try_new0(struct timeout_data, 1);
+	if (!data)
+		return 0;
+
+	data->func = func;
+	data->destroy = destroy;
+	data->user_data = user_data;
+
+	if (!timeout)
+		id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, timeout_callback,
+							data, timeout_destroy);
+	else
+		id = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT, timeout,
+							timeout_callback, data,
+							timeout_destroy);
+	if (!id)
+		g_free(data);
+
+	return id;
+}
diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.c
index 5ffa65c2a..9be803cda 100644
--- a/src/shared/timeout-mainloop.c
+++ b/src/shared/timeout-mainloop.c
@@ -71,3 +71,9 @@ void timeout_remove(unsigned int id)
 
 	mainloop_remove_timeout((int) id);
 }
+
+unsigned int timeout_add_seconds(unsigned int timeout, timeout_func_t func,
+			void *user_data, timeout_destroy_func_t destroy)
+{
+	return timeout_add(timeout * 1000, func, user_data, destroy);
+}
diff --git a/src/shared/timeout.h b/src/shared/timeout.h
index 7e22345dd..0945c3318 100644
--- a/src/shared/timeout.h
+++ b/src/shared/timeout.h
@@ -16,3 +16,6 @@ typedef void (*timeout_destroy_func_t)(void *user_data);
 unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
 			void *user_data, timeout_destroy_func_t destroy);
 void timeout_remove(unsigned int id);
+
+unsigned int timeout_add_seconds(unsigned int timeout, timeout_func_t func,
+			void *user_data, timeout_destroy_func_t destroy);
-- 
2.18.0

