Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Christian Hoene" <hoene@uni-tuebingen.de>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Thu, 29 Jan 2009 18:31:49 +0200
Cc: "'Marcel Holtmann'" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
References: <200901290310.03440.siarhei.siamashka@nokia.com> <021801c98222$4a1726e0$de4574a0$@de> <200901291730.31869.siarhei.siamashka@nokia.com>
In-Reply-To: <200901291730.31869.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1ndgJzCvkBDOoDq"
Message-Id: <200901291831.49427.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_1ndgJzCvkBDOoDq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 29 January 2009 17:30:31 ext Siarhei Siamashka wrote:
> On Thursday 29 January 2009 17:00:11 ext Christian Hoene wrote:
> > > > The attached patch contains optimization for scale factors
> > > > calculation
> >
> > which
> >
> > > > provides additional SBC encoder speedup.
> > > >
> > > > For non-gcc compilers, CLZ function is implemented with a very simple
> >
> > and
> >
> > > > slow straightforward code (but it is still faster than current git
> > > > code
> >
> > even
> >
> > > > if used instead of __builtin_clz). Something better could be done
> > > > like:
> > > > http://groups.google.com/group/comp.sys.arm/msg/5ae56e3a95a2345e?hl=e
> > > >n But I'm not sure about license/copyright of the code at this link
> > > > and
> > >
> > > decided
> > >
> > > > not to touch it. Anyway, I don't think that gcc implementation of
> > > > __builtin_clz for the CPU cores which do not support CLZ instruction
> > > > is
> >
> > any
> >
> > > > worse.
> > >
> > > personally I don't really care about non-gcc compilers. I think that
> > > some of the BlueZ source might not even compile without gcc.
> > >
> > > Anyway, patch has been applied. Thanks.
> >
> > The testing results are not positive. It is better to revoke the patch.
> > http://net.cs.uni-tuebingen.de/html/nexgenvoip/
> > http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/encoder.bluez.03.wav
>
> Thanks for finding the bug. A common things about these failed testcases
> is that block size is not 16.
>
> Looks like this was not covered by my own regression tests, I'll try to do
> something about this problem now.

A fix is attached. I also extended my regression test script to cover such
cases.


Best regards,
Siarhei Siamashka

--Boundary-00=_1ndgJzCvkBDOoDq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-Fix-for-SBC-encoding-with-block-sizes-other-than-16.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-Fix-for-SBC-encoding-with-block-sizes-other-than-16.patch"

>From d9a207576eb9b1df3c8e820f8c34d03f7276bea9 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Thu, 29 Jan 2009 18:15:31 +0200
Subject: [PATCH] Fix for SBC encoding with block sizes other than 16

Thanks to Christian Hoene for finding and reporting the
problem. This regression was intruduced in commit
19af3c49e61aa046375497108e05a3a0605da158
---
 sbc/sbc.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 8a2d782..29f1d14 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -651,30 +651,37 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 				struct sbc_frame *frame)
 {
 	int ch, blk;
+	int16_t *x;
 
 	switch (frame->subbands) {
 	case 4:
-		for (ch = 0; ch < frame->channels; ch++)
+		for (ch = 0; ch < frame->channels; ch++) {
+			x = &state->X[ch][state->position - 16 +
+							frame->blocks * 4];
 			for (blk = 0; blk < frame->blocks; blk += 4) {
 				state->sbc_analyze_4b_4s(
-					&state->X[ch][state->position +
-							48 - blk * 4],
+					x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
+				x -= 16;
 			}
+		}
 		return frame->blocks * 4;
 
 	case 8:
-		for (ch = 0; ch < frame->channels; ch++)
+		for (ch = 0; ch < frame->channels; ch++) {
+			x = &state->X[ch][state->position - 32 +
+							frame->blocks * 8];
 			for (blk = 0; blk < frame->blocks; blk += 4) {
 				state->sbc_analyze_4b_8s(
-					&state->X[ch][state->position +
-							96 - blk * 8],
+					x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
+				x -= 32;
 			}
+		}
 		return frame->blocks * 8;
 
 	default:
-- 
1.5.6.5


--Boundary-00=_1ndgJzCvkBDOoDq--
