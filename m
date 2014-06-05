Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/hal-audio: Fix leaving open socket
Date: Thu,  5 Jun 2014 15:31:10 +0300
Message-Id: <1401971470-29048-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When getting out of the poll loop we shall close socket always.
---
 android/hal-audio.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index bfc102f..439b583 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1346,14 +1346,12 @@ static void *ipc_handler(void *data)
 		/* Check if socket is still alive. Empty while loop.*/
 		while (poll(&pfd, 1, -1) < 0 && errno == EINTR);
 
-		if (pfd.revents & (POLLHUP | POLLERR | POLLNVAL)) {
-			info("Audio HAL: Socket closed");
+		info("Audio HAL: Socket closed");
 
-			pthread_mutex_lock(&sk_mutex);
-			close(audio_sk);
-			audio_sk = -1;
-			pthread_mutex_unlock(&sk_mutex);
-		}
+		pthread_mutex_lock(&sk_mutex);
+		close(audio_sk);
+		audio_sk = -1;
+		pthread_mutex_unlock(&sk_mutex);
 	}
 
 	/* audio_sk is closed at this point, just cleanup endpoints states */
-- 
1.8.3.2

