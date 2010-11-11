Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 11 Nov 2010 16:05:46 +0800
Message-ID: <AANLkTikPiwr+OtsDVbgoya281Zncg0P5Joq_v0UCzZDi@mail.gmail.com>
Subject: [PATCH] Add iwmmxt optimization for sbc for pxa series cpu
From: Keith Mok <ek9852@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch add iwmmxt (Intel wireless mmx, pxa platform) optimzation
for sbc, based on the mmx code.
Have verified the encoded result against the mmx generated one.

Keith

Signed-off-by: Keith Mok <ek9852@gmail.com>
---
 Makefile.am                 |    1 +
 sbc/sbc_primitives.c        |    4 +
 sbc/sbc_primitives_iwmmxt.c |  361 +++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives_iwmmxt.h |   38 +++++
 4 files changed, 404 insertions(+), 0 deletions(-)
 create mode 100644 sbc/sbc_primitives_iwmmxt.c
 create mode 100644 sbc/sbc_primitives_iwmmxt.h

diff --git a/Makefile.am b/Makefile.am
index da308a7..03a9bf2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -65,6 +65,7 @@ noinst_LTLIBRARIES += sbc/libsbc.la
 sbc_libsbc_la_SOURCES = sbc/sbc.h sbc/sbc.c sbc/sbc_math.h sbc/sbc_tables.h \
 			sbc/sbc_primitives.h sbc/sbc_primitives.c \
 			sbc/sbc_primitives_mmx.h sbc/sbc_primitives_mmx.c \
+			sbc/sbc_primitives_iwmmxt.h sbc/sbc_primitives_iwmmxt.c \
 			sbc/sbc_primitives_neon.h sbc/sbc_primitives_neon.c \
 			sbc/sbc_primitives_armv6.h sbc/sbc_primitives_armv6.c

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index f87fb5a..ad780d0 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -33,6 +33,7 @@

 #include "sbc_primitives.h"
 #include "sbc_primitives_mmx.h"
+#include "sbc_primitives_iwmmxt.h"
 #include "sbc_primitives_neon.h"
 #include "sbc_primitives_armv6.h"

@@ -544,6 +545,9 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 #ifdef SBC_BUILD_WITH_ARMV6_SUPPORT
 	sbc_init_primitives_armv6(state);
 #endif
+#ifdef SBC_BUILD_WITH_IWMMXT_SUPPORT
+	sbc_init_primitives_iwmmxt(state);
+#endif
 #ifdef SBC_BUILD_WITH_NEON_SUPPORT
 	sbc_init_primitives_neon(state);
 #endif
