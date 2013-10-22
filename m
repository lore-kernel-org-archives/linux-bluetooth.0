Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] android/hal: Use notification socket for daemon lifetime tracking
Date: Tue, 22 Oct 2013 15:24:58 +0200
Message-Id: <1382448299-16887-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
References: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If daemon exited unexpectedly HAL should be stop. With cleanup
procedure command socket is closed as first so use that to distinguish
correct action.
---
 android/hal-ipc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 16f2bd3..f753f10 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -88,8 +88,13 @@ static void *notification_handler(void *data)
 		}
 
 		/* socket was shutdown */
-		if (ret == 0)
-			break;
+		if (ret == 0) {
+			if (cmd_sk == -1)
+				break;
+
+			error("Notification socket closed, aborting");
+			exit(EXIT_FAILURE);
+		}
 
 		if (ret < (ssize_t) sizeof(*hal_msg)) {
 			error("Too small notification (%zd bytes), aborting",
-- 
1.8.4

