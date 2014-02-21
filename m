Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/hal-ipc: Fix race condition when closing IPC
Date: Fri, 21 Feb 2014 17:49:53 +0100
Message-Id: <1393001393-1160-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393001393-1160-1-git-send-email-szymon.janc@tieto.com>
References: <1393001393-1160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Protect command socket cleanup with mutex to avoid bogus exit when
stopping notification thread.
---
 android/hal-ipc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 99ba38e..1ba03f5 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -159,8 +159,12 @@ static void *notification_handler(void *data)
 
 		/* socket was shutdown */
 		if (ret == 0) {
-			if (cmd_sk == -1)
+			pthread_mutex_lock(&cmd_sk_mutex);
+			if (cmd_sk == -1) {
+				pthread_mutex_unlock(&cmd_sk_mutex);
 				break;
+			}
+			pthread_mutex_unlock(&cmd_sk_mutex);
 
 			error("Notification socket closed, aborting");
 			exit(EXIT_FAILURE);
@@ -299,8 +303,10 @@ bool hal_ipc_init(void)
 
 void hal_ipc_cleanup(void)
 {
+	pthread_mutex_lock(&cmd_sk_mutex);
 	close(cmd_sk);
 	cmd_sk = -1;
+	pthread_mutex_unlock(&cmd_sk_mutex);
 
 	shutdown(notif_sk, SHUT_RD);
 
-- 
1.8.5.3

