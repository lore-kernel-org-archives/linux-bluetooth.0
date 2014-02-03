Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 4/6] android/hal-audio: Fix audio with large omtu value
Date: Mon, 3 Feb 2014 17:55:47 +0100
Message-ID: <1391446549-31455-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes media packet construction with devices which use large
omtu value. In such cases it's possible that we will try to fit more
than 15 SBC frames in single media packet (which is maximum possible
value as it's encoded using 4 bits) which will cause frame counter to
wrap around and provide incorrect data to SBC encoder.

This behaviour was seen on UPF with one of carkit devices which set
omtu=2688.
---
 android/hal-audio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index ff2b6e4..be17c76 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -39,6 +39,8 @@
 
 #define FIXED_A2DP_PLAYBACK_LATENCY_MS 25
 
+#define MAX_FRAMES_IN_PAYLOAD 15
+
 static const uint8_t a2dp_src_uuid[] = {
 		0x00, 0x00, 0x11, 0x0a, 0x00, 0x00, 0x10, 0x00,
 		0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
@@ -483,7 +485,9 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 		 * input data
 		 */
 		if (mp->payload.frame_count == sbc_data->frames_per_packet ||
-				bytes == consumed) {
+				bytes == consumed ||
+				mp->payload.frame_count ==
+							MAX_FRAMES_IN_PAYLOAD) {
 			ret = write_media_packet(fd, sbc_data, mp, encoded);
 			if (ret < 0)
 				return ret;
-- 
1.8.5.3

