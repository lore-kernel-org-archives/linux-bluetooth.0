Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 04/11] android: Split command and notification socket watch
Date: Mon, 21 Oct 2013 20:56:44 +0200
Message-Id: <1382381811-28123-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/main.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/android/main.c b/android/main.c
index fac1003..b24451e 100644
--- a/android/main.c
+++ b/android/main.c
@@ -62,10 +62,19 @@ static GIOChannel *hal_notif_io = NULL;
 
 static volatile sig_atomic_t __terminated = 0;
 
-static gboolean watch_cb(GIOChannel *io, GIOCondition cond,
+static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	info("HAL socket closed, terminating");
+	info("HAL command socket closed, terminating");
+	g_main_loop_quit(event_loop);
+
+	return FALSE;
+}
+
+static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	info("HAL notification socket closed, terminating");
 	g_main_loop_quit(event_loop);
 
 	return FALSE;
@@ -123,7 +132,7 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	g_io_add_watch(io, cond, watch_cb, NULL);
+	g_io_add_watch(io, cond, notif_watch_cb, NULL);
 
 	info("Successfully connected to HAL");
 
@@ -144,7 +153,7 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	g_io_add_watch(io, cond, watch_cb, NULL);
+	g_io_add_watch(io, cond, cmd_watch_cb, NULL);
 
 	hal_notif_io = connect_hal(notif_connect_cb);
 	if (!hal_notif_io) {
-- 
1.8.4

