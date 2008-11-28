Return-Path: <cyrus@holtmann.org>
Subject: [RFC/PATCH] sbc: new filtering function for 8 band fixed point
	encoding
From: Jaska Uimonen <jaska.uimonen@nokia.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-h7UKt5O7VN3MJpnna9Y3"
Date: Fri, 28 Nov 2008 15:35:37 +0200
Message-Id: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-h7UKt5O7VN3MJpnna9Y3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi All,

I did some testing on the current 8 band fixed point 
encoding and it seems to attenuate frequencies below 800Hz 
and above 18kHz. There might be some other stuff happening 
also, because at least to me the bass seemed to lack some 
"definition".

I didn't quite understand how the current tables are calculated
and how the filtering works so I wrote a new filtering function
and calculated new filter tables for it. It is written
using 16 bit fixed point without any platform specific optimizations.
I only unrolled some loops etc. I tried to follow the
flow chart in MPEG-1 annex c.

With this new filtering the low and high frequencies are there, but
I haven't done any more thorough testing. At least it sounds
a little bit better to my ears :)

br,
Jaska Uimonen

P.S. I could have done some discussion with the list members 
about the current implementation, but I kind of got carried away. 
Sorry about that.

--=-h7UKt5O7VN3MJpnna9Y3
Content-Disposition: attachment; filename*0=0001-New-function-and-coefficients-for-8-band-fixed-point.pat; filename*1=ch
Content-Type: application/mbox; name=0001-New-function-and-coefficients-for-8-band-fixed-point.patch
Content-Transfer-Encoding: 7bit

>From f192e87fe4de74cd3d9651eea61d90efcd70198a Mon Sep 17 00:00:00 2001
From: Jaska Uimonen <jauimone@esdhcp03999.research.nokia.com>
Date: Fri, 28 Nov 2008 10:50:09 +0200
Subject: [PATCH] New function and coefficients for 8 band fixed point encoding.

---
 sbc/sbc.c        |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sbc/sbc_tables.h |   44 ++++++++++++++++++++++
 2 files changed, 149 insertions(+), 1 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 7072673..7966f2a 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -862,6 +862,108 @@ static inline void _sbc_analyze_eight(const int32_t *in, int32_t *out)
 	out[7] = SCALE8_STAGE2( s[0] + s[1] - s[2] + s[3]);
 }
 
