Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/client: Check stream before standby() call
Date: Wed, 23 Jul 2014 14:35:00 +0300
Message-Id: <1406115301-18812-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406115301-18812-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1406115301-18812-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Rearrange stop sequence. Fixes following issue:
...
Program received signal SIGSEGV, Segmentation fault.
0x00000000004105b8 in stop_p (argc=<optimized out>, argv=<optimized
out>) at android/client/if-sco.c:483
483		stream_out->common.standby(&stream_out->common);
(gdb) bt
out>) at android/client/if-sco.c:483
...

f stop
---
 android/client/if-sco.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index c33b012..7a89692 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -473,16 +473,18 @@ static void stop_p(int argc, const char **argv)
 		return;
 	}
 
+	if (stream_out) {
+		pthread_mutex_lock(&outstream_mutex);
+		stream_out->common.standby(&stream_out->common);
+		pthread_mutex_unlock(&outstream_mutex);
+	}
+
 	current_state = STATE_STOPPING;
 	pthread_mutex_unlock(&state_mutex);
 
 	pthread_join(play_thread, NULL);
 	play_thread = 0;
 
-	pthread_mutex_lock(&outstream_mutex);
-	stream_out->common.standby(&stream_out->common);
-	pthread_mutex_unlock(&outstream_mutex);
-
 	haltest_info("Ended %s\n", __func__);
 }
 
-- 
1.9.1

