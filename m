Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Thu, 29 Jan 2009 03:20:25 +0200
References: <200901290310.03440.siarhei.siamashka@nokia.com>
In-Reply-To: <200901290310.03440.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZRQgJy9IGcySom4"
Message-Id: <200901290320.25122.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_ZRQgJy9IGcySom4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 29 January 2009 03:10:03 ext Siarhei Siamashka wrote:
> The attached patch contains optimization for scale factors calculation
> which provides additional SBC encoder speedup.

And MMX variant of this optimization can be implemented with something
like this patch. It still needs to be tested on X86-64 systems though.

Best regards,
Siarhei Siamashka

--Boundary-00=_ZRQgJy9IGcySom4
Content-Type: text/x-diff;
  charset="utf-8";
  name="sbc-scalefactors-mmx.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="sbc-scalefactors-mmx.diff"

diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index 7db4af7..41c0241 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -275,6 +275,59 @@ static inline void sbc_analyze_4b_8s_mmx(int16_t *x, int32_t *out,
 	asm volatile ("emms\n");
 }
 
+static void sbc_calc_scalefactors_mmx(
+	int32_t sb_sample_f[16][2][8],
+	uint32_t scale_factor[2][8],
+	int blocks, int channels, int subbands)
+{
+	static const SBC_ALIGNED int32_t consts[2] = {
+		1 << SCALE_OUT_BITS,
+		1 << SCALE_OUT_BITS,
+	};
+	int ch, sb;
+	intptr_t blk;
+	for (ch = 0; ch < channels; ch++) {
+		for (sb = 0; sb < subbands; sb += 2) {
+			blk = (blocks - 1) * (((char *) &sb_sample_f[1][0][0] -
+				(char *) &sb_sample_f[0][0][0]));
+			asm volatile (
+				"movq         (%4), %%mm0\n"
+			"1:\n"
+				"movq     (%1, %0), %%mm1\n"
+				"pxor        %%mm2, %%mm2\n"
+				"pcmpgtd     %%mm2, %%mm1\n"
+				"paddd    (%1, %0), %%mm1\n"
+				"pcmpgtd     %%mm1, %%mm2\n"
+				"pxor        %%mm2, %%mm1\n"
+
+				"por         %%mm1, %%mm0\n"
+
+				"sub            %2, %0\n"
+				"jns            1b\n"
+
+				"movd        %%mm0, %k0\n"
+				"psrlq         $32, %%mm0\n"
+				"bsrl          %k0, %k0\n"
+				"subl           %5, %k0\n"
+				"movl          %k0, (%3)\n"
+
+				"movd        %%mm0, %k0\n"
+				"bsrl          %k0, %k0\n"
+				"subl           %5, %k0\n"
+				"movl          %k0, 4(%3)\n"
+			: "+r" (blk)
+			: "r" (&sb_sample_f[0][ch][sb]),
+				"i" ((char *) &sb_sample_f[1][0][0] -
+					(char *) &sb_sample_f[0][0][0]),
+				"r" (&scale_factor[ch][sb]),
+				"r" (&consts),
+				"i" (SCALE_OUT_BITS)
+			: "memory");
+		}
+	}
+	asm volatile ("emms\n");
+}
+
 static int check_mmx_support()
 {
 #ifdef __amd64__
@@ -313,6 +366,8 @@ void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
 	if (check_mmx_support()) {
 		state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_mmx;
 		state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
+
+		state->sbc_calc_scalefactors = sbc_calc_scalefactors_mmx;
 	}
 }
 

--Boundary-00=_ZRQgJy9IGcySom4--
