Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Thu, 15 Jan 2009 21:34:02 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <200812311803.45279.siarhei.siamashka@nokia.com> <1231210146.13304.15.camel@californication> <200901091850.55032.siarhei.siamashka@nokia.com>
In-Reply-To: <200901091850.55032.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q+4bJ+h0zMwM0T+"
Message-Id: <200901152134.02777.siarhei.siamashka@nokia.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_q+4bJ+h0zMwM0T+
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 09 January 2009 18:50:54 ext Siarhei Siamashka wrote:
> On Tuesday 06 January 2009 04:49:06 ext Marcel Holtmann wrote:
> > > The attached patch contains what I would consider to be a final
> > > variant. MMX support is now complete. It works for both x86 and amd64,
> > > has runtime autodetection of MMX availability, supports 4 and 8
> > > subbands cases. I also ensured that only original MMX instructions are
> > > used (and no SSE or other later additions), so the code should work
> > > fine even on the old Pentium1 MMX. New MMX optimized functions produce
> > > bit identical results when compared with bluez-4.25 release.
> > >
> > > With this patch applied, new filtering functions are noticeably faster
> > > than than the old ones on x86 (so now they are both faster and have
> > > better quality). Assembly optimizations for the other platforms can be
> > > easily added too.
> >
> > can you re-base your patch against the latest tree and re-send the
> > patch.
>
> Yes, I will submit an updated SIMD optimizations patchset in a few days.

Updated patches are attached.

Performance improvement when testing with big buck bunny soundtrack varies
somewhere between 1.4x (4 subbands, MMX analysis filter, Intel Core2 CPU) and
2x factor (8 subbands, NEON analysis filter, ARM Cortex-A8 CPU). But these
numbers are for default bitpool settings (32) and no joint stereo, this
configuration is quite sensitive to analysis filter performance.

SIMD optimized code provides exactly the same output as C version.

But even with this optimization done, there are still a lot more things
to improve. I'm going to improve input data permutation/endian
conversion/channels deinterleaving next. Also scalefactors processing
can be vectorized. Audio quality can be still improved by tweaking
constant tables.


Best regards,
Siarhei Siamashka

--Boundary-00=_q+4bJ+h0zMwM0T+
Content-Type: text/x-diff;
  charset="utf-8";
  name="0001-SIMD-friendly-variant-of-SBC-encoder-analysis-filter.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0001-SIMD-friendly-variant-of-SBC-encoder-analysis-filter.patch"

>From 45aab0c1d41ec949a7db83d17ba1e1bb5093dfaf Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Thu, 15 Jan 2009 19:11:23 +0200
Subject: [PATCH] SIMD-friendly variant of SBC encoder analysis filter

Added SIMD-friendly C implementation of SBC analysis filter (the
structure of code had to be changed a bit and constants in the
tables reordered). This code can be used as a reference for
developing platform specific SIMD optimizations. These functions
are put into a new file 'sbc_primitives.c', which is going to
contain all the basic stuff for SBC codec.
---
 sbc/Makefile.am      |    3 +-
 sbc/sbc.c            |  155 +-------------------
 sbc/sbc_math.h       |    2 -
 sbc/sbc_primitives.c |  401 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives.h |   52 +++++++
 sbc/sbc_tables.h     |  250 +++++++++++++++++++++++++++++++-
 6 files changed, 703 insertions(+), 160 deletions(-)
 create mode 100644 sbc/sbc_primitives.c
 create mode 100644 sbc/sbc_primitives.h

diff --git a/sbc/Makefile.am b/sbc/Makefile.am
index c42f162..cd068e7 100644
--- a/sbc/Makefile.am
+++ b/sbc/Makefile.am
@@ -8,7 +8,8 @@ endif
 if SBC
 noinst_LTLIBRARIES = libsbc.la
 
-libsbc_la_SOURCES = sbc.h sbc.c sbc_math.h sbc_tables.h
+libsbc_la_SOURCES = sbc.h sbc.c sbc_math.h sbc_tables.h \
+	sbc_primitives.c
 
 libsbc_la_CFLAGS = -finline-functions -funswitch-loops -fgcse-after-reload
 
diff --git a/sbc/sbc.c b/sbc/sbc.c
index 651981f..534c935 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -46,6 +46,7 @@
 #include "sbc_tables.h"
 
 #include "sbc.h"
+#include "sbc_primitives.h"
 
 #define SBC_SYNCWORD	0x9C
 
@@ -91,16 +92,6 @@ struct sbc_decoder_state {
 	int offset[2][16];
 };
 
-struct sbc_encoder_state {
-	int subbands;
-	int position[2];
-	int16_t X[2][256];
-	void (*sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
-				  int32_t *out, int out_stride);
-	void (*sbc_analyze_4b_8s)(int16_t *pcm, int16_t *x,
-				  int32_t *out, int out_stride);
-};
-
 /*
  * Calculates the CRC-8 of the first len bits in data
  */
@@ -653,146 +644,6 @@ static int sbc_synthesize_audio(struct sbc_decoder_state *state,
 	}
 }
 
