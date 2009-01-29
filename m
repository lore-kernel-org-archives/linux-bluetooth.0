Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Thu, 29 Jan 2009 03:10:03 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rHQgJdLG6apqNQf"
Message-Id: <200901290310.03440.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_rHQgJdLG6apqNQf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,

The attached patch contains optimization for scale factors calculation which
provides additional SBC encoder speedup.

=46or non-gcc compilers, CLZ function is implemented with a very simple and
slow straightforward code (but it is still faster than current git code even
if used instead of __builtin_clz). Something better could be done like:=20
http://groups.google.com/group/comp.sys.arm/msg/5ae56e3a95a2345e?hl=3Den
But I'm not sure about license/copyright of the code at this link and decid=
ed
not to touch it. Anyway, I don't think that gcc implementation of
__builtin_clz for the CPU cores which do not support CLZ instruction is any
worse.

Joint stereo processing also involves recalculation of scale factors, which
can use a similar optimization or even exactly the same function.
I intentionally did not benchmark encoding with joint stereo yet as it would
spoil the nice numbers :) That's something to improve next.

Benchmark results (sbcenc with default settings):

=3D=3D=3D=3D

ARM Cortex-A8:

before:
real    1m 4.84s
user    1m 1.05s
sys     0m 3.78s

after:
real    0m 58.93s
user    0m 55.15s
sys     0m 3.78s

Intel Core2:

before:
real =A0 =A00m7.729s
user =A0 =A00m7.268s
sys =A0 =A0 0m0.376s

after:
real    0m6.473s
user    0m6.116s
sys     0m0.292s

=3D=3D=3D=3D

Overall, CPU usage in SBC encoder looks more or less like this (oprofile log
from ARM Cortex-A8):

samples  %        image name               symbol name
2173     30.6791  sbcenc.neon_new          sbc_encode
1774     25.0459  sbcenc.neon_new          sbc_analyze_4b_8s_neon
1525     21.5304  sbcenc.neon_new          sbc_calculate_bits
916      12.9324  sbcenc.neon_new          sbc_calc_scalefactors
600       8.4710  sbcenc.neon_new          sbc_enc_process_input_8s_be
75        1.0589  libc-2.5.so              memcpy
13        0.1835  sbcenc.neon_new          main
4         0.0565  libc-2.5.so              write
2         0.0282  sbcenc.neon_new          .plt
1         0.0141  ld-2.5.so                _dl_relocate_object

=20
Best regards,
Siarhei Siamashka

--Boundary-00=_rHQgJdLG6apqNQf
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-SBC-encoder-scale-factors-calculation-optimized-with.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-SBC-encoder-scale-factors-calculation-optimized-with.patch"

>From 90c60f04f1540fe2c7d5ab631dbd111c25b03e17 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Thu, 29 Jan 2009 02:17:36 +0200
Subject: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz

