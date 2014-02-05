Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/haltest: Remove unneeded assignment
Date: Wed,  5 Feb 2014 17:45:53 +0200
Message-Id: <1391615153-22744-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-audio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index bb8f51b..72fea98 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -227,7 +227,6 @@ static void *playback_thread(void *data)
 
 	if (in) {
 		fclose(in);
-		in = NULL;
 	}
 
 	pthread_cleanup_pop(1);
-- 
1.8.3.2

