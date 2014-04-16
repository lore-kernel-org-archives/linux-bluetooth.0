Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 4/6] android/hal-audio: Resync audio when lagging too much
Date: Thu, 17 Apr 2014 01:50:36 +0200
Message-Id: <1397692238-18642-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397692238-18642-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case we're more than 100ms behind actual audio clock, we start to
skip writing data until we're back in sync. Delay value of 100ms is
what PulseAudio use for the same purpose.
---
 android/hal-audio.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index a261871..3ff3b9d 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -45,6 +45,8 @@
 
 #define MAX_FRAMES_IN_PAYLOAD 15
 
+#define MAX_DELAY	100000 /* 100ms */
+
 static const uint8_t a2dp_src_uuid[] = {
 		0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
 		0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
@@ -236,6 +238,8 @@ struct audio_endpoint {
 	uint16_t seq;
 	uint32_t samples;
 	struct timespec start;
+
+	bool resync;
 };
 
 static struct audio_endpoint audio_endpoints[MAX_AUDIO_ENDPOINTS];
@@ -914,6 +918,7 @@ static bool resume_endpoint(struct audio_endpoint *ep)
 		return false;
 
 	ep->samples = 0;
+	ep->resync = false;
 
 	return true;
 }
@@ -1031,10 +1036,15 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 		audio_sent = ep->samples * 1000000ll / out->cfg.rate;
 		audio_passed = timespec_diff_us(&current, &ep->start);
 
-		/* if we're ahead of stream then wait for next write point */
+		/* if we're ahead of stream then wait for next write point
+		 * if we're lagging more than 100ms then stop writing and just
+		 * skip data until we're back in sync
+		 */
 		if (audio_sent > audio_passed) {
 			struct timespec anchor;
 
+			ep->resync = false;
+
 			timespec_add(&ep->start, audio_sent, &anchor);
 
 			while (true) {
@@ -1051,18 +1061,28 @@ static bool write_data(struct a2dp_stream_out *out, const void *buffer,
 					return false;
 				}
 			}
-		}
+		} else if (!ep->resync) {
+			uint64_t diff = audio_passed - audio_sent;
 
-		/* wait some time for socket to be ready for write,
-		 * but we'll just skip writing data if timeout occurs
-		 */
-		if (!wait_for_endpoint(ep, &do_write))
-			return false;
+			if (diff > MAX_DELAY) {
+				warn("lag is %jums, resyncing", diff / 1000);
+				ep->resync = true;
+			}
+		}
 
-		if (do_write)
-			if (!write_to_endpoint(ep, written))
+		/* in resync mode we'll just drop mediapackets */
+		if (!ep->resync) {
+			/* wait some time for socket to be ready for write,
+			 * but we'll just skip writing data if timeout occurs
+			 */
+			if (!wait_for_endpoint(ep, &do_write))
 				return false;
 
+			if (do_write)
+				if (!write_to_endpoint(ep, written))
+					return false;
+		}
+
 		/* AudioFlinger provides 16bit PCM, so sample size is 2 bytes
 		 * multiplied by number of channels. Number of channels is
 		 * simply number of bits set in channels mask.
-- 
1.9.2

