Return-Path: <cyrus@holtmann.org>
From: Jorge Fernandez Gonzalez <jorge.fernandez.gonzalez@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jorge Fernandez Gonzalez <jorge.fernandez.gonzalez@gmail.com>
Subject: [PATCH] Fix a GLib-Warning in adaptername plugin.
Date: Mon, 18 Jul 2011 16:22:19 +0200
Message-Id: <1310998939-15143-1-git-send-email-jorge.fernandez.gonzalez@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A -GLib-WARNING **: Invalid file descriptor.- was showed when the
bluetooth daemon is killed.
---
 plugins/adaptername.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 2a54cc0..a7ebf37 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -262,10 +262,15 @@ static gboolean handle_inotify_cb(GIOChannel *channel, GIOCondition cond,
 
 static void adaptername_remove(struct btd_adapter *adapter)
 {
-	if (watch_fd >= 0)
+	if (watch_fd >= 0) {
 		close(watch_fd);
-	if (inotify != NULL)
+		watch_fd = -1;
+	}
+	if (inotify != NULL) {
 		g_io_channel_shutdown(inotify, FALSE, NULL);
+		g_io_channel_unref(inotify);
+		inotify = NULL;
+	}
 }
 
 static struct btd_adapter_driver adaptername_driver = {
-- 
1.7.4.1

