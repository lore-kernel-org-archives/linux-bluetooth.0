Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 01/16] sbc: Add encoder_state to analysis functions
Date: Tue, 30 Oct 2012 10:39:20 +0100
Message-Id: <1351589975-22640-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until now, SIMD analysis used to process 4 blocks of 8 samples at a time. This
was implemented using two constant tables: odd and even. This mean we can only
process 4, 8, 12, or 16 blocks par SBC packets.
mSBC requires 15 blocks, so to be able to analyse 1 block, it will be necessary
to know if we are processing an odd or even block. This will be done with a
new member to encoder_state.
---
 sbc/sbc.c                   |    4 ++--
 sbc/sbc_primitives.c        |    8 ++++----
 sbc/sbc_primitives.h        |    6 ++++--
 sbc/sbc_primitives_armv6.c  |    6 ++++--
 sbc/sbc_primitives_iwmmxt.c |    8 ++++----
 sbc/sbc_primitives_mmx.c    |    8 ++++----
 sbc/sbc_primitives_neon.c   |    8 ++++----
 7 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index f0c77c7..e51ed57 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -692,7 +692,7 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 							frame->blocks * 4];
 			for (blk = 0; blk < frame->blocks; blk += 4) {
 				state->sbc_analyze_4b_4s(
-					x,
+					state, x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
@@ -707,7 +707,7 @@ static int sbc_analyze_audio(struct sbc_encoder_state *state,
 							frame->blocks * 8];
 			for (blk = 0; blk < frame->blocks; blk += 4) {
 				state->sbc_analyze_4b_8s(
-					x,
+					state, x,
 					frame->sb_sample_f[blk][ch],
 					frame->sb_sample_f[blk + 1][ch] -
 					frame->sb_sample_f[blk][ch]);
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index ad780d0..f8cc4b6 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -183,8 +183,8 @@ static inline void sbc_analyze_eight_simd(const int16_t *in, int32_t *out,
 			(SBC_COS_TABLE_FIXED8_SCALE - SCALE_OUT_BITS);
 }
 
-static inline void sbc_analyze_4b_4s_simd(int16_t *x,
-						int32_t *out, int out_stride)
+static inline void sbc_analyze_4b_4s_simd(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	sbc_analyze_four_simd(x + 12, out, analysis_consts_fixed4_simd_odd);
@@ -196,8 +196,8 @@ static inline void sbc_analyze_4b_4s_simd(int16_t *x,
 	sbc_analyze_four_simd(x + 0, out, analysis_consts_fixed4_simd_even);
 }
 
-static inline void sbc_analyze_4b_8s_simd(int16_t *x,
-					  int32_t *out, int out_stride)
+static inline void sbc_analyze_4b_8s_simd(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	sbc_analyze_eight_simd(x + 24, out, analysis_consts_fixed8_simd_odd);
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index 17ad4f7..a7bbef1 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -41,10 +41,12 @@ struct sbc_encoder_state {
 	int16_t SBC_ALIGNED X[2][SBC_X_BUFFER_SIZE];
 	/* Polyphase analysis filter for 4 subbands configuration,
 	 * it handles 4 blocks at once */
-	void (*sbc_analyze_4b_4s)(int16_t *x, int32_t *out, int out_stride);
+	void (*sbc_analyze_4b_4s)(struct sbc_encoder_state *state,
+			int16_t *x, int32_t *out, int out_stride);
 	/* Polyphase analysis filter for 8 subbands configuration,
 	 * it handles 4 blocks at once */
-	void (*sbc_analyze_4b_8s)(int16_t *x, int32_t *out, int out_stride);
+	void (*sbc_analyze_4b_8s)(struct sbc_encoder_state *state,
+			int16_t *x, int32_t *out, int out_stride);
 	/* Process input data (deinterleave, endian conversion, reordering),
 	 * depending on the number of subbands and input data byte order */
 	int (*sbc_enc_process_input_4s_le)(int position,
diff --git a/sbc/sbc_primitives_armv6.c b/sbc/sbc_primitives_armv6.c
index b321272..6ad94c6 100644
--- a/sbc/sbc_primitives_armv6.c
+++ b/sbc/sbc_primitives_armv6.c
@@ -265,7 +265,8 @@ static void __attribute__((naked)) sbc_analyze_eight_armv6()
 	((void (*)(int16_t *, int32_t *, const FIXED_T*)) \
 		sbc_analyze_eight_armv6)((in), (out), (consts))
 
-static void sbc_analyze_4b_4s_armv6(int16_t *x, int32_t *out, int out_stride)
+static void sbc_analyze_4b_4s_armv6(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	sbc_analyze_four(x + 12, out, analysis_consts_fixed4_simd_odd);
@@ -277,7 +278,8 @@ static void sbc_analyze_4b_4s_armv6(int16_t *x, int32_t *out, int out_stride)
 	sbc_analyze_four(x + 0, out, analysis_consts_fixed4_simd_even);
 }
 
-static void sbc_analyze_4b_8s_armv6(int16_t *x, int32_t *out, int out_stride)
+static void sbc_analyze_4b_8s_armv6(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	sbc_analyze_eight(x + 24, out, analysis_consts_fixed8_simd_odd);
diff --git a/sbc/sbc_primitives_iwmmxt.c b/sbc/sbc_primitives_iwmmxt.c
index e0bd060..39cc390 100644
--- a/sbc/sbc_primitives_iwmmxt.c
+++ b/sbc/sbc_primitives_iwmmxt.c
@@ -268,8 +268,8 @@ static inline void sbc_analyze_eight_iwmmxt(const int16_t *in, int32_t *out,
 		  "wcgr0", "memory");
 }
 
-static inline void sbc_analyze_4b_4s_iwmmxt(int16_t *x, int32_t *out,
-						int out_stride)
+static inline void sbc_analyze_4b_4s_iwmmxt(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	sbc_analyze_four_iwmmxt(x + 12, out, analysis_consts_fixed4_simd_odd);
@@ -281,8 +281,8 @@ static inline void sbc_analyze_4b_4s_iwmmxt(int16_t *x, int32_t *out,
 	sbc_analyze_four_iwmmxt(x + 0, out, analysis_consts_fixed4_simd_even);
 }
 
-static inline void sbc_analyze_4b_8s_iwmmxt(int16_t *x, int32_t *out,
-						int out_stride)
+static inline void sbc_analyze_4b_8s_iwmmxt(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	sbc_analyze_eight_iwmmxt(x + 24, out, analysis_consts_fixed8_simd_odd);
diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index 27e9a56..cbacb4e 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -246,8 +246,8 @@ static inline void sbc_analyze_eight_mmx(const int16_t *in, int32_t *out,
 		: "cc", "memory");
 }
 
-static inline void sbc_analyze_4b_4s_mmx(int16_t *x, int32_t *out,
-						int out_stride)
+static inline void sbc_analyze_4b_4s_mmx(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	sbc_analyze_four_mmx(x + 12, out, analysis_consts_fixed4_simd_odd);
@@ -261,8 +261,8 @@ static inline void sbc_analyze_4b_4s_mmx(int16_t *x, int32_t *out,
 	__asm__ volatile ("emms\n");
 }
 
-static inline void sbc_analyze_4b_8s_mmx(int16_t *x, int32_t *out,
-						int out_stride)
+static inline void sbc_analyze_4b_8s_mmx(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	sbc_analyze_eight_mmx(x + 24, out, analysis_consts_fixed8_simd_odd);
diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index 5d4d0e3..aeca8df 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -211,8 +211,8 @@ static inline void _sbc_analyze_eight_neon(const int16_t *in, int32_t *out,
 			"d18", "d19");
 }
 
-static inline void sbc_analyze_4b_4s_neon(int16_t *x,
-						int32_t *out, int out_stride)
+static inline void sbc_analyze_4b_4s_neon(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	_sbc_analyze_four_neon(x + 12, out, analysis_consts_fixed4_simd_odd);
@@ -224,8 +224,8 @@ static inline void sbc_analyze_4b_4s_neon(int16_t *x,
 	_sbc_analyze_four_neon(x + 0, out, analysis_consts_fixed4_simd_even);
 }
 
-static inline void sbc_analyze_4b_8s_neon(int16_t *x,
-						int32_t *out, int out_stride)
+static inline void sbc_analyze_4b_8s_neon(struct sbc_encoder_state *state,
+		int16_t *x, int32_t *out, int out_stride)
 {
 	/* Analyze blocks */
 	_sbc_analyze_eight_neon(x + 24, out, analysis_consts_fixed8_simd_odd);
-- 
1.7.9.5

