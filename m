Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 1/3] Fix memory leak in src/rfkill.c
Date: Mon, 20 Dec 2010 00:29:04 -0400
Message-Id: <1292819346-27318-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Watches must be removed with g_source_remove() otherwise they leak a
reference count to the GIOChannel and internal memory allocations.

Also g_io_channel_set_close_on_unref() is used, so there is no need to
call g_io_channel_shutdown() by hand.
---
 src/rfkill.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/rfkill.c b/src/rfkill.c
index 75397b8..6e9e040 100644
--- a/src/rfkill.c
+++ b/src/rfkill.c
@@ -139,6 +139,7 @@ static gboolean rfkill_event(GIOChannel *chan,
 }
 
 static GIOChannel *channel = NULL;
+static guint watch_id = 0;
 
 void rfkill_init(void)
 {
@@ -156,8 +157,8 @@ void rfkill_init(void)
 	channel = g_io_channel_unix_new(fd);
 	g_io_channel_set_close_on_unref(channel, TRUE);
 
-	g_io_add_watch(channel, G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
-							rfkill_event, NULL);
+	watch_id = g_io_add_watch(channel, G_IO_IN | G_IO_NVAL | G_IO_HUP |
+						G_IO_ERR, rfkill_event, NULL);
 }
 
 void rfkill_exit(void)
@@ -165,7 +166,9 @@ void rfkill_exit(void)
 	if (!channel)
 		return;
 
-	g_io_channel_shutdown(channel, TRUE, NULL);
+	if (watch_id > 0)
+		g_source_remove(watch_id);
+
 	g_io_channel_unref(channel);
 
 	channel = NULL;
-- 
1.7.0.4

