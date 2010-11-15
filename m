Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201011121522.51428.siarhei.siamashka@gmail.com>
References: <AANLkTikPiwr+OtsDVbgoya281Zncg0P5Joq_v0UCzZDi@mail.gmail.com>
	<201011111346.58906.siarhei.siamashka@gmail.com>
	<AANLkTi=rVvmwXwtZgMgwfBigyFXKsWRGy==rdcVjkitW@mail.gmail.com>
	<201011121522.51428.siarhei.siamashka@gmail.com>
Date: Mon, 15 Nov 2010 10:46:25 +0800
Message-ID: <AANLkTimQR5wMTTEO6KGuv3YvPBaftO-i+96WKYQEOzFU@mail.gmail.com>
Subject: Re: [PATCH v3] Add iwmmxt optimization for sbc for pxa series cpu
From: Keith Mok <ek9852@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> I sometimes use different indentation levels in such cases in order to improve
> readability after instructions reordering, so that each logically independent
> block of code has its own indentation level and it is still easily visible
> after instructions reordering. For example, with the original code:
Thanks for the hints. I rearranged the code.


> Not so much, but every little bit
> helps. And if for iwmmxt it causes such backwards compatibility issues, then it
> might be not worth it. It's up to you to decide.
I removed the scale_factor optimization since from the result I
tested, it shows little help in performance.


> Regarding the benchmarks and functions usage:
> 1. sbc_analyze_four_iwmmxt is important for 4 subbands case ('-s4' option for
> sbcenc)
> 2. sbc_analyze_eight_iwmmxt is important for 8 subbands case ('-s8' option for
> sbcenc)
===  Before (4 bands) ====
$ time  ./sbcenc_orig  -s 4     long.au  > /dev/null
real    0m 2.44s
user    0m 2.39s
sys     0m 0.05s
===  After (4 bands) ====
$ time  ./sbcenc  -s 4     long.au  > /dev/null
real    0m 1.59s
user    0m 1.49s
sys     0m 0.10s


===  Before (8 bands) ====
$ time  ./sbcenc_orig   -s 8     long.au  > /dev/null
real    0m 4.05s
user    0m 3.98s
sys     0m 0.07s
===  After (8 bands) ====
$ time  ./sbcenc  -s 8     long.au  > /dev/null
real    0m 1.48s
user    0m 1.41s
sys     0m 0.06s


===  Before (a2dp usage) ====
$ time  ./sbcenc_orig   -b53 -s8 -j    long.au  > /dev/null
real    0m 4.51s
user    0m 4.41s
sys     0m 0.10s
===  After (a2dp usage) ====
$ time  ./sbcenc   -b53 -s8 -j    long.au  > /dev/null
real    0m 2.05s
user    0m 1.99s
sys     0m 0.06s


Keith


