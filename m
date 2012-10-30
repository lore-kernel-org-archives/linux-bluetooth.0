Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 10/16] sbc: simd support for 8 multiples block size
Date: Tue, 30 Oct 2012 10:39:29 +0100
Message-Id: <1351589975-22640-11-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sbc/sbc_primitives.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 9311848..b189320 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -309,8 +309,26 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
 	#define PCM(i) (big_endian ? \
 		unaligned16_be(pcm + (i) * 2) : unaligned16_le(pcm + (i) * 2))
 
+	if (position % 16 == 8) {
+		position -= 8;
+		nsamples -= 8;
+		if (nchannels > 0) {
+			int16_t *x = &X[0][position];
+			x[0]  = PCM(0 + (15-8) * nchannels);
+			x[2]  = PCM(0 + (14-8) * nchannels);
+			x[3]  = PCM(0 + (8-8) * nchannels);
+			x[4]  = PCM(0 + (13-8) * nchannels);
+			x[5]  = PCM(0 + (9-8) * nchannels);
+			x[6]  = PCM(0 + (12-8) * nchannels);
+			x[7]  = PCM(0 + (10-8) * nchannels);
+			x[8]  = PCM(0 + (11-8) * nchannels);
+		}
+		/* mSBC is designed for 1 channel */
+		pcm += 16 * nchannels;
+	}
+
 	/* copy/permutate audio samples */
-	while ((nsamples -= 16) >= 0) {
+	while (nsamples >= 16) {
 		position -= 16;
 		if (nchannels > 0) {
 			int16_t *x = &X[0][position];
@@ -351,6 +369,23 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_input_s8_internal(
 			x[15] = PCM(1 + 2 * nchannels);
 		}
 		pcm += 32 * nchannels;
+		nsamples -= 16;
+	}
+
+	if (nsamples == 8) {
+		position -= 8;
+		if (nchannels > 0) {
+			int16_t *x = &X[0][position];
+			x[-7] = PCM(0 + 7 * nchannels);
+			x[1]  = PCM(0 + 3 * nchannels);
+			x[2]  = PCM(0 + 6 * nchannels);
+			x[3]  = PCM(0 + 0 * nchannels);
+			x[4]  = PCM(0 + 5 * nchannels);
+			x[5]  = PCM(0 + 1 * nchannels);
+			x[6]  = PCM(0 + 4 * nchannels);
+			x[7]  = PCM(0 + 2 * nchannels);
+		}
+		/* mSBC is designed for 1 channel */
 	}
 	#undef PCM
 
-- 
1.7.9.5

