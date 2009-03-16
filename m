Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] sbc: powerpc altivec optimizations for 4 subbands encoding
Date: Mon, 16 Mar 2009 21:59:49 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1+qvJem6idPswm9"
Message-Id: <200903162159.49487.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_1+qvJem6idPswm9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

On the last weekend I tried to get familiar with powerpc altivec assembly  and
added some optimization for sbc encoder. Experimental patch is attached. It
handles 4 subbands case only, so is not that much useful in practice. There
are no problems supporting 8 subbands too, but I was just running out of
time. The patch merges processing of 4 blocks into the single block of code.
It's something that is also in my todo list for ARM NEON. But while this merge
is mostly "nice to have" optimization for ARM, it is much more important for
PowerPC because of a huge multiply-accumulate latency.

And bluez a2dp seems to work fine on ppc64 linux (playstation3).

In order to activate altivec code, -maltivec option needs to be added to
gcc compilation flags.

Benchmark result:

time ./sbcenc -s4 somefile.au > /dev/null

before:
real	0m13.999s
user	0m13.468s
sys	0m0.523s

after:
real	0m5.714s
user	0m5.199s
sys	0m0.519s

3.2GHz CPU in playstation3 uses roughly 1.5% of cpu resources on sbc encoding
without any optimizations. cpu usage is down to something like 0.6% after this
optimization is applied.

-- 
Best regards,
Siarhei Siamashka

--Boundary-00=_1+qvJem6idPswm9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0004-sbc-powerpc-altivec-optimizations-for-4-subbands-en.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0004-sbc-powerpc-altivec-optimizations-for-4-subbands-en.patch"

=46rom a995acc428e2c02306ca69efa85d7f6e15529245 Mon Sep 17 00:00:00 2001
=46rom: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Mon, 16 Mar 2009 03:38:52 +0200
Subject: [PATCH] sbc: powerpc altivec optimizations for 4 subbands encoding

=2D--
 sbc/Makefile.am              |    3 +-
 sbc/sbc_primitives.c         |    6 +
 sbc/sbc_primitives_altivec.c |  207 ++++++++++++++++++++++++++++++++++++++=
++++
 sbc/sbc_primitives_altivec.h |   40 ++++++++
 4 files changed, 255 insertions(+), 1 deletions(-)
 create mode 100644 sbc/sbc_primitives_altivec.c
 create mode 100644 sbc/sbc_primitives_altivec.h

diff --git a/sbc/Makefile.am b/sbc/Makefile.am
index f870164..75cc29b 100644
=2D-- a/sbc/Makefile.am
+++ b/sbc/Makefile.am
@@ -10,7 +10,8 @@ noinst_LTLIBRARIES =3D libsbc.la
=20
 libsbc_la_SOURCES =3D sbc.h sbc.c sbc_math.h sbc_tables.h \
 	sbc_primitives.h sbc_primitives_mmx.h sbc_primitives_neon.h \
=2D	sbc_primitives.c sbc_primitives_mmx.c sbc_primitives_neon.c
+	sbc_primitives.c sbc_primitives_mmx.c sbc_primitives_neon.c \
+	sbc_primitives_altivec.h sbc_primitives_altivec.c
=20
 libsbc_la_CFLAGS =3D -finline-functions -fgcse-after-reload \
 				-funswitch-loops -funroll-loops
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 2105280..209e2c3 100644
=2D-- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -33,6 +33,7 @@
 #include "sbc_primitives.h"
 #include "sbc_primitives_mmx.h"
 #include "sbc_primitives_neon.h"
+#include "sbc_primitives_altivec.h"
=20
 /*
  * A reference C code of analysis filter with SIMD-friendly tables
@@ -467,4 +468,9 @@ void sbc_init_primitives(struct sbc_encoder_state *stat=
e)
 #ifdef SBC_BUILD_WITH_NEON_SUPPORT
 	sbc_init_primitives_neon(state);
 #endif
+
+	/* PPC Altivec optimizations */
+#ifdef SBC_BUILD_WITH_ALTIVEC_SUPPORT
+	sbc_init_primitives_altivec(state);
+#endif
 }
