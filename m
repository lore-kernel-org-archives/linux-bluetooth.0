Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/10] android/hal-ipc: Move exit calls under label in notification_handler
Date: Wed, 11 Jun 2014 16:32:48 +0200
Message-Id: <1402497172-12436-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reduce number of exit points in preparation for destroy callback.
---
 android/hal-ipc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 2cc6eda..59bc3dc 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -154,9 +154,9 @@ static void *notification_handler(void *data)
 
 		ret = recvmsg(notif_sk, &msg, 0);
 		if (ret < 0) {
-			error("Receiving notifications failed, aborting :%s",
+			error("Receiving notifications failed: %s",
 							strerror(errno));
-			exit(EXIT_FAILURE);
+			goto failed;
 		}
 
 		/* socket was shutdown */
@@ -168,8 +168,8 @@ static void *notification_handler(void *data)
 			}
 			pthread_mutex_unlock(&cmd_sk_mutex);
 
-			error("Notification socket closed, aborting");
-			exit(EXIT_FAILURE);
+			error("Notification socket closed");
+			goto failed;
 		}
 
 		fd = -1;
@@ -185,7 +185,7 @@ static void *notification_handler(void *data)
 		}
 
 		if (!handle_msg(buf, ret))
-			exit(EXIT_FAILURE);
+			goto failed;
 	}
 
 	close(notif_sk);
@@ -196,6 +196,9 @@ static void *notification_handler(void *data)
 	DBG("exit");
 
 	return NULL;
+
+failed:
+	exit(EXIT_FAILURE);
 }
 
 static int accept_connection(int sk)
-- 
1.9.1

