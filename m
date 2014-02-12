Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] android/test-ipc: Use correct boolean values for glib functions
Date: Wed, 12 Feb 2014 15:13:21 -0400
Message-Id: <1392232401-26119-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/test-ipc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 3a0729e..2def97b 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -263,8 +263,8 @@ static void execute_context(struct context *context)
 {
 	g_main_loop_run(context->main_loop);
 
-	g_io_channel_shutdown(context->notif_io, true, NULL);
-	g_io_channel_shutdown(context->cmd_io, true, NULL);
+	g_io_channel_shutdown(context->notif_io, TRUE, NULL);
+	g_io_channel_shutdown(context->cmd_io, TRUE, NULL);
 	g_io_channel_unref(context->cmd_io);
 	g_io_channel_unref(context->notif_io);
 
-- 
1.7.9.5

