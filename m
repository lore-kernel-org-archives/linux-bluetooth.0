Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point encoding
Date: Sat, 20 Dec 2008 00:12:08 +0200
Cc: "Jaska Uimonen" <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com> <d89ddf300812150716y7ac88ee5y19baf38a4d91bcfb@mail.gmail.com> <200812170037.48141.siarhei.siamashka@nokia.com>
In-Reply-To: <200812170037.48141.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4wBTJGkhw3nN9y+"
Message-Id: <200812200012.08430.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_4wBTJGkhw3nN9y+
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 17 December 2008 00:37:48 ext Siarhei Siamashka wrote:
> On Monday 15 December 2008 17:16:58 ext Brad Midgley wrote:
> > I like your idea of using a macro with the original floating point
> > tables, as long as we know it is done at compile time, not runtime :)
>
> What about something like this modification to Jaska's patch? It contains
> floating point constants wrapped into a macro.
>
> This version is using 16-bit multiplications only (additional natural
> change would be just to convert 'sbc_encoder_state->' to int16_t because it
> does not need to be int32_t), which is good for performance for the
> platforms with fast 16-bit integer multiplication. But it is also flexible
> enough to be changed to use 32x32->64 multiplications just by replacing
> FIXED_A and FIXED_T types to int64_t and int32_t respectively (for better
> precision or experiments with conformance testing).
>
> > > Can anybody try to remember/explain what transformations were applied
> > > to the existing fixed point implementation?
> >
> > it was done by several people and the only record we have is in cvs.
> > (part of it is in the old btsco project's cvs)
>
> Regarding the code optimizations. Looking at the tables, It can be seen
> that 'cos_table_fixed_8[0+hop]' is always equal to
> 'cos_table_fixed_8[8+hop]'. The same is true for 'cos_table_fixed_8[1+hop]'
> and 'cos_table_fixed_8[7+hop]' So it is possible to join 't1[0] + t1[8]',
> 't1[1]+ t1[7]' and the other such pairs, effectively halving the number of
> counters. This looks very much like the optimization that was applied to
> the current fixed point code :)
>
> But now it would be very interesting to see if the conformance tests pass
> rate is better with the new filtering function.

Here is one more attempt at improving filtering function. Now I tried to get
the best possible audio quality (using 32-bit fixed point).

16-bit version of filtering function can be enabled by just commenting
out '#define SBC_HIGH_PRECISION' line

