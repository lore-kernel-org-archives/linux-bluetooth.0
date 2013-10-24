Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 1/5] android: Start command watch after notify channel is connected
Date: Thu, 24 Oct 2013 10:36:49 +0200
Message-ID: <1382603813-9157-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

Daemon should start processing commands only after both communication
channels were connected.
---
 android/main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/android/main.c b/android/main.c
index 9879f05..740b532 100644
--- a/android/main.c
+++ b/android/main.c
@@ -288,9 +288,11 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	g_io_add_watch(io, cond, notif_watch_cb, NULL);
 
-	info("Successfully connected to HAL");
+	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	/* TODO start handling commands */
+	g_io_add_watch(hal_cmd_io, cond, cmd_watch_cb, NULL);
+
+	info("Successfully connected to HAL");
 
 	return FALSE;
 }
@@ -305,10 +307,6 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-
-	g_io_add_watch(io, cond, cmd_watch_cb, NULL);
-
 	hal_notif_io = connect_hal(notif_connect_cb);
 	if (!hal_notif_io) {
 		error("Cannot connect to HAL, terminating");
-- 
1.8.4