+static inline void _sbc_analyze_eight_modified_fixed(const int32_t *in, int32_t *out)
+{
+        int32_t t[16];
+        int i = 0, hop = 0, R = 0;
+
+	/* rounding coefficient for Q15 */
+	R = 1 << (15-1);
+
+	/* low pass polyphase filter */
+	t[0] =  (int32_t)in[0] * _sbc_proto_fixed8[0];
+	t[1] =  (int32_t)in[1] * _sbc_proto_fixed8[1];
+	t[2] =  (int32_t)in[2] * _sbc_proto_fixed8[2];
+	t[3] =  (int32_t)in[3] * _sbc_proto_fixed8[3];
+	t[4] =  (int32_t)in[4] * _sbc_proto_fixed8[4];
+	t[5] =  (int32_t)in[5] * _sbc_proto_fixed8[5];
+	t[6] =  (int32_t)in[6] * _sbc_proto_fixed8[6];
+	t[7] =  (int32_t)in[7] * _sbc_proto_fixed8[7];
+	t[8] =  (int32_t)in[8] * _sbc_proto_fixed8[8];
+	t[9] =  (int32_t)in[9] * _sbc_proto_fixed8[9];
+	t[10] = (int32_t)in[10] * _sbc_proto_fixed8[10];
+	t[11] = (int32_t)in[11] * _sbc_proto_fixed8[11];
+	t[12] = (int32_t)in[12] * _sbc_proto_fixed8[12];
+	t[13] = (int32_t)in[13] * _sbc_proto_fixed8[13];
+	t[14] = (int32_t)in[14] * _sbc_proto_fixed8[14];
+	t[15] = (int32_t)in[15] * _sbc_proto_fixed8[15];
+
+	hop = 16;
+        for (i = 0; i < 4; i++) {
+	        t[0] +=  (int32_t)in[hop] * _sbc_proto_fixed8[hop];
+		t[1] +=  (int32_t)in[hop + 1] * _sbc_proto_fixed8[hop + 1];
+		t[2] +=  (int32_t)in[hop + 2] * _sbc_proto_fixed8[hop + 2];
+		t[3] +=  (int32_t)in[hop + 3] * _sbc_proto_fixed8[hop + 3];
+		t[4] +=  (int32_t)in[hop + 4] * _sbc_proto_fixed8[hop + 4];
+		t[5] +=  (int32_t)in[hop + 5] * _sbc_proto_fixed8[hop + 5];
+		t[6] +=  (int32_t)in[hop + 6] * _sbc_proto_fixed8[hop + 6];
+		t[7] +=  (int32_t)in[hop + 7] * _sbc_proto_fixed8[hop + 7];
+		t[8] +=  (int32_t)in[hop + 8] * _sbc_proto_fixed8[hop + 8];
+		t[9] +=  (int32_t)in[hop + 9] * _sbc_proto_fixed8[hop + 9];
+		t[10] += (int32_t)in[hop + 10] * _sbc_proto_fixed8[hop + 10];
+		t[11] += (int32_t)in[hop + 11] * _sbc_proto_fixed8[hop + 11];
+		t[12] += (int32_t)in[hop + 12] * _sbc_proto_fixed8[hop + 12];
+		t[13] += (int32_t)in[hop + 13] * _sbc_proto_fixed8[hop + 13];
+		t[14] += (int32_t)in[hop + 14] * _sbc_proto_fixed8[hop + 14];
+		t[15] += (int32_t)in[hop + 15] * _sbc_proto_fixed8[hop + 15];
+
+		hop += 16;
+	}
+
+	/* scaling */
+	t[0] = (t[0] + R) >> 15;
+	t[1] = (t[1] + R) >> 15;
+	t[2] = (t[2] + R) >> 15;
+	t[3] = (t[3] + R) >> 15;
+	t[4] = (t[4] + R) >> 15;
+	t[5] = (t[5] + R) >> 15;
+	t[6] = (t[6] + R) >> 15;
+	t[7] = (t[7] + R) >> 15;
+	t[8] = (t[8] + R) >> 15;
+	t[9] = (t[9] + R) >> 15;
+	t[10] = (t[10] + R) >> 15;
+	t[11] = (t[11] + R) >> 15;
+	t[12] = (t[12] + R) >> 15;
+	t[13] = (t[13] + R) >> 15;
+	t[14] = (t[14] + R) >> 15;
+	t[15] = (t[15] + R) >> 15;
+
+	/* do the cos transform */
+	hop = 0;
+	for (i = 0; i < 8; i++) {
+	        out[i] = 0;
+
+		out[i] += t[0] * cos_table_fixed_8[0 + hop];
+		out[i] += t[1] * cos_table_fixed_8[1 + hop];
+		out[i] += t[2] * cos_table_fixed_8[2 + hop];
+		out[i] += t[3] * cos_table_fixed_8[3 + hop];
+		out[i] += t[4] * cos_table_fixed_8[4 + hop];
+		out[i] += t[5] * cos_table_fixed_8[5 + hop];
+		out[i] += t[6] * cos_table_fixed_8[6 + hop];
+		out[i] += t[7] * cos_table_fixed_8[7 + hop];
+		out[i] += t[8] * cos_table_fixed_8[8 + hop];
+		out[i] += t[9] * cos_table_fixed_8[9 + hop];
+		out[i] += t[10] * cos_table_fixed_8[10 + hop];
+		out[i] += t[11] * cos_table_fixed_8[11 + hop];
+		out[i] += t[12] * cos_table_fixed_8[12 + hop];
+		out[i] += t[13] * cos_table_fixed_8[13 + hop];
+		out[i] += t[14] * cos_table_fixed_8[14 + hop];
+		out[i] += t[15] * cos_table_fixed_8[15 + hop];
+
+		hop += 16;
+	}
+
+	/* scaling */
+	out[0] = (out[0] + R) >> 15;
+	out[1] = (out[1] + R) >> 15;
+	out[2] = (out[2] + R) >> 15;
+	out[3] = (out[3] + R) >> 15;
+	out[4] = (out[4] + R) >> 15;
+	out[5] = (out[5] + R) >> 15;
+	out[6] = (out[6] + R) >> 15;
+	out[7] = (out[7] + R) >> 15;
+}
+
 static inline void sbc_analyze_eight(struct sbc_encoder_state *state,
 					struct sbc_frame *frame, int ch,
 					int blk)