Count leading zeros operation is often implemented using a special
instruction for it on various architectures (at least this is true
for ARM and x86). Using __builtin_clz gcc intrinsic allows to
eliminate innermost loop in scale factors calculation and improve
performance. Also scale factors calculation can be optimized even
more using SIMD instructions.
---
 sbc/sbc.c            |   21 +++++----------------
 sbc/sbc_primitives.c |   41 +++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives.h |    4 ++++
 3 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 365ee1f..8a2d782 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -77,7 +77,7 @@ struct sbc_frame {
 	uint8_t joint;
 
 	/* only the lower 4 bits of every element are to be used */
-	uint8_t scale_factor[2][8];
+	uint32_t scale_factor[2][8];
 
 	/* raw integer subband samples in the frame */
 	int32_t SBC_ALIGNED sb_sample_f[16][2][8];
@@ -745,8 +745,6 @@ static SBC_ALWAYS_INLINE int sbc_pack_frame_internal(
 	uint32_t levels[2][8];	/* levels are derived from that */
 	uint32_t sb_sample_delta[2][8];
 
-	u_int32_t scalefactor[2][8];	/* derived from frame->scale_factor */
-
 	data[0] = SBC_SYNCWORD;
 
 	data[1] = (frame->frequency & 0x03) << 6;
@@ -785,19 +783,6 @@ static SBC_ALWAYS_INLINE int sbc_pack_frame_internal(
 	crc_header[1] = data[2];
 	crc_pos = 16;
 
-	for (ch = 0; ch < frame_channels; ch++) {
-		for (sb = 0; sb < frame_subbands; sb++) {
-			frame->scale_factor[ch][sb] = 0;
-			scalefactor[ch][sb] = 2 << SCALE_OUT_BITS;
-			for (blk = 0; blk < frame->blocks; blk++) {
-				while (scalefactor[ch][sb] < fabs(frame->sb_sample_f[blk][ch][sb])) {
-					frame->scale_factor[ch][sb]++;
-					scalefactor[ch][sb] *= 2;
-				}
-			}
-		}
-	}
-
 	if (frame->mode == JOINT_STEREO) {
 		/* like frame->sb_sample but joint stereo */
 		int32_t sb_sample_j[16][2];
@@ -1115,6 +1100,10 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
 
 	samples = sbc_analyze_audio(&priv->enc_state, &priv->frame);
 
+	priv->enc_state.sbc_calc_scalefactors(
+		priv->frame.sb_sample_f, priv->frame.scale_factor,
+		priv->frame.blocks, priv->frame.channels, priv->frame.subbands);
+
 	framelen = sbc_pack_frame(output, &priv->frame, output_len);
 
 	if (written)
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 338feb9..303f3fe 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -401,6 +401,44 @@ static int sbc_enc_process_input_8s_be(int position,
 			position, pcm, X, nsamples, 1, 1);
 }
 
+/* Supplementary function to count the number of leading zeros */
+
+static inline int sbc_clz(uint32_t x)
+{
+#ifdef __GNUC__
+	return __builtin_clz(x);
+#else
+	/* TODO: this should be replaced with something better if good
+	 * performance is wanted when using compilers other than gcc */
+	int cnt = 0;
+	while (x) {
+		cnt++;
+		x >>= 1;
+	}
+	return 32 - cnt;
+#endif
+}
+
+static void sbc_calc_scalefactors(
+	int32_t sb_sample_f[16][2][8],
+	uint32_t scale_factor[2][8],
+	int blocks, int channels, int subbands)
+{
+	int ch, sb, blk;
+	for (ch = 0; ch < channels; ch++) {
+		for (sb = 0; sb < subbands; sb++) {
+			uint32_t x = 1 << SCALE_OUT_BITS;
+			for (blk = 0; blk < blocks; blk++) {
+				int32_t tmp = fabs(sb_sample_f[blk][ch][sb]);
+				if (tmp != 0)
+					x |= tmp - 1;
+			}
+			scale_factor[ch][sb] = (31 - SCALE_OUT_BITS) -
+				sbc_clz(x);
+		}
+	}
+}
+
 /*
  * Detect CPU features and setup function pointers
  */
@@ -416,6 +454,9 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 	state->sbc_enc_process_input_8s_le = sbc_enc_process_input_8s_le;
 	state->sbc_enc_process_input_8s_be = sbc_enc_process_input_8s_be;
 
+	/* Default implementation for scale factors calculation */
+	state->sbc_calc_scalefactors = sbc_calc_scalefactors;
+
 	/* X86/AMD64 optimizations */
 #ifdef SBC_BUILD_WITH_MMX_SUPPORT
 	sbc_init_primitives_mmx(state);
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 5b7c9ac..2708c82 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -58,6 +58,10 @@ struct sbc_encoder_state {
 	int (*sbc_enc_process_input_8s_be)(int position,
 			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 			int nsamples, int nchannels);
+	/* Scale factors calculation */
+	void (*sbc_calc_scalefactors)(int32_t sb_sample_f[16][2][8],
+			uint32_t scale_factor[2][8],
+			int blocks, int channels, int subbands);
 };
 
 /*
-- 
1.5.6.5


--Boundary-00=_rHQgJdLG6apqNQf--
