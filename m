Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] android/haltest: Remove unneeded assignment
Date: Thu,  6 Feb 2014 16:22:43 +0200
Message-Id: <1391696563-7478-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391696563-7478-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391615042-22677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1391696563-7478-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 3b34c95..f449b49 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -225,10 +225,8 @@ static void *playback_thread(void *data)
 		pthread_mutex_unlock(&outstream_mutex);
 	} while (len && w_len);
 
-	if (in) {
+	if (in)
 		fclose(in);
-		in = NULL;
-	}
 
 	pthread_cleanup_pop(1);
 	return NULL;
-- 
1.8.3.2

