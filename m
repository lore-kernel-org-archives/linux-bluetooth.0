Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] unit: Fix removing invalid source in test-hfp
Date: Thu, 17 Apr 2014 15:59:45 +0200
Message-Id: <1397743186-29897-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since GLib 2.39 calling g_source_remove on already removed source
is causing critical warning. This was causing unit/test-hfp to
fail when running with GLib 2.40.

./unit/test-hfp
/hfp/test_init:
(./unit/test-hfp:28878): GLib-CRITICAL **: Source ID 1 was not found
    when attempting to remove it
Trace/breakpoint trap
---
 unit/test-hfp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 445fcb7..20aa0b5 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -121,6 +121,8 @@ static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
 	g_assert(!pdu->valid);
 	context_quit(context);
 
+	context->watch_id = 0;
+
 	return FALSE;
 }
 
@@ -187,7 +189,8 @@ static void execute_context(struct context *context)
 {
 	g_main_loop_run(context->main_loop);
 
-	g_source_remove(context->watch_id);
+	if (context->watch_id)
+		g_source_remove(context->watch_id);
 
 	g_main_loop_unref(context->main_loop);
 
-- 
1.9.1

