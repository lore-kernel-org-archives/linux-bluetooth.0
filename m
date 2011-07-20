Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Fix removing inotify watch whenever an adapter is removed
Date: Wed, 20 Jul 2011 12:12:22 +0300
Message-Id: <1311153142-6165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This sometimes cause bluetoothd to burn cpu when an adapter is removed
from the system.

Since the watch is not really bond to any adapter, in fact it is added on
plugin .init, its removal is now moved to plugin .exit.
---
 plugins/adaptername.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 2a54cc0..9e99e6a 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -262,10 +262,6 @@ static gboolean handle_inotify_cb(GIOChannel *channel, GIOCondition cond,
 
 static void adaptername_remove(struct btd_adapter *adapter)
 {
-	if (watch_fd >= 0)
-		close(watch_fd);
-	if (inotify != NULL)
-		g_io_channel_shutdown(inotify, FALSE, NULL);
 }
 
 static struct btd_adapter_driver adaptername_driver = {
@@ -314,6 +310,13 @@ static int adaptername_init(void)
 
 static void adaptername_exit(void)
 {
+	if (watch_fd >= 0)
+		close(watch_fd);
+	if (inotify != NULL) {
+		g_io_channel_shutdown(inotify, FALSE, NULL);
+		g_io_channel_unref(inotify);
+	}
+
 	btd_unregister_adapter_driver(&adaptername_driver);
 }
 
-- 
1.7.6