diff --git a/sbc/sbc_primitives_altivec.c b/sbc/sbc_primitives_altivec.c
new file mode 100644
index 0000000..537cd8a
=2D-- /dev/null
+++ b/sbc/sbc_primitives_altivec.c
@@ -0,0 +1,207 @@
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#include <stdint.h>
+#include <limits.h>
+#include "sbc.h"
+#include "sbc_math.h"
+#include "sbc_tables.h"
+
+#include "sbc_primitives_altivec.h"
+
+#include <stdio.h>
+
+/*
+ * PPC Altivec optimizations
+ */
+
+#ifdef SBC_BUILD_WITH_ALTIVEC_SUPPORT
+
+/* Because of strict 16-byte alignment requirements for altivec, we need
+ * to add some zero padding to the beginning and end of the first part
+ * of the odd case coefficients table.
+ */
+static const FIXED_T SBC_ALIGNED analysis_consts_fixed4_altivec_odd[48 + 1=
6] =3D {
+#define C0 1.3056875580
+#define C1 1.6772280856
+#define C2 1.0932568993
+#define C3 1.3056875580
+
+#define F(x) F_PROTO4(x)
+	0, 0,
+	0, 0,
+	 F(2.73370904E-03 * C0),  F(5.36548976E-04 * C0),
+	-F(1.49188357E-03 * C1),  F(0.00000000E+00 * C1),
+	 F(3.83720193E-03 * C2),  F(1.09137620E-02 * C2),
+	 F(3.89205149E-03 * C3),  F(3.06012286E-03 * C3),
+	 F(3.21939290E-02 * C0),  F(2.04385087E-02 * C0),
+	-F(2.88757392E-02 * C1),  F(0.00000000E+00 * C1),
+	 F(2.58767811E-02 * C2),  F(1.35593274E-01 * C2),
+	 F(6.13245186E-03 * C3),  F(7.76463494E-02 * C3),
+	 F(2.81828203E-01 * C0),  F(1.94987841E-01 * C0),
+	-F(2.46636662E-01 * C1),  F(0.00000000E+00 * C1),
+	 F(2.94315332E-01 * C2), -F(1.35593274E-01 * C2),
+	 F(2.81828203E-01 * C3), -F(1.94987841E-01 * C3),
+	 F(6.13245186E-03 * C0), -F(7.76463494E-02 * C0),
+	 F(2.88217274E-02 * C1),  F(0.00000000E+00 * C1),
+	 F(2.58767811E-02 * C2), -F(1.09137620E-02 * C2),
+	 F(3.21939290E-02 * C3), -F(2.04385087E-02 * C3),
+	 F(3.89205149E-03 * C0), -F(3.06012286E-03 * C0),
+	-F(1.86581691E-03 * C1),  F(0.00000000E+00 * C1),
+	 F(3.83720193E-03 * C2),  F(0.00000000E+00 * C2),
+	 F(2.73370904E-03 * C3), -F(5.36548976E-04 * C3),
+	0, 0,
+	0, 0,
+#undef F
+#define F(x) F_COS4(x)
+	/* swap halves */
+	 F(0.7071067812 / C2),  F(0.3826834324 / C3),
+	-F(0.7071067812 / C2), -F(0.9238795325 / C3),
+	-F(0.7071067812 / C2),  F(0.9238795325 / C3),
+	 F(0.7071067812 / C2), -F(0.3826834324 / C3),
+	 F(0.9238795325 / C0), -F(1.0000000000 / C1),
+	 F(0.3826834324 / C0), -F(1.0000000000 / C1),
+	-F(0.3826834324 / C0), -F(1.0000000000 / C1),
+	-F(0.9238795325 / C0), -F(1.0000000000 / C1),
+#undef F
+
+#undef C0
+#undef C1
+#undef C2
+#undef C3
+};
+
+static void sbc_analyze_4b_4s_altivec(int16_t *x, int32_t *out, int out_st=
ride)
+{
+	static const SBC_ALIGNED int32_t round_c[4] =3D {
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+		1 << (SBC_PROTO_FIXED4_SCALE - 1),
+	};
+	static const SBC_ALIGNED int8_t perm_c1[16] =3D {
+		0, 1, 4, 5, 0, 1, 4, 5, 0, 1, 4, 5, 0, 1, 4, 5,
+	};
+	static const SBC_ALIGNED int8_t perm_c2[16] =3D {
+		8, 9, 12, 13, 8, 9, 12, 13, 8, 9, 12, 13, 8, 9, 12, 13,
+	};
+	const int16_t *const_e =3D analysis_consts_fixed4_simd_even;
+	const int16_t *const_o =3D analysis_consts_fixed4_altivec_odd;
+	asm volatile (
+		"lvx      %%v17, 0, %[round_c]\n"
+
+		"lvx      %%v1,  0, %[in]\n"
+		"addi     %[in], %[in], 16\n"
+
+		"lvx      %%v2,  0, %[consts_e]\n"
+		"addi     %[consts_e], %[consts_e], 16\n"
+		"lvx      %%v12, 0, %[consts_o]\n"
+		"addi     %[consts_o], %[consts_o], 16\n"
+		"vmsumshm %%v0,  %%v1, %%v2,  %%v17\n"
+		"vmsumshm %%v10, %%v1, %%v12, %%v17\n"
+		"lvx      %%v1,  0, %[in]\n"
+		"addi     %[in], %[in], 16\n"
+		"vmsumshm %%v14, %%v1, %%v2,  %%v17\n"
+		"vmsumshm %%v17, %%v1, %%v12, %%v17\n"
+
+		".rept 4\n"
+			"lvx      %%v2,  0, %[consts_e]\n"
+			"addi     %[consts_e], %[consts_e], 16\n"
+			"lvx      %%v12, 0, %[consts_o]\n"
+			"addi     %[consts_o], %[consts_o], 16\n"
+			"vmsumshm %%v0,  %%v1, %%v2,  %%v0\n"
+			"vmsumshm %%v10, %%v1, %%v12, %%v10\n"
+			"lvx      %%v1,  0, %[in]\n"
+			"addi     %[in], %[in], 16\n"
+			"vmsumshm %%v14, %%v1, %%v2,  %%v14\n"
+			"vmsumshm %%v17, %%v1, %%v12, %%v17\n"
+		".endr\n"
+
+		"lvx      %%v12, 0, %[consts_o]\n"
+		"addi     %[consts_o], %[consts_o], 16\n"
+		"lvx      %%v3,  0, %[in]\n"
+		"vmsumshm %%v10, %%v1, %%v12, %%v10\n"
+		"vmsumshm %%v17, %%v3, %%v12, %%v17\n"
+
+		"lvx      %%v18, 0, %[perm_c1]\n"
+		"lvx      %%v19, 0, %[perm_c2]\n"
+		"vperm    %%v1,  %%v0,  %%v0,  %%v18\n"
+		"vperm    %%v2,  %%v0,  %%v0,  %%v19\n"
+		"vperm    %%v15, %%v14, %%v14, %%v18\n"
+		"vperm    %%v16, %%v14, %%v14, %%v19\n"
+		"vperm    %%v11, %%v10, %%v10, %%v18\n"
+		"vperm    %%v12, %%v10, %%v10, %%v19\n"
+		"vperm    %%v18, %%v17, %%v17, %%v18\n"
+		"vperm    %%v19, %%v17, %%v17, %%v19\n"
+
+		"vspltisw %%v0,  0\n"
+
+		"lvx      %%v13, 0, %[consts_o]\n"
+		"addi     %[consts_o], %[consts_o], 16\n"
+		"lvx      %%v3,  0, %[consts_e]\n"
+		"addi     %[consts_e], %[consts_e], 16\n"
+		"vmsumshm %%v17, %%v13, %%v18, %%v0\n"
+		"vmsumshm %%v14, %%v3,  %%v15, %%v0\n"
+		"vmsumshm %%v10, %%v13, %%v11, %%v0\n"
+		"vmsumshm %%v0,  %%v3,  %%v1,  %%v0\n"
+
+		"lvx      %%v13, %%v0, %[consts_o]\n"
+		"lvx      %%v3,  %%v0, %[consts_e]\n"
+		"vmsumshm %%v17, %%v13, %%v19, %%v17\n"
+		"vmsumshm %%v14, %%v3,  %%v16, %%v14\n"
+		"vmsumshm %%v10, %%v13, %%v12, %%v10\n"
+		"vmsumshm %%v0,  %%v3,  %%v2,  %%v0\n"
+
+		"add      %[consts_e], %[out], %[out_stride]\n"
+		"add      %[consts_e], %[consts_e], %[out_stride]\n"
+		"stvx     %%v17, 0, %[out]\n"
+		"stvx     %%v14, %[out_stride], %[out]\n"
+		"stvx     %%v10, 0, %[consts_e]\n"
+		"stvx     %%v0, %[out_stride], %[consts_e]\n"
+
+		:
+			[in]         "+b" (x),
+			[consts_e]   "+b" (const_e),
+			[consts_o]   "+b" (const_o),
+			[out]        "+b" (out)
+		:
+			[round_c]     "b" (round_c),
+			[out_stride]  "b" (out_stride * 4),
+			[perm_c1]     "b" (perm_c1),
+			[perm_c2]     "b" (perm_c2)
+		:
+			"memory", "v0", "v1", "v2", "v3", "v10", "v11", "v12",
+			"v13", "v14", "v15", "v16", "v17", "v18", "v19");
+}
+
+void sbc_init_primitives_altivec(struct sbc_encoder_state *state)
+{
+	if (SBC_PROTO_FIXED4_SCALE =3D=3D 16 && SBC_PROTO_FIXED8_SCALE =3D=3D 16)=
 {
+		state->sbc_analyze_4b_4s =3D sbc_analyze_4b_4s_altivec;
+		state->implementation_info =3D "Altivec";
+	}
+}
+
+#endif
diff --git a/sbc/sbc_primitives_altivec.h b/sbc/sbc_primitives_altivec.h
new file mode 100644
index 0000000..8b87c8e
=2D-- /dev/null
+++ b/sbc/sbc_primitives_altivec.h
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifndef __SBC_PRIMITIVES_ALTIVEC_H
+#define __SBC_PRIMITIVES_ALTIVEC_H
+
+#include "sbc_primitives.h"
+
+#if defined(__GNUC__) && defined(__ALTIVEC__) && \
+		!defined(SBC_HIGH_PRECISION) && (SCALE_OUT_BITS =3D=3D 15)
+
+#define SBC_BUILD_WITH_ALTIVEC_SUPPORT
+
+void sbc_init_primitives_altivec(struct sbc_encoder_state *encoder_state);
+
+#endif
+
+#endif
=2D-=20
1.5.6.5


--Boundary-00=_1+qvJem6idPswm9--
