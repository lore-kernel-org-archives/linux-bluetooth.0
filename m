Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client: Allow to save SCO mono audio
Date: Thu, 24 Jul 2014 14:25:23 +0300
Message-Id: <1406201123-5373-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Audio to be played with:
$ play -c 1 -r 8000 -t s16 <file>
---
 android/client/if-sco.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 1964d45..b28fa60 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -29,6 +29,7 @@ static struct audio_stream_in *stream_in = NULL;
 
 static size_t buffer_size = 0;
 static size_t buffer_size_in = 0;
+static bool mono = false;
 static pthread_t play_thread = 0;
 static pthread_mutex_t outstream_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_mutex_t state_mutex = PTHREAD_MUTEX_INITIALIZER;
@@ -323,7 +324,11 @@ static void *read_thread(void *data)
 		haltest_info("Read %zd bytes\n", len);
 
 		if (out) {
-			write_stereo_pcm16((char *) buffer, len, out);
+			if (mono)
+				fwrite(buffer, len, 1, out);
+			else
+				write_stereo_pcm16((char *) buffer, len, out);
+
 			haltest_info("Written %zd bytes\n", len * 2);
 		}
 	} while (len);
@@ -450,6 +455,13 @@ static void read_p(int argc, const char **argv)
 		haltest_info("Reading to file: %s\n", fname);
 	}
 
+	if (argc == 4) {
+		if (atoi(argv[3]) == 1) {
+			haltest_info("Saving to mono s16");
+			mono = true;
+		}
+	}
+
 	if (!buffer_size_in) {
 		haltest_error("Invalid buffer size.\n");
 		goto failed;
-- 
1.9.1

