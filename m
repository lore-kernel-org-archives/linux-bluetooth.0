Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 2/5] sbc: ARM NEON optimizations for input permutation in SBC encoder
Date: Fri,  2 Jul 2010 15:25:39 +0300
Message-Id: <1278073542-14859-3-git-send-email-siarhei.siamashka@gmail.com>
In-Reply-To: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

Using SIMD optimizations for 'sbc_enc_process_input_*' functions provides
a modest, but consistent speedup in all SBC encoding cases.

Benchmarked on ARM Cortex-A8:

== Before: ==

$ time ./sbcenc -b53 -s8 -j test.au > /dev/null

real    0m4.389s
user    0m3.969s
sys     0m0.422s

samples  %        image name               symbol name
26234    29.9625  sbcenc                   sbc_pack_frame
20057    22.9076  sbcenc                   sbc_analyze_4b_8s_neon
14306    16.3393  sbcenc                   sbc_calculate_bits
9866     11.2682  sbcenc                   sbc_enc_process_input_8s_be
8506      9.7149  no-vmlinux               /no-vmlinux
5219      5.9608  sbcenc                   sbc_calc_scalefactors_j_neon
2280      2.6040  sbcenc                   sbc_encode
661       0.7549  libc-2.10.1.so           memcpy

== After: ==

$ time ./sbcenc -b53 -s8 -j test.au > /dev/null

real    0m3.989s
user    0m3.602s
sys     0m0.391s

samples  %        image name               symbol name
26057    32.6128  sbcenc                   sbc_pack_frame
20003    25.0357  sbcenc                   sbc_analyze_4b_8s_neon
14220    17.7977  sbcenc                   sbc_calculate_bits
8498     10.6361  no-vmlinux               /no-vmlinux
5300      6.6335  sbcenc                   sbc_calc_scalefactors_j_neon
3235      4.0489  sbcenc                   sbc_enc_process_input_8s_be_neon
2172      2.7185  sbcenc                   sbc_encode
---
 sbc/sbc_primitives_neon.c |  350 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 350 insertions(+), 0 deletions(-)

diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
index c6a16ac..7713759 100644
--- a/sbc/sbc_primitives_neon.c
+++ b/sbc/sbc_primitives_neon.c
@@ -536,12 +536,362 @@ int sbc_calc_scalefactors_j_neon(
 	return joint;
 }
 
