Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point
	encoding
From: Jaska Uimonen <jaska.uimonen@nokia.com>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: ext Brad Midgley <bmidgley@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200812170037.48141.siarhei.siamashka@nokia.com>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <200812151454.19090.siarhei.siamashka@nokia.com>
	 <d89ddf300812150716y7ac88ee5y19baf38a4d91bcfb@mail.gmail.com>
	 <200812170037.48141.siarhei.siamashka@nokia.com>
Content-Type: multipart/mixed; boundary="=-zJzX5vNYHzrcdtEBi6ok"
Date: Wed, 17 Dec 2008 10:16:34 +0200
Message-Id: <1229501794.20555.73.camel@esdhcp03999.research.nokia.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-zJzX5vNYHzrcdtEBi6ok
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello All,

Sorry about the silence, I was away from the office for 
couple of weeks.

Anyway here is the original patch modified to suit the 
bluez coding conventions. There might still be something 
(I'm quite bad with these issues...)

I also added Siarhei's rounding stuff to the filter 
tables. Good point Siarhei!

Concerning Brad's comments I think the calculation 
of tables should now be quite clear. There are 
comments on the tables how to produce them in Octave and 
the filtering function is very basic fixed point Q15 
calculation. 

I agree that including the original float values to the 
code would probably be a good idea. Then we could just 
use some macro at compile time to modify them to suitable 
Q format and original values would always be there to 
be viewed and compared to.

I would still be careful about the optimization of the 
filtering, so that we don't obfuscate the code too much. 
The filter and cosine table are quite small so we should 
consider how much we save in computation. Anyway if the savings 
are significant let's just add them there.

br,
Jaska Uimonen


 
 


On Wed, 2008-12-17 at 00:37 +0200, Siarhei Siamashka wrote:
> On Monday 15 December 2008 17:16:58 ext Brad Midgley wrote:
> > I like your idea of using a macro with the original floating point
> > tables, as long as we know it is done at compile time, not runtime :)
> 
> What about something like this modification to Jaska's patch? It contains
> floating point constants wrapped into a macro.
> 
> This version is using 16-bit multiplications only (additional natural change
> would be just to convert 'sbc_encoder_state->' to int16_t because it does not
> need to be int32_t), which is good for performance for the platforms with fast
> 16-bit integer multiplication. But it is also flexible enough to be changed to
> use 32x32->64 multiplications just by replacing FIXED_A and FIXED_T types
> to int64_t and int32_t respectively (for better precision or experiments with
> conformance testing).
> 
> > > Can anybody try to remember/explain what transformations were applied to
> > > the existing fixed point implementation?
> >
> > it was done by several people and the only record we have is in cvs.
> > (part of it is in the old btsco project's cvs)
> 
> Regarding the code optimizations. Looking at the tables, It can be seen that
> 'cos_table_fixed_8[0+hop]' is always equal to 'cos_table_fixed_8[8+hop]'.
> The same is true for 'cos_table_fixed_8[1+hop]' and 'cos_table_fixed_8[7+hop]'
> So it is possible to join 't1[0] + t1[8]', 't1[1]+ t1[7]' and the other such
> pairs, effectively halving the number of counters. This looks very much like
> the optimization that was applied to the current fixed point code :)
> 
> But now it would be very interesting to see if the conformance tests pass
> rate is better with the new filtering function.
> 
> 
> Best regards,
> Siarhei Siamashka

--=-zJzX5vNYHzrcdtEBi6ok
Content-Disposition: attachment; filename*0=0001-New-function-and-tables-for-8-band-fixed-point-analy.pat; filename*1=ch
Content-Type: application/mbox; name=0001-New-function-and-tables-for-8-band-fixed-point-analy.patch
Content-Transfer-Encoding: 7bit

>From 057e455739a0011b2b7be9d5e219d809e39604ce Mon Sep 17 00:00:00 2001
From: Jaska Uimonen <jaska.uimonen@nokia.com>
Date: Mon, 15 Dec 2008 11:00:19 +0200
Subject: [PATCH] New function and tables for 8 band fixed point analysis.

---
 sbc/sbc.c        |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sbc/sbc_tables.h |   47 ++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 1 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 7072673..00a8002 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -862,6 +862,109 @@ static inline void _sbc_analyze_eight(const int32_t *in, int32_t *out)
 	out[7] = SCALE8_STAGE2( s[0] + s[1] - s[2] + s[3]);
 }
 