Signed-off-by: Keith Mok <ek9852@gmail.com>
---
 Makefile.am                 |    1 +
 sbc/sbc_primitives.c        |    4 +
 sbc/sbc_primitives_iwmmxt.c |  301 +++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives_iwmmxt.h |   38 ++++++
 4 files changed, 344 insertions(+), 0 deletions(-)
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
index 0000000..fc462d2
--- /dev/null
+++ b/sbc/sbc_primitives_iwmmxt.c
@@ -0,0 +1,301 @@
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
+		"wldrd        wr0, [%0]\n"
+		"tbcstw       wr4, %2\n"
+		"wldrd        wr2, [%1]\n"
+		"wldrd        wr1, [%0, #8]\n"
+		"wldrd        wr3, [%1, #8]\n"
+		"wmadds       wr0, wr2, wr0\n"
+		" wldrd       wr6, [%0, #16]\n"
+		"wmadds       wr1, wr3, wr1\n"
+		" wldrd       wr7, [%0, #24]\n"
+		"waddwss      wr0, wr0, wr4\n"
+		" wldrd       wr8, [%1, #16]\n"
+		"waddwss      wr1, wr1, wr4\n"
+		" wldrd       wr9, [%1, #24]\n"
+		" wmadds      wr6, wr8, wr6\n"
+		"  wldrd      wr2, [%0, #32]\n"
+		" wmadds      wr7, wr9, wr7\n"
+		"  wldrd      wr3, [%0, #40]\n"
+		" waddwss     wr0, wr6, wr0\n"
+		"  wldrd      wr4, [%1, #32]\n"
+		" waddwss     wr1, wr7, wr1\n"
+		"  wldrd      wr5, [%1, #40]\n"
+		"  wmadds     wr2, wr4, wr2\n"
+		"wldrd        wr6, [%0, #48]\n"
+		"  wmadds     wr3, wr5, wr3\n"
+		"wldrd        wr7, [%0, #56]\n"
+		"  waddwss    wr0, wr2, wr0\n"
+		"wldrd        wr8, [%1, #48]\n"
+		"  waddwss    wr1, wr3, wr1\n"
+		"wldrd        wr9, [%1, #56]\n"
+		"wmadds       wr6, wr8, wr6\n"
+		" wldrd       wr2, [%0, #64]\n"
+		"wmadds       wr7, wr9, wr7\n"
+		" wldrd       wr3, [%0, #72]\n"
+		"waddwss      wr0, wr6, wr0\n"
+		" wldrd       wr4, [%1, #64]\n"
+		"waddwss      wr1, wr7, wr1\n"
+		" wldrd       wr5, [%1, #72]\n"
+		" wmadds      wr2, wr4, wr2\n"
+		"tmcr       wcgr0, %4\n"
+		" wmadds      wr3, wr5, wr3\n"
+		" waddwss     wr0, wr2, wr0\n"
+		" waddwss     wr1, wr3, wr1\n"
+		"\n"
+		"wsrawg       wr0, wr0, wcgr0\n"
+		" wldrd       wr4, [%1, #80]\n"
+		"wsrawg       wr1, wr1, wcgr0\n"
+		" wldrd       wr5, [%1, #88]\n"
+		"wpackwss     wr0, wr0, wr0\n"
+		" wldrd       wr6, [%1, #96]\n"
+		"wpackwss     wr1, wr1, wr1\n"
+		"wmadds       wr2, wr5, wr0\n"
+		" wldrd       wr7, [%1, #104]\n"
+		"wmadds       wr0, wr4, wr0\n"
+		"\n"
+		" wmadds      wr3, wr7, wr1\n"
+		" wmadds      wr1, wr6, wr1\n"
+		" waddwss     wr2, wr3, wr2\n"
+		" waddwss     wr0, wr1, wr0\n"
+		"\n"
+		"wstrd        wr0, [%3]\n"
+		"wstrd        wr2, [%3, #8]\n"
+		:
+		: "r" (in), "r" (consts),
+			"r" (1 << (SBC_PROTO_FIXED4_SCALE - 1)), "r" (out),
+			"r" (SBC_PROTO_FIXED4_SCALE)
+		: "wr0", "wr1", "wr2", "wr3", "wr4", "wr5", "wr6", "wr7",
+		  "wr8", "wr9", "wcgr0", "memory");
+}
+
+static inline void sbc_analyze_eight_iwmmxt(const int16_t *in, int32_t *out,
+							const FIXED_T *consts)
+{
+	asm volatile (
+		"wldrd        wr0, [%0]\n"
+		"tbcstw       wr15, %2\n"
+		"wldrd        wr1, [%0, #8]\n"
+		"wldrd        wr2, [%0, #16]\n"
+		"wldrd        wr3, [%0, #24]\n"
+		"wldrd        wr4, [%1]\n"
+		"wldrd        wr5, [%1, #8]\n"
+		"wldrd        wr6, [%1, #16]\n"
+		"wldrd        wr7, [%1, #24]\n"
+		"wmadds       wr0, wr0, wr4\n"
+		" wldrd       wr8, [%1, #32]\n"
+		"wmadds       wr1, wr1, wr5\n"
+		" wldrd       wr9, [%1, #40]\n"
+		"wmadds       wr2, wr2, wr6\n"
+		" wldrd      wr10, [%1, #48]\n"
+		"wmadds       wr3, wr3, wr7\n"
+		" wldrd      wr11, [%1, #56]\n"
+		"waddwss      wr0, wr0, wr15\n"
+		" wldrd       wr4, [%0, #32]\n"
+		"waddwss      wr1, wr1, wr15\n"
+		" wldrd       wr5, [%0, #40]\n"
+		"waddwss      wr2, wr2, wr15\n"
+		" wldrd       wr6, [%0, #48]\n"
+		"waddwss      wr3, wr3, wr15\n"
+		" wldrd       wr7, [%0, #56]\n"
+		" wmadds      wr4, wr4, wr8\n"
+		"  wldrd     wr12, [%0, #64]\n"
+		" wmadds      wr5, wr5, wr9\n"
+		"  wldrd     wr13, [%0, #72]\n"
+		" wmadds      wr6, wr6, wr10\n"
+		"  wldrd     wr14, [%0, #80]\n"
+		" wmadds      wr7, wr7, wr11\n"
+		"  wldrd     wr15, [%0, #88]\n"
+		" waddwss     wr0, wr4, wr0\n"
+		"  wldrd      wr8, [%1, #64]\n"
+		" waddwss     wr1, wr5, wr1\n"
+		"  wldrd      wr9, [%1, #72]\n"
+		" waddwss     wr2, wr6, wr2\n"
+		"  wldrd     wr10, [%1, #80]\n"
+		" waddwss     wr3, wr7, wr3\n"
+		"  wldrd     wr11, [%1, #88]\n"
+		"  wmadds    wr12, wr12, wr8\n"
+		"wldrd        wr4, [%0, #96]\n"
+		"  wmadds    wr13, wr13, wr9\n"
+		"wldrd        wr5, [%0, #104]\n"
+		"  wmadds    wr14, wr14, wr10\n"
+		"wldrd        wr6, [%0, #112]\n"
+		"  wmadds    wr15, wr15, wr11\n"
+		"wldrd        wr7, [%0, #120]\n"
+		"  waddwss    wr0, wr12, wr0\n"
+		"wldrd        wr8, [%1, #96]\n"
+		"  waddwss    wr1, wr13, wr1\n"
+		"wldrd        wr9, [%1, #104]\n"
+		"  waddwss    wr2, wr14, wr2\n"
+		"wldrd       wr10, [%1, #112]\n"
+		"  waddwss    wr3, wr15, wr3\n"
+		"wldrd       wr11, [%1, #120]\n"
+		"wmadds       wr4, wr4, wr8\n"
+		" wldrd      wr12, [%0, #128]\n"
+		"wmadds       wr5, wr5, wr9\n"
+		" wldrd      wr13, [%0, #136]\n"
+		"wmadds       wr6, wr6, wr10\n"
+		" wldrd      wr14, [%0, #144]\n"
+		"wmadds       wr7, wr7, wr11\n"
+		" wldrd      wr15, [%0, #152]\n"
+		"waddwss      wr0, wr4, wr0\n"
+		" wldrd       wr8, [%1, #128]\n"
+		"waddwss      wr1, wr5, wr1\n"
+		" wldrd       wr9, [%1, #136]\n"
+		"waddwss      wr2, wr6, wr2\n"
+		" wldrd      wr10, [%1, #144]\n"
+		" waddwss     wr3, wr7, wr3\n"
+		" wldrd     wr11, [%1, #152]\n"
+		" wmadds     wr12, wr12, wr8\n"
+		"tmcr       wcgr0, %4\n"
+		" wmadds     wr13, wr13, wr9\n"
+		" wmadds     wr14, wr14, wr10\n"
+		" wmadds     wr15, wr15, wr11\n"
+		" waddwss     wr0, wr12, wr0\n"
+		" waddwss     wr1, wr13, wr1\n"
+		" waddwss     wr2, wr14, wr2\n"
+		" waddwss     wr3, wr15, wr3\n"
+		"\n"
+		"wsrawg       wr0, wr0, wcgr0\n"
+		"wsrawg       wr1, wr1, wcgr0\n"
+		"wsrawg       wr2, wr2, wcgr0\n"
+		"wsrawg       wr3, wr3, wcgr0\n"
+		"\n"
+		"wpackwss     wr0, wr0, wr0\n"
+		"wpackwss     wr1, wr1, wr1\n"
+		" wldrd       wr4, [%1, #160]\n"
+		"wpackwss     wr2, wr2, wr2\n"
+		" wldrd       wr5, [%1, #168]\n"
+		"wpackwss     wr3, wr3, wr3\n"
+		"  wldrd      wr6, [%1, #192]\n"
+		" wmadds      wr4, wr4, wr0\n"
+		"  wldrd      wr7, [%1, #200]\n"
+		" wmadds      wr5, wr5, wr0\n"
+		"   wldrd     wr8, [%1, #224]\n"
+		"  wmadds     wr6, wr6, wr1\n"
+		"   wldrd     wr9, [%1, #232]\n"
+		"  wmadds     wr7, wr7, wr1\n"
+		"  waddwss    wr4, wr6, wr4\n"
+		"  waddwss    wr5, wr7, wr5\n"
+		"   wmadds    wr8, wr8, wr2\n"
+		"wldrd        wr6, [%1, #256]\n"
+		"   wmadds    wr9, wr9, wr2\n"
+		"wldrd        wr7, [%1, #264]\n"
+		"waddwss      wr4, wr8, wr4\n"
+		"   waddwss   wr5, wr9, wr5\n"
+		"wmadds       wr6, wr6, wr3\n"
+		"wmadds       wr7, wr7, wr3\n"
+		"waddwss      wr4, wr6, wr4\n"
+		"waddwss      wr5, wr7, wr5\n"
+		"\n"
+		"wstrd        wr4, [%3]\n"
+		"wstrd        wr5, [%3, #8]\n"
+		"\n"
+		"wldrd        wr6, [%1, #176]\n"
+		"wldrd        wr5, [%1, #184]\n"
+		"wmadds       wr5, wr5, wr0\n"
+		"wldrd        wr8, [%1, #208]\n"
+		"wmadds       wr0, wr6, wr0\n"
+		"wldrd        wr9, [%1, #216]\n"
+		"wmadds       wr9, wr9, wr1\n"
+		"wldrd        wr6, [%1, #240]\n"
+		"wmadds       wr1, wr8, wr1\n"
+		"wldrd        wr7, [%1, #248]\n"
+		"waddwss      wr0, wr1, wr0\n"
+		"waddwss      wr5, wr9, wr5\n"
+		"wmadds       wr7, wr7, wr2\n"
+		"wldrd        wr8, [%1, #272]\n"
+		"wmadds       wr2, wr6, wr2\n"
+		"wldrd        wr9, [%1, #280]\n"
+		"waddwss      wr0, wr2, wr0\n"
+		"waddwss      wr5, wr7, wr5\n"
+		"wmadds       wr9, wr9, wr3\n"
+		"wmadds       wr3, wr8, wr3\n"
+		"waddwss      wr0, wr3, wr0\n"
+		"waddwss      wr5, wr9, wr5\n"
+		"\n"
+		"wstrd        wr0, [%3, #16]\n"
+		"wstrd        wr5, [%3, #24]\n"
+		:
+		: "r" (in), "r" (consts),
+			"r" (1 << (SBC_PROTO_FIXED8_SCALE - 1)), "r" (out),
+			"r" (SBC_PROTO_FIXED8_SCALE)
+		: "wr0", "wr1", "wr2", "wr3", "wr4", "wr5", "wr6", "wr7",
+		  "wr8", "wr9", "wr10", "wr11", "wr12", "wr13", "wr14", "wr15",
+		  "wcgr0", "memory");
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
+void sbc_init_primitives_iwmmxt(struct sbc_encoder_state *state)
+{
+	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_iwmmxt;
+	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_iwmmxt;
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