The improvements include fixing a problem in scalefactors processing code.
Here we don't want to use the absolute value just because it is possible to
encode more negative values than positive values with the same number
of bits:
-	while (scalefactor[ch][sb] < fabs(frame->sb_sample_f[blk][ch][sb])) {
+	while ((scalefactor[ch][sb] << SCALE_OUT_BITS) <= 
neginv(frame->sb_sample_f[blk][ch][sb])) {

Another quality improvement is achieved by keeping more bits in the output of
filtering function, thus avoiding unnecessary precision loss on quantizing
stage.

Both of these changes also naturally improve audio quality for the 16-bit
variant.

We had a talk with Jaska Uimonen here, and now I'm kind of delegated to finish
the work on this filtering function for SBC encoder (including the final
addition of ARM assembly optimizations).  He provided me with his last variant
of code, which contains some more optimizations to reduce the number of
operations and also loops unrolling. I will add his changes to the patch on
next iteration.

Now the question is how to best integrate a fixed filtering function to git
repository? If I just continue adding changes to the patch in order to make it
a faster, it will be also not so obvious to see how we got to these code
transformations just from the commit log.

I intentionally keep posting work-in-progress variants just to keep track of
the history at least in this mailing list archive :)

As always, feedback is very much welcome.

Best regards,
Siarhei Siamashka

--Boundary-00=_4wBTJGkhw3nN9y+
Content-Type: text/x-diff;
  charset="utf-8";
  name="analyze_eight_modified_32bit.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="analyze_eight_modified_32bit.diff"

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 5411893..873c370 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -40,6 +40,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <sys/types.h>
+#include <limits.h>
 
 #include "sbc_math.h"
 #include "sbc_tables.h"
@@ -742,124 +743,108 @@ static inline void sbc_analyze_four(struct sbc_encoder_state *state,
 
 static inline void _sbc_analyze_eight(const int32_t *in, int32_t *out)
 {
-	sbc_fixed_t t[8], s[8];
-
-	t[0] = SCALE8_STAGE1( /* Q10 */
-		MULA(_sbc_proto_8[0], (in[16] - in[64]), /* Q18 = Q18 * Q0 */
-		MULA(_sbc_proto_8[1], (in[32] - in[48]),
-		MULA(_sbc_proto_8[2], in[4],
-		MULA(_sbc_proto_8[3], in[20],
-		MULA(_sbc_proto_8[4], in[36],
-		MUL( _sbc_proto_8[5], in[52])))))));
-
-	t[1] = SCALE8_STAGE1(
-		MULA(_sbc_proto_8[6], in[2],
-		MULA(_sbc_proto_8[7], in[18],
-		MULA(_sbc_proto_8[8], in[34],
-		MULA(_sbc_proto_8[9], in[50],
-		MUL(_sbc_proto_8[10], in[66]))))));
-
-	t[2] = SCALE8_STAGE1(
-		MULA(_sbc_proto_8[11], in[1],
-		MULA(_sbc_proto_8[12], in[17],
-		MULA(_sbc_proto_8[13], in[33],
-		MULA(_sbc_proto_8[14], in[49],
-		MULA(_sbc_proto_8[15], in[65],
-		MULA(_sbc_proto_8[16], in[3],
-		MULA(_sbc_proto_8[17], in[19],
-		MULA(_sbc_proto_8[18], in[35],
-		MULA(_sbc_proto_8[19], in[51],
-		MUL( _sbc_proto_8[20], in[67])))))))))));
-
-	t[3] = SCALE8_STAGE1(
-		MULA( _sbc_proto_8[21], in[5],
-		MULA( _sbc_proto_8[22], in[21],
-		MULA( _sbc_proto_8[23], in[37],
-		MULA( _sbc_proto_8[24], in[53],
-		MULA( _sbc_proto_8[25], in[69],
-		MULA(-_sbc_proto_8[15], in[15],
-		MULA(-_sbc_proto_8[14], in[31],
-		MULA(-_sbc_proto_8[13], in[47],
-		MULA(-_sbc_proto_8[12], in[63],
-		MUL( -_sbc_proto_8[11], in[79])))))))))));
-
-	t[4] = SCALE8_STAGE1(
-		MULA( _sbc_proto_8[26], in[6],
-		MULA( _sbc_proto_8[27], in[22],
-		MULA( _sbc_proto_8[28], in[38],
-		MULA( _sbc_proto_8[29], in[54],
-		MULA( _sbc_proto_8[30], in[70],
-		MULA(-_sbc_proto_8[10], in[14],
-		MULA(-_sbc_proto_8[9], in[30],
-		MULA(-_sbc_proto_8[8], in[46],
-		MULA(-_sbc_proto_8[7], in[62],
-		MUL( -_sbc_proto_8[6], in[78])))))))))));
-
-	t[5] = SCALE8_STAGE1(
-		MULA( _sbc_proto_8[31], in[7],
-		MULA( _sbc_proto_8[32], in[23],
-		MULA( _sbc_proto_8[33], in[39],
-		MULA( _sbc_proto_8[34], in[55],
-		MULA( _sbc_proto_8[35], in[71],
-		MULA(-_sbc_proto_8[20], in[13],
-		MULA(-_sbc_proto_8[19], in[29],
-		MULA(-_sbc_proto_8[18], in[45],
-		MULA(-_sbc_proto_8[17], in[61],
-		MUL( -_sbc_proto_8[16], in[77])))))))))));
-
-	t[6] = SCALE8_STAGE1(
-		MULA( _sbc_proto_8[36], (in[8] + in[72]),
-		MULA( _sbc_proto_8[37], (in[24] + in[56]),
-		MULA( _sbc_proto_8[38], in[40],
-		MULA(-_sbc_proto_8[39], in[12],
-		MULA(-_sbc_proto_8[5], in[28],
-		MULA(-_sbc_proto_8[4], in[44],
-		MULA(-_sbc_proto_8[3], in[60],
-		MUL( -_sbc_proto_8[2], in[76])))))))));
-
-	t[7] = SCALE8_STAGE1(
-		MULA( _sbc_proto_8[35], in[9],
-		MULA( _sbc_proto_8[34], in[25],
-		MULA( _sbc_proto_8[33], in[41],
-		MULA( _sbc_proto_8[32], in[57],
-		MULA( _sbc_proto_8[31], in[73],
-		MULA(-_sbc_proto_8[25], in[11],
-		MULA(-_sbc_proto_8[24], in[27],
-		MULA(-_sbc_proto_8[23], in[43],
-		MULA(-_sbc_proto_8[22], in[59],
-		MUL( -_sbc_proto_8[21], in[75])))))))))));
-
-	s[0] = MULA(  _anamatrix8[0], t[0],
-		MUL(  _anamatrix8[1], t[6]));
-	s[1] = MUL(   _anamatrix8[7], t[1]);
-	s[2] = MULA(  _anamatrix8[2], t[2],
-		MULA( _anamatrix8[3], t[3],
-		MULA( _anamatrix8[4], t[5],
-		MUL(  _anamatrix8[5], t[7]))));
-	s[3] = MUL(   _anamatrix8[6], t[4]);
-	s[4] = MULA(  _anamatrix8[3], t[2],
-		MULA(-_anamatrix8[5], t[3],
-		MULA(-_anamatrix8[2], t[5],
-		MUL( -_anamatrix8[4], t[7]))));
-	s[5] = MULA(  _anamatrix8[4], t[2],
-		MULA(-_anamatrix8[2], t[3],
-		MULA( _anamatrix8[5], t[5],
-		MUL(  _anamatrix8[3], t[7]))));
-	s[6] = MULA(  _anamatrix8[1], t[0],
-		MUL( -_anamatrix8[0], t[6]));
-	s[7] = MULA(  _anamatrix8[5], t[2],
-		MULA(-_anamatrix8[4], t[3],
-		MULA( _anamatrix8[3], t[5],
-		MUL( -_anamatrix8[2], t[7]))));
-
-	out[0] = SCALE8_STAGE2( s[0] + s[1] + s[2] + s[3]);
-	out[1] = SCALE8_STAGE2( s[1] - s[3] + s[4] + s[6]);
-	out[2] = SCALE8_STAGE2( s[1] - s[3] + s[5] - s[6]);
-	out[3] = SCALE8_STAGE2(-s[0] + s[1] + s[3] + s[7]);
-	out[4] = SCALE8_STAGE2(-s[0] + s[1] + s[3] - s[7]);
-	out[5] = SCALE8_STAGE2( s[1] - s[3] - s[5] - s[6]);
-	out[6] = SCALE8_STAGE2( s[1] - s[3] - s[4] + s[6]);
-	out[7] = SCALE8_STAGE2( s[0] + s[1] - s[2] + s[3]);
+	FIXED_A t1[16];
+	FIXED_T t2[16];
+	FIXED_A R;
+	int i, hop;
+
+	/* rounding coefficient */
+	R = (FIXED_A)1 << (SBC_PROTO_FIXED8_SCALE-1);
+
+	/* low pass polyphase filter */
+	t1[0] =  (FIXED_A)in[0] * _sbc_proto_fixed8[0];
+	t1[1] =  (FIXED_A)in[1] * _sbc_proto_fixed8[1];
+	t1[2] =  (FIXED_A)in[2] * _sbc_proto_fixed8[2];
+	t1[3] =  (FIXED_A)in[3] * _sbc_proto_fixed8[3];
+	t1[4] =  (FIXED_A)in[4] * _sbc_proto_fixed8[4];
+	t1[5] =  (FIXED_A)in[5] * _sbc_proto_fixed8[5];
+	t1[6] =  (FIXED_A)in[6] * _sbc_proto_fixed8[6];
+	t1[7] =  (FIXED_A)in[7] * _sbc_proto_fixed8[7];
+	t1[8] =  (FIXED_A)in[8] * _sbc_proto_fixed8[8];
+	t1[9] =  (FIXED_A)in[9] * _sbc_proto_fixed8[9];
+	t1[10] = (FIXED_A)in[10] * _sbc_proto_fixed8[10];
+	t1[11] = (FIXED_A)in[11] * _sbc_proto_fixed8[11];
+	/* t1[12] = (FIXED_A)in[12] * _sbc_proto_fixed8[12]; */
+	t1[13] = (FIXED_A)in[13] * _sbc_proto_fixed8[13];
+	t1[14] = (FIXED_A)in[14] * _sbc_proto_fixed8[14];
+	t1[15] = (FIXED_A)in[15] * _sbc_proto_fixed8[15];
+
+	hop = 16;
+	for (i = 0; i < 4; i++) {
+		t1[0] +=  (FIXED_A)in[hop] * _sbc_proto_fixed8[hop];
+		t1[1] +=  (FIXED_A)in[hop + 1] * _sbc_proto_fixed8[hop + 1];
+		t1[2] +=  (FIXED_A)in[hop + 2] * _sbc_proto_fixed8[hop + 2];
+		t1[3] +=  (FIXED_A)in[hop + 3] * _sbc_proto_fixed8[hop + 3];
+		t1[4] +=  (FIXED_A)in[hop + 4] * _sbc_proto_fixed8[hop + 4];
+		t1[5] +=  (FIXED_A)in[hop + 5] * _sbc_proto_fixed8[hop + 5];
+		t1[6] +=  (FIXED_A)in[hop + 6] * _sbc_proto_fixed8[hop + 6];
+		t1[7] +=  (FIXED_A)in[hop + 7] * _sbc_proto_fixed8[hop + 7];
+		t1[8] +=  (FIXED_A)in[hop + 8] * _sbc_proto_fixed8[hop + 8];
+		t1[9] +=  (FIXED_A)in[hop + 9] * _sbc_proto_fixed8[hop + 9];
+		t1[10] += (FIXED_A)in[hop + 10] * _sbc_proto_fixed8[hop + 10];
+		t1[11] += (FIXED_A)in[hop + 11] * _sbc_proto_fixed8[hop + 11];
+		/* t1[12] += (FIXED_A)in[hop + 12] * _sbc_proto_fixed8[hop + 12]; */
+		t1[13] += (FIXED_A)in[hop + 13] * _sbc_proto_fixed8[hop + 13];
+		t1[14] += (FIXED_A)in[hop + 14] * _sbc_proto_fixed8[hop + 14];
+		t1[15] += (FIXED_A)in[hop + 15] * _sbc_proto_fixed8[hop + 15];
+		
+		hop += 16;
+	}
+
+	/* scaling */
+	t2[0] = (t1[0] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[1] = (t1[1] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[2] = (t1[2] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[3] = (t1[3] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[4] = (t1[4] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[5] = (t1[5] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[6] = (t1[6] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[7] = (t1[7] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[8] = (t1[8] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[9] = (t1[9] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[10] = (t1[10] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[11] = (t1[11] + R) >> SBC_PROTO_FIXED8_SCALE;
+	/* t2[12] = (t1[12] + R) >> SBC_PROTO_FIXED8_SCALE; */
+	t2[13] = (t1[13] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[14] = (t1[14] + R) >> SBC_PROTO_FIXED8_SCALE;
+	t2[15] = (t1[15] + R) >> SBC_PROTO_FIXED8_SCALE;
+
+	R = (FIXED_A)1 << (SBC_COS_TABLE_FIXED8_SCALE-1-SCALE_OUT_BITS);
+
+	/* do the cos transform */
+	hop = 0;
+	for (i = 0; i < 8; i++) {
+		t1[i]  = (FIXED_A)t2[0] * cos_table_fixed_8[0 + hop];
+		t1[i] += (FIXED_A)t2[1] * cos_table_fixed_8[1 + hop];
+		t1[i] += (FIXED_A)t2[2] * cos_table_fixed_8[2 + hop];
+		t1[i] += (FIXED_A)t2[3] * cos_table_fixed_8[3 + hop];
+		/* cos_table_fixed_8[4 + hop] = 1.0 */
+		t1[i] += (FIXED_A)t2[4] << (sizeof(FIXED_T)*CHAR_BIT-1);
+		t1[i] += (FIXED_A)t2[5] * cos_table_fixed_8[5 + hop];
+		t1[i] += (FIXED_A)t2[6] * cos_table_fixed_8[6 + hop];
+		t1[i] += (FIXED_A)t2[7] * cos_table_fixed_8[7 + hop];
+		t1[i] += (FIXED_A)t2[8] * cos_table_fixed_8[8 + hop];
+		t1[i] += (FIXED_A)t2[9] * cos_table_fixed_8[9 + hop];
+		t1[i] += (FIXED_A)t2[10] * cos_table_fixed_8[10 + hop];
+		t1[i] += (FIXED_A)t2[11] * cos_table_fixed_8[11 + hop];
+		/* cos_table_fixed_8[12 + hop] = 0.0 */
+		/* t1[i] += (FIXED_A)t2[12] * cos_table_fixed_8[12 + hop]; */
+		t1[i] += (FIXED_A)t2[13] * cos_table_fixed_8[13 + hop];
+		t1[i] += (FIXED_A)t2[14] * cos_table_fixed_8[14 + hop];
+		t1[i] += (FIXED_A)t2[15] * cos_table_fixed_8[15 + hop];
+
+		hop += 16;
+	}
+
+	/* scaling */
+	out[0] = (t1[0] + R) >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[1] = (t1[1] + R) >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[2] = (t1[2] + R) >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[3] = (t1[3] + R) >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[4] = (t1[4] + R) >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[5] = (t1[5] + R) >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[6] = (t1[6] + R) >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[7] = (t1[7] + R) >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
 }
 
 static inline void sbc_analyze_eight(struct sbc_encoder_state *state,
@@ -1006,7 +991,7 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 			frame->scale_factor[ch][sb] = 0;
 			scalefactor[ch][sb] = 2;
 			for (blk = 0; blk < frame->blocks; blk++) {
-				while (scalefactor[ch][sb] < fabs(frame->sb_sample_f[blk][ch][sb])) {
+				while ((scalefactor[ch][sb] << SCALE_OUT_BITS) <= neginv(frame->sb_sample_f[blk][ch][sb])) {
 					frame->scale_factor[ch][sb]++;
 					scalefactor[ch][sb] *= 2;
 				}
@@ -1040,11 +1025,11 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 						frame->sb_sample_f[blk][1][sb]) >> 1;
 
 				/* calculate scale_factor_j and scalefactor_j for joint case */
-				while (scalefactor_j[0] < fabs(sb_sample_j[blk][0])) {
+				while ((scalefactor_j[0] << SCALE_OUT_BITS) <= neginv(sb_sample_j[blk][0])) {
 					scale_factor_j[0]++;
 					scalefactor_j[0] *= 2;
 				}
-				while (scalefactor_j[1] < fabs(sb_sample_j[blk][1])) {
+				while ((scalefactor_j[1] << SCALE_OUT_BITS) <= neginv(sb_sample_j[blk][1])) {
 					scale_factor_j[1]++;
 					scalefactor_j[1] *= 2;
 				}
@@ -1100,11 +1085,11 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 		for (ch = 0; ch < frame->channels; ch++) {
 			for (sb = 0; sb < frame->subbands; sb++) {
 				if (levels[ch][sb] > 0) {
-					audio_sample =
-						(uint16_t) (((((int64_t)frame->sb_sample_f[blk][ch][sb]*levels[ch][sb]) >>
-									(frame->scale_factor[ch][sb] + 1)) +
-								levels[ch][sb]) >> 1);
-					PUT_BITS(audio_sample & levels[ch][sb], bits[ch][sb]);
+					int32_t sample = frame->sb_sample_f[blk][ch][sb];
+					int32_t s_shift = (frame->scale_factor[ch][sb] + 1 + SCALE_OUT_BITS);
+					int32_t ls = levels[ch][sb];
+					audio_sample = ((((int64_t)1 << s_shift) + sample) * ls) >> (s_shift + 1);
+					PUT_BITS(audio_sample, bits[ch][sb]);
 				}
 			}
 		}
diff --git a/sbc/sbc_math.h b/sbc/sbc_math.h
index b3d87a6..b53e3d1 100644
--- a/sbc/sbc_math.h
+++ b/sbc/sbc_math.h
@@ -23,12 +23,14 @@
  *
  */
 
-#define fabs(x) ((x) < 0 ? -(x) : (x))
+#define neginv(x) ((x) < 0 ? ~(x) : (x))
 /* C does not provide an explicit arithmetic shift right but this will
    always be correct and every compiler *should* generate optimal code */
 #define ASR(val, bits) ((-2 >> 1 == -1) ? \
 		 ((int32_t)(val)) >> (bits) : ((int32_t) (val)) / (1 << (bits)))
 
+#define SCALE_OUT_BITS 14
+
 #define SCALE_PROTO4_TBL	15
 #define SCALE_ANA4_TBL		17
 #define SCALE_PROTO8_TBL	16
@@ -38,7 +40,7 @@
 #define SCALE_NPROTO4_TBL	11
 #define SCALE_NPROTO8_TBL	11
 #define SCALE4_STAGE1_BITS	15
-#define SCALE4_STAGE2_BITS	16
+#define SCALE4_STAGE2_BITS	(16-SCALE_OUT_BITS)
 #define SCALE4_STAGED1_BITS	15
 #define SCALE4_STAGED2_BITS	16
 #define SCALE8_STAGE1_BITS	15
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index f5daaa7..eeea7b7 100644
--- a/sbc/sbc_tables.h
+++ b/sbc/sbc_tables.h
@@ -166,3 +166,88 @@ static const int32_t synmatrix8[16][8] = {
 	{ SN8(0xf9592678), SN8(0x018f8b84), SN8(0x07d8a5f0), SN8(0x0471ced0),
 	  SN8(0xfb8e3130), SN8(0xf8275a10), SN8(0xfe70747c), SN8(0x06a6d988) }
 };
+
+#define SBC_HIGH_PRECISION
+
+#ifdef SBC_HIGH_PRECISION
+# define FIXED_A int64_t /* data type for fixed point accumulator */
+# define FIXED_T int32_t /* data type for fixed point constants */
+# define SBC_FIXED8_EXTRA_BITS 15
+#else
+# define FIXED_A int32_t /* data type for fixed point accumulator */
+# define FIXED_T int16_t /* data type for fixed point constants */
+# define SBC_FIXED8_EXTRA_BITS 0
+#endif
+
+/* A2DP specification: Section 12.8 Tables */
+#define SBC_PROTO_FIXED8_SCALE (sizeof(FIXED_T)*CHAR_BIT-1-SBC_FIXED8_EXTRA_BITS)
+#define F(x) (FIXED_T)(FIXED_A)((x)*((FIXED_A)1<<(sizeof(FIXED_T)*CHAR_BIT-1))+0.5)
+static const FIXED_T _sbc_proto_fixed8[80] = {
+	 F(0.00000000E+00), F(1.56575398E-04), F(3.43256425E-04), F(5.54620202E-04),
+	 F(8.23919506E-04), F(1.13992507E-03), F(1.47640169E-03), F(1.78371725E-03),
+	 F(2.01182542E-03), F(2.10371989E-03), F(1.99454554E-03), F(1.61656283E-03),
+	 F(9.02154502E-04),-F(1.78805361E-04),-F(1.64973098E-03),-F(3.49717454E-03),
+	 F(5.65949473E-03), F(8.02941163E-03), F(1.04584443E-02), F(1.27472335E-02),
+	 F(1.46525263E-02), F(1.59045603E-02), F(1.62208471E-02), F(1.53184106E-02),
+	 F(1.29371806E-02), F(8.85757540E-03), F(2.92408442E-03),-F(4.91578024E-03),
+	-F(1.46404076E-02),-F(2.61098752E-02),-F(3.90751381E-02),-F(5.31873032E-02),
+	 F(6.79989431E-02), F(8.29847578E-02), F(9.75753918E-02), F(1.11196689E-01),
+	 F(1.23264548E-01), F(1.33264415E-01), F(1.40753505E-01), F(1.45389847E-01),
+	 F(1.46955068E-01), F(1.45389847E-01), F(1.40753505E-01), F(1.33264415E-01),
+	 F(1.23264548E-01), F(1.11196689E-01), F(9.75753918E-02), F(8.29847578E-02),
+	-F(6.79989431E-02),-F(5.31873032E-02),-F(3.90751381E-02),-F(2.61098752E-02),
+	-F(1.46404076E-02),-F(4.91578024E-03), F(2.92408442E-03), F(8.85757540E-03),
+	 F(1.29371806E-02), F(1.53184106E-02), F(1.62208471E-02), F(1.59045603E-02),
+	 F(1.46525263E-02), F(1.27472335E-02), F(1.04584443E-02), F(8.02941163E-03),
+	-F(5.65949473E-03),-F(3.49717454E-03),-F(1.64973098E-03),-F(1.78805361E-04),
+	 F(9.02154502E-04), F(1.61656283E-03), F(1.99454554E-03), F(2.10371989E-03),
+	 F(2.01182542E-03), F(1.78371725E-03), F(1.47640169E-03), F(1.13992507E-03),
+	 F(8.23919506E-04), F(5.54620202E-04), F(3.43256425E-04), F(1.56575398E-04),
+};
+#undef F
+
+/*
+ * To produce this cosine matrix in Octave:
+ *
+ * b = zeros(8, 16);
+ * for i = 0:7 for j = 0:15 b(i+1, j+1) = cos( (i + 0.5) * (j - 4) * (pi/8) ) endfor endfor;
+ * printf("%.10f, ", b');
+ *
+ */
+#define SBC_COS_TABLE_FIXED8_SCALE (sizeof(FIXED_T)*CHAR_BIT-1+SBC_FIXED8_EXTRA_BITS)
+#define F(x) (FIXED_T)(FIXED_A)((x)*((FIXED_A)1<<(sizeof(FIXED_T)*CHAR_BIT-1))+0.5)
+static const FIXED_T cos_table_fixed_8[128] = {
+	 F(0.7071067812), F(0.8314696123), F(0.9238795325), F(0.9807852804),
+	 F(1.0000000000), F(0.9807852804), F(0.9238795325), F(0.8314696123),
+	 F(0.7071067812), F(0.5555702330), F(0.3826834324), F(0.1950903220),
+	 F(0.0000000000),-F(0.1950903220),-F(0.3826834324),-F(0.5555702330),
+	-F(0.7071067812),-F(0.1950903220), F(0.3826834324), F(0.8314696123),
+	 F(1.0000000000), F(0.8314696123), F(0.3826834324),-F(0.1950903220),
+	-F(0.7071067812),-F(0.9807852804),-F(0.9238795325),-F(0.5555702330),
+	-F(0.0000000000), F(0.5555702330), F(0.9238795325), F(0.9807852804),
+	-F(0.7071067812),-F(0.9807852804),-F(0.3826834324), F(0.5555702330),
+	 F(1.0000000000), F(0.5555702330),-F(0.3826834324),-F(0.9807852804),
+	-F(0.7071067812), F(0.1950903220), F(0.9238795325), F(0.8314696123),
+	 F(0.0000000000),-F(0.8314696123),-F(0.9238795325),-F(0.1950903220),
+	 F(0.7071067812),-F(0.5555702330),-F(0.9238795325), F(0.1950903220),
+	 F(1.0000000000), F(0.1950903220),-F(0.9238795325),-F(0.5555702330),
+	 F(0.7071067812), F(0.8314696123),-F(0.3826834324),-F(0.9807852804),
+	-F(0.0000000000), F(0.9807852804), F(0.3826834324),-F(0.8314696123),
+	 F(0.7071067812), F(0.5555702330),-F(0.9238795325),-F(0.1950903220),
+	 F(1.0000000000),-F(0.1950903220),-F(0.9238795325), F(0.5555702330),
+	 F(0.7071067812),-F(0.8314696123),-F(0.3826834324), F(0.9807852804),
+	 F(0.0000000000),-F(0.9807852804), F(0.3826834324), F(0.8314696123),
+	-F(0.7071067812), F(0.9807852804),-F(0.3826834324),-F(0.5555702330),
+	 F(1.0000000000),-F(0.5555702330),-F(0.3826834324), F(0.9807852804),
+	-F(0.7071067812),-F(0.1950903220), F(0.9238795325),-F(0.8314696123),
+	-F(0.0000000000), F(0.8314696123),-F(0.9238795325), F(0.1950903220),
+	-F(0.7071067812), F(0.1950903220), F(0.3826834324),-F(0.8314696123),
+	 F(1.0000000000),-F(0.8314696123), F(0.3826834324), F(0.1950903220),
+	-F(0.7071067812), F(0.9807852804),-F(0.9238795325), F(0.5555702330),
+	-F(0.0000000000),-F(0.5555702330), F(0.9238795325),-F(0.9807852804),
+	 F(0.7071067812),-F(0.8314696123), F(0.9238795325),-F(0.9807852804),
+	 F(1.0000000000),-F(0.9807852804), F(0.9238795325),-F(0.8314696123),
+	 F(0.7071067812),-F(0.5555702330), F(0.3826834324),-F(0.1950903220),
+	-F(0.0000000000), F(0.1950903220),-F(0.3826834324), F(0.5555702330),
+};
+#undef F

--Boundary-00=_4wBTJGkhw3nN9y+--