+static inline void _sbc_analyze_eight_modified_fixed(const int32_t *in,
+						int32_t *out)
+{
+	int32_t t[16];
+	int i = 0, hop = 0, R = 0;
+
+	/* rounding coefficient for Q15 */
+	R = 1 << (15-1);
+
+	/* low pass polyphase filter */
+	t[0] = (int32_t)in[0] * _sbc_proto_fixed8[0];
+	t[1] = (int32_t)in[1] * _sbc_proto_fixed8[1];
+	t[2] = (int32_t)in[2] * _sbc_proto_fixed8[2];
+	t[3] = (int32_t)in[3] * _sbc_proto_fixed8[3];
+	t[4] = (int32_t)in[4] * _sbc_proto_fixed8[4];
+	t[5] = (int32_t)in[5] * _sbc_proto_fixed8[5];
+	t[6] = (int32_t)in[6] * _sbc_proto_fixed8[6];
+	t[7] = (int32_t)in[7] * _sbc_proto_fixed8[7];
+	t[8] = (int32_t)in[8] * _sbc_proto_fixed8[8];
+	t[9] = (int32_t)in[9] * _sbc_proto_fixed8[9];
+	t[10] = (int32_t)in[10] * _sbc_proto_fixed8[10];
+	t[11] = (int32_t)in[11] * _sbc_proto_fixed8[11];
+	t[12] = (int32_t)in[12] * _sbc_proto_fixed8[12];
+	t[13] = (int32_t)in[13] * _sbc_proto_fixed8[13];
+	t[14] = (int32_t)in[14] * _sbc_proto_fixed8[14];
+	t[15] = (int32_t)in[15] * _sbc_proto_fixed8[15];
+
+	hop = 16;
+	for (i = 0; i < 4; i++) {
+		t[0] += (int32_t)in[hop] * _sbc_proto_fixed8[hop];
+		t[1] += (int32_t)in[hop + 1] * _sbc_proto_fixed8[hop + 1];
+		t[2] += (int32_t)in[hop + 2] * _sbc_proto_fixed8[hop + 2];
+		t[3] += (int32_t)in[hop + 3] * _sbc_proto_fixed8[hop + 3];
+		t[4] += (int32_t)in[hop + 4] * _sbc_proto_fixed8[hop + 4];
+		t[5] += (int32_t)in[hop + 5] * _sbc_proto_fixed8[hop + 5];
+		t[6] += (int32_t)in[hop + 6] * _sbc_proto_fixed8[hop + 6];
+		t[7] += (int32_t)in[hop + 7] * _sbc_proto_fixed8[hop + 7];
+		t[8] += (int32_t)in[hop + 8] * _sbc_proto_fixed8[hop + 8];
+		t[9] += (int32_t)in[hop + 9] * _sbc_proto_fixed8[hop + 9];
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
+		out[i] = 0;
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
@@ -879,7 +982,8 @@ static inline void sbc_analyze_eight(struct sbc_encoder_state *state,
 	x[86] = x[6] = pcm[1];
 	x[87] = x[7] = pcm[0];
 
-	_sbc_analyze_eight(x, frame->sb_sample_f[blk][ch]);
+	/* _sbc_analyze_eight(x, frame->sb_sample_f[blk][ch]); */
+	_sbc_analyze_eight_modified_fixed(x, frame->sb_sample_f[blk][ch]);
 
 	state->position[ch] -= 8;
 	if (state->position[ch] < 0)
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index f5daaa7..766b20f 100644
--- a/sbc/sbc_tables.h
+++ b/sbc/sbc_tables.h
@@ -166,3 +166,50 @@ static const int32_t synmatrix8[16][8] = {
 	{ SN8(0xf9592678), SN8(0x018f8b84), SN8(0x07d8a5f0), SN8(0x0471ced0),
 	  SN8(0xfb8e3130), SN8(0xf8275a10), SN8(0xfe70747c), SN8(0x06a6d988) }
 };
+
+/*
+ * to produce this Q15 format table:
+ *
+ * get the filter coeffs from the spec and multiply them by 2^15 and round
+ * to nearest integer.
+ */
+static const signed short _sbc_proto_fixed8[80] = {
+	0, 5, 11, 18, 27, 37, 48, 58, 66, 69,
+	65, 53, 30, -6, -54, -115, 185, 263, 343, 418,
+	480, 521, 532, 502, 424, 290, 96, -161, -480, -856,
+	-1280, -1743, 2228, 2719, 3197, 3644, 4039, 4367, 4612, 4764,
+	4815, 4764, 4612, 4367, 4039, 3644, 3197, 2719, -2228, -1743,
+	-1280, -856, -480, -161, 96, 290, 424, 502, 532, 521,
+	480, 418, 343, 263, -185, -115, -54, -6, 30, 53,
+	65, 69, 66, 58, 48, 37, 27, 18, 11, 5
+};
+
+/*
+ * to produce this Q15 format cosine matrix in Octave:
+ *
+ * b = zeros(8, 16);
+ * for i = 0:7 for j = 0:15 b(i+1, j+1) =...
+ * cos( (i + 0.5) * (j - 4) * (pi/8) ) endfor endfor;
+ * cosfixed = round(b*2^15);
+ * for i = 1:8 for j = 1:16 if(cosfixed(i,j) == 32768) cosfixed(i,j) =...
+ * 32767; endif; endfor; endfor;
+ * printf("%d, ", cosfixed');
+ */
+static const signed short cos_table_fixed_8[128] = {
+	23170, 27246, 30274, 32138, 32767, 32138, 30274, 27246,
+	23170, 18205, 12540, 6393, 0, -6393, -12540, -18205,
+	-23170, -6393, 12540, 27246, 32767, 27246, 12540, -6393,
+	-23170, -32138, -30274, -18205, 0, 18205, 30274, 32138,
+	-23170, -32138, -12540, 18205, 32767, 18205, -12540, -32138,
+	-23170, 6393, 30274, 27246, 0, -27246, -30274, -6393,
+	23170, -18205, -30274, 6393, 32767, 6393, -30274, -18205,
+	23170, 27246, -12540, -32138, 0, 32138, 12540, -27246,
+	23170, 18205, -30274, -6393, 32767, -6393, -30274, 18205,
+	23170, -27246, -12540, 32138, 0, -32138, 12540, 27246,
+	-23170, 32138, -12540, -18205, 32767, -18205, -12540, 32138,
+	-23170, -6393, 30274, -27246, 0, 27246, -30274, 6393,
+	-23170, 6393, 12540, -27246, 32767, -27246, 12540, 6393,
+	-23170, 32138, -30274, 18205, 0, -18205, 30274, -32138,
+	23170, -27246, 30274, -32138, 32767, -32138, 30274, -27246,
+	23170, -18205, 12540, -6393, 0, 6393, -12540, 18205
+};
-- 
1.5.4.3


--=-zJzX5vNYHzrcdtEBi6ok--

