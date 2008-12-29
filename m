Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: [PATCH] sbc: fix for overflow bug in quantization code
Date: Mon, 29 Dec 2008 12:22:00 +0200
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, jaska.uimonen@nokia.com,
        "ext Marcel Holtmann" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <200812172243.27442.siarhei.siamashka@nokia.com> <d89ddf300812191451q5a94a6b7n91423f1ce5a91a9f@mail.gmail.com> <200812221337.53781.siarhei.siamashka@nokia.com>
In-Reply-To: <200812221337.53781.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ITKWJzK6OUzRNPA"
Message-Id: <200812291222.00855.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_ITKWJzK6OUzRNPA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 22 December 2008 13:37:53 ext Siarhei Siamashka wrote:
[...]
> If we try to use more realistic settings similar to the recommended high
> quality settings from SBC specification (Table 4.7):
> ./sbcenc -j -S -b 51 BigBuckBunny-stereo.au >BigBuckBunny-stereo.sbc
>
> bluez 16-bit fixed point:
> stddev:   43.82 PSNR: 63.48 bytes:114491016/114491308
>
> bluez 32-bit fixed point:
> stddev:   43.78 PSNR: 63.49 bytes:114491016/114491308
>
> reference encoder:
> stddev:   43.37 PSNR: 63.57 bytes:114491016/114491308
[...]
> PS. I still wonder why there is a loss when compared to reference encoder.
> 32-bit fixed point version should be even more precise than single
> precision floating point. Maybe there could be another minor bug in the
> code, or it is just a random deviation and there could be a win for other
> audio files.

Found what's the matter. It's a problem in subbands selection criteria for
joint-stereo. The following patch fixes it.

Best regards,
Siarhei Siamashka

--Boundary-00=_ITKWJzK6OUzRNPA
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-Fixed-subbands-selection-for-joint-stereo-in-SBC-enc.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Fixed-subbands-selection-for-joint-stereo-in-SBC-enc.patch"

>From c1e98a7130377c126b6cdf93812016eab9151729 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Sat, 27 Dec 2008 19:36:14 +0200
Subject: [PATCH] Fixed subbands selection for joint-stereo in SBC encoder

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@nokia.com>
---
 sbc/sbc.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index a3a3ac1..d3dcd9a 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1051,15 +1051,15 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 			}
 
 			/* decide whether to join this subband */
-			if ((scalefactor[0][sb] + scalefactor[1][sb]) >
-					(scalefactor_j[0] + scalefactor_j[1]) ) {
+			if ((frame->scale_factor[0][sb] +
+					frame->scale_factor[1][sb]) >
+					(scale_factor_j[0] +
+					scale_factor_j[1])) {
 				/* use joint stereo for this subband */
 				joint |= 1 << (frame->subbands - 1 - sb);
 				frame->joint |= 1 << sb;
 				frame->scale_factor[0][sb] = scale_factor_j[0];
 				frame->scale_factor[1][sb] = scale_factor_j[1];
-				scalefactor[0][sb] = scalefactor_j[0];
-				scalefactor[1][sb] = scalefactor_j[1];
 				for (blk = 0; blk < frame->blocks; blk++) {
 					frame->sb_sample_f[blk][0][sb] =
 							sb_sample_j[blk][0];
-- 
1.5.6.5


--Boundary-00=_ITKWJzK6OUzRNPA--
