Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Subject: [PATCH 5/5] sbc: ARMv6 optimized version of analysis filter for SBC encoder
Date: Fri,  2 Jul 2010 15:25:42 +0300
Message-Id: <1278073542-14859-6-git-send-email-siarhei.siamashka@gmail.com>
In-Reply-To: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1278073542-14859-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Siarhei Siamashka <siarhei.siamashka@nokia.com>

The optimized filter gets enabled when the code is compiled
with -mcpu=/-march options set to target the processors which
support ARMv6 instructions. This code is also disabled when
NEON is used (which is a lot better alternative). For additional
safety ARM EABI is required and thumb mode should not be used.

Benchmarks from ARM11:

== 8 subbands ==

$ time ./sbcenc -b53 -s8 -j test.au > /dev/null

real    0m 35.65s
user    0m 34.17s
sys     0m 1.28s

$ time ./sbcenc.armv6 -b53 -s8 -j test.au > /dev/null

real    0m 17.29s
user    0m 15.47s
sys     0m 0.67s

== 4 subbands ==

$ time ./sbcenc -b53 -s4 -j test.au > /dev/null

real    0m 25.28s
user    0m 23.76s
sys     0m 1.32s

$ time ./sbcenc.armv6 -b53 -s4 -j test.au > /dev/null

real    0m 18.64s
user    0m 15.78s
sys     0m 2.22s
---
 Makefile.am                |    3 +-
 sbc/sbc_primitives.c       |    4 +
 sbc/sbc_primitives_armv6.c |  299 ++++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives_armv6.h |   52 ++++++++
 4 files changed, 357 insertions(+), 1 deletions(-)
 create mode 100644 sbc/sbc_primitives_armv6.c
 create mode 100644 sbc/sbc_primitives_armv6.h

diff --git a/Makefile.am b/Makefile.am
index 36ffde3..9ed3f89 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -65,7 +65,8 @@ noinst_LTLIBRARIES += sbc/libsbc.la
 sbc_libsbc_la_SOURCES = sbc/sbc.h sbc/sbc.c sbc/sbc_math.h sbc/sbc_tables.h \
 			sbc/sbc_primitives.h sbc/sbc_primitives.c \
 			sbc/sbc_primitives_mmx.h sbc/sbc_primitives_mmx.c \
-			sbc/sbc_primitives_neon.h sbc/sbc_primitives_neon.c
+			sbc/sbc_primitives_neon.h sbc/sbc_primitives_neon.c \
+			sbc/sbc_primitives_armv6.h sbc/sbc_primitives_armv6.c
 
 sbc_libsbc_la_CFLAGS = -finline-functions -fgcse-after-reload \
 					-funswitch-loops -funroll-loops
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index c73fb1c..f87fb5a 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -34,6 +34,7 @@
 #include "sbc_primitives.h"
 #include "sbc_primitives_mmx.h"
 #include "sbc_primitives_neon.h"
+#include "sbc_primitives_armv6.h"
 
 /*
  * A reference C code of analysis filter with SIMD-friendly tables
@@ -540,6 +541,9 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 #endif
 
 	/* ARM optimizations */
+#ifdef SBC_BUILD_WITH_ARMV6_SUPPORT
+	sbc_init_primitives_armv6(state);
+#endif
 #ifdef SBC_BUILD_WITH_NEON_SUPPORT
 	sbc_init_primitives_neon(state);
 #endif
