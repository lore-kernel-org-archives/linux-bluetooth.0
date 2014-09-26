Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] android/client: Simplify PCM handling function in SCO HAL
Date: Fri, 26 Sep 2014 15:42:14 +0200
Message-Id: <1411738938-29524-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those functions operates on aligned buffers so there is no need for
unaligned memory access helpers.
---
 android/client/if-sco.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 7a89692..e7197b2 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -19,7 +19,6 @@
 #include <unistd.h>
 #include <math.h>
 
-#include "../src/shared/util.h"
 #include "if-main.h"
 #include "../hal-utils.h"
 
@@ -176,14 +175,11 @@ static void prepare_sample(void)
 
 static void mono_to_stereo_pcm16(const int16_t *in, int16_t *out, size_t samples)
 {
-	int16_t mono;
 	size_t i;
 
 	for (i = 0; i < samples; i++) {
-		mono = get_unaligned(&in[i]);
-
-		put_unaligned(mono, &out[2 * i]);
-		put_unaligned(mono, &out[2 * i + 1]);
+		out[2 * i] = in[i];
+		out[2 * i + 1] = in[i];
 	}
 }
 
@@ -267,17 +263,14 @@ static void *playback_thread(void *data)
 	return NULL;
 }
 
-static void write_stereo_pcm16(char *buffer, size_t len, FILE *out)
+static void write_stereo_pcm16(const short *input, size_t len, FILE *out)
 {
-	const int16_t *input = (const void *) buffer;
-	int16_t sample[2];
+	short sample[2];
 	size_t i;
 
 	for (i = 0; i < len / 2; i++) {
-		int16_t mono = get_unaligned(&input[i]);
-
-		put_unaligned(mono, &sample[0]);
-		put_unaligned(mono, &sample[1]);
+		sample[0] = input[i];
+		sample[1] = input[i];
 
 		fwrite(sample, sizeof(sample), 1, out);
 	}
@@ -319,7 +312,7 @@ static void *read_thread(void *data)
 		haltest_info("Read %zd bytes\n", len);
 
 		if (out) {
-			write_stereo_pcm16((char *) buffer, len, out);
+			write_stereo_pcm16(buffer, len, out);
 			haltest_info("Written %zd bytes\n", len * 2);
 		}
 	} while (len);
-- 
1.9.1

