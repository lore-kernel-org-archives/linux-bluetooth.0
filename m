Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 31/32] android/hal-sco: Fix leaving open socket
Date: Fri,  4 Jul 2014 16:47:16 +0300
Message-Id: <1404481637-900-32-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Close accepted socket always after poll loop.
---
 android/hal-sco.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index d405b41..6a46e90 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -1252,14 +1252,12 @@ static void *ipc_handler(void *data)
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