@@ -879,7 +981,9 @@ static inline void sbc_analyze_eight(struct sbc_encoder_state *state,
 	x[86] = x[6] = pcm[1];
 	x[87] = x[7] = pcm[0];
 
-	_sbc_analyze_eight(x, frame->sb_sample_f[blk][ch]);
+
+	/* _sbc_analyze_eight(x, frame->sb_sample_f[blk][ch]); */
+	_sbc_analyze_eight_modified_fixed(x, frame->sb_sample_f[blk][ch]);
 
 	state->position[ch] -= 8;
 	if (state->position[ch] < 0)
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index f5daaa7..00a09a2 100644
--- a/sbc/sbc_tables.h
+++ b/sbc/sbc_tables.h
@@ -166,3 +166,47 @@ static const int32_t synmatrix8[16][8] = {
 	{ SN8(0xf9592678), SN8(0x018f8b84), SN8(0x07d8a5f0), SN8(0x0471ced0),
 	  SN8(0xfb8e3130), SN8(0xf8275a10), SN8(0xfe70747c), SN8(0x06a6d988) }
 };
+
+/*
+ * to produce this Q15 format table:
+ *
+ * Get the filter coeffs from the spec and multiply them by 2^15.
+ */
+static const signed short _sbc_proto_fixed8[80] = {
+       0, 5, 11, 18, 26, 37, 48, 58, 65, 68,
+       65, 52, 29, -5, -54, -114, 185, 263, 342, 417,
+       480, 521, 531, 501, 423, 290, 95, -161, -479, -855,
+       -1280, -1742, 2228, 2719, 3197, 3643, 4039, 4366, 4612, 4764,
+       4815, 4764, 4612, 4366, 4039, 3643, 3197, 2719, -2228, -1742,
+       -1280, -855, -479, -161, 95, 290, 423, 501, 531, 521,
+       480, 417, 342, 263, -185, -114, -54, -5, 29, 52,
+       65, 68, 65, 58, 48, 37, 26, 18, 11, 5
+};
+
+/*
+ * to produce this Q15 format cosine matrix in Octave:
+ *
+ * b = zeros(8, 16);
+ * for i = 0:7 for j = 0:15 b(i+1, j+1) = cos( (i + 0.5) * (j - 4) * (pi/8) ) endfor endfor;
+ * cosfixed = b*2^15;
+ * for i = 1:8 for j = 1:16 if(cosfixed(i,j) == 32768) cosfixed(i,j) = 32767; endif; endfor; endfor;
+ * printf("%d, ", cosfixed');
+ */
+static const signed short cos_table_fixed_8[128] = {
+        23170, 27245, 30273, 32138, 32767, 32138, 30273, 27245,
+	23170, 18204, 12539, 6392, 0, -6392, -12539, -18204,
+	-23170, -6392, 12539, 27245, 32767, 27245, 12539, -6392,
+	-23170, -32138, -30273, -18204, 0, 18204, 30273, 32138,
+	-23170, -32138, -12539, 18204, 32767, 18204, -12539, -32138,
+	-23170, 6392, 30273, 27245, 0, -27245, -30273, -6392,
+	23170, -18204, -30273, 6392, 32767, 6392, -30273, -18204,
+	23170, 27245, -12539, -32138, 0, 32138, 12539, -27245,
+	23170, 18204, -30273, -6392, 32767, -6392, -30273, 18204,
+	23170, -27245, -12539, 32138, 0, -32138, 12539, 27245,
+	-23170, 32138, -12539, -18204, 32767, -18204, -12539, 32138,
+	-23170, -6392, 30273, -27245, 0, 27245, -30273, 6392,
+	-23170, 6392, 12539, -27245, 32767, -27245, 12539, 6392,
+	-23170, 32138, -30273, 18204, 0, -18204, 30273, -32138,
+	23170, -27245, 30273, -32138, 32767, -32138, 30273, -27245,
+	23170, -18204, 12539, -6392, 0, 6392, -12539, 18204
+};
-- 
1.5.4.3


--=-h7UKt5O7VN3MJpnna9Y3--