diff --git a/sbc/sbc_primitives_armv6.c b/sbc/sbc_primitives_armv6.c
new file mode 100644
index 0000000..9586098
--- /dev/null
+++ b/sbc/sbc_primitives_armv6.c
@@ -0,0 +1,299 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2008-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2004-2005  Henryk Ploetz <henryk@ploetzli.ch>
+ *  Copyright (C) 2005-2006  Brad Midgley <bmidgley@xmission.com>
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
+#include "sbc_primitives_armv6.h"
+
+/*
+ * ARMv6 optimizations. The instructions are scheduled for ARM11 pipeline.
+ */
+
+#ifdef SBC_BUILD_WITH_ARMV6_SUPPORT
+
+static void __attribute__((naked)) sbc_analyze_four_armv6()
+{
+	/* r0 = in, r1 = out, r2 = consts */
+	asm volatile (
+		"push   {r1, r4-r7, lr}\n"
+		"push   {r8-r11}\n"
+		"ldrd   r4,  r5,  [r0, #0]\n"
+		"ldrd   r6,  r7,  [r2, #0]\n"
+		"ldrd   r8,  r9,  [r0, #16]\n"
+		"ldrd   r10, r11, [r2, #16]\n"
+		"mov    r14, #0x8000\n"
+		"smlad  r3,  r4,  r6,  r14\n"
+		"smlad  r12, r5,  r7,  r14\n"
+		"ldrd   r4,  r5,  [r0, #32]\n"
+		"ldrd   r6,  r7,  [r2, #32]\n"
+		"smlad  r3,  r8,  r10, r3\n"
+		"smlad  r12, r9,  r11, r12\n"
+		"ldrd   r8,  r9,  [r0, #48]\n"
+		"ldrd   r10, r11, [r2, #48]\n"
+		"smlad  r3,  r4,  r6,  r3\n"
+		"smlad  r12, r5,  r7,  r12\n"
+		"ldrd   r4,  r5,  [r0, #64]\n"
+		"ldrd   r6,  r7,  [r2, #64]\n"
+		"smlad  r3,  r8,  r10, r3\n"
+		"smlad  r12, r9,  r11, r12\n"
+		"ldrd   r8,  r9,  [r0, #8]\n"
+		"ldrd   r10, r11, [r2, #8]\n"
+		"smlad  r3,  r4,  r6,  r3\n"      /* t1[0] is done */
+		"smlad  r12, r5,  r7,  r12\n"     /* t1[1] is done */
+		"ldrd   r4,  r5,  [r0, #24]\n"
+		"ldrd   r6,  r7,  [r2, #24]\n"
+		"pkhtb  r3,  r12, r3, asr #16\n"  /* combine t1[0] and t1[1] */
+		"smlad  r12, r8,  r10, r14\n"
+		"smlad  r14, r9,  r11, r14\n"
+		"ldrd   r8,  r9,  [r0, #40]\n"
+		"ldrd   r10, r11, [r2, #40]\n"
+		"smlad  r12, r4,  r6,  r12\n"
+		"smlad  r14, r5,  r7,  r14\n"
+		"ldrd   r4,  r5,  [r0, #56]\n"
+		"ldrd   r6,  r7,  [r2, #56]\n"
+		"smlad  r12, r8,  r10, r12\n"
+		"smlad  r14, r9,  r11, r14\n"
+		"ldrd   r8,  r9,  [r0, #72]\n"
+		"ldrd   r10, r11, [r2, #72]\n"
+		"smlad  r12, r4,  r6,  r12\n"
+		"smlad  r14, r5,  r7,  r14\n"
+		"ldrd   r4,  r5,  [r2, #80]\n"    /* start loading cos table */
+		"smlad  r12, r8,  r10, r12\n"     /* t1[2] is done */
+		"smlad  r14, r9,  r11, r14\n"     /* t1[3] is done */
+		"ldrd   r6,  r7,  [r2, #88]\n"
+		"ldrd   r8,  r9,  [r2, #96]\n"
+		"ldrd   r10, r11, [r2, #104]\n"   /* cos table fully loaded */
+		"pkhtb  r12, r14, r12, asr #16\n" /* combine t1[2] and t1[3] */
+		"smuad  r4,  r3,  r4\n"
+		"smuad  r5,  r3,  r5\n"
+		"smlad  r4,  r12, r8,  r4\n"
+		"smlad  r5,  r12, r9,  r5\n"
+		"smuad  r6,  r3,  r6\n"
+		"smuad  r7,  r3,  r7\n"
+		"smlad  r6,  r12, r10, r6\n"
+		"smlad  r7,  r12, r11, r7\n"
+		"pop    {r8-r11}\n"
+		"stmia  r1, {r4, r5, r6, r7}\n"
+		"pop    {r1, r4-r7, pc}\n"
+	);
+}
+
+#define sbc_analyze_four(in, out, consts) \
+	((void (*)(int16_t *, int32_t *, const FIXED_T*)) \
+		sbc_analyze_four_armv6)((in), (out), (consts))
+
+static void __attribute__((naked)) sbc_analyze_eight_armv6()
+{
+	/* r0 = in, r1 = out, r2 = consts */
+	asm volatile (
+		"push   {r1, r4-r7, lr}\n"
+		"push   {r8-r11}\n"
+		"ldrd   r4,  r5,  [r0, #24]\n"
+		"ldrd   r6,  r7,  [r2, #24]\n"
+		"ldrd   r8,  r9,  [r0, #56]\n"
+		"ldrd   r10, r11, [r2, #56]\n"
+		"mov    r14, #0x8000\n"
+		"smlad  r3,  r4,  r6,  r14\n"
+		"smlad  r12, r5,  r7,  r14\n"
+		"ldrd   r4,  r5,  [r0, #88]\n"
+		"ldrd   r6,  r7,  [r2, #88]\n"
+		"smlad  r3,  r8,  r10, r3\n"
+		"smlad  r12, r9,  r11, r12\n"
+		"ldrd   r8,  r9,  [r0, #120]\n"
+		"ldrd   r10, r11, [r2, #120]\n"
+		"smlad  r3,  r4,  r6,  r3\n"
+		"smlad  r12, r5,  r7,  r12\n"
+		"ldrd   r4,  r5,  [r0, #152]\n"
+		"ldrd   r6,  r7,  [r2, #152]\n"
+		"smlad  r3,  r8,  r10, r3\n"
+		"smlad  r12, r9,  r11, r12\n"
+		"ldrd   r8,  r9,  [r0, #16]\n"
+		"ldrd   r10, r11, [r2, #16]\n"
+		"smlad  r3,  r4,  r6,  r3\n"      /* t1[6] is done */
+		"smlad  r12, r5,  r7,  r12\n"     /* t1[7] is done */
+		"ldrd   r4,  r5,  [r0, #48]\n"
+		"ldrd   r6,  r7,  [r2, #48]\n"
+		"pkhtb  r3,  r12, r3, asr #16\n"  /* combine t1[6] and t1[7] */
+		"str    r3,  [sp, #-4]!\n"        /* save to stack */
+		"smlad  r3,  r8,  r10, r14\n"
+		"smlad  r12, r9,  r11, r14\n"
+		"ldrd   r8,  r9,  [r0, #80]\n"
+		"ldrd   r10, r11, [r2, #80]\n"
+		"smlad  r3,  r4,  r6,  r3\n"
+		"smlad  r12, r5,  r7,  r12\n"
+		"ldrd   r4,  r5,  [r0, #112]\n"
+		"ldrd   r6,  r7,  [r2, #112]\n"
+		"smlad  r3,  r8,  r10, r3\n"
+		"smlad  r12, r9,  r11, r12\n"
+		"ldrd   r8,  r9,  [r0, #144]\n"
+		"ldrd   r10, r11, [r2, #144]\n"
+		"smlad  r3,  r4,  r6,  r3\n"
+		"smlad  r12, r5,  r7,  r12\n"
+		"ldrd   r4,  r5,  [r0, #0]\n"
+		"ldrd   r6,  r7,  [r2, #0]\n"
+		"smlad  r3,  r8,  r10, r3\n"      /* t1[4] is done */
+		"smlad  r12, r9,  r11, r12\n"     /* t1[5] is done */
+		"ldrd   r8,  r9,  [r0, #32]\n"
+		"ldrd   r10, r11, [r2, #32]\n"
+		"pkhtb  r3,  r12, r3, asr #16\n"  /* combine t1[4] and t1[5] */
+		"str    r3,  [sp, #-4]!\n"        /* save to stack */
+		"smlad  r3,  r4,  r6,  r14\n"
+		"smlad  r12, r5,  r7,  r14\n"
+		"ldrd   r4,  r5,  [r0, #64]\n"
+		"ldrd   r6,  r7,  [r2, #64]\n"
+		"smlad  r3,  r8,  r10, r3\n"
+		"smlad  r12, r9,  r11, r12\n"
+		"ldrd   r8,  r9,  [r0, #96]\n"
+		"ldrd   r10, r11, [r2, #96]\n"
+		"smlad  r3,  r4,  r6,  r3\n"
+		"smlad  r12, r5,  r7,  r12\n"
+		"ldrd   r4,  r5,  [r0, #128]\n"
+		"ldrd   r6,  r7,  [r2, #128]\n"
+		"smlad  r3,  r8,  r10, r3\n"
+		"smlad  r12, r9,  r11, r12\n"
+		"ldrd   r8,  r9,  [r0, #8]\n"
+		"ldrd   r10, r11, [r2, #8]\n"
+		"smlad  r3,  r4,  r6,  r3\n"      /* t1[0] is done */
+		"smlad  r12, r5,  r7,  r12\n"     /* t1[1] is done */
+		"ldrd   r4,  r5,  [r0, #40]\n"
+		"ldrd   r6,  r7,  [r2, #40]\n"
+		"pkhtb  r3,  r12, r3, asr #16\n"  /* combine t1[0] and t1[1] */
+		"smlad  r12, r8,  r10, r14\n"
+		"smlad  r14, r9,  r11, r14\n"
+		"ldrd   r8,  r9,  [r0, #72]\n"
+		"ldrd   r10, r11, [r2, #72]\n"
+		"smlad  r12, r4,  r6,  r12\n"
+		"smlad  r14, r5,  r7,  r14\n"
+		"ldrd   r4,  r5,  [r0, #104]\n"
+		"ldrd   r6,  r7,  [r2, #104]\n"
+		"smlad  r12, r8,  r10, r12\n"
+		"smlad  r14, r9,  r11, r14\n"
+		"ldrd   r8,  r9,  [r0, #136]\n"
+		"ldrd   r10, r11, [r2, #136]!\n"
+		"smlad  r12, r4,  r6,  r12\n"
+		"smlad  r14, r5,  r7,  r14\n"
+		"ldrd   r4,  r5,  [r2, #(160 - 136 + 0)]\n"
+		"smlad  r12, r8,  r10, r12\n"     /* t1[2] is done */
+		"smlad  r14, r9,  r11, r14\n"     /* t1[3] is done */
+		"ldrd   r6,  r7,  [r2, #(160 - 136 + 8)]\n"
+		"smuad  r4,  r3,  r4\n"
+		"smuad  r5,  r3,  r5\n"
+		"pkhtb  r12, r14, r12, asr #16\n" /* combine t1[2] and t1[3] */
+						  /* r3  = t2[0:1] */
+						  /* r12 = t2[2:3] */
+		"pop    {r0, r14}\n"              /* t2[4:5], t2[6:7] */
+		"ldrd   r8,  r9,  [r2, #(160 - 136 + 32)]\n"
+		"smuad  r6,  r3,  r6\n"
+		"smuad  r7,  r3,  r7\n"
+		"ldrd   r10, r11, [r2, #(160 - 136 + 40)]\n"
+		"smlad  r4,  r12, r8,  r4\n"
+		"smlad  r5,  r12, r9,  r5\n"
+		"ldrd   r8,  r9,  [r2, #(160 - 136 + 64)]\n"
+		"smlad  r6,  r12, r10, r6\n"
+		"smlad  r7,  r12, r11, r7\n"
+		"ldrd   r10, r11, [r2, #(160 - 136 + 72)]\n"
+		"smlad  r4,  r0,  r8,  r4\n"
+		"smlad  r5,  r0,  r9,  r5\n"
+		"ldrd   r8,  r9,  [r2, #(160 - 136 + 96)]\n"
+		"smlad  r6,  r0,  r10, r6\n"
+		"smlad  r7,  r0,  r11, r7\n"
+		"ldrd   r10, r11, [r2, #(160 - 136 + 104)]\n"
+		"smlad  r4,  r14, r8,  r4\n"
+		"smlad  r5,  r14, r9,  r5\n"
+		"ldrd   r8,  r9,  [r2, #(160 - 136 + 16 + 0)]\n"
+		"smlad  r6,  r14, r10, r6\n"
+		"smlad  r7,  r14, r11, r7\n"
+		"ldrd   r10, r11, [r2, #(160 - 136 + 16 + 8)]\n"
+		"stmia  r1!, {r4, r5}\n"
+		"smuad  r4,  r3,  r8\n"
+		"smuad  r5,  r3,  r9\n"
+		"ldrd   r8,  r9,  [r2, #(160 - 136 + 16 + 32)]\n"
+		"stmia  r1!, {r6, r7}\n"
+		"smuad  r6,  r3,  r10\n"
+		"smuad  r7,  r3,  r11\n"
+		"ldrd   r10, r11, [r2, #(160 - 136 + 16 + 40)]\n"
+		"smlad  r4,  r12, r8,  r4\n"
+		"smlad  r5,  r12, r9,  r5\n"
+		"ldrd   r8,  r9,  [r2, #(160 - 136 + 16 + 64)]\n"
+		"smlad  r6,  r12, r10, r6\n"
+		"smlad  r7,  r12, r11, r7\n"
+		"ldrd   r10, r11, [r2, #(160 - 136 + 16 + 72)]\n"
+		"smlad  r4,  r0,  r8,  r4\n"
+		"smlad  r5,  r0,  r9,  r5\n"
+		"ldrd   r8,  r9,  [r2, #(160 - 136 + 16 + 96)]\n"
+		"smlad  r6,  r0,  r10, r6\n"
+		"smlad  r7,  r0,  r11, r7\n"
+		"ldrd   r10, r11, [r2, #(160 - 136 + 16 + 104)]\n"
+		"smlad  r4,  r14, r8,  r4\n"
+		"smlad  r5,  r14, r9,  r5\n"
+		"smlad  r6,  r14, r10, r6\n"
+		"smlad  r7,  r14, r11, r7\n"
+		"pop    {r8-r11}\n"
+		"stmia  r1!, {r4, r5, r6, r7}\n"
+		"pop    {r1, r4-r7, pc}\n"
+	);
+}
+
+#define sbc_analyze_eight(in, out, consts) \
+	((void (*)(int16_t *, int32_t *, const FIXED_T*)) \
+		sbc_analyze_eight_armv6)((in), (out), (consts))
+
+static void sbc_analyze_4b_4s_armv6(int16_t *x, int32_t *out, int out_stride)
+{
+	/* Analyze blocks */
+	sbc_analyze_four(x + 12, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four(x + 8, out, analysis_consts_fixed4_simd_even);
+	out += out_stride;
+	sbc_analyze_four(x + 4, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four(x + 0, out, analysis_consts_fixed4_simd_even);
+}
+
+static void sbc_analyze_4b_8s_armv6(int16_t *x, int32_t *out, int out_stride)
+{
+	/* Analyze blocks */
+	sbc_analyze_eight(x + 24, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight(x + 16, out, analysis_consts_fixed8_simd_even);
+	out += out_stride;
+	sbc_analyze_eight(x + 8, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight(x + 0, out, analysis_consts_fixed8_simd_even);
+}
+
+void sbc_init_primitives_armv6(struct sbc_encoder_state *state)
+{
+	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_armv6;
+	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_armv6;
+	state->implementation_info = "ARMv6 SIMD";
+}
+
+#endif
diff --git a/sbc/sbc_primitives_armv6.h b/sbc/sbc_primitives_armv6.h
new file mode 100644
index 0000000..1862aed
--- /dev/null
+++ b/sbc/sbc_primitives_armv6.h
@@ -0,0 +1,52 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2008-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2004-2005  Henryk Ploetz <henryk@ploetzli.ch>
+ *  Copyright (C) 2005-2006  Brad Midgley <bmidgley@xmission.com>
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
+#ifndef __SBC_PRIMITIVES_ARMV6_H
+#define __SBC_PRIMITIVES_ARMV6_H
+
+#include "sbc_primitives.h"
+
+#if defined(__ARM_ARCH_6__) || defined(__ARM_ARCH_6J__) || \
+	defined(__ARM_ARCH_6K__) || defined(__ARM_ARCH_6Z__) || \
+	defined(__ARM_ARCH_6ZK__) || defined(__ARM_ARCH_6T2__) || \
+	defined(__ARM_ARCH_6M__) || defined(__ARM_ARCH_7__) || \
+	defined(__ARM_ARCH_7A__) || defined(__ARM_ARCH_7R__) || \
+	defined(__ARM_ARCH_7M__)
+#define SBC_HAVE_ARMV6 1
+#endif
+
+#if !defined(SBC_HIGH_PRECISION) && (SCALE_OUT_BITS == 15) && \
+	defined(__GNUC__) && defined(SBC_HAVE_ARMV6) && \
+	defined(__ARM_EABI__) && !defined(__thumb__) && \
+	!defined(__ARM_NEON__)
+
+#define SBC_BUILD_WITH_ARMV6_SUPPORT
+
+void sbc_init_primitives_armv6(struct sbc_encoder_state *encoder_state);
+
+#endif
+
+#endif
-- 
1.6.4.4

