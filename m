Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 19/21] android/hal-sco: Fix leaving open socket
Date: Fri, 18 Jul 2014 12:48:18 +0300
Message-Id: <1405676900-17703-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Close accepted socket always after poll loop.
---
 android/hal-sco.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 7cbe558..b6ba55f 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -1246,14 +1246,12 @@ static void *ipc_handler(void *data)
 		/* Check if socket is still alive. Empty while loop.*/
 		while (poll(&pfd, 1, -1) < 0 && errno == EINTR);
 
-		if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
-			info("SCO HAL: Socket closed");
+		info("SCO HAL: Socket closed");
 
-			pthread_mutex_lock(&sk_mutex);
-			close(ipc_sk);
-			ipc_sk = -1;
-			pthread_mutex_unlock(&sk_mutex);
-		}
+		pthread_mutex_lock(&sk_mutex);
+		close(ipc_sk);
+		ipc_sk = -1;
+		pthread_mutex_unlock(&sk_mutex);
 	}
 
 	info("Closing SCO IPC thread");
-- 
1.9.1