+#define PERM_BE(a, b, c, d) {             \
+		(a * 2) + 1, (a * 2) + 0, \
+		(b * 2) + 1, (b * 2) + 0, \
+		(c * 2) + 1, (c * 2) + 0, \
+		(d * 2) + 1, (d * 2) + 0  \
+	}
+#define PERM_LE(a, b, c, d) {             \
+		(a * 2) + 0, (a * 2) + 1, \
+		(b * 2) + 0, (b * 2) + 1, \
+		(c * 2) + 0, (c * 2) + 1, \
+		(d * 2) + 0, (d * 2) + 1  \
+	}
+
+static SBC_ALWAYS_INLINE int sbc_enc_process_input_4s_neon_internal(
+	int position,
+	const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+	int nsamples, int nchannels, int big_endian)
+{
+	static SBC_ALIGNED uint8_t perm_be[2][8] = {
+		PERM_BE(7, 3, 6, 4),
+		PERM_BE(0, 2, 1, 5)
+	};
+	static SBC_ALIGNED uint8_t perm_le[2][8] = {
+		PERM_LE(7, 3, 6, 4),
+		PERM_LE(0, 2, 1, 5)
+	};
+	/* handle X buffer wraparound */
+	if (position < nsamples) {
+		int16_t *dst = &X[0][SBC_X_BUFFER_SIZE - 40];
+		int16_t *src = &X[0][position];
+		asm volatile (
+			"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+			"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+			"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+			"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+			"vld1.16 {d0}, [%[src], :64]!\n"
+			"vst1.16 {d0}, [%[dst], :64]!\n"
+			:
+			  [dst] "+r" (dst),
+			  [src] "+r" (src)
+			: : "memory", "d0", "d1", "d2", "d3");
+		if (nchannels > 1) {
+			dst = &X[1][SBC_X_BUFFER_SIZE - 40];
+			src = &X[1][position];
+			asm volatile (
+				"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+				"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+				"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+				"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+				"vld1.16 {d0}, [%[src], :64]!\n"
+				"vst1.16 {d0}, [%[dst], :64]!\n"
+				:
+				  [dst] "+r" (dst),
+				  [src] "+r" (src)
+				: : "memory", "d0", "d1", "d2", "d3");
+		}
+		position = SBC_X_BUFFER_SIZE - 40;
+	}
+
+	if ((nchannels > 1) && ((uintptr_t)pcm & 1)) {
+		/* poor 'pcm' alignment */
+		int16_t *x = &X[0][position];
+		int16_t *y = &X[1][position];
+		asm volatile (
+			"vld1.8  {d0, d1}, [%[perm], :128]\n"
+		"1:\n"
+			"sub     %[x], %[x], #16\n"
+			"sub     %[y], %[y], #16\n"
+			"sub     %[position], %[position], #8\n"
+			"vld1.8  {d4, d5}, [%[pcm]]!\n"
+			"vuzp.16 d4,  d5\n"
+			"vld1.8  {d20, d21}, [%[pcm]]!\n"
+			"vuzp.16 d20, d21\n"
+			"vswp    d5,  d20\n"
+			"vtbl.8  d16, {d4, d5}, d0\n"
+			"vtbl.8  d17, {d4, d5}, d1\n"
+			"vtbl.8  d18, {d20, d21}, d0\n"
+			"vtbl.8  d19, {d20, d21}, d1\n"
+			"vst1.16 {d16, d17}, [%[x], :128]\n"
+			"vst1.16 {d18, d19}, [%[y], :128]\n"
+			"subs    %[nsamples], %[nsamples], #8\n"
+			"bgt     1b\n"
+			:
+			  [x]        "+r" (x),
+			  [y]        "+r" (y),
+			  [pcm]      "+r" (pcm),
+			  [nsamples] "+r" (nsamples),
+			  [position] "+r" (position)
+			:
+			  [perm]      "r" (big_endian ? perm_be : perm_le)
+			: "cc", "memory", "d0", "d1", "d2", "d3", "d4",
+			  "d5", "d6", "d7", "d16", "d17", "d18", "d19",
+			  "d20", "d21", "d22", "d23");
+	} else if (nchannels > 1) {
+		/* proper 'pcm' alignment */
+		int16_t *x = &X[0][position];
+		int16_t *y = &X[1][position];
+		asm volatile (
+			"vld1.8  {d0, d1}, [%[perm], :128]\n"
+		"1:\n"
+			"sub     %[x], %[x], #16\n"
+			"sub     %[y], %[y], #16\n"
+			"sub     %[position], %[position], #8\n"
+			"vld2.16 {d4, d5}, [%[pcm]]!\n"
+			"vld2.16 {d20, d21}, [%[pcm]]!\n"
+			"vswp    d5, d20\n"
+			"vtbl.8  d16, {d4, d5}, d0\n"
+			"vtbl.8  d17, {d4, d5}, d1\n"
+			"vtbl.8  d18, {d20, d21}, d0\n"
+			"vtbl.8  d19, {d20, d21}, d1\n"
+			"vst1.16 {d16, d17}, [%[x], :128]\n"
+			"vst1.16 {d18, d19}, [%[y], :128]\n"
+			"subs    %[nsamples], %[nsamples], #8\n"
+			"bgt     1b\n"
+			:
+			  [x]        "+r" (x),
+			  [y]        "+r" (y),
+			  [pcm]      "+r" (pcm),
+			  [nsamples] "+r" (nsamples),
+			  [position] "+r" (position)
+			:
+			  [perm]      "r" (big_endian ? perm_be : perm_le)
+			: "cc", "memory", "d0", "d1", "d2", "d3", "d4",
+			  "d5", "d6", "d7", "d16", "d17", "d18", "d19",
+			  "d20", "d21", "d22", "d23");
+	} else {
+		int16_t *x = &X[0][position];
+		asm volatile (
+			"vld1.8  {d0, d1}, [%[perm], :128]\n"
+		"1:\n"
+			"sub     %[x], %[x], #16\n"
+			"sub     %[position], %[position], #8\n"
+			"vld1.8  {d4, d5}, [%[pcm]]!\n"
+			"vtbl.8  d16, {d4, d5}, d0\n"
+			"vtbl.8  d17, {d4, d5}, d1\n"
+			"vst1.16 {d16, d17}, [%[x], :128]\n"
+			"subs    %[nsamples], %[nsamples], #8\n"
+			"bgt     1b\n"
+			:
+			  [x]        "+r" (x),
+			  [pcm]      "+r" (pcm),
+			  [nsamples] "+r" (nsamples),
+			  [position] "+r" (position)
+			:
+			  [perm]      "r" (big_endian ? perm_be : perm_le)
+			: "cc", "memory", "d0", "d1", "d2", "d3", "d4",
+			  "d5", "d6", "d7", "d16", "d17", "d18", "d19");
+	}
+	return position;
+}
+
+static SBC_ALWAYS_INLINE int sbc_enc_process_input_8s_neon_internal(
+	int position,
+	const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
+	int nsamples, int nchannels, int big_endian)
+{
+	static SBC_ALIGNED uint8_t perm_be[4][8] = {
+		PERM_BE(15, 7, 14, 8),
+		PERM_BE(13, 9, 12, 10),
+		PERM_BE(11, 3, 6,  0),
+		PERM_BE(5,  1, 4,  2)
+	};
+	static SBC_ALIGNED uint8_t perm_le[4][8] = {
+		PERM_LE(15, 7, 14, 8),
+		PERM_LE(13, 9, 12, 10),
+		PERM_LE(11, 3, 6,  0),
+		PERM_LE(5,  1, 4,  2)
+	};
+	/* handle X buffer wraparound */
+	if (position < nsamples) {
+		int16_t *dst = &X[0][SBC_X_BUFFER_SIZE - 72];
+		int16_t *src = &X[0][position];
+		asm volatile (
+			"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+			"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+			"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+			"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+			"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+			"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+			"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+			"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+			"vld1.16 {d0, d1}, [%[src], :128]!\n"
+			"vst1.16 {d0, d1}, [%[dst], :128]!\n"
+			:
+			  [dst] "+r" (dst),
+			  [src] "+r" (src)
+			: : "memory", "d0", "d1", "d2", "d3");
+		if (nchannels > 1) {
+			dst = &X[1][SBC_X_BUFFER_SIZE - 72];
+			src = &X[1][position];
+			asm volatile (
+				"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+				"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+				"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+				"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+				"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+				"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+				"vld1.16 {d0, d1, d2, d3}, [%[src], :128]!\n"
+				"vst1.16 {d0, d1, d2, d3}, [%[dst], :128]!\n"
+				"vld1.16 {d0, d1}, [%[src], :128]!\n"
+				"vst1.16 {d0, d1}, [%[dst], :128]!\n"
+				:
+				  [dst] "+r" (dst),
+				  [src] "+r" (src)
+				: : "memory", "d0", "d1", "d2", "d3");
+		}
+		position = SBC_X_BUFFER_SIZE - 72;
+	}
+
+	if ((nchannels > 1) && ((uintptr_t)pcm & 1)) {
+		/* poor 'pcm' alignment */
+		int16_t *x = &X[0][position];
+		int16_t *y = &X[1][position];
+		asm volatile (
+			"vld1.8  {d0, d1, d2, d3}, [%[perm], :128]\n"
+		"1:\n"
+			"sub     %[x], %[x], #32\n"
+			"sub     %[y], %[y], #32\n"
+			"sub     %[position], %[position], #16\n"
+			"vld1.8  {d4, d5, d6, d7}, [%[pcm]]!\n"
+			"vuzp.16 q2,  q3\n"
+			"vld1.8  {d20, d21, d22, d23}, [%[pcm]]!\n"
+			"vuzp.16 q10, q11\n"
+			"vswp    q3,  q10\n"
+			"vtbl.8  d16, {d4, d5, d6, d7}, d0\n"
+			"vtbl.8  d17, {d4, d5, d6, d7}, d1\n"
+			"vtbl.8  d18, {d4, d5, d6, d7}, d2\n"
+			"vtbl.8  d19, {d4, d5, d6, d7}, d3\n"
+			"vst1.16 {d16, d17, d18, d19}, [%[x], :128]\n"
+			"vtbl.8  d16, {d20, d21, d22, d23}, d0\n"
+			"vtbl.8  d17, {d20, d21, d22, d23}, d1\n"
+			"vtbl.8  d18, {d20, d21, d22, d23}, d2\n"
+			"vtbl.8  d19, {d20, d21, d22, d23}, d3\n"
+			"vst1.16 {d16, d17, d18, d19}, [%[y], :128]\n"
+			"subs    %[nsamples], %[nsamples], #16\n"
+			"bgt     1b\n"
+			:
+			  [x]        "+r" (x),
+			  [y]        "+r" (y),
+			  [pcm]      "+r" (pcm),
+			  [nsamples] "+r" (nsamples),
+			  [position] "+r" (position)
+			:
+			  [perm]      "r" (big_endian ? perm_be : perm_le)
+			: "cc", "memory", "d0", "d1", "d2", "d3", "d4",
+			  "d5", "d6", "d7", "d16", "d17", "d18", "d19",
+			  "d20", "d21", "d22", "d23");
+	} else if (nchannels > 1) {
+		/* proper 'pcm' alignment */
+		int16_t *x = &X[0][position];
+		int16_t *y = &X[1][position];
+		asm volatile (
+			"vld1.8  {d0, d1, d2, d3}, [%[perm], :128]\n"
+		"1:\n"
+			"sub     %[x], %[x], #32\n"
+			"sub     %[y], %[y], #32\n"
+			"sub     %[position], %[position], #16\n"
+			"vld2.16  {d4, d5, d6, d7}, [%[pcm]]!\n"
+			"vld2.16  {d20, d21, d22, d23}, [%[pcm]]!\n"
+			"vswp    q3, q10\n"
+			"vtbl.8  d16, {d4, d5, d6, d7}, d0\n"
+			"vtbl.8  d17, {d4, d5, d6, d7}, d1\n"
+			"vtbl.8  d18, {d4, d5, d6, d7}, d2\n"
+			"vtbl.8  d19, {d4, d5, d6, d7}, d3\n"
+			"vst1.16 {d16, d17, d18, d19}, [%[x], :128]\n"
+			"vtbl.8  d16, {d20, d21, d22, d23}, d0\n"
+			"vtbl.8  d17, {d20, d21, d22, d23}, d1\n"
+			"vtbl.8  d18, {d20, d21, d22, d23}, d2\n"
+			"vtbl.8  d19, {d20, d21, d22, d23}, d3\n"
+			"vst1.16 {d16, d17, d18, d19}, [%[y], :128]\n"
+			"subs    %[nsamples], %[nsamples], #16\n"
+			"bgt     1b\n"
+			:
+			  [x]        "+r" (x),
+			  [y]        "+r" (y),
+			  [pcm]      "+r" (pcm),
+			  [nsamples] "+r" (nsamples),
+			  [position] "+r" (position)
+			:
+			  [perm]      "r" (big_endian ? perm_be : perm_le)
+			: "cc", "memory", "d0", "d1", "d2", "d3", "d4",
+			  "d5", "d6", "d7", "d16", "d17", "d18", "d19",
+			  "d20", "d21", "d22", "d23");
+	} else {
+		int16_t *x = &X[0][position];
+		asm volatile (
+			"vld1.8  {d0, d1, d2, d3}, [%[perm], :128]\n"
+		"1:\n"
+			"sub     %[x], %[x], #32\n"
+			"sub     %[position], %[position], #16\n"
+			"vld1.8  {d4, d5, d6, d7}, [%[pcm]]!\n"
+			"vtbl.8  d16, {d4, d5, d6, d7}, d0\n"
+			"vtbl.8  d17, {d4, d5, d6, d7}, d1\n"
+			"vtbl.8  d18, {d4, d5, d6, d7}, d2\n"
+			"vtbl.8  d19, {d4, d5, d6, d7}, d3\n"
+			"vst1.16 {d16, d17, d18, d19}, [%[x], :128]\n"
+			"subs    %[nsamples], %[nsamples], #16\n"
+			"bgt     1b\n"
+			:
+			  [x]        "+r" (x),
+			  [pcm]      "+r" (pcm),
+			  [nsamples] "+r" (nsamples),
+			  [position] "+r" (position)
+			:
+			  [perm]      "r" (big_endian ? perm_be : perm_le)
+			: "cc", "memory", "d0", "d1", "d2", "d3", "d4",
+			  "d5", "d6", "d7", "d16", "d17", "d18", "d19");
+	}
+	return position;
+}
+
+#undef PERM_BE
+#undef PERM_LE
+
+static int sbc_enc_process_input_4s_be_neon(int position, const uint8_t *pcm,
+					int16_t X[2][SBC_X_BUFFER_SIZE],
+					int nsamples, int nchannels)
+{
+	return sbc_enc_process_input_4s_neon_internal(
+		position, pcm, X, nsamples, nchannels, 1);
+}
+
+static int sbc_enc_process_input_4s_le_neon(int position, const uint8_t *pcm,
+					int16_t X[2][SBC_X_BUFFER_SIZE],
+					int nsamples, int nchannels)
+{
+	return sbc_enc_process_input_4s_neon_internal(
+		position, pcm, X, nsamples, nchannels, 0);
+}
+
+static int sbc_enc_process_input_8s_be_neon(int position, const uint8_t *pcm,
+					int16_t X[2][SBC_X_BUFFER_SIZE],
+					int nsamples, int nchannels)
+{
+	return sbc_enc_process_input_8s_neon_internal(
+		position, pcm, X, nsamples, nchannels, 1);
+}
+
+static int sbc_enc_process_input_8s_le_neon(int position, const uint8_t *pcm,
+					int16_t X[2][SBC_X_BUFFER_SIZE],
+					int nsamples, int nchannels)
+{
+	return sbc_enc_process_input_8s_neon_internal(
+		position, pcm, X, nsamples, nchannels, 0);
+}
+
 void sbc_init_primitives_neon(struct sbc_encoder_state *state)
 {
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_neon;
 	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_neon;
 	state->sbc_calc_scalefactors = sbc_calc_scalefactors_neon;
 	state->sbc_calc_scalefactors_j = sbc_calc_scalefactors_j_neon;
+	state->sbc_enc_process_input_4s_le = sbc_enc_process_input_4s_le_neon;
+	state->sbc_enc_process_input_4s_be = sbc_enc_process_input_4s_be_neon;
+	state->sbc_enc_process_input_8s_le = sbc_enc_process_input_8s_le_neon;
+	state->sbc_enc_process_input_8s_be = sbc_enc_process_input_8s_be_neon;
 	state->implementation_info = "NEON";
 }
 
-- 
1.6.4.4

