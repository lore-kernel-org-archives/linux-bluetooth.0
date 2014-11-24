Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] shared/io-glib: Fix not calling destroy callback
Date: Mon, 24 Nov 2014 23:35:37 +0100
Message-Id: <1416868537-2478-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Destroy callback should be called also for G_IO_ERR | G_IO_NVAL
condition.
---
 src/shared/io-glib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
index af2ba4e..e9578e1 100644
--- a/src/shared/io-glib.c
+++ b/src/shared/io-glib.c
@@ -159,9 +159,11 @@ static gboolean watch_callback(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
 	struct io_watch *watch = user_data;
-	bool result;
+	bool result, destroy;
 
-	if (cond & (G_IO_ERR | G_IO_NVAL))
+	destroy = watch == watch->io->disconnect_watch;
+
+	if (!destroy && (cond & (G_IO_ERR | G_IO_NVAL)))
 		return FALSE;
 
 	if (watch->callback)
-- 
1.9.3

