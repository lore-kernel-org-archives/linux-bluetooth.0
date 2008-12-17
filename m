Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] sbc: fix for overflow bug in quantization code
Date: Wed, 17 Dec 2008 22:43:27 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vRWSJJTdo04dqkg"
Message-Id: <200812172243.27442.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_vRWSJJTdo04dqkg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

This simple patch resolves one more SBC encoding quality issue. Now SBC
audio encoding quality should be fine in almost all cases after applying it
together with a new 8 subband filter.

The patch conflicts with the bitstream packing optimization, but I hope that
after all the encoding quality problems are fixed, we can get back to it.


Best regards,
Siarhei Siamashka

--Boundary-00=_vRWSJJTdo04dqkg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-sbc-fix-for-overflow-bug-in-quantization-code.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-sbc-fix-for-overflow-bug-in-quantization-code.patch"

>From 12088ac2053709bf89c3c84d47aef46b7f2da475 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Wed, 17 Dec 2008 22:32:11 +0200
Subject: [PATCH] sbc: fix for overflow bug in quantization code

The result of multiplication does not always fit into 32-bits. Using 64-bit
calculations helps to avoid overflows and sound quality problems in encoded
audio. Overflows are more likely to show up when using high values for
bitpool setting.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
---
 sbc/sbc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 7072673..6624921 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1085,7 +1085,7 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 			for (sb = 0; sb < frame->subbands; sb++) {
 				if (levels[ch][sb] > 0) {
 					audio_sample =
-						(uint16_t) ((((frame->sb_sample_f[blk][ch][sb]*levels[ch][sb]) >>
+						(uint16_t) (((((int64_t)frame->sb_sample_f[blk][ch][sb]*levels[ch][sb]) >>
 									(frame->scale_factor[ch][sb] + 1)) +
 								levels[ch][sb]) >> 1);
 					audio_sample <<= 16 - bits[ch][sb];
-- 
1.5.6.5


--Boundary-00=_vRWSJJTdo04dqkg--
