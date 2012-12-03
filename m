Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] adaptername: Fix passing negative error code to strerror
Date: Mon, 3 Dec 2012 15:03:29 +0100
Message-ID: <1354543409-21258-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This also make error reporting code compliant with convention used.
---
 plugins/adaptername.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 018e6f0..179152f 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -288,9 +288,9 @@ static int adaptername_init(void)
 
 	inot_fd = inotify_init();
 	if (inot_fd < 0) {
-		int err = errno;
+		int err = -errno;
 		error("Failed to setup inotify: %s (%d)", strerror(-err), -err);
-		return -err;
+		return err;
 	}
 
 	mask = IN_CLOSE_WRITE;
@@ -301,11 +301,11 @@ static int adaptername_init(void)
 
 	watch_d = inotify_add_watch(inot_fd, MACHINE_INFO_DIR, mask);
 	if (watch_d < 0) {
-		int err = errno;
+		int err = -errno;
 		error("Failed to setup watch for '%s': %s (%d)",
 				MACHINE_INFO_DIR, strerror(-err), -err);
 		close(inot_fd);
-		return -err;
+		return err;
 	}
 
 	data = g_new(struct inotify_data, 1);
-- 
1.7.9.5