diff --git a/sbc/sbc_primitives_iwmmxt.c b/sbc/sbc_primitives_iwmmxt.c
new file mode 100644
index 0000000..4825998
--- /dev/null
+++ b/sbc/sbc_primitives_iwmmxt.c
@@ -0,0 +1,361 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2010 Keith Mok <ek9852@gmail.com>
+ *  Based on sbc_primitives_mmx.c
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdint.h>
+#include <limits.h>
+#include "sbc.h"
+#include "sbc_math.h"
+#include "sbc_tables.h"
+
+#include "sbc_primitives_iwmmxt.h"
+
+/*
+ * IWMMXT optimizations
+ */
+
+#ifdef SBC_BUILD_WITH_IWMMXT_SUPPORT
+
+static inline void sbc_analyze_four_iwmmxt(const int16_t *in, int32_t *out,
+					const FIXED_T *consts)
+{
+	asm volatile (
+		"tbcstw       wr4, %2\n"
+		"wldrd        wr0, [%0]\n"
+		"wldrd        wr1, [%0, #8]\n"
+		"wldrd        wr2, [%1]\n"
+		"wldrd        wr3, [%1, #8]\n"
+		"wmadds       wr0, wr2, wr0\n"
+		"wmadds       wr1, wr3, wr1\n"
+		"waddwss      wr0, wr0, wr4\n"
+		"waddwss      wr1, wr1, wr4\n"
+		"\n"
+		"wldrd        wr2, [%0, #16]\n"
+		"wldrd        wr3, [%0, #24]\n"
+		"wldrd        wr4, [%1, #16]\n"
+		"wldrd        wr5, [%1, #24]\n"
+		"wmadds       wr2, wr4, wr2\n"
+		"wmadds       wr3, wr5, wr3\n"
+		"waddwss      wr0, wr2, wr0\n"
+		"waddwss      wr1, wr3, wr1\n"
+		"\n"
+		"wldrd        wr2, [%0, #32]\n"
+		"wldrd        wr3, [%0, #40]\n"
+		"wldrd        wr4, [%1, #32]\n"
+		"wldrd        wr5, [%1, #40]\n"
+		"wmadds       wr2, wr4, wr2\n"
+		"wmadds       wr3, wr5, wr3\n"
+		"waddwss      wr0, wr2, wr0\n"
+		"waddwss      wr1, wr3, wr1\n"
+		"\n"
+		"wldrd        wr2, [%0, #48]\n"
+		"wldrd        wr3, [%0, #56]\n"
+		"wldrd        wr4, [%1, #48]\n"
+		"wldrd        wr5, [%1, #56]\n"
+		"wmadds       wr2, wr4, wr2\n"
+		"wmadds       wr3, wr5, wr3\n"
+		"waddwss      wr0, wr2, wr0\n"
+		"waddwss      wr1, wr3, wr1\n"
+		"\n"
+		"wldrd        wr2, [%0, #64]\n"
+		"wldrd        wr3, [%0, #72]\n"
+		"wldrd        wr4, [%1, #64]\n"
+		"wldrd        wr5, [%1, #72]\n"
+		"wmadds       wr2, wr4, wr2\n"
+		"wmadds       wr3, wr5, wr3\n"
+		"waddwss      wr0, wr2, wr0\n"
+		"waddwss      wr1, wr3, wr1\n"
+		"\n"
+		"tmcr       wcgr0, %4\n"
+		"wsrawg       wr0, wr0, wcgr0\n"
+		"wsrawg       wr1, wr1, wcgr0\n"
+		"wpackwss     wr0, wr0, wr0\n"
+		"wpackwss     wr1, wr1, wr1\n"
+		"\n"
+		"wldrd        wr4, [%1, #80]\n"
+		"wldrd        wr5, [%1, #88]\n"
+		"wldrd        wr6, [%1, #96]\n"
+		"wldrd        wr7, [%1, #104]\n"
+		"wmadds       wr2, wr5, wr0\n"
+		"wmadds       wr0, wr4, wr0\n"
+		"\n"
+		"wmadds       wr3, wr7, wr1\n"
+		"wmadds       wr1, wr6, wr1\n"
+		"waddwss      wr0, wr1, wr0\n"
+		"waddwss      wr2, wr3, wr2\n"
+		"\n"
+		"wstrd        wr0, [%3]\n"
+		"wstrd        wr2, [%3, #8]\n"
+		:
+		: "r" (in), "r" (consts),
+			"r" (1 << (SBC_PROTO_FIXED4_SCALE - 1)), "r" (out),
+			"r" (SBC_PROTO_FIXED4_SCALE)
+		: "memory");
+}
+
+static inline void sbc_analyze_eight_iwmmxt(const int16_t *in, int32_t *out,
+							const FIXED_T *consts)
+{
+	asm volatile (
+		"tbcstw       wr8, %2\n"
+		"wldrd        wr0, [%0]\n"
+		"wldrd        wr1, [%0, #8]\n"
+		"wldrd        wr2, [%0, #16]\n"
+		"wldrd        wr3, [%0, #24]\n"
+		"wldrd        wr4, [%1]\n"
+		"wldrd        wr5, [%1, #8]\n"
+		"wldrd        wr6, [%1, #16]\n"
+		"wldrd        wr7, [%1, #24]\n"
+		"wmadds       wr0, wr0, wr4\n"
+		"wmadds       wr1, wr1, wr5\n"
+		"wmadds       wr2, wr2, wr6\n"
+		"wmadds       wr3, wr3, wr7\n"
+		"waddwss      wr0, wr0, wr8\n"
+		"waddwss      wr1, wr1, wr8\n"
+		"waddwss      wr2, wr2, wr8\n"
+		"waddwss      wr3, wr3, wr8\n"
+		"\n"
+		"wldrd        wr4, [%0, #32]\n"
+		"wldrd        wr5, [%0, #40]\n"
+		"wldrd        wr6, [%0, #48]\n"
+		"wldrd        wr7, [%0, #56]\n"
+		"wldrd        wr8, [%1, #32]\n"
+		"wldrd        wr9, [%1, #40]\n"
+		"wldrd       wr10, [%1, #48]\n"
+		"wldrd       wr11, [%1, #56]\n"
+		"wmadds       wr4, wr4, wr8\n"
+		"wmadds       wr5, wr5, wr9\n"
+		"wmadds       wr6, wr6, wr10\n"
+		"wmadds       wr7, wr7, wr11\n"
+		"waddwss      wr0, wr4, wr0\n"
+		"waddwss      wr1, wr5, wr1\n"
+		"waddwss      wr2, wr6, wr2\n"
+		"waddwss      wr3, wr7, wr3\n"
+		"\n"
+		"wldrd        wr4, [%0, #64]\n"
+		"wldrd        wr5, [%0, #72]\n"
+		"wldrd        wr6, [%0, #80]\n"
+		"wldrd        wr7, [%0, #88]\n"
+		"wldrd        wr8, [%1, #64]\n"
+		"wldrd        wr9, [%1, #72]\n"
+		"wldrd       wr10, [%1, #80]\n"
+		"wldrd       wr11, [%1, #88]\n"
+		"wmadds       wr4, wr4, wr8\n"
+		"wmadds       wr5, wr5, wr9\n"
+		"wmadds       wr6, wr6, wr10\n"
+		"wmadds       wr7, wr7, wr11\n"
+		"waddwss      wr0, wr4, wr0\n"
+		"waddwss      wr1, wr5, wr1\n"
+		"waddwss      wr2, wr6, wr2\n"
+		"waddwss      wr3, wr7, wr3\n"
+		"\n"
+		"wldrd        wr4, [%0, #96]\n"
+		"wldrd        wr5, [%0, #104]\n"
+		"wldrd        wr6, [%0, #112]\n"
+		"wldrd        wr7, [%0, #120]\n"
+		"wldrd        wr8, [%1, #96]\n"
+		"wldrd        wr9, [%1, #104]\n"
+		"wldrd       wr10, [%1, #112]\n"
+		"wldrd       wr11, [%1, #120]\n"
+		"wmadds       wr4, wr4, wr8\n"
+		"wmadds       wr5, wr5, wr9\n"
+		"wmadds       wr6, wr6, wr10\n"
+		"wmadds       wr7, wr7, wr11\n"
+		"waddwss      wr0, wr4, wr0\n"
+		"waddwss      wr1, wr5, wr1\n"
+		"waddwss      wr2, wr6, wr2\n"
+		"waddwss      wr3, wr7, wr3\n"
+		"\n"
+		"wldrd        wr4, [%0, #128]\n"
+		"wldrd        wr5, [%0, #136]\n"
+		"wldrd        wr6, [%0, #144]\n"
+		"wldrd        wr7, [%0, #152]\n"
+		"wldrd        wr8, [%1, #128]\n"
+		"wldrd        wr9, [%1, #136]\n"
+		"wldrd       wr10, [%1, #144]\n"
+		"wldrd       wr11, [%1, #152]\n"
+		"wmadds       wr4, wr4, wr8\n"
+		"wmadds       wr5, wr5, wr9\n"
+		"wmadds       wr6, wr6, wr10\n"
+		"wmadds       wr7, wr7, wr11\n"
+		"waddwss      wr0, wr4, wr0\n"
+		"waddwss      wr1, wr5, wr1\n"
+		"waddwss      wr2, wr6, wr2\n"
+		"waddwss      wr3, wr7, wr3\n"
+		"\n"
+		"tmcr       wcgr0, %4\n"
+		"wsrawg       wr0, wr0, wcgr0\n"
+		"wsrawg       wr1, wr1, wcgr0\n"
+		"wsrawg       wr2, wr2, wcgr0\n"
+		"wsrawg       wr3, wr3, wcgr0\n"
+		"\n"
+		"wpackwss     wr0, wr0, wr0\n"
+		"wpackwss     wr1, wr1, wr1\n"
+		"wpackwss     wr2, wr2, wr2\n"
+		"wpackwss     wr3, wr3, wr3\n"
+		"\n"
+		"wldrd        wr4, [%1, #160]\n"
+		"wldrd        wr5, [%1, #168]\n"
+		"wmadds       wr4, wr4, wr0\n"
+		"wmadds       wr5, wr5, wr0\n"
+		"\n"
+		"wldrd        wr6, [%1, #192]\n"
+		"wldrd        wr7, [%1, #200]\n"
+		"wmadds       wr6, wr6, wr1\n"
+		"wmadds       wr7, wr7, wr1\n"
+		"waddwss      wr4, wr6, wr4\n"
+		"waddwss      wr5, wr7, wr5\n"
+		"\n"
+		"wldrd        wr6, [%1, #224]\n"
+		"wldrd        wr7, [%1, #232]\n"
+		"wmadds       wr6, wr6, wr2\n"
+		"wmadds       wr7, wr7, wr2\n"
+		"waddwss      wr4, wr6, wr4\n"
+		"waddwss      wr5, wr7, wr5\n"
+		"\n"
+		"wldrd        wr6, [%1, #256]\n"
+		"wldrd        wr7, [%1, #264]\n"
+		"wmadds       wr6, wr6, wr3\n"
+		"wmadds       wr7, wr7, wr3\n"
+		"waddwss      wr4, wr6, wr4\n"
+		"waddwss      wr5, wr7, wr5\n"
+		"\n"
+		"wstrd        wr4, [%3]\n"
+		"wstrd        wr5, [%3, #8]\n"
+		"\n"
+		"wldrd        wr4, [%1, #176]\n"
+		"wldrd        wr5, [%1, #184]\n"
+		"wmadds       wr5, wr5, wr0\n"
+		"wmadds       wr0, wr4, wr0\n"
+		"\n"
+		"wldrd        wr4, [%1, #208]\n"
+		"wldrd        wr7, [%1, #216]\n"
+		"wmadds       wr7, wr7, wr1\n"
+		"wmadds       wr1, wr4, wr1\n"
+		"waddwss      wr0, wr1, wr0\n"
+		"waddwss      wr5, wr7, wr5\n"
+		"\n"
+		"wldrd        wr4, [%1, #240]\n"
+		"wldrd        wr7, [%1, #248]\n"
+		"wmadds       wr7, wr7, wr2\n"
+		"wmadds       wr2, wr4, wr2\n"
+		"waddwss      wr0, wr2, wr0\n"
+		"waddwss      wr5, wr7, wr5\n"
+		"\n"
+		"wldrd        wr4, [%1, #272]\n"
+		"wldrd        wr7, [%1, #280]\n"
+		"wmadds       wr7, wr7, wr3\n"
+		"wmadds       wr3, wr4, wr3\n"
+		"waddwss      wr0, wr3, wr0\n"
+		"waddwss      wr5, wr7, wr5\n"
+		"\n"
+		"wstrd        wr0, [%3, #16]\n"
+		"wstrd        wr5, [%3, #24]\n"
+		:
+		: "r" (in), "r" (consts),
+			"r" (1 << (SBC_PROTO_FIXED8_SCALE - 1)), "r" (out),
+			"r" (SBC_PROTO_FIXED8_SCALE)
+		: "memory");
+}
+
+static inline void sbc_analyze_4b_4s_iwmmxt(int16_t *x, int32_t *out,
+						int out_stride)
+{
+	/* Analyze blocks */
+	sbc_analyze_four_iwmmxt(x + 12, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four_iwmmxt(x + 8, out, analysis_consts_fixed4_simd_even);
+	out += out_stride;
+	sbc_analyze_four_iwmmxt(x + 4, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four_iwmmxt(x + 0, out, analysis_consts_fixed4_simd_even);
+}
+
+static inline void sbc_analyze_4b_8s_iwmmxt(int16_t *x, int32_t *out,
+						int out_stride)
+{
+	/* Analyze blocks */
+	sbc_analyze_eight_iwmmxt(x + 24, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight_iwmmxt(x + 16, out, analysis_consts_fixed8_simd_even);
+	out += out_stride;
+	sbc_analyze_eight_iwmmxt(x + 8, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight_iwmmxt(x + 0, out, analysis_consts_fixed8_simd_even);
+}
+
+static void sbc_calc_scalefactors_iwmmxt(
+	int32_t sb_sample_f[16][2][8],
+	uint32_t scale_factor[2][8],
+	int blocks, int channels, int subbands)
+{
+	int ch, sb;
+	intptr_t blk;
+	for (ch = 0; ch < channels; ch++) {
+		for (sb = 0; sb < subbands; sb += 2) {
+			int b;
+			blk = &sb_sample_f[0][ch][sb];
+			b = blocks;
+			asm volatile (
+				"tbcstw       wr0, %4\n"
+			"1:\n"
+				"wldrd        wr1, [%0], %2\n"
+				"wxor         wr2, wr2, wr2\n"
+				"wcmpgtsw     wr3, wr1, wr2\n"
+				"waddwss      wr1, wr1, wr3\n"
+				"wcmpgtsw     wr2, wr2, wr1\n"
+				"wxor         wr1, wr1, wr2\n"
+
+				"wor          wr0, wr0, wr1\n"
+
+				"subs         %1, %1, #1\n"
+				"bne          1b\n"
+
+				"tmrrc        %0, %1, wr0\n"
+				"clz          %0, %0\n"
+				"rsb          %0, %0, %5\n"
+				"str          %0, [%3]\n"
+
+				"clz          %1, %1\n"
+				"rsb          %1, %1, %5\n"
+				"str          %1, [%3, #4]\n"
+			: "+&r" (blk), "+&r" (b)
+			: "i" ((char *) &sb_sample_f[1][0][0] -
+				(char *) &sb_sample_f[0][0][0]),
+				"r" (&scale_factor[ch][sb]),
+				"r" (1 << SCALE_OUT_BITS),
+				"i" (SCALE_OUT_BITS+1)
+			: "memory");
+		}
+	}
+}
+
+void sbc_init_primitives_iwmmxt(struct sbc_encoder_state *state)
+{
+	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_iwmmxt;
+	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_iwmmxt;
+	state->sbc_calc_scalefactors = sbc_calc_scalefactors_iwmmxt;
+	state->implementation_info = "IWMMXT";
+}
+
+#endif
diff --git a/sbc/sbc_primitives_iwmmxt.h b/sbc/sbc_primitives_iwmmxt.h
new file mode 100644
index 0000000..827d811
--- /dev/null
+++ b/sbc/sbc_primitives_iwmmxt.h
@@ -0,0 +1,38 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Based on sbc_primitives_mmx.c
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifndef __SBC_PRIMITIVES_IWMMXT_H
+#define __SBC_PRIMITIVES_IWMMXT_H
+
+#include "sbc_primitives.h"
+
+#if defined(__GNUC__) && defined(__IWMMXT__) && \
+		!defined(SBC_HIGH_PRECISION) && (SCALE_OUT_BITS == 15)
+
+#define SBC_BUILD_WITH_IWMMXT_SUPPORT
+
+void sbc_init_primitives_iwmmxt(struct sbc_encoder_state *encoder_state);
+
+#endif
+
+#endif
-- 
1.6.3.3
