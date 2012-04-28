Return-Path: <cyrus@holtmann.org>
Message-ID: <1335626216.14431.3.camel@sirocco.config>
Subject: [PATCH] Fix adaptername shutdown
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 28 Apr 2012 16:16:56 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

An inotify watch descriptor isn't a file descriptor, so don't
treat it as such and remove it properly.
---
 plugins/adaptername.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index e154e92..9af19aa 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -52,7 +52,7 @@
 #define MACHINE_INFO_FILE "machine-info"
 
 static GIOChannel *inotify = NULL;
-static int watch_fd = -1;
+static int watch_d = -1;
 
 /* This file is part of systemd's hostnamed functionality:
  * http://0pointer.de/public/systemd-man/machine-info.html
@@ -292,8 +292,8 @@ static int adaptername_init(void)
 	mask |= IN_MOVED_FROM;
 	mask |= IN_MOVED_TO;
 
-	watch_fd = inotify_add_watch(inot_fd, MACHINE_INFO_DIR, mask);
-	if (watch_fd < 0) {
+	watch_d = inotify_add_watch(inot_fd, MACHINE_INFO_DIR, mask);
+	if (watch_d < 0) {
 		error("Failed to setup watch for '%s'", MACHINE_INFO_DIR);
 		close(inot_fd);
 		return 0;
@@ -310,8 +310,11 @@ static int adaptername_init(void)
 
 static void adaptername_exit(void)
 {
-	if (watch_fd >= 0)
-		close(watch_fd);
+	if (watch_d >= 0 && inotify != NULL) {
+		int inot_fd;
+		inot_fd = g_io_channel_unix_get_fd (inotify);
+		inotify_rm_watch(inot_fd, watch_d);
+	}
 	if (inotify != NULL) {
 		g_io_channel_shutdown(inotify, FALSE, NULL);
 		g_io_channel_unref(inotify);
-- 
1.7.10