-static inline void _sbc_analyze_four(const int16_t *in, int32_t *out)
-{
-	FIXED_A t1[4];
-	FIXED_T t2[4];
-	int i = 0, hop = 0;
-
-	/* rounding coefficient */
-	t1[0] = t1[1] = t1[2] = t1[3] =
-		(FIXED_A) 1 << (SBC_PROTO_FIXED4_SCALE - 1);
-
-	/* low pass polyphase filter */
-	for (hop = 0; hop < 40; hop += 8) {
-		t1[0] += (FIXED_A) in[hop] * _sbc_proto_fixed4[hop];
-		t1[1] += (FIXED_A) in[hop + 1] * _sbc_proto_fixed4[hop + 1];
-		t1[2] += (FIXED_A) in[hop + 2] * _sbc_proto_fixed4[hop + 2];
-		t1[1] += (FIXED_A) in[hop + 3] * _sbc_proto_fixed4[hop + 3];
-		t1[0] += (FIXED_A) in[hop + 4] * _sbc_proto_fixed4[hop + 4];
-		t1[3] += (FIXED_A) in[hop + 5] * _sbc_proto_fixed4[hop + 5];
-		t1[3] += (FIXED_A) in[hop + 7] * _sbc_proto_fixed4[hop + 7];
-	}
-
-	/* scaling */
-	t2[0] = t1[0] >> SBC_PROTO_FIXED4_SCALE;
-	t2[1] = t1[1] >> SBC_PROTO_FIXED4_SCALE;
-	t2[2] = t1[2] >> SBC_PROTO_FIXED4_SCALE;
-	t2[3] = t1[3] >> SBC_PROTO_FIXED4_SCALE;
-
-	/* do the cos transform */
-	for (i = 0, hop = 0; i < 4; hop += 8, i++) {
-		out[i] = ((FIXED_A) t2[0] * cos_table_fixed_4[0 + hop] +
-			  (FIXED_A) t2[1] * cos_table_fixed_4[1 + hop] +
-			  (FIXED_A) t2[2] * cos_table_fixed_4[2 + hop] +
-			  (FIXED_A) t2[3] * cos_table_fixed_4[5 + hop]) >>
-			(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
-	}
-}
-
-static void sbc_analyze_4b_4s(int16_t *pcm, int16_t *x,
-			      int32_t *out, int out_stride)
-{
-	int i;
-
-	/* Input 4 x 4 Audio Samples */
-	for (i = 0; i < 16; i += 4) {
-		x[64 + i] = x[0 + i] = pcm[15 - i];
-		x[65 + i] = x[1 + i] = pcm[14 - i];
-		x[66 + i] = x[2 + i] = pcm[13 - i];
-		x[67 + i] = x[3 + i] = pcm[12 - i];
-	}
-
-	/* Analyze four blocks */
-	_sbc_analyze_four(x + 12, out);
-	out += out_stride;
-	_sbc_analyze_four(x + 8, out);
-	out += out_stride;
-	_sbc_analyze_four(x + 4, out);
-	out += out_stride;
-	_sbc_analyze_four(x, out);
-}
-
-static inline void _sbc_analyze_eight(const int16_t *in, int32_t *out)
-{
-	FIXED_A t1[8];
-	FIXED_T t2[8];
-	int i, hop;
-
-	/* rounding coefficient */
-	t1[0] = t1[1] = t1[2] = t1[3] = t1[4] = t1[5] = t1[6] = t1[7] =
-		(FIXED_A) 1 << (SBC_PROTO_FIXED8_SCALE-1);
-
-	/* low pass polyphase filter */
-	for (hop = 0; hop < 80; hop += 16) {
-		t1[0] += (FIXED_A) in[hop] * _sbc_proto_fixed8[hop];
-		t1[1] += (FIXED_A) in[hop + 1] * _sbc_proto_fixed8[hop + 1];
-		t1[2] += (FIXED_A) in[hop + 2] * _sbc_proto_fixed8[hop + 2];
-		t1[3] += (FIXED_A) in[hop + 3] * _sbc_proto_fixed8[hop + 3];
-		t1[4] += (FIXED_A) in[hop + 4] * _sbc_proto_fixed8[hop + 4];
-		t1[3] += (FIXED_A) in[hop + 5] * _sbc_proto_fixed8[hop + 5];
-		t1[2] += (FIXED_A) in[hop + 6] * _sbc_proto_fixed8[hop + 6];
-		t1[1] += (FIXED_A) in[hop + 7] * _sbc_proto_fixed8[hop + 7];
-		t1[0] += (FIXED_A) in[hop + 8] * _sbc_proto_fixed8[hop + 8];
-		t1[5] += (FIXED_A) in[hop + 9] * _sbc_proto_fixed8[hop + 9];
-		t1[6] += (FIXED_A) in[hop + 10] * _sbc_proto_fixed8[hop + 10];
-		t1[7] += (FIXED_A) in[hop + 11] * _sbc_proto_fixed8[hop + 11];
-		t1[7] += (FIXED_A) in[hop + 13] * _sbc_proto_fixed8[hop + 13];
-		t1[6] += (FIXED_A) in[hop + 14] * _sbc_proto_fixed8[hop + 14];
-		t1[5] += (FIXED_A) in[hop + 15] * _sbc_proto_fixed8[hop + 15];
-	}
-
-	/* scaling */
-	t2[0] = t1[0] >> SBC_PROTO_FIXED8_SCALE;
-	t2[1] = t1[1] >> SBC_PROTO_FIXED8_SCALE;
-	t2[2] = t1[2] >> SBC_PROTO_FIXED8_SCALE;
-	t2[3] = t1[3] >> SBC_PROTO_FIXED8_SCALE;
-	t2[4] = t1[4] >> SBC_PROTO_FIXED8_SCALE;
-	t2[5] = t1[5] >> SBC_PROTO_FIXED8_SCALE;
-	t2[6] = t1[6] >> SBC_PROTO_FIXED8_SCALE;
-	t2[7] = t1[7] >> SBC_PROTO_FIXED8_SCALE;
-
-	/* do the cos transform */
-	for (i = 0, hop = 0; i < 8; hop += 16, i++) {
-		out[i] = ((FIXED_A) t2[0] * cos_table_fixed_8[0 + hop] +
-			  (FIXED_A) t2[1] * cos_table_fixed_8[1 + hop] +
-			  (FIXED_A) t2[2] * cos_table_fixed_8[2 + hop] +
-			  (FIXED_A) t2[3] * cos_table_fixed_8[3 + hop] +
-			  (FIXED_A) t2[4] * cos_table_fixed_8[4 + hop] +
-			  (FIXED_A) t2[5] * cos_table_fixed_8[9 + hop] +
-			  (FIXED_A) t2[6] * cos_table_fixed_8[10 + hop] +
-			  (FIXED_A) t2[7] * cos_table_fixed_8[11 + hop]) >>
-			(SBC_COS_TABLE_FIXED8_SCALE - SCALE_OUT_BITS);
-	}
-}
-
-static void sbc_analyze_4b_8s(int16_t *pcm, int16_t *x,
-			      int32_t *out, int out_stride)
-{
-	int i;
-
-	/* Input 4 x 8 Audio Samples */
-	for (i = 0; i < 32; i += 8) {
-		x[128 + i] = x[0 + i] = pcm[31 - i];
-		x[129 + i] = x[1 + i] = pcm[30 - i];
-		x[130 + i] = x[2 + i] = pcm[29 - i];
-		x[131 + i] = x[3 + i] = pcm[28 - i];
-		x[132 + i] = x[4 + i] = pcm[27 - i];
-		x[133 + i] = x[5 + i] = pcm[26 - i];
-		x[134 + i] = x[6 + i] = pcm[25 - i];
-		x[135 + i] = x[7 + i] = pcm[24 - i];
-	}
-
-	/* Analyze four blocks */
-	_sbc_analyze_eight(x + 24, out);
-	out += out_stride;
-	_sbc_analyze_eight(x + 16, out);
-	out += out_stride;
-	_sbc_analyze_eight(x + 8, out);
-	out += out_stride;
-	_sbc_analyze_eight(x, out);
-}
-
 static int sbc_analyze_audio(struct sbc_encoder_state *state,
 				struct sbc_frame *frame)
 {
@@ -1056,9 +907,7 @@ static void sbc_encoder_init(struct sbc_encoder_state *state,
 	state->subbands = frame->subbands;
 	state->position[0] = state->position[1] = 12 * frame->subbands;
 
-	/* Default implementation for analyze function */
-	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s;
-	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s;
+	sbc_init_primitives(state);
 }
 
 struct sbc_priv {
diff --git a/sbc/sbc_math.h b/sbc/sbc_math.h
index 6ca4f52..b87bc81 100644
--- a/sbc/sbc_math.h
+++ b/sbc/sbc_math.h
@@ -29,8 +29,6 @@
 #define ASR(val, bits) ((-2 >> 1 == -1) ? \
 		 ((int32_t)(val)) >> (bits) : ((int32_t) (val)) / (1 << (bits)))
 
-#define SCALE_OUT_BITS 15
-
 #define SCALE_SPROTO4_TBL	12
 #define SCALE_SPROTO8_TBL	14
 #define SCALE_NPROTO4_TBL	11
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
new file mode 100644
index 0000000..f2e75b4
--- /dev/null
+++ b/sbc/sbc_primitives.c
@@ -0,0 +1,401 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#include "sbc_primitives.h"
+
+/*
+ * A standard C code of analysis filter.
+ */
+static inline void sbc_analyze_four(const int16_t *in, int32_t *out)
+{
+	FIXED_A t1[4];
+	FIXED_T t2[4];
+	int i = 0, hop = 0;
+
+	/* rounding coefficient */
+	t1[0] = t1[1] = t1[2] = t1[3] =
+		(FIXED_A) 1 << (SBC_PROTO_FIXED4_SCALE - 1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 40; hop += 8) {
+		t1[0] += (FIXED_A) in[hop] * _sbc_proto_fixed4[hop];
+		t1[1] += (FIXED_A) in[hop + 1] * _sbc_proto_fixed4[hop + 1];
+		t1[2] += (FIXED_A) in[hop + 2] * _sbc_proto_fixed4[hop + 2];
+		t1[1] += (FIXED_A) in[hop + 3] * _sbc_proto_fixed4[hop + 3];
+		t1[0] += (FIXED_A) in[hop + 4] * _sbc_proto_fixed4[hop + 4];
+		t1[3] += (FIXED_A) in[hop + 5] * _sbc_proto_fixed4[hop + 5];
+		t1[3] += (FIXED_A) in[hop + 7] * _sbc_proto_fixed4[hop + 7];
+	}
+
+	/* scaling */
+	t2[0] = t1[0] >> SBC_PROTO_FIXED4_SCALE;
+	t2[1] = t1[1] >> SBC_PROTO_FIXED4_SCALE;
+	t2[2] = t1[2] >> SBC_PROTO_FIXED4_SCALE;
+	t2[3] = t1[3] >> SBC_PROTO_FIXED4_SCALE;
+
+	/* do the cos transform */
+	for (i = 0, hop = 0; i < 4; hop += 8, i++) {
+		out[i] = ((FIXED_A) t2[0] * cos_table_fixed_4[0 + hop] +
+			  (FIXED_A) t2[1] * cos_table_fixed_4[1 + hop] +
+			  (FIXED_A) t2[2] * cos_table_fixed_4[2 + hop] +
+			  (FIXED_A) t2[3] * cos_table_fixed_4[5 + hop]) >>
+			(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+	}
+}
+
+static void sbc_analyze_4b_4s(int16_t *pcm, int16_t *x,
+			      int32_t *out, int out_stride)
+{
+	int i;
+
+	/* Input 4 x 4 Audio Samples */
+	for (i = 0; i < 16; i += 4) {
+		x[64 + i] = x[0 + i] = pcm[15 - i];
+		x[65 + i] = x[1 + i] = pcm[14 - i];
+		x[66 + i] = x[2 + i] = pcm[13 - i];
+		x[67 + i] = x[3 + i] = pcm[12 - i];
+	}
+
+	/* Analyze four blocks */
+	sbc_analyze_four(x + 12, out);
+	out += out_stride;
+	sbc_analyze_four(x + 8, out);
+	out += out_stride;
+	sbc_analyze_four(x + 4, out);
+	out += out_stride;
+	sbc_analyze_four(x, out);
+}
+
+static inline void sbc_analyze_eight(const int16_t *in, int32_t *out)
+{
+	FIXED_A t1[8];
+	FIXED_T t2[8];
+	int i, hop;
+
+	/* rounding coefficient */
+	t1[0] = t1[1] = t1[2] = t1[3] = t1[4] = t1[5] = t1[6] = t1[7] =
+		(FIXED_A) 1 << (SBC_PROTO_FIXED8_SCALE-1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 80; hop += 16) {
+		t1[0] += (FIXED_A) in[hop] * _sbc_proto_fixed8[hop];
+		t1[1] += (FIXED_A) in[hop + 1] * _sbc_proto_fixed8[hop + 1];
+		t1[2] += (FIXED_A) in[hop + 2] * _sbc_proto_fixed8[hop + 2];
+		t1[3] += (FIXED_A) in[hop + 3] * _sbc_proto_fixed8[hop + 3];
+		t1[4] += (FIXED_A) in[hop + 4] * _sbc_proto_fixed8[hop + 4];
+		t1[3] += (FIXED_A) in[hop + 5] * _sbc_proto_fixed8[hop + 5];
+		t1[2] += (FIXED_A) in[hop + 6] * _sbc_proto_fixed8[hop + 6];
+		t1[1] += (FIXED_A) in[hop + 7] * _sbc_proto_fixed8[hop + 7];
+		t1[0] += (FIXED_A) in[hop + 8] * _sbc_proto_fixed8[hop + 8];
+		t1[5] += (FIXED_A) in[hop + 9] * _sbc_proto_fixed8[hop + 9];
+		t1[6] += (FIXED_A) in[hop + 10] * _sbc_proto_fixed8[hop + 10];
+		t1[7] += (FIXED_A) in[hop + 11] * _sbc_proto_fixed8[hop + 11];
+		t1[7] += (FIXED_A) in[hop + 13] * _sbc_proto_fixed8[hop + 13];
+		t1[6] += (FIXED_A) in[hop + 14] * _sbc_proto_fixed8[hop + 14];
+		t1[5] += (FIXED_A) in[hop + 15] * _sbc_proto_fixed8[hop + 15];
+	}
+
+	/* scaling */
+	t2[0] = t1[0] >> SBC_PROTO_FIXED8_SCALE;
+	t2[1] = t1[1] >> SBC_PROTO_FIXED8_SCALE;
+	t2[2] = t1[2] >> SBC_PROTO_FIXED8_SCALE;
+	t2[3] = t1[3] >> SBC_PROTO_FIXED8_SCALE;
+	t2[4] = t1[4] >> SBC_PROTO_FIXED8_SCALE;
+	t2[5] = t1[5] >> SBC_PROTO_FIXED8_SCALE;
+	t2[6] = t1[6] >> SBC_PROTO_FIXED8_SCALE;
+	t2[7] = t1[7] >> SBC_PROTO_FIXED8_SCALE;
+
+	/* do the cos transform */
+	for (i = 0, hop = 0; i < 8; hop += 16, i++) {
+		out[i] = ((FIXED_A) t2[0] * cos_table_fixed_8[0 + hop] +
+			  (FIXED_A) t2[1] * cos_table_fixed_8[1 + hop] +
+			  (FIXED_A) t2[2] * cos_table_fixed_8[2 + hop] +
+			  (FIXED_A) t2[3] * cos_table_fixed_8[3 + hop] +
+			  (FIXED_A) t2[4] * cos_table_fixed_8[4 + hop] +
+			  (FIXED_A) t2[5] * cos_table_fixed_8[9 + hop] +
+			  (FIXED_A) t2[6] * cos_table_fixed_8[10 + hop] +
+			  (FIXED_A) t2[7] * cos_table_fixed_8[11 + hop]) >>
+			(SBC_COS_TABLE_FIXED8_SCALE - SCALE_OUT_BITS);
+	}
+}
+
+static void sbc_analyze_4b_8s(int16_t *pcm, int16_t *x,
+			      int32_t *out, int out_stride)
+{
+	int i;
+
+	/* Input 4 x 8 Audio Samples */
+	for (i = 0; i < 32; i += 8) {
+		x[128 + i] = x[0 + i] = pcm[31 - i];
+		x[129 + i] = x[1 + i] = pcm[30 - i];
+		x[130 + i] = x[2 + i] = pcm[29 - i];
+		x[131 + i] = x[3 + i] = pcm[28 - i];
+		x[132 + i] = x[4 + i] = pcm[27 - i];
+		x[133 + i] = x[5 + i] = pcm[26 - i];
+		x[134 + i] = x[6 + i] = pcm[25 - i];
+		x[135 + i] = x[7 + i] = pcm[24 - i];
+	}
+
+	/* Analyze four blocks */
+	sbc_analyze_eight(x + 24, out);
+	out += out_stride;
+	sbc_analyze_eight(x + 16, out);
+	out += out_stride;
+	sbc_analyze_eight(x + 8, out);
+	out += out_stride;
+	sbc_analyze_eight(x, out);
+}
+
+/*
+ * A reference C code of analysis filter with SIMD-friendly tables
+ * reordering and code layout. This code can be used to develop platform
+ * specific SIMD optimizations. Also it may be used as some kind of test
+ * for compiler autovectorization capabilities (who knows, if the compiler
+ * is very good at this stuff, hand optimized assembly may be not strictly
+ * needed for some platform).
+ */
+
+static inline void sbc_analyze_four_simd(const int16_t *in, int32_t *out,
+					 const FIXED_T *consts)
+{
+	FIXED_A t1[4];
+	FIXED_T t2[4];
+	int hop = 0;
+
+	/* rounding coefficient */
+	t1[0] = t1[1] = t1[2] = t1[3] =
+		(FIXED_A) 1 << (SBC_PROTO_FIXED4_SCALE - 1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 40; hop += 8) {
+		t1[0] += (FIXED_A) in[hop] * consts[hop];
+		t1[0] += (FIXED_A) in[hop + 1] * consts[hop + 1];
+		t1[1] += (FIXED_A) in[hop + 2] * consts[hop + 2];
+		t1[1] += (FIXED_A) in[hop + 3] * consts[hop + 3];
+		t1[2] += (FIXED_A) in[hop + 4] * consts[hop + 4];
+		t1[2] += (FIXED_A) in[hop + 5] * consts[hop + 5];
+		t1[3] += (FIXED_A) in[hop + 6] * consts[hop + 6];
+		t1[3] += (FIXED_A) in[hop + 7] * consts[hop + 7];
+	}
+
+	/* scaling */
+	t2[0] = t1[0] >> SBC_PROTO_FIXED4_SCALE;
+	t2[1] = t1[1] >> SBC_PROTO_FIXED4_SCALE;
+	t2[2] = t1[2] >> SBC_PROTO_FIXED4_SCALE;
+	t2[3] = t1[3] >> SBC_PROTO_FIXED4_SCALE;
+
+	/* do the cos transform */
+	t1[0]  = (FIXED_A) t2[0] * consts[40 + 0];
+	t1[0] += (FIXED_A) t2[1] * consts[40 + 1];
+	t1[1]  = (FIXED_A) t2[0] * consts[40 + 2];
+	t1[1] += (FIXED_A) t2[1] * consts[40 + 3];
+	t1[2]  = (FIXED_A) t2[0] * consts[40 + 4];
+	t1[2] += (FIXED_A) t2[1] * consts[40 + 5];
+	t1[3]  = (FIXED_A) t2[0] * consts[40 + 6];
+	t1[3] += (FIXED_A) t2[1] * consts[40 + 7];
+
+	t1[0] += (FIXED_A) t2[2] * consts[40 + 8];
+	t1[0] += (FIXED_A) t2[3] * consts[40 + 9];
+	t1[1] += (FIXED_A) t2[2] * consts[40 + 10];
+	t1[1] += (FIXED_A) t2[3] * consts[40 + 11];
+	t1[2] += (FIXED_A) t2[2] * consts[40 + 12];
+	t1[2] += (FIXED_A) t2[3] * consts[40 + 13];
+	t1[3] += (FIXED_A) t2[2] * consts[40 + 14];
+	t1[3] += (FIXED_A) t2[3] * consts[40 + 15];
+
+	out[0] = t1[0] >>
+		(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+	out[1] = t1[1] >>
+		(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+	out[2] = t1[2] >>
+		(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+	out[3] = t1[3] >>
+		(SBC_COS_TABLE_FIXED4_SCALE - SCALE_OUT_BITS);
+}
+
+static inline void sbc_analyze_eight_simd(const int16_t *in, int32_t *out,
+					  const FIXED_T *consts)
+{
+	FIXED_A t1[8];
+	FIXED_T t2[8];
+	int i, hop;
+
+	/* rounding coefficient */
+	t1[0] = t1[1] = t1[2] = t1[3] = t1[4] = t1[5] = t1[6] = t1[7] =
+		(FIXED_A) 1 << (SBC_PROTO_FIXED8_SCALE-1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 80; hop += 16) {
+		t1[0] += (FIXED_A) in[hop] * consts[hop];
+		t1[0] += (FIXED_A) in[hop + 1] * consts[hop + 1];
+		t1[1] += (FIXED_A) in[hop + 2] * consts[hop + 2];
+		t1[1] += (FIXED_A) in[hop + 3] * consts[hop + 3];
+		t1[2] += (FIXED_A) in[hop + 4] * consts[hop + 4];
+		t1[2] += (FIXED_A) in[hop + 5] * consts[hop + 5];
+		t1[3] += (FIXED_A) in[hop + 6] * consts[hop + 6];
+		t1[3] += (FIXED_A) in[hop + 7] * consts[hop + 7];
+		t1[4] += (FIXED_A) in[hop + 8] * consts[hop + 8];
+		t1[4] += (FIXED_A) in[hop + 9] * consts[hop + 9];
+		t1[5] += (FIXED_A) in[hop + 10] * consts[hop + 10];
+		t1[5] += (FIXED_A) in[hop + 11] * consts[hop + 11];
+		t1[6] += (FIXED_A) in[hop + 12] * consts[hop + 12];
+		t1[6] += (FIXED_A) in[hop + 13] * consts[hop + 13];
+		t1[7] += (FIXED_A) in[hop + 14] * consts[hop + 14];
+		t1[7] += (FIXED_A) in[hop + 15] * consts[hop + 15];
+	}
+
+	/* scaling */
+	t2[0] = t1[0] >> SBC_PROTO_FIXED8_SCALE;
+	t2[1] = t1[1] >> SBC_PROTO_FIXED8_SCALE;
+	t2[2] = t1[2] >> SBC_PROTO_FIXED8_SCALE;
+	t2[3] = t1[3] >> SBC_PROTO_FIXED8_SCALE;
+	t2[4] = t1[4] >> SBC_PROTO_FIXED8_SCALE;
+	t2[5] = t1[5] >> SBC_PROTO_FIXED8_SCALE;
+	t2[6] = t1[6] >> SBC_PROTO_FIXED8_SCALE;
+	t2[7] = t1[7] >> SBC_PROTO_FIXED8_SCALE;
+
+
+	/* do the cos transform */
+	t1[0] = t1[1] = t1[2] = t1[3] = t1[4] = t1[5] = t1[6] = t1[7] = 0;
+
+	for (i = 0; i < 4; i++) {
+		t1[0] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 0];
+		t1[0] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 1];
+		t1[1] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 2];
+		t1[1] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 3];
+		t1[2] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 4];
+		t1[2] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 5];
+		t1[3] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 6];
+		t1[3] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 7];
+		t1[4] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 8];
+		t1[4] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 9];
+		t1[5] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 10];
+		t1[5] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 11];
+		t1[6] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 12];
+		t1[6] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 13];
+		t1[7] += (FIXED_A) t2[i * 2 + 0] * consts[80 + i * 16 + 14];
+		t1[7] += (FIXED_A) t2[i * 2 + 1] * consts[80 + i * 16 + 15];
+	}
+
+	for (i = 0; i < 8; i++)
+		out[i] = t1[i] >>
+			(SBC_COS_TABLE_FIXED8_SCALE - SCALE_OUT_BITS);
+}
+
+static inline void sbc_analyze_4b_4s_simd(int16_t *pcm, int16_t *x,
+					  int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[64] = x[0]  = pcm[8 + 7];
+	x[65] = x[1]  = pcm[8 + 3];
+	x[66] = x[2]  = pcm[8 + 6];
+	x[67] = x[3]  = pcm[8 + 4];
+	x[68] = x[4]  = pcm[8 + 0];
+	x[69] = x[5]  = pcm[8 + 2];
+	x[70] = x[6]  = pcm[8 + 1];
+	x[71] = x[7]  = pcm[8 + 5];
+
+	x[72] = x[8]  = pcm[0 + 7];
+	x[73] = x[9]  = pcm[0 + 3];
+	x[74] = x[10] = pcm[0 + 6];
+	x[75] = x[11] = pcm[0 + 4];
+	x[76] = x[12] = pcm[0 + 0];
+	x[77] = x[13] = pcm[0 + 2];
+	x[78] = x[14] = pcm[0 + 1];
+	x[79] = x[15] = pcm[0 + 5];
+
+	/* Analyze blocks */
+	sbc_analyze_four_simd(x + 12, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four_simd(x + 8, out, analysis_consts_fixed4_simd_even);
+	out += out_stride;
+	sbc_analyze_four_simd(x + 4, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four_simd(x + 0, out, analysis_consts_fixed4_simd_even);
+}
+
+static inline void sbc_analyze_4b_8s_simd(int16_t *pcm, int16_t *x,
+					  int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[128] = x[0]  = pcm[16 + 15];
+	x[129] = x[1]  = pcm[16 + 7];
+	x[130] = x[2]  = pcm[16 + 14];
+	x[131] = x[3]  = pcm[16 + 8];
+	x[132] = x[4]  = pcm[16 + 13];
+	x[133] = x[5]  = pcm[16 + 9];
+	x[134] = x[6]  = pcm[16 + 12];
+	x[135] = x[7]  = pcm[16 + 10];
+	x[136] = x[8]  = pcm[16 + 11];
+	x[137] = x[9]  = pcm[16 + 3];
+	x[138] = x[10] = pcm[16 + 6];
+	x[139] = x[11] = pcm[16 + 0];
+	x[140] = x[12] = pcm[16 + 5];
+	x[141] = x[13] = pcm[16 + 1];
+	x[142] = x[14] = pcm[16 + 4];
+	x[143] = x[15] = pcm[16 + 2];
+
+	x[144] = x[16] = pcm[0 + 15];
+	x[145] = x[17] = pcm[0 + 7];
+	x[146] = x[18] = pcm[0 + 14];
+	x[147] = x[19] = pcm[0 + 8];
+	x[148] = x[20] = pcm[0 + 13];
+	x[149] = x[21] = pcm[0 + 9];
+	x[150] = x[22] = pcm[0 + 12];
+	x[151] = x[23] = pcm[0 + 10];
+	x[152] = x[24] = pcm[0 + 11];
+	x[153] = x[25] = pcm[0 + 3];
+	x[154] = x[26] = pcm[0 + 6];
+	x[155] = x[27] = pcm[0 + 0];
+	x[156] = x[28] = pcm[0 + 5];
+	x[157] = x[29] = pcm[0 + 1];
+	x[158] = x[30] = pcm[0 + 4];
+	x[159] = x[31] = pcm[0 + 2];
+
+	/* Analyze blocks */
+	sbc_analyze_eight_simd(x + 24, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight_simd(x + 16, out, analysis_consts_fixed8_simd_even);
+	out += out_stride;
+	sbc_analyze_eight_simd(x + 8, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight_simd(x + 0, out, analysis_consts_fixed8_simd_even);
+}
+
+/*
+ * Detect CPU features and setup function pointers
+ */
+void sbc_init_primitives(struct sbc_encoder_state *state)
+{
+	/* Default implementation for analyze functions */
+	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s;
+	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s;
+}
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
new file mode 100644
index 0000000..ca1ec27
--- /dev/null
+++ b/sbc/sbc_primitives.h
@@ -0,0 +1,52 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#ifndef __SBC_PRIMITIVES_H
+#define __SBC_PRIMITIVES_H
+
+#define SCALE_OUT_BITS 15
+
+struct sbc_encoder_state {
+	int subbands;
+	int position[2];
+	int16_t X[2][256];
+	/* Polyphase analysis filter for 4 subbands configuration,
+	   it handles 4 blocks at once */
+	void (*sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
+				  int32_t *out, int out_stride);
+	/* Polyphase analysis filter for 8 subbands configuration,
+	   it handles 4 blocks at once */
+	void (*sbc_analyze_4b_8s)(int16_t *pcm, int16_t *x,
+				  int32_t *out, int out_stride);
+};
+
+/*
+ * Initialize pointers to the functions which are the basic "building bricks"
+ * of SBC codec. Best implementation is selected based on target CPU
+ * capabilities.
+ */
+void sbc_init_primitives(struct sbc_encoder_state *encoder_state);
+
+#endif
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index f1dfe6c..a9a995f 100644
--- a/sbc/sbc_tables.h
+++ b/sbc/sbc_tables.h
@@ -157,8 +157,9 @@ static const int32_t synmatrix8[16][8] = {
  */
 #define SBC_PROTO_FIXED4_SCALE \
 	((sizeof(FIXED_T) * CHAR_BIT - 1) - SBC_FIXED_EXTRA_BITS + 1)
-#define F(x) (FIXED_A) ((x * 2) * \
+#define F_PROTO4(x) (FIXED_A) ((x * 2) * \
 	((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
+#define F(x) F_PROTO4(x)
 static const FIXED_T _sbc_proto_fixed4[40] = {
 	 F(0.00000000E+00),  F(5.36548976E-04),
 	-F(1.49188357E-03),  F(2.73370904E-03),
@@ -206,8 +207,9 @@ static const FIXED_T _sbc_proto_fixed4[40] = {
  */
 #define SBC_COS_TABLE_FIXED4_SCALE \
 	((sizeof(FIXED_T) * CHAR_BIT - 1) + SBC_FIXED_EXTRA_BITS)
-#define F(x) (FIXED_A) ((x) * \
+#define F_COS4(x) (FIXED_A) ((x) * \
 	((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
+#define F(x) F_COS4(x)
 static const FIXED_T cos_table_fixed_4[32] = {
 	 F(0.7071067812),  F(0.9238795325), -F(1.0000000000),  F(0.9238795325),
 	 F(0.7071067812),  F(0.3826834324),  F(0.0000000000),  F(0.3826834324),
@@ -233,8 +235,9 @@ static const FIXED_T cos_table_fixed_4[32] = {
  */
 #define SBC_PROTO_FIXED8_SCALE \
 	((sizeof(FIXED_T) * CHAR_BIT - 1) - SBC_FIXED_EXTRA_BITS + 2)
-#define F(x) (FIXED_A) ((x * 4) * \
+#define F_PROTO8(x) (FIXED_A) ((x * 4) * \
 	((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
+#define F(x) F_PROTO8(x)
 static const FIXED_T _sbc_proto_fixed8[80] = {
 	 F(0.00000000E+00),  F(1.56575398E-04),
 	 F(3.43256425E-04),  F(5.54620202E-04),
@@ -301,8 +304,9 @@ static const FIXED_T _sbc_proto_fixed8[80] = {
  */
 #define SBC_COS_TABLE_FIXED8_SCALE \
 	((sizeof(FIXED_T) * CHAR_BIT - 1) + SBC_FIXED_EXTRA_BITS)
-#define F(x) (FIXED_A) ((x) * \
+#define F_COS8(x) (FIXED_A) ((x) * \
 	((FIXED_A) 1 << (sizeof(FIXED_T) * CHAR_BIT - 1)) + 0.5)
+#define F(x) F_COS8(x)
 static const FIXED_T cos_table_fixed_8[128] = {
 	 F(0.7071067812),  F(0.8314696123),  F(0.9238795325),  F(0.9807852804),
 	-F(1.0000000000),  F(0.9807852804),  F(0.9238795325),  F(0.8314696123),
@@ -345,3 +349,241 @@ static const FIXED_T cos_table_fixed_8[128] = {
 	-F(0.0000000000), -F(0.1950903220),  F(0.3826834324), -F(0.5555702330),
 };
 #undef F
+
+/*
+ * Constant tables for the use in SIMD optimized analysis filters
+ * Each table consists of two parts:
+ * 1. reordered "proto" table
+ * 2. reordered "cos" table
+ *
+ * Due to non-symmetrical reordering, separate tables for "even"
+ * and "odd" cases are needed
+ */
+
+static const FIXED_T analysis_consts_fixed4_simd_even[40 + 16] = {
+#define F(x) F_PROTO4(x)
+	 F(0.00000000E+00),  F(3.83720193E-03),
+	 F(5.36548976E-04),  F(2.73370904E-03),
+	 F(3.06012286E-03),  F(3.89205149E-03),
+	 F(0.00000000E+00), -F(1.49188357E-03),
+	 F(1.09137620E-02),  F(2.58767811E-02),
+	 F(2.04385087E-02),  F(3.21939290E-02),
+	 F(7.76463494E-02),  F(6.13245186E-03),
+	 F(0.00000000E+00), -F(2.88757392E-02),
+	 F(1.35593274E-01),  F(2.94315332E-01),
+	 F(1.94987841E-01),  F(2.81828203E-01),
+	-F(1.94987841E-01),  F(2.81828203E-01),
+	 F(0.00000000E+00), -F(2.46636662E-01),
+	-F(1.35593274E-01),  F(2.58767811E-02),
+	-F(7.76463494E-02),  F(6.13245186E-03),
+	-F(2.04385087E-02),  F(3.21939290E-02),
+	 F(0.00000000E+00),  F(2.88217274E-02),
+	-F(1.09137620E-02),  F(3.83720193E-03),
+	-F(3.06012286E-03),  F(3.89205149E-03),
+	-F(5.36548976E-04),  F(2.73370904E-03),
+	 F(0.00000000E+00), -F(1.86581691E-03),
+#undef F
+#define F(x) F_COS4(x)
+	 F(0.7071067812),  F(0.9238795325),
+	-F(0.7071067812),  F(0.3826834324),
+	-F(0.7071067812), -F(0.3826834324),
+	 F(0.7071067812), -F(0.9238795325),
+	 F(0.3826834324), -F(1.0000000000),
+	-F(0.9238795325), -F(1.0000000000),
+	 F(0.9238795325), -F(1.0000000000),
+	-F(0.3826834324), -F(1.0000000000),
+#undef F
+};
+
+static const FIXED_T analysis_consts_fixed4_simd_odd[40 + 16] = {
+#define F(x) F_PROTO4(x)
+	 F(2.73370904E-03),  F(5.36548976E-04),
+	-F(1.49188357E-03),  F(0.00000000E+00),
+	 F(3.83720193E-03),  F(1.09137620E-02),
+	 F(3.89205149E-03),  F(3.06012286E-03),
+	 F(3.21939290E-02),  F(2.04385087E-02),
+	-F(2.88757392E-02),  F(0.00000000E+00),
+	 F(2.58767811E-02),  F(1.35593274E-01),
+	 F(6.13245186E-03),  F(7.76463494E-02),
+	 F(2.81828203E-01),  F(1.94987841E-01),
+	-F(2.46636662E-01),  F(0.00000000E+00),
+	 F(2.94315332E-01), -F(1.35593274E-01),
+	 F(2.81828203E-01), -F(1.94987841E-01),
+	 F(6.13245186E-03), -F(7.76463494E-02),
+	 F(2.88217274E-02),  F(0.00000000E+00),
+	 F(2.58767811E-02), -F(1.09137620E-02),
+	 F(3.21939290E-02), -F(2.04385087E-02),
+	 F(3.89205149E-03), -F(3.06012286E-03),
+	-F(1.86581691E-03),  F(0.00000000E+00),
+	 F(3.83720193E-03),  F(0.00000000E+00),
+	 F(2.73370904E-03), -F(5.36548976E-04),
+#undef F
+#define F(x) F_COS4(x)
+	 F(0.9238795325), -F(1.0000000000),
+	 F(0.3826834324), -F(1.0000000000),
+	-F(0.3826834324), -F(1.0000000000),
+	-F(0.9238795325), -F(1.0000000000),
+	 F(0.7071067812),  F(0.3826834324),
+	-F(0.7071067812), -F(0.9238795325),
+	-F(0.7071067812),  F(0.9238795325),
+	 F(0.7071067812), -F(0.3826834324),
+#undef F
+};
+
+static const FIXED_T analysis_consts_fixed8_simd_even[80 + 64] = {
+#define F(x) F_PROTO8(x)
+	 F(0.00000000E+00),  F(2.01182542E-03),
+	 F(1.56575398E-04),  F(1.78371725E-03),
+	 F(3.43256425E-04),  F(1.47640169E-03),
+	 F(5.54620202E-04),  F(1.13992507E-03),
+	-F(8.23919506E-04),  F(0.00000000E+00),
+	 F(2.10371989E-03),  F(3.49717454E-03),
+	 F(1.99454554E-03),  F(1.64973098E-03),
+	 F(1.61656283E-03),  F(1.78805361E-04),
+	 F(5.65949473E-03),  F(1.29371806E-02),
+	 F(8.02941163E-03),  F(1.53184106E-02),
+	 F(1.04584443E-02),  F(1.62208471E-02),
+	 F(1.27472335E-02),  F(1.59045603E-02),
+	-F(1.46525263E-02),  F(0.00000000E+00),
+	 F(8.85757540E-03),  F(5.31873032E-02),
+	 F(2.92408442E-03),  F(3.90751381E-02),
+	-F(4.91578024E-03),  F(2.61098752E-02),
+	 F(6.79989431E-02),  F(1.46955068E-01),
+	 F(8.29847578E-02),  F(1.45389847E-01),
+	 F(9.75753918E-02),  F(1.40753505E-01),
+	 F(1.11196689E-01),  F(1.33264415E-01),
+	-F(1.23264548E-01),  F(0.00000000E+00),
+	 F(1.45389847E-01), -F(8.29847578E-02),
+	 F(1.40753505E-01), -F(9.75753918E-02),
+	 F(1.33264415E-01), -F(1.11196689E-01),
+	-F(6.79989431E-02),  F(1.29371806E-02),
+	-F(5.31873032E-02),  F(8.85757540E-03),
+	-F(3.90751381E-02),  F(2.92408442E-03),
+	-F(2.61098752E-02), -F(4.91578024E-03),
+	 F(1.46404076E-02),  F(0.00000000E+00),
+	 F(1.53184106E-02), -F(8.02941163E-03),
+	 F(1.62208471E-02), -F(1.04584443E-02),
+	 F(1.59045603E-02), -F(1.27472335E-02),
+	-F(5.65949473E-03),  F(2.01182542E-03),
+	-F(3.49717454E-03),  F(2.10371989E-03),
+	-F(1.64973098E-03),  F(1.99454554E-03),
+	-F(1.78805361E-04),  F(1.61656283E-03),
+	-F(9.02154502E-04),  F(0.00000000E+00),
+	 F(1.78371725E-03), -F(1.56575398E-04),
+	 F(1.47640169E-03), -F(3.43256425E-04),
+	 F(1.13992507E-03), -F(5.54620202E-04),
+#undef F
+#define F(x) F_COS8(x)
+	 F(0.7071067812),  F(0.8314696123),
+	-F(0.7071067812), -F(0.1950903220),
+	-F(0.7071067812), -F(0.9807852804),
+	 F(0.7071067812), -F(0.5555702330),
+	 F(0.7071067812),  F(0.5555702330),
+	-F(0.7071067812),  F(0.9807852804),
+	-F(0.7071067812),  F(0.1950903220),
+	 F(0.7071067812), -F(0.8314696123),
+	 F(0.9238795325),  F(0.9807852804),
+	 F(0.3826834324),  F(0.8314696123),
+	-F(0.3826834324),  F(0.5555702330),
+	-F(0.9238795325),  F(0.1950903220),
+	-F(0.9238795325), -F(0.1950903220),
+	-F(0.3826834324), -F(0.5555702330),
+	 F(0.3826834324), -F(0.8314696123),
+	 F(0.9238795325), -F(0.9807852804),
+	-F(1.0000000000),  F(0.5555702330),
+	-F(1.0000000000), -F(0.9807852804),
+	-F(1.0000000000),  F(0.1950903220),
+	-F(1.0000000000),  F(0.8314696123),
+	-F(1.0000000000), -F(0.8314696123),
+	-F(1.0000000000), -F(0.1950903220),
+	-F(1.0000000000),  F(0.9807852804),
+	-F(1.0000000000), -F(0.5555702330),
+	 F(0.3826834324),  F(0.1950903220),
+	-F(0.9238795325), -F(0.5555702330),
+	 F(0.9238795325),  F(0.8314696123),
+	-F(0.3826834324), -F(0.9807852804),
+	-F(0.3826834324),  F(0.9807852804),
+	 F(0.9238795325), -F(0.8314696123),
+	-F(0.9238795325),  F(0.5555702330),
+	 F(0.3826834324), -F(0.1950903220),
+#undef F
+};
+
+static const FIXED_T analysis_consts_fixed8_simd_odd[80 + 64] = {
+#define F(x) F_PROTO8(x)
+	 F(0.00000000E+00), -F(8.23919506E-04),
+	 F(1.56575398E-04),  F(1.78371725E-03),
+	 F(3.43256425E-04),  F(1.47640169E-03),
+	 F(5.54620202E-04),  F(1.13992507E-03),
+	 F(2.01182542E-03),  F(5.65949473E-03),
+	 F(2.10371989E-03),  F(3.49717454E-03),
+	 F(1.99454554E-03),  F(1.64973098E-03),
+	 F(1.61656283E-03),  F(1.78805361E-04),
+	 F(0.00000000E+00), -F(1.46525263E-02),
+	 F(8.02941163E-03),  F(1.53184106E-02),
+	 F(1.04584443E-02),  F(1.62208471E-02),
+	 F(1.27472335E-02),  F(1.59045603E-02),
+	 F(1.29371806E-02),  F(6.79989431E-02),
+	 F(8.85757540E-03),  F(5.31873032E-02),
+	 F(2.92408442E-03),  F(3.90751381E-02),
+	-F(4.91578024E-03),  F(2.61098752E-02),
+	 F(0.00000000E+00), -F(1.23264548E-01),
+	 F(8.29847578E-02),  F(1.45389847E-01),
+	 F(9.75753918E-02),  F(1.40753505E-01),
+	 F(1.11196689E-01),  F(1.33264415E-01),
+	 F(1.46955068E-01), -F(6.79989431E-02),
+	 F(1.45389847E-01), -F(8.29847578E-02),
+	 F(1.40753505E-01), -F(9.75753918E-02),
+	 F(1.33264415E-01), -F(1.11196689E-01),
+	 F(0.00000000E+00),  F(1.46404076E-02),
+	-F(5.31873032E-02),  F(8.85757540E-03),
+	-F(3.90751381E-02),  F(2.92408442E-03),
+	-F(2.61098752E-02), -F(4.91578024E-03),
+	 F(1.29371806E-02), -F(5.65949473E-03),
+	 F(1.53184106E-02), -F(8.02941163E-03),
+	 F(1.62208471E-02), -F(1.04584443E-02),
+	 F(1.59045603E-02), -F(1.27472335E-02),
+	 F(0.00000000E+00), -F(9.02154502E-04),
+	-F(3.49717454E-03),  F(2.10371989E-03),
+	-F(1.64973098E-03),  F(1.99454554E-03),
+	-F(1.78805361E-04),  F(1.61656283E-03),
+	 F(2.01182542E-03),  F(0.00000000E+00),
+	 F(1.78371725E-03), -F(1.56575398E-04),
+	 F(1.47640169E-03), -F(3.43256425E-04),
+	 F(1.13992507E-03), -F(5.54620202E-04),
+#undef F
+#define F(x) F_COS8(x)
+	-F(1.0000000000),  F(0.8314696123),
+	-F(1.0000000000), -F(0.1950903220),
+	-F(1.0000000000), -F(0.9807852804),
+	-F(1.0000000000), -F(0.5555702330),
+	-F(1.0000000000),  F(0.5555702330),
+	-F(1.0000000000),  F(0.9807852804),
+	-F(1.0000000000),  F(0.1950903220),
+	-F(1.0000000000), -F(0.8314696123),
+	 F(0.9238795325),  F(0.9807852804),
+	 F(0.3826834324),  F(0.8314696123),
+	-F(0.3826834324),  F(0.5555702330),
+	-F(0.9238795325),  F(0.1950903220),
+	-F(0.9238795325), -F(0.1950903220),
+	-F(0.3826834324), -F(0.5555702330),
+	 F(0.3826834324), -F(0.8314696123),
+	 F(0.9238795325), -F(0.9807852804),
+	 F(0.7071067812),  F(0.5555702330),
+	-F(0.7071067812), -F(0.9807852804),
+	-F(0.7071067812),  F(0.1950903220),
+	 F(0.7071067812),  F(0.8314696123),
+	 F(0.7071067812), -F(0.8314696123),
+	-F(0.7071067812), -F(0.1950903220),
+	-F(0.7071067812),  F(0.9807852804),
+	 F(0.7071067812), -F(0.5555702330),
+	 F(0.3826834324),  F(0.1950903220),
+	-F(0.9238795325), -F(0.5555702330),
+	 F(0.9238795325),  F(0.8314696123),
+	-F(0.3826834324), -F(0.9807852804),
+	-F(0.3826834324),  F(0.9807852804),
+	 F(0.9238795325), -F(0.8314696123),
+	-F(0.9238795325),  F(0.5555702330),
+	 F(0.3826834324), -F(0.1950903220),
+#undef F
+};
-- 
1.5.6.5


--Boundary-00=_q+4bJ+h0zMwM0T+
Content-Type: text/x-diff;
  charset="utf-8";
  name="0002-SBC-arrays-and-constant-tables-aligned-at-16-byte-bo.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0002-SBC-arrays-and-constant-tables-aligned-at-16-byte-bo.patch"

>From 7e96a2769e8559fc8b90acfa5671029b75254fa5 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Thu, 15 Jan 2009 19:45:36 +0200
Subject: [PATCH] SBC arrays and constant tables aligned at 16 byte boundary for SIMD

Most SIMD instruction sets benefit from data being naturally aligned.
And even if it is not strictly required, performance is usually better
with the aligned data. ARM NEON and SSE2 have different instruction
variants for aligned/unaligned memory accesses.
---
 sbc/sbc.c            |   26 ++++++++++++++++----------
 sbc/sbc.h            |    1 +
 sbc/sbc_primitives.h |    2 +-
 sbc/sbc_tables.h     |   22 ++++++++++++++++++----
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 534c935..0699ae0 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -80,10 +80,13 @@ struct sbc_frame {
 	uint8_t scale_factor[2][8];
 
 	/* raw integer subband samples in the frame */
+	int32_t SBC_ALIGNED sb_sample_f[16][2][8];
 
-	int32_t sb_sample_f[16][2][8];
-	int32_t sb_sample[16][2][8];	/* modified subband samples */
-	int16_t pcm_sample[2][16*8];	/* original pcm audio samples */
+	/* modified subband samples */
+	int32_t SBC_ALIGNED sb_sample[16][2][8];
+
+	/* original pcm audio samples */
+	int16_t SBC_ALIGNED pcm_sample[2][16*8];
 };
 
 struct sbc_decoder_state {
@@ -912,9 +915,9 @@ static void sbc_encoder_init(struct sbc_encoder_state *state,
 
 struct sbc_priv {
 	int init;
-	struct sbc_frame frame;
-	struct sbc_decoder_state dec_state;
-	struct sbc_encoder_state enc_state;
+	struct SBC_ALIGNED sbc_frame frame;
+	struct SBC_ALIGNED sbc_decoder_state dec_state;
+	struct SBC_ALIGNED sbc_encoder_state enc_state;
 };
 
 static void sbc_set_defaults(sbc_t *sbc, unsigned long flags)
@@ -940,10 +943,13 @@ int sbc_init(sbc_t *sbc, unsigned long flags)
 
 	memset(sbc, 0, sizeof(sbc_t));
 
-	sbc->priv = malloc(sizeof(struct sbc_priv));
-	if (!sbc->priv)
+	sbc->priv_alloc_base = malloc(sizeof(struct sbc_priv) + SBC_ALIGN_MASK);
+	if (!sbc->priv_alloc_base)
 		return -ENOMEM;
 
+	sbc->priv = (void *) (((uintptr_t) sbc->priv_alloc_base +
+			SBC_ALIGN_MASK) & ~((uintptr_t) SBC_ALIGN_MASK));
+
 	memset(sbc->priv, 0, sizeof(struct sbc_priv));
 
 	sbc_set_defaults(sbc, flags);
@@ -1091,8 +1097,8 @@ void sbc_finish(sbc_t *sbc)
 	if (!sbc)
 		return;
 
-	if (sbc->priv)
-		free(sbc->priv);
+	if (sbc->priv_alloc_base)
+		free(sbc->priv_alloc_base);
 
 	memset(sbc, 0, sizeof(sbc_t));
 }
diff --git a/sbc/sbc.h b/sbc/sbc.h
index 8ac5930..b0a1488 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -74,6 +74,7 @@ struct sbc_struct {
 	uint8_t endian;
 
 	void *priv;
+	void *priv_alloc_base;
 };
 
 typedef struct sbc_struct sbc_t;
diff --git a/sbc/sbc_primitives.h b/sbc/sbc_primitives.h
index ca1ec27..a8b3df6 100644
--- a/sbc/sbc_primitives.h
+++ b/sbc/sbc_primitives.h
@@ -31,7 +31,7 @@
 struct sbc_encoder_state {
 	int subbands;
 	int position[2];
-	int16_t X[2][256];
+	int16_t SBC_ALIGNED X[2][256];
 	/* Polyphase analysis filter for 4 subbands configuration,
 	   it handles 4 blocks at once */
 	void (*sbc_analyze_4b_4s)(int16_t *pcm, int16_t *x,
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index a9a995f..7c2af07 100644
--- a/sbc/sbc_tables.h
+++ b/sbc/sbc_tables.h
@@ -351,6 +351,20 @@ static const FIXED_T cos_table_fixed_8[128] = {
 #undef F
 
 /*
+ * Enforce 16 byte alignment for the data, which is supposed to be used
+ * with SIMD optimized code.
+ */
+
+#define SBC_ALIGN_BITS 4
+#define SBC_ALIGN_MASK ((1 << (SBC_ALIGN_BITS)) - 1)
+
+#ifdef __GNUC__
+#define SBC_ALIGNED __attribute__((aligned(1 << (SBC_ALIGN_BITS))))
+#else
+#define SBC_ALIGNED
+#endif
+
+/*
  * Constant tables for the use in SIMD optimized analysis filters
  * Each table consists of two parts:
  * 1. reordered "proto" table
@@ -360,7 +374,7 @@ static const FIXED_T cos_table_fixed_8[128] = {
  * and "odd" cases are needed
  */
 
-static const FIXED_T analysis_consts_fixed4_simd_even[40 + 16] = {
+static const FIXED_T SBC_ALIGNED analysis_consts_fixed4_simd_even[40 + 16] = {
 #define F(x) F_PROTO4(x)
 	 F(0.00000000E+00),  F(3.83720193E-03),
 	 F(5.36548976E-04),  F(2.73370904E-03),
@@ -395,7 +409,7 @@ static const FIXED_T analysis_consts_fixed4_simd_even[40 + 16] = {
 #undef F
 };
 
-static const FIXED_T analysis_consts_fixed4_simd_odd[40 + 16] = {
+static const FIXED_T SBC_ALIGNED analysis_consts_fixed4_simd_odd[40 + 16] = {
 #define F(x) F_PROTO4(x)
 	 F(2.73370904E-03),  F(5.36548976E-04),
 	-F(1.49188357E-03),  F(0.00000000E+00),
@@ -430,7 +444,7 @@ static const FIXED_T analysis_consts_fixed4_simd_odd[40 + 16] = {
 #undef F
 };
 
-static const FIXED_T analysis_consts_fixed8_simd_even[80 + 64] = {
+static const FIXED_T SBC_ALIGNED analysis_consts_fixed8_simd_even[80 + 64] = {
 #define F(x) F_PROTO8(x)
 	 F(0.00000000E+00),  F(2.01182542E-03),
 	 F(1.56575398E-04),  F(1.78371725E-03),
@@ -509,7 +523,7 @@ static const FIXED_T analysis_consts_fixed8_simd_even[80 + 64] = {
 #undef F
 };
 
-static const FIXED_T analysis_consts_fixed8_simd_odd[80 + 64] = {
+static const FIXED_T SBC_ALIGNED analysis_consts_fixed8_simd_odd[80 + 64] = {
 #define F(x) F_PROTO8(x)
 	 F(0.00000000E+00), -F(8.23919506E-04),
 	 F(1.56575398E-04),  F(1.78371725E-03),
-- 
1.5.6.5


--Boundary-00=_q+4bJ+h0zMwM0T+
Content-Type: text/x-diff;
  charset="utf-8";
  name="0003-MMX-and-ARM-NEON-optimized-versions-of-analysis-filt.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="0003-MMX-and-ARM-NEON-optimized-versions-of-analysis-filt.patch"

>From fd46776a2734d800ecc2db6fd226b6cb9cacda36 Mon Sep 17 00:00:00 2001
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Thu, 15 Jan 2009 20:25:49 +0200
Subject: [PATCH] MMX and ARM NEON optimized versions of analysis filter for SBC encoder

---
 sbc/Makefile.am           |    2 +-
 sbc/sbc_primitives.c      |   12 ++
 sbc/sbc_primitives_mmx.c  |  373 +++++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives_mmx.h  |   40 +++++
 sbc/sbc_primitives_neon.c |  299 ++++++++++++++++++++++++++++++++++++
 sbc/sbc_primitives_neon.h |   40 +++++
 6 files changed, 765 insertions(+), 1 deletions(-)
 create mode 100644 sbc/sbc_primitives_mmx.c
 create mode 100644 sbc/sbc_primitives_mmx.h
 create mode 100644 sbc/sbc_primitives_neon.c
 create mode 100644 sbc/sbc_primitives_neon.h

diff --git a/sbc/Makefile.am b/sbc/Makefile.am
index cd068e7..5e47c77 100644
--- a/sbc/Makefile.am
+++ b/sbc/Makefile.am
@@ -9,7 +9,7 @@ if SBC
 noinst_LTLIBRARIES = libsbc.la
 
 libsbc_la_SOURCES = sbc.h sbc.c sbc_math.h sbc_tables.h \
-	sbc_primitives.c
+	sbc_primitives.c sbc_primitives_mmx.c sbc_primitives_neon.c
 
 libsbc_la_CFLAGS = -finline-functions -funswitch-loops -fgcse-after-reload
 
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index f2e75b4..c77a138 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -30,6 +30,8 @@
 #include "sbc_tables.h"
 
 #include "sbc_primitives.h"
+#include "sbc_primitives_mmx.h"
+#include "sbc_primitives_neon.h"
 
 /*
  * A standard C code of analysis filter.
@@ -398,4 +400,14 @@ void sbc_init_primitives(struct sbc_encoder_state *state)
 	/* Default implementation for analyze functions */
 	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s;
 	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s;
+
+	/* X86/AMD64 optimizations */
+#ifdef SBC_BUILD_WITH_MMX_SUPPORT
+	sbc_init_primitives_mmx(state);
+#endif
+
+	/* ARM optimizations */
+#ifdef SBC_BUILD_WITH_NEON_SUPPORT
+	sbc_init_primitives_neon(state);
+#endif
 }
diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
new file mode 100644
index 0000000..9f29220
--- /dev/null
+++ b/sbc/sbc_primitives_mmx.c
@@ -0,0 +1,373 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#include "sbc_primitives_mmx.h"
+
+/*
+ * MMX optimizations
+ */
+
+#ifdef SBC_BUILD_WITH_MMX_SUPPORT
+
+static inline void sbc_analyze_four_mmx(const int16_t *in, int32_t *out,
+					const FIXED_T *consts)
+{
+	static const SBC_ALIGNED int32_t round_c[2] = {
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+	};
+	asm volatile (
+		"movq        (%0), %%mm0\n"
+		"movq       8(%0), %%mm1\n"
+		"pmaddwd     (%1), %%mm0\n"
+		"pmaddwd    8(%1), %%mm1\n"
+		"paddd       (%2), %%mm0\n"
+		"paddd       (%2), %%mm1\n"
+		"\n"
+		"movq      16(%0), %%mm2\n"
+		"movq      24(%0), %%mm3\n"
+		"pmaddwd   16(%1), %%mm2\n"
+		"pmaddwd   24(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"movq      32(%0), %%mm2\n"
+		"movq      40(%0), %%mm3\n"
+		"pmaddwd   32(%1), %%mm2\n"
+		"pmaddwd   40(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"movq      48(%0), %%mm2\n"
+		"movq      56(%0), %%mm3\n"
+		"pmaddwd   48(%1), %%mm2\n"
+		"pmaddwd   56(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"movq      64(%0), %%mm2\n"
+		"movq      72(%0), %%mm3\n"
+		"pmaddwd   64(%1), %%mm2\n"
+		"pmaddwd   72(%1), %%mm3\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm3, %%mm1\n"
+		"\n"
+		"psrad         %4, %%mm0\n"
+		"psrad         %4, %%mm1\n"
+		"packssdw   %%mm0, %%mm0\n"
+		"packssdw   %%mm1, %%mm1\n"
+		"\n"
+		"movq       %%mm0, %%mm2\n"
+		"pmaddwd   80(%1), %%mm0\n"
+		"pmaddwd   88(%1), %%mm2\n"
+		"\n"
+		"movq       %%mm1, %%mm3\n"
+		"pmaddwd   96(%1), %%mm1\n"
+		"pmaddwd  104(%1), %%mm3\n"
+		"paddd      %%mm1, %%mm0\n"
+		"paddd      %%mm3, %%mm2\n"
+		"\n"
+		"movq       %%mm0, (%3)\n"
+		"movq       %%mm2, 8(%3)\n"
+		:
+		: "r" (in), "r" (consts), "r" (&round_c), "r" (out),
+		  "i" (SBC_PROTO_FIXED4_SCALE)
+		: "memory");
+}
+
+static inline void sbc_analyze_eight_mmx(const int16_t *in, int32_t *out,
+					 const FIXED_T *consts)
+{
+	static const SBC_ALIGNED int32_t round_c[2] = {
+		1 << (SBC_PROTO_FIXED8_SCALE - 1),
+		1 << (SBC_PROTO_FIXED8_SCALE - 1),
+	};
+	asm volatile (
+		"movq        (%0), %%mm0\n"
+		"movq       8(%0), %%mm1\n"
+		"movq      16(%0), %%mm2\n"
+		"movq      24(%0), %%mm3\n"
+		"pmaddwd     (%1), %%mm0\n"
+		"pmaddwd    8(%1), %%mm1\n"
+		"pmaddwd   16(%1), %%mm2\n"
+		"pmaddwd   24(%1), %%mm3\n"
+		"paddd       (%2), %%mm0\n"
+		"paddd       (%2), %%mm1\n"
+		"paddd       (%2), %%mm2\n"
+		"paddd       (%2), %%mm3\n"
+		"\n"
+		"movq      32(%0), %%mm4\n"
+		"movq      40(%0), %%mm5\n"
+		"movq      48(%0), %%mm6\n"
+		"movq      56(%0), %%mm7\n"
+		"pmaddwd   32(%1), %%mm4\n"
+		"pmaddwd   40(%1), %%mm5\n"
+		"pmaddwd   48(%1), %%mm6\n"
+		"pmaddwd   56(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"movq      64(%0), %%mm4\n"
+		"movq      72(%0), %%mm5\n"
+		"movq      80(%0), %%mm6\n"
+		"movq      88(%0), %%mm7\n"
+		"pmaddwd   64(%1), %%mm4\n"
+		"pmaddwd   72(%1), %%mm5\n"
+		"pmaddwd   80(%1), %%mm6\n"
+		"pmaddwd   88(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"movq      96(%0), %%mm4\n"
+		"movq     104(%0), %%mm5\n"
+		"movq     112(%0), %%mm6\n"
+		"movq     120(%0), %%mm7\n"
+		"pmaddwd   96(%1), %%mm4\n"
+		"pmaddwd  104(%1), %%mm5\n"
+		"pmaddwd  112(%1), %%mm6\n"
+		"pmaddwd  120(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"movq     128(%0), %%mm4\n"
+		"movq     136(%0), %%mm5\n"
+		"movq     144(%0), %%mm6\n"
+		"movq     152(%0), %%mm7\n"
+		"pmaddwd  128(%1), %%mm4\n"
+		"pmaddwd  136(%1), %%mm5\n"
+		"pmaddwd  144(%1), %%mm6\n"
+		"pmaddwd  152(%1), %%mm7\n"
+		"paddd      %%mm4, %%mm0\n"
+		"paddd      %%mm5, %%mm1\n"
+		"paddd      %%mm6, %%mm2\n"
+		"paddd      %%mm7, %%mm3\n"
+		"\n"
+		"psrad         %4, %%mm0\n"
+		"psrad         %4, %%mm1\n"
+		"psrad         %4, %%mm2\n"
+		"psrad         %4, %%mm3\n"
+		"\n"
+		"packssdw   %%mm0, %%mm0\n"
+		"packssdw   %%mm1, %%mm1\n"
+		"packssdw   %%mm2, %%mm2\n"
+		"packssdw   %%mm3, %%mm3\n"
+		"\n"
+		"movq       %%mm0, %%mm4\n"
+		"movq       %%mm0, %%mm5\n"
+		"pmaddwd  160(%1), %%mm4\n"
+		"pmaddwd  168(%1), %%mm5\n"
+		"\n"
+		"movq       %%mm1, %%mm6\n"
+		"movq       %%mm1, %%mm7\n"
+		"pmaddwd  192(%1), %%mm6\n"
+		"pmaddwd  200(%1), %%mm7\n"
+		"paddd      %%mm6, %%mm4\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm2, %%mm6\n"
+		"movq       %%mm2, %%mm7\n"
+		"pmaddwd  224(%1), %%mm6\n"
+		"pmaddwd  232(%1), %%mm7\n"
+		"paddd      %%mm6, %%mm4\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm3, %%mm6\n"
+		"movq       %%mm3, %%mm7\n"
+		"pmaddwd  256(%1), %%mm6\n"
+		"pmaddwd  264(%1), %%mm7\n"
+		"paddd      %%mm6, %%mm4\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm4, (%3)\n"
+		"movq       %%mm5, 8(%3)\n"
+		"\n"
+		"movq       %%mm0, %%mm5\n"
+		"pmaddwd  176(%1), %%mm0\n"
+		"pmaddwd  184(%1), %%mm5\n"
+		"\n"
+		"movq       %%mm1, %%mm7\n"
+		"pmaddwd  208(%1), %%mm1\n"
+		"pmaddwd  216(%1), %%mm7\n"
+		"paddd      %%mm1, %%mm0\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm2, %%mm7\n"
+		"pmaddwd  240(%1), %%mm2\n"
+		"pmaddwd  248(%1), %%mm7\n"
+		"paddd      %%mm2, %%mm0\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm3, %%mm7\n"
+		"pmaddwd  272(%1), %%mm3\n"
+		"pmaddwd  280(%1), %%mm7\n"
+		"paddd      %%mm3, %%mm0\n"
+		"paddd      %%mm7, %%mm5\n"
+		"\n"
+		"movq       %%mm0, 16(%3)\n"
+		"movq       %%mm5, 24(%3)\n"
+		:
+		: "r" (in), "r" (consts), "r" (&round_c), "r" (out),
+		  "i" (SBC_PROTO_FIXED8_SCALE)
+		: "memory");
+}
+
+static inline void sbc_analyze_4b_4s_mmx(int16_t *pcm, int16_t *x,
+					 int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[64] = x[0]  = pcm[8 + 7];
+	x[65] = x[1]  = pcm[8 + 3];
+	x[66] = x[2]  = pcm[8 + 6];
+	x[67] = x[3]  = pcm[8 + 4];
+	x[68] = x[4]  = pcm[8 + 0];
+	x[69] = x[5]  = pcm[8 + 2];
+	x[70] = x[6]  = pcm[8 + 1];
+	x[71] = x[7]  = pcm[8 + 5];
+
+	x[72] = x[8]  = pcm[0 + 7];
+	x[73] = x[9]  = pcm[0 + 3];
+	x[74] = x[10] = pcm[0 + 6];
+	x[75] = x[11] = pcm[0 + 4];
+	x[76] = x[12] = pcm[0 + 0];
+	x[77] = x[13] = pcm[0 + 2];
+	x[78] = x[14] = pcm[0 + 1];
+	x[79] = x[15] = pcm[0 + 5];
+
+	/* Analyze blocks */
+	sbc_analyze_four_mmx(x + 12, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four_mmx(x + 8, out, analysis_consts_fixed4_simd_even);
+	out += out_stride;
+	sbc_analyze_four_mmx(x + 4, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	sbc_analyze_four_mmx(x + 0, out, analysis_consts_fixed4_simd_even);
+
+	asm volatile ("emms\n");
+}
+
+static inline void sbc_analyze_4b_8s_mmx(int16_t *pcm, int16_t *x,
+					 int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[128] = x[0]  = pcm[16 + 15];
+	x[129] = x[1]  = pcm[16 + 7];
+	x[130] = x[2]  = pcm[16 + 14];
+	x[131] = x[3]  = pcm[16 + 8];
+	x[132] = x[4]  = pcm[16 + 13];
+	x[133] = x[5]  = pcm[16 + 9];
+	x[134] = x[6]  = pcm[16 + 12];
+	x[135] = x[7]  = pcm[16 + 10];
+	x[136] = x[8]  = pcm[16 + 11];
+	x[137] = x[9]  = pcm[16 + 3];
+	x[138] = x[10] = pcm[16 + 6];
+	x[139] = x[11] = pcm[16 + 0];
+	x[140] = x[12] = pcm[16 + 5];
+	x[141] = x[13] = pcm[16 + 1];
+	x[142] = x[14] = pcm[16 + 4];
+	x[143] = x[15] = pcm[16 + 2];
+
+	x[144] = x[16] = pcm[0 + 15];
+	x[145] = x[17] = pcm[0 + 7];
+	x[146] = x[18] = pcm[0 + 14];
+	x[147] = x[19] = pcm[0 + 8];
+	x[148] = x[20] = pcm[0 + 13];
+	x[149] = x[21] = pcm[0 + 9];
+	x[150] = x[22] = pcm[0 + 12];
+	x[151] = x[23] = pcm[0 + 10];
+	x[152] = x[24] = pcm[0 + 11];
+	x[153] = x[25] = pcm[0 + 3];
+	x[154] = x[26] = pcm[0 + 6];
+	x[155] = x[27] = pcm[0 + 0];
+	x[156] = x[28] = pcm[0 + 5];
+	x[157] = x[29] = pcm[0 + 1];
+	x[158] = x[30] = pcm[0 + 4];
+	x[159] = x[31] = pcm[0 + 2];
+
+	/* Analyze blocks */
+	sbc_analyze_eight_mmx(x + 24, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight_mmx(x + 16, out, analysis_consts_fixed8_simd_even);
+	out += out_stride;
+	sbc_analyze_eight_mmx(x + 8, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	sbc_analyze_eight_mmx(x + 0, out, analysis_consts_fixed8_simd_even);
+
+	asm volatile ("emms\n");
+}
+
+static int check_mmx_support()
+{
+#ifdef __amd64__
+	return 1; /* We assume that all 64-bit processors have MMX support */
+#else
+	int cpuid_feature_information;
+	asm volatile (
+		/* According to Intel manual, CPUID instruction is supported
+		   if the value of ID bit (bit 21) in EFLAGS can be modified */
+		"pushf\n"
+		"movl     (%%esp),   %0\n"
+		"xorl     $0x200000, (%%esp)\n" /* try to modify ID bit */
+		"popf\n"
+		"pushf\n"
+		"xorl     (%%esp),   %0\n"      /* check if ID bit changed */
+		"jz       1f\n"
+		"push     %%eax\n"
+		"push     %%ebx\n"
+		"push     %%ecx\n"
+		"mov      $1,        %%eax\n"
+		"cpuid\n"
+		"pop      %%ecx\n"
+		"pop      %%ebx\n"
+		"pop      %%eax\n"
+		"1:\n"
+		"popf\n"
+		: "=d" (cpuid_feature_information)
+		:
+		: "cc");
+    return cpuid_feature_information & (1 << 23);
+#endif
+}
+
+void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
+{
+	if (check_mmx_support()) {
+		state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_mmx;
+		state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_mmx;
+	}
+}
+
+#endif
diff --git a/sbc/sbc_primitives_mmx.h b/sbc/sbc_primitives_mmx.h
new file mode 100644
index 0000000..c1e44a5
--- /dev/null
+++ b/sbc/sbc_primitives_mmx.h
@@ -0,0 +1,40 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#ifndef __SBC_PRIMITIVES_MMX_H
+#define __SBC_PRIMITIVES_MMX_H
+
+#include "sbc_primitives.h"
+
+#if defined(__GNUC__) && (defined(__i386__) || defined(__amd64__)) && \
+		!defined(SBC_HIGH_PRECISION) && (SCALE_OUT_BITS == 15)
+
+#define SBC_BUILD_WITH_MMX_SUPPORT
+
+void sbc_init_primitives_mmx(struct sbc_encoder_state *encoder_state);
+
+#endif
+
+#endif
diff --git a/sbc/sbc_primitives_neon.c b/sbc/sbc_primitives_neon.c
new file mode 100644
index 0000000..ea8446f
--- /dev/null
+++ b/sbc/sbc_primitives_neon.c
@@ -0,0 +1,299 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#include "sbc_primitives_neon.h"
+
+/*
+ * ARM NEON optimizations
+ */
+
+#ifdef SBC_BUILD_WITH_NEON_SUPPORT
+
+static inline void _sbc_analyze_four_neon(const int16_t *in, int32_t *out,
+					 const FIXED_T *consts)
+{
+	/* TODO: merge even and odd cases (or even merge all four calls to this
+		 function) in order to have only aligned reads from 'in' array
+		 and reduce number of load instructions */
+	asm volatile (
+		"vld1.16    {d4, d5}, [%0, :64]!\n"
+		"vld1.16    {d8, d9}, [%1, :128]!\n"
+
+		"vmull.s16  q0, d4, d8\n"
+		"vld1.16    {d6,  d7}, [%0, :64]!\n"
+		"vmull.s16  q1, d5, d9\n"
+		"vld1.16    {d10, d11}, [%1, :128]!\n"
+
+		"vmlal.s16  q0, d6, d10\n"
+		"vld1.16    {d4, d5}, [%0, :64]!\n"
+		"vmlal.s16  q1, d7, d11\n"
+		"vld1.16    {d8, d9}, [%1, :128]!\n"
+
+		"vmlal.s16  q0, d4, d8\n"
+		"vld1.16    {d6,  d7}, [%0, :64]!\n"
+		"vmlal.s16  q1, d5, d9\n"
+		"vld1.16    {d10, d11}, [%1, :128]!\n"
+
+		"vmlal.s16  q0, d6, d10\n"
+		"vld1.16    {d4, d5}, [%0, :64]!\n"
+		"vmlal.s16  q1, d7, d11\n"
+		"vld1.16    {d8, d9}, [%1, :128]!\n"
+
+		"vmlal.s16  q0, d4, d8\n"
+		"vmlal.s16  q1, d5, d9\n"
+
+		"vpadd.s32  d0, d0, d1\n"
+		"vpadd.s32  d1, d2, d3\n"
+
+		"vrshrn.s32 d0, q0, %3\n"
+
+		"vld1.16    {d2, d3, d4, d5}, [%1, :128]!\n"
+
+		"vdup.i32   d1, d0[1]\n"  /* TODO: can be eliminated */
+		"vdup.i32   d0, d0[0]\n"  /* TODO: can be eliminated */
+
+		"vmull.s16  q3, d2, d0\n"
+		"vmull.s16  q4, d3, d0\n"
+		"vmlal.s16  q3, d4, d1\n"
+		"vmlal.s16  q4, d5, d1\n"
+
+		"vpadd.s32  d0, d6, d7\n" /* TODO: can be eliminated */
+		"vpadd.s32  d1, d8, d9\n" /* TODO: can be eliminated */
+
+		"vst1.32    {d0, d1}, [%2, :128]\n"
+		: "+r" (in), "+r" (consts)
+		: "r" (out),
+		  "i" (SBC_PROTO_FIXED4_SCALE)
+		: "memory",
+		  "d0", "d1", "d2", "d3", "d4", "d5",
+		  "d6", "d7", "d8", "d9", "d10", "d11");
+}
+
+static inline void _sbc_analyze_eight_neon(const int16_t *in, int32_t *out,
+					 const FIXED_T *consts)
+{
+	/* TODO: merge even and odd cases (or even merge all four calls to this
+		 function) in order to have only aligned reads from 'in' array
+		 and reduce number of load instructions */
+	asm volatile (
+		"vld1.16    {d4, d5}, [%0, :64]!\n"
+		"vld1.16    {d8, d9}, [%1, :128]!\n"
+
+		"vmull.s16  q6, d4, d8\n"
+		"vld1.16    {d6,  d7}, [%0, :64]!\n"
+		"vmull.s16  q7, d5, d9\n"
+		"vld1.16    {d10, d11}, [%1, :128]!\n"
+		"vmull.s16  q8, d6, d10\n"
+		"vld1.16    {d4, d5}, [%0, :64]!\n"
+		"vmull.s16  q9, d7, d11\n"
+		"vld1.16    {d8, d9}, [%1, :128]!\n"
+
+		"vmlal.s16  q6, d4, d8\n"
+		"vld1.16    {d6,  d7}, [%0, :64]!\n"
+		"vmlal.s16  q7, d5, d9\n"
+		"vld1.16    {d10, d11}, [%1, :128]!\n"
+		"vmlal.s16  q8, d6, d10\n"
+		"vld1.16    {d4, d5}, [%0, :64]!\n"
+		"vmlal.s16  q9, d7, d11\n"
+		"vld1.16    {d8, d9}, [%1, :128]!\n"
+
+		"vmlal.s16  q6, d4, d8\n"
+		"vld1.16    {d6,  d7}, [%0, :64]!\n"
+		"vmlal.s16  q7, d5, d9\n"
+		"vld1.16    {d10, d11}, [%1, :128]!\n"
+		"vmlal.s16  q8, d6, d10\n"
+		"vld1.16    {d4, d5}, [%0, :64]!\n"
+		"vmlal.s16  q9, d7, d11\n"
+		"vld1.16    {d8, d9}, [%1, :128]!\n"
+
+		"vmlal.s16  q6, d4, d8\n"
+		"vld1.16    {d6,  d7}, [%0, :64]!\n"
+		"vmlal.s16  q7, d5, d9\n"
+		"vld1.16    {d10, d11}, [%1, :128]!\n"
+		"vmlal.s16  q8, d6, d10\n"
+		"vld1.16    {d4, d5}, [%0, :64]!\n"
+		"vmlal.s16  q9, d7, d11\n"
+		"vld1.16    {d8, d9}, [%1, :128]!\n"
+
+		"vmlal.s16  q6, d4, d8\n"
+		"vld1.16    {d6,  d7}, [%0, :64]!\n"
+		"vmlal.s16  q7, d5, d9\n"
+		"vld1.16    {d10, d11}, [%1, :128]!\n"
+
+		"vmlal.s16  q8, d6, d10\n"
+		"vmlal.s16  q9, d7, d11\n"
+
+		"vpadd.s32  d0, d12, d13\n"
+		"vpadd.s32  d1, d14, d15\n"
+		"vpadd.s32  d2, d16, d17\n"
+		"vpadd.s32  d3, d18, d19\n"
+
+		"vrshr.s32 q0, q0, %3\n"
+		"vrshr.s32 q1, q1, %3\n"
+		"vmovn.s32 d0, q0\n"
+		"vmovn.s32 d1, q1\n"
+
+		"vdup.i32   d3, d1[1]\n"  /* TODO: can be eliminated */
+		"vdup.i32   d2, d1[0]\n"  /* TODO: can be eliminated */
+		"vdup.i32   d1, d0[1]\n"  /* TODO: can be eliminated */
+		"vdup.i32   d0, d0[0]\n"  /* TODO: can be eliminated */
+
+		"vld1.16    {d4, d5}, [%1, :128]!\n"
+		"vmull.s16  q6, d4, d0\n"
+		"vld1.16    {d6, d7}, [%1, :128]!\n"
+		"vmull.s16  q7, d5, d0\n"
+		"vmull.s16  q8, d6, d0\n"
+		"vmull.s16  q9, d7, d0\n"
+
+		"vld1.16    {d4, d5}, [%1, :128]!\n"
+		"vmlal.s16  q6, d4, d1\n"
+		"vld1.16    {d6, d7}, [%1, :128]!\n"
+		"vmlal.s16  q7, d5, d1\n"
+		"vmlal.s16  q8, d6, d1\n"
+		"vmlal.s16  q9, d7, d1\n"
+
+		"vld1.16    {d4, d5}, [%1, :128]!\n"
+		"vmlal.s16  q6, d4, d2\n"
+		"vld1.16    {d6, d7}, [%1, :128]!\n"
+		"vmlal.s16  q7, d5, d2\n"
+		"vmlal.s16  q8, d6, d2\n"
+		"vmlal.s16  q9, d7, d2\n"
+
+		"vld1.16    {d4, d5}, [%1, :128]!\n"
+		"vmlal.s16  q6, d4, d3\n"
+		"vld1.16    {d6, d7}, [%1, :128]!\n"
+		"vmlal.s16  q7, d5, d3\n"
+		"vmlal.s16  q8, d6, d3\n"
+		"vmlal.s16  q9, d7, d3\n"
+
+		"vpadd.s32  d0, d12, d13\n" /* TODO: can be eliminated */
+		"vpadd.s32  d1, d14, d15\n" /* TODO: can be eliminated */
+		"vpadd.s32  d2, d16, d17\n" /* TODO: can be eliminated */
+		"vpadd.s32  d3, d18, d19\n" /* TODO: can be eliminated */
+
+		"vst1.32    {d0, d1, d2, d3}, [%2, :128]\n"
+		: "+r" (in), "+r" (consts)
+		: "r" (out),
+		  "i" (SBC_PROTO_FIXED8_SCALE)
+		: "memory",
+		  "d0", "d1", "d2", "d3", "d4", "d5",
+		  "d6", "d7", "d8", "d9", "d10", "d11",
+		  "d12", "d13", "d14", "d15", "d16", "d17",
+		  "d18", "d19");
+}
+
+static inline void sbc_analyze_4b_4s_neon(int16_t *pcm, int16_t *x,
+					 int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[64] = x[0]  = pcm[8 + 7];
+	x[65] = x[1]  = pcm[8 + 3];
+	x[66] = x[2]  = pcm[8 + 6];
+	x[67] = x[3]  = pcm[8 + 4];
+	x[68] = x[4]  = pcm[8 + 0];
+	x[69] = x[5]  = pcm[8 + 2];
+	x[70] = x[6]  = pcm[8 + 1];
+	x[71] = x[7]  = pcm[8 + 5];
+
+	x[72] = x[8]  = pcm[0 + 7];
+	x[73] = x[9]  = pcm[0 + 3];
+	x[74] = x[10] = pcm[0 + 6];
+	x[75] = x[11] = pcm[0 + 4];
+	x[76] = x[12] = pcm[0 + 0];
+	x[77] = x[13] = pcm[0 + 2];
+	x[78] = x[14] = pcm[0 + 1];
+	x[79] = x[15] = pcm[0 + 5];
+
+	/* Analyze blocks */
+	_sbc_analyze_four_neon(x + 12, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	_sbc_analyze_four_neon(x + 8, out, analysis_consts_fixed4_simd_even);
+	out += out_stride;
+	_sbc_analyze_four_neon(x + 4, out, analysis_consts_fixed4_simd_odd);
+	out += out_stride;
+	_sbc_analyze_four_neon(x + 0, out, analysis_consts_fixed4_simd_even);
+}
+
+static inline void sbc_analyze_4b_8s_neon(int16_t *pcm, int16_t *x,
+					  int32_t *out, int out_stride)
+{
+	/* Fetch audio samples and do input data reordering for SIMD */
+	x[128] = x[0]  = pcm[16 + 15];
+	x[129] = x[1]  = pcm[16 + 7];
+	x[130] = x[2]  = pcm[16 + 14];
+	x[131] = x[3]  = pcm[16 + 8];
+	x[132] = x[4]  = pcm[16 + 13];
+	x[133] = x[5]  = pcm[16 + 9];
+	x[134] = x[6]  = pcm[16 + 12];
+	x[135] = x[7]  = pcm[16 + 10];
+	x[136] = x[8]  = pcm[16 + 11];
+	x[137] = x[9]  = pcm[16 + 3];
+	x[138] = x[10] = pcm[16 + 6];
+	x[139] = x[11] = pcm[16 + 0];
+	x[140] = x[12] = pcm[16 + 5];
+	x[141] = x[13] = pcm[16 + 1];
+	x[142] = x[14] = pcm[16 + 4];
+	x[143] = x[15] = pcm[16 + 2];
+
+	x[144] = x[16] = pcm[0 + 15];
+	x[145] = x[17] = pcm[0 + 7];
+	x[146] = x[18] = pcm[0 + 14];
+	x[147] = x[19] = pcm[0 + 8];
+	x[148] = x[20] = pcm[0 + 13];
+	x[149] = x[21] = pcm[0 + 9];
+	x[150] = x[22] = pcm[0 + 12];
+	x[151] = x[23] = pcm[0 + 10];
+	x[152] = x[24] = pcm[0 + 11];
+	x[153] = x[25] = pcm[0 + 3];
+	x[154] = x[26] = pcm[0 + 6];
+	x[155] = x[27] = pcm[0 + 0];
+	x[156] = x[28] = pcm[0 + 5];
+	x[157] = x[29] = pcm[0 + 1];
+	x[158] = x[30] = pcm[0 + 4];
+	x[159] = x[31] = pcm[0 + 2];
+
+	/* Analyze blocks */
+	_sbc_analyze_eight_neon(x + 24, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	_sbc_analyze_eight_neon(x + 16, out, analysis_consts_fixed8_simd_even);
+	out += out_stride;
+	_sbc_analyze_eight_neon(x + 8, out, analysis_consts_fixed8_simd_odd);
+	out += out_stride;
+	_sbc_analyze_eight_neon(x + 0, out, analysis_consts_fixed8_simd_even);
+}
+
+void sbc_init_primitives_neon(struct sbc_encoder_state *state)
+{
+	state->sbc_analyze_4b_4s = sbc_analyze_4b_4s_neon;
+	state->sbc_analyze_4b_8s = sbc_analyze_4b_8s_neon;
+}
+
+#endif
diff --git a/sbc/sbc_primitives_neon.h b/sbc/sbc_primitives_neon.h
new file mode 100644
index 0000000..30766ed
--- /dev/null
+++ b/sbc/sbc_primitives_neon.h
@@ -0,0 +1,40 @@
+/*
+ *
+ *  Bluetooth low-complexity, subband codec (SBC) library
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#ifndef __SBC_PRIMITIVES_NEON_H
+#define __SBC_PRIMITIVES_NEON_H
+
+#include "sbc_primitives.h"
+
+#if defined(__GNUC__) && defined(__ARM_NEON__) && \
+		!defined(SBC_HIGH_PRECISION) && (SCALE_OUT_BITS == 15)
+
+#define SBC_BUILD_WITH_NEON_SUPPORT
+
+void sbc_init_primitives_neon(struct sbc_encoder_state *encoder_state);
+
+#endif
+
+#endif
-- 
1.5.6.5


--Boundary-00=_q+4bJ+h0zMwM0T+--
