Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/haltest: Remove unneeded assignment
Date: Fri,  7 Feb 2014 14:11:15 +0200
Message-Id: <1391775078-25010-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 8c640a1..5ab11a6 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -225,10 +225,8 @@ static void *playback_thread(void *data)
 		pthread_mutex_unlock(&outstream_mutex);
 	} while (len && w_len > 0);
 
-	if (in) {
+	if (in)
 		fclose(in);
-		in = NULL;
-	}
 
 	pthread_cleanup_pop(1);
 	return NULL;
-- 
1.8.3.2

