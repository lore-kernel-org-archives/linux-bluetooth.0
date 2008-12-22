Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "ext Brad Midgley" <bmidgley@gmail.com>
Subject: Re: [RFC/PATCH] sbc: new filtering function for 8 band fixed point encoding
Date: Tue, 23 Dec 2008 01:30:43 +0200
Cc: "Jaska Uimonen" <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com> <200812170037.48141.siarhei.siamashka@nokia.com> <200812200012.08430.siarhei.siamashka@nokia.com>
In-Reply-To: <200812200012.08430.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jMCUJE9ycMHBWBD"
Message-Id: <200812230130.43968.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_jMCUJE9ycMHBWBD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 20 December 2008 00:12:08 ext Siarhei Siamashka wrote:
[...]
> We had a talk with Jaska Uimonen here, and now I'm kind of delegated to
> finish the work on this filtering function for SBC encoder (including the
> final addition of ARM assembly optimizations).  He provided me with his
> last variant of code, which contains some more optimizations to reduce the
> number of operations and also loops unrolling. I will add his changes to
> the patch on next iteration.
>
> Now the question is how to best integrate a fixed filtering function to git
> repository? If I just continue adding changes to the patch in order to make
> it a faster, it will be also not so obvious to see how we got to these code
> transformations just from the commit log.

Next iteration done.  Added support for 4 subbands, number of arithmetic
operations reduced (but without loop unrolling for better code readability),
precision improved for both 16-bit and 32-bit fixed point, 'neginv' macro is
now more portable and faster. The rest is in the code comments.


Best regards,
Siarhei Siamashka

--Boundary-00=_jMCUJE9ycMHBWBD
Content-Type: text/x-diff;
  charset="utf-8";
  name="sbc_analyze_modified.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="sbc_analyze_modified.diff"

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 5411893..3d6a412 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -40,6 +40,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <sys/types.h>
+#include <limits.h>
 
 #include "sbc_math.h"
 #include "sbc_tables.h"
@@ -93,7 +94,7 @@ struct sbc_decoder_state {
 struct sbc_encoder_state {
 	int subbands;
 	int position[2];
-	int32_t X[2][160];
+	int16_t X[2][160];
 };
 
 /*
@@ -656,75 +657,56 @@ static void sbc_encoder_init(struct sbc_encoder_state *state,
 	state->position[0] = state->position[1] = 9 * frame->subbands;
 }
 
-static inline void _sbc_analyze_four(const int32_t *in, int32_t *out)
+static inline void _sbc_analyze_four(const int16_t *in, int32_t *out)
 {
-	sbc_fixed_t t[8], s[5];
-
-	t[0] = SCALE4_STAGE1( /* Q8 */
-		MULA(_sbc_proto_4[0], in[8] - in[32], /* Q18 */
-		MUL( _sbc_proto_4[1], in[16] - in[24])));
-
-	t[1] = SCALE4_STAGE1(
-		MULA(_sbc_proto_4[2], in[1],
-		MULA(_sbc_proto_4[3], in[9],
-		MULA(_sbc_proto_4[4], in[17],
-		MULA(_sbc_proto_4[5], in[25],
-		MUL( _sbc_proto_4[6], in[33]))))));
-
-	t[2] = SCALE4_STAGE1(
-		MULA(_sbc_proto_4[7], in[2],
-		MULA(_sbc_proto_4[8], in[10],
-		MULA(_sbc_proto_4[9], in[18],
-		MULA(_sbc_proto_4[10], in[26],
-		MUL( _sbc_proto_4[11], in[34]))))));
-
-	t[3] = SCALE4_STAGE1(
-		MULA(_sbc_proto_4[12], in[3],
-		MULA(_sbc_proto_4[13], in[11],
-		MULA(_sbc_proto_4[14], in[19],
-		MULA(_sbc_proto_4[15], in[27],
-		MUL( _sbc_proto_4[16], in[35]))))));
-
-	t[4] = SCALE4_STAGE1(
-		MULA(_sbc_proto_4[17], in[4] + in[36],
-		MULA(_sbc_proto_4[18], in[12] + in[28],
-		MUL( _sbc_proto_4[19], in[20]))));
-
-	t[5] = SCALE4_STAGE1(
-		MULA(_sbc_proto_4[16], in[5],
-		MULA(_sbc_proto_4[15], in[13],
-		MULA(_sbc_proto_4[14], in[21],
-		MULA(_sbc_proto_4[13], in[29],
-		MUL( _sbc_proto_4[12], in[37]))))));
-
-	/* don't compute t[6]... this term always multiplies
-	 * with cos(pi/2) = 0 */
-
-	t[7] = SCALE4_STAGE1(
-		MULA(_sbc_proto_4[6], in[7],
-		MULA(_sbc_proto_4[5], in[15],
-		MULA(_sbc_proto_4[4], in[23],
-		MULA(_sbc_proto_4[3], in[31],
-		MUL( _sbc_proto_4[2], in[39]))))));
-
-	s[0] = MUL( _anamatrix4[0], t[0] + t[4]);
-	s[1] = MUL( _anamatrix4[2], t[2]);
-	s[2] = MULA(_anamatrix4[1], t[1] + t[3],
-		MUL(_anamatrix4[3], t[5]));
-	s[3] = MULA(_anamatrix4[3], t[1] + t[3],
-		MUL(_anamatrix4[1], -t[5] + t[7]));
-	s[4] = MUL( _anamatrix4[3], t[7]);
-
-	out[0] = SCALE4_STAGE2( s[0] + s[1] + s[2] + s[4]); /* Q0 */
-	out[1] = SCALE4_STAGE2(-s[0] + s[1] + s[3]);
-	out[2] = SCALE4_STAGE2(-s[0] + s[1] - s[3]);
-	out[3] = SCALE4_STAGE2( s[0] + s[1] - s[2] - s[4]);
+	FIXED_A t1[4];
+	FIXED_T t2[4];
+	int i = 0, hop = 0;
+
+	/* rounding coefficient */
+
+	t1[0] = t1[1] = t1[2] = t1[3] =
+		(FIXED_A)1 << (SBC_PROTO_FIXED4_SCALE-1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 40; hop += 8) {
+		t1[0] +=  (FIXED_A)in[hop] * _sbc_proto_fixed4[hop];
+		t1[1] +=  (FIXED_A)in[hop + 1] * _sbc_proto_fixed4[hop + 1];
+		t1[2] +=  (FIXED_A)in[hop + 2] * _sbc_proto_fixed4[hop + 2];
+		t1[1] +=  (FIXED_A)in[hop + 3] * _sbc_proto_fixed4[hop + 3];
+		t1[0] +=  (FIXED_A)in[hop + 4] * _sbc_proto_fixed4[hop + 4];
+		t1[3] +=  (FIXED_A)in[hop + 5] * _sbc_proto_fixed4[hop + 5];
+		t1[3] +=  (FIXED_A)in[hop + 7] * _sbc_proto_fixed4[hop + 7];
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
+		/* rounding coefficient */
+		t1[i]  = (FIXED_A)1 << (SBC_COS_TABLE_FIXED4_SCALE-1-SCALE_OUT_BITS);
+		
+		t1[i] += (FIXED_A)t2[0] * cos_table_fixed_4[0 + hop];
+		t1[i] += (FIXED_A)t2[1] * cos_table_fixed_4[1 + hop];
+		t1[i] += (FIXED_A)t2[2] * cos_table_fixed_4[2 + hop];
+		t1[i] += (FIXED_A)t2[3] * cos_table_fixed_4[5 + hop];
+	}
+
+	/* scaling */
+	out[0] = t1[0] >> (SBC_COS_TABLE_FIXED4_SCALE-SCALE_OUT_BITS);
+	out[1] = t1[1] >> (SBC_COS_TABLE_FIXED4_SCALE-SCALE_OUT_BITS);
+	out[2] = t1[2] >> (SBC_COS_TABLE_FIXED4_SCALE-SCALE_OUT_BITS);
+	out[3] = t1[3] >> (SBC_COS_TABLE_FIXED4_SCALE-SCALE_OUT_BITS);
 }
 
 static inline void sbc_analyze_four(struct sbc_encoder_state *state,
 				struct sbc_frame *frame, int ch, int blk)
 {
-	int32_t *x = &state->X[ch][state->position[ch]];
+	int16_t *x = &state->X[ch][state->position[ch]];
 	int16_t *pcm = &frame->pcm_sample[ch][blk * 4];
 
 	/* Input 4 Audio Samples */
@@ -740,133 +722,80 @@ static inline void sbc_analyze_four(struct sbc_encoder_state *state,
 		state->position[ch] = 36;
 }
 
-static inline void _sbc_analyze_eight(const int32_t *in, int32_t *out)
+static inline void _sbc_analyze_eight(const int16_t *in, int32_t *out)
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
+	FIXED_A t1[8];
+	FIXED_T t2[8];
+	int i, hop;
+
+	/* rounding coefficient */
+	t1[0] = t1[1] = t1[2] = t1[3] = t1[4] = t1[5] = t1[6] = t1[7] =
+		(FIXED_A)1 << (SBC_PROTO_FIXED8_SCALE-1);
+
+	/* low pass polyphase filter */
+	for (hop = 0; hop < 80; hop += 16) {
+		t1[0] += (FIXED_A)in[hop] * _sbc_proto_fixed8[hop];
+		t1[1] += (FIXED_A)in[hop + 1] * _sbc_proto_fixed8[hop + 1];
+		t1[2] += (FIXED_A)in[hop + 2] * _sbc_proto_fixed8[hop + 2];
+		t1[3] += (FIXED_A)in[hop + 3] * _sbc_proto_fixed8[hop + 3];
+
+		t1[4] += (FIXED_A)in[hop + 4] * _sbc_proto_fixed8[hop + 4];
+
+		t1[0] += (FIXED_A)in[hop + 8] * _sbc_proto_fixed8[hop + 8];
+		t1[1] += (FIXED_A)in[hop + 7] * _sbc_proto_fixed8[hop + 7];
+		t1[2] += (FIXED_A)in[hop + 6] * _sbc_proto_fixed8[hop + 6];
+		t1[3] += (FIXED_A)in[hop + 5] * _sbc_proto_fixed8[hop + 5];
+
+		t1[5] += (FIXED_A)in[hop + 9] * _sbc_proto_fixed8[hop + 9];
+		t1[6] += (FIXED_A)in[hop + 10] * _sbc_proto_fixed8[hop + 10];
+		t1[7] += (FIXED_A)in[hop + 11] * _sbc_proto_fixed8[hop + 11];
+
+		t1[5] += (FIXED_A)in[hop + 15] * _sbc_proto_fixed8[hop + 15];
+		t1[6] += (FIXED_A)in[hop + 14] * _sbc_proto_fixed8[hop + 14];
+		t1[7] += (FIXED_A)in[hop + 13] * _sbc_proto_fixed8[hop + 13];
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
+		/* rounding coefficient */
+		t1[i] = (FIXED_A)1 << (SBC_COS_TABLE_FIXED8_SCALE-1-SCALE_OUT_BITS);
+
+		t1[i] += (FIXED_A)t2[0] * cos_table_fixed_8[0 + hop];
+		t1[i] += (FIXED_A)t2[1] * cos_table_fixed_8[1 + hop];
+		t1[i] += (FIXED_A)t2[2] * cos_table_fixed_8[2 + hop];
+		t1[i] += (FIXED_A)t2[3] * cos_table_fixed_8[3 + hop];
+		t1[i] += (FIXED_A)t2[4] * cos_table_fixed_8[4 + hop];
+		t1[i] += (FIXED_A)t2[5] * cos_table_fixed_8[9 + hop];
+		t1[i] += (FIXED_A)t2[6] * cos_table_fixed_8[10 + hop];
+		t1[i] += (FIXED_A)t2[7] * cos_table_fixed_8[11 + hop];
+	}
+
+	/* scaling */
+	out[0] = t1[0] >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[1] = t1[1] >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[2] = t1[2] >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[3] = t1[3] >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[4] = t1[4] >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[5] = t1[5] >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[6] = t1[6] >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
+	out[7] = t1[7] >> (SBC_COS_TABLE_FIXED8_SCALE-SCALE_OUT_BITS);
 }
 
 static inline void sbc_analyze_eight(struct sbc_encoder_state *state,
 					struct sbc_frame *frame, int ch,
 					int blk)
 {
-	int32_t *x = &state->X[ch][state->position[ch]];
+	int16_t *x = &state->X[ch][state->position[ch]];
 	int16_t *pcm = &frame->pcm_sample[ch][blk * 8];
 
 	/* Input 8 Audio Samples */
@@ -1006,7 +935,7 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
 			frame->scale_factor[ch][sb] = 0;
 			scalefactor[ch][sb] = 2;
 			for (blk = 0; blk < frame->blocks; blk++) {
-				while (scalefactor[ch][sb] < fabs(frame->sb_sample_f[blk][ch][sb])) {
+				while ((scalefactor[ch][sb] << SCALE_OUT_BITS) <= neginv(frame->sb_sample_f[blk][ch][sb])) {
 					frame->scale_factor[ch][sb]++;
 					scalefactor[ch][sb] *= 2;
 				}
@@ -1040,11 +969,11 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
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
@@ -1100,11 +1029,11 @@ static int sbc_pack_frame(uint8_t *data, struct sbc_frame *frame, size_t len)
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
index b3d87a6..f3937ce 100644
--- a/sbc/sbc_math.h
+++ b/sbc/sbc_math.h
@@ -23,37 +23,30 @@
  *
  */
 
-#define fabs(x) ((x) < 0 ? -(x) : (x))
 /* C does not provide an explicit arithmetic shift right but this will
    always be correct and every compiler *should* generate optimal code */
 #define ASR(val, bits) ((-2 >> 1 == -1) ? \
 		 ((int32_t)(val)) >> (bits) : ((int32_t) (val)) / (1 << (bits)))
 
-#define SCALE_PROTO4_TBL	15
-#define SCALE_ANA4_TBL		17
-#define SCALE_PROTO8_TBL	16
-#define SCALE_ANA8_TBL		17
+#define neginv(x) ((-2 >> 1 == -1) ? \
+		 ((((int32_t)(x)) >> 31) ^ (int32_t)(x)) : \
+		 ((x >= 0) ? (x) : -(x)-1))
+
+#define SCALE_OUT_BITS 14
+
 #define SCALE_SPROTO4_TBL	12
 #define SCALE_SPROTO8_TBL	14
 #define SCALE_NPROTO4_TBL	11
 #define SCALE_NPROTO8_TBL	11
-#define SCALE4_STAGE1_BITS	15
-#define SCALE4_STAGE2_BITS	16
 #define SCALE4_STAGED1_BITS	15
 #define SCALE4_STAGED2_BITS	16
-#define SCALE8_STAGE1_BITS	15
-#define SCALE8_STAGE2_BITS	15
 #define SCALE8_STAGED1_BITS	15
 #define SCALE8_STAGED2_BITS	16
 
 typedef int32_t sbc_fixed_t;
 
-#define SCALE4_STAGE1(src)  ASR(src, SCALE4_STAGE1_BITS)
-#define SCALE4_STAGE2(src)  ASR(src, SCALE4_STAGE2_BITS)
 #define SCALE4_STAGED1(src) ASR(src, SCALE4_STAGED1_BITS)
 #define SCALE4_STAGED2(src) ASR(src, SCALE4_STAGED2_BITS)
-#define SCALE8_STAGE1(src)  ASR(src, SCALE8_STAGE1_BITS)
-#define SCALE8_STAGE2(src)  ASR(src, SCALE8_STAGE2_BITS)
 #define SCALE8_STAGED1(src) ASR(src, SCALE8_STAGED1_BITS)
 #define SCALE8_STAGED2(src) ASR(src, SCALE8_STAGED2_BITS)
 
diff --git a/sbc/sbc_tables.h b/sbc/sbc_tables.h
index f5daaa7..9c96732 100644
--- a/sbc/sbc_tables.h
+++ b/sbc/sbc_tables.h
@@ -40,40 +40,11 @@ static const int sbc_offset8[4][8] = {
 };
 
 
-#define SP4(val) (((int32_t)(val))/17658) /* Used to be #define SP4(val) ASR(val, SCALE_PROTO4_TBL) but causes wrong gain */
-#define SA4(val) ASR(val, SCALE_ANA4_TBL)
-#define SP8(val) (((int32_t)(val))/57740) /* Used to be #define SP8(val) ASR(val, SCALE_PROTO8_TBL) but causes wrong gain */
-#define SA8(val) ASR(val, SCALE_ANA8_TBL)
 #define SS4(val) ASR(val, SCALE_SPROTO4_TBL)
 #define SS8(val) ASR(val, SCALE_SPROTO8_TBL)
 #define SN4(val) ASR(val, SCALE_NPROTO4_TBL)
 #define SN8(val) ASR(val, SCALE_NPROTO8_TBL)
 
-static const int32_t _sbc_proto_4[20] = {
-	SP4(0x02cb3e8c), SP4(0x22b63dc0), SP4(0x002329cc), SP4(0x053b7548),
-	SP4(0x31eab940), SP4(0xec1f5e60), SP4(0xff3773a8), SP4(0x0061c5a7),
-	SP4(0x07646680), SP4(0x3f239480), SP4(0xf89f23a8), SP4(0x007a4737),
-	SP4(0x00b32807), SP4(0x083ddc80), SP4(0x4825e480), SP4(0x0191e578),
-	SP4(0x00ff11ca), SP4(0x00fb7991), SP4(0x069fdc58), SP4(0x4b584000)
-};
-
-static const int32_t _anamatrix4[4] = {
-	SA4(0x2d413cc0), SA4(0x3b20d780), SA4(0x40000000), SA4(0x187de2a0)
-};
-
-static const int32_t _sbc_proto_8[40] = {
-	SP8(0x02e5cd20), SP8(0x22d0c200), SP8(0x006bfe27), SP8(0x07808930),
-	SP8(0x3f1c8800), SP8(0xf8810d70), SP8(0x002cfdc6), SP8(0x055acf28),
-	SP8(0x31f566c0), SP8(0xebfe57e0), SP8(0xff27c437), SP8(0x001485cc),
-	SP8(0x041c6e58), SP8(0x2a7cfa80), SP8(0xe4c4a240), SP8(0xfe359e4c),
-	SP8(0x0048b1f8), SP8(0x0686ce30), SP8(0x38eec5c0), SP8(0xf2a1b9f0),
-	SP8(0xffe8904a), SP8(0x0095698a), SP8(0x0824a480), SP8(0x443b3c00),
-	SP8(0xfd7badc8), SP8(0x00d3e2d9), SP8(0x00c183d2), SP8(0x084e1950),
-	SP8(0x4810d800), SP8(0x017f43fe), SP8(0x01056dd8), SP8(0x00e9cb9f),
-	SP8(0x07d7d090), SP8(0x4a708980), SP8(0x0488fae8), SP8(0x0113bd20),
-	SP8(0x0107b1a8), SP8(0x069fb3c0), SP8(0x4b3db200), SP8(0x00763f48)
-};
-
 static const int32_t sbc_proto_4_40m0[] = {
 	SS4(0x00000000), SS4(0xffa6982f), SS4(0xfba93848), SS4(0x0456c7b8),
 	SS4(0x005967d1), SS4(0xfffb9ac7), SS4(0xff589157), SS4(0xf9c2a8d8),
@@ -116,11 +87,6 @@ static const int32_t sbc_proto_8_80m1[] = {
 	SS8(0x0d9daee0), SS8(0xeac182c0), SS8(0xfdf1c8d4), SS8(0xfff5bd1a)
 };
 
-static const int32_t _anamatrix8[8] = {
-	SA8(0x3b20d780), SA8(0x187de2a0), SA8(0x3ec52f80), SA8(0x3536cc40),
-	SA8(0x238e7680), SA8(0x0c7c5c20), SA8(0x2d413cc0), SA8(0x40000000)
-};
-
 static const int32_t synmatrix4[8][4] = {
 	{ SN4(0x05a82798), SN4(0xfa57d868), SN4(0xfa57d868), SN4(0x05a82798) },
 	{ SN4(0x030fbc54), SN4(0xf89be510), SN4(0x07641af0), SN4(0xfcf043ac) },
@@ -166,3 +132,169 @@ static const int32_t synmatrix8[16][8] = {
 	{ SN8(0xf9592678), SN8(0x018f8b84), SN8(0x07d8a5f0), SN8(0x0471ced0),
 	  SN8(0xfb8e3130), SN8(0xf8275a10), SN8(0xfe70747c), SN8(0x06a6d988) }
 };
+
+//#define SBC_HIGH_PRECISION
+
+#ifdef SBC_HIGH_PRECISION
+# define FIXED_A int64_t /* data type for fixed point accumulator */
+# define FIXED_T int32_t /* data type for fixed point constants */
+# define SBC_FIXED8_EXTRA_BITS 16
+#else
+# define FIXED_A int32_t /* data type for fixed point accumulator */
+# define FIXED_T int16_t /* data type for fixed point constants */
+# define SBC_FIXED8_EXTRA_BITS 0
+#endif
+
+/* A2DP specification: Section 12.8 Tables 
+ *
+ * Original values are premultiplied by 4 for better precision (that is the
+ * maximum which is possible without overflows)
+ *
+ * Note: in each block of 16 numbers sign was changed for elements 4, 13, 14, 15
+ * in order to compensate the same change applied to cos_table_fixed_8
+ */
+#define SBC_PROTO_FIXED8_SCALE (sizeof(FIXED_T)*CHAR_BIT-1-SBC_FIXED8_EXTRA_BITS+2)
+#define F(x) (FIXED_A)((x*4)*((FIXED_A)1<<(sizeof(FIXED_T)*CHAR_BIT-1))+0.5)
+static const FIXED_T _sbc_proto_fixed8[80] = {
+	 F(0.00000000E+00), F(1.56575398E-04), F(3.43256425E-04), F(5.54620202E-04),
+	-F(8.23919506E-04), F(1.13992507E-03), F(1.47640169E-03), F(1.78371725E-03),
+	 F(2.01182542E-03), F(2.10371989E-03), F(1.99454554E-03), F(1.61656283E-03),
+	 F(9.02154502E-04), F(1.78805361E-04), F(1.64973098E-03), F(3.49717454E-03),
+
+	 F(5.65949473E-03), F(8.02941163E-03), F(1.04584443E-02), F(1.27472335E-02),
+	-F(1.46525263E-02), F(1.59045603E-02), F(1.62208471E-02), F(1.53184106E-02),
+	 F(1.29371806E-02), F(8.85757540E-03), F(2.92408442E-03),-F(4.91578024E-03),
+	-F(1.46404076E-02), F(2.61098752E-02), F(3.90751381E-02), F(5.31873032E-02),
+
+	 F(6.79989431E-02), F(8.29847578E-02), F(9.75753918E-02), F(1.11196689E-01),
+	-F(1.23264548E-01), F(1.33264415E-01), F(1.40753505E-01), F(1.45389847E-01),
+	 F(1.46955068E-01), F(1.45389847E-01), F(1.40753505E-01), F(1.33264415E-01),
+	 F(1.23264548E-01),-F(1.11196689E-01),-F(9.75753918E-02),-F(8.29847578E-02),
+
+	-F(6.79989431E-02),-F(5.31873032E-02),-F(3.90751381E-02),-F(2.61098752E-02),
+	 F(1.46404076E-02),-F(4.91578024E-03), F(2.92408442E-03), F(8.85757540E-03),
+	 F(1.29371806E-02), F(1.53184106E-02), F(1.62208471E-02), F(1.59045603E-02),
+	 F(1.46525263E-02),-F(1.27472335E-02),-F(1.04584443E-02),-F(8.02941163E-03),
+
+	-F(5.65949473E-03),-F(3.49717454E-03),-F(1.64973098E-03),-F(1.78805361E-04),
+	-F(9.02154502E-04), F(1.61656283E-03), F(1.99454554E-03), F(2.10371989E-03),
+	 F(2.01182542E-03), F(1.78371725E-03), F(1.47640169E-03), F(1.13992507E-03),
+	 F(8.23919506E-04),-F(5.54620202E-04),-F(3.43256425E-04),-F(1.56575398E-04),
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
+ * Note: in each block of 16 numbers sign was changed for elements 4, 13, 14, 15.
+ * Change of sign for element 4 allows to replace constant 1.0 (not representable
+ * in Q15 format) with -1.0 (fine with Q15).
+ * Changed signs for elements 13, 14, 15 allow to have more similar constants
+ * and simplify subband filter function code.
+ */
+#define SBC_COS_TABLE_FIXED8_SCALE (sizeof(FIXED_T)*CHAR_BIT-1+SBC_FIXED8_EXTRA_BITS)
+#define F(x) (FIXED_A)((x)*((FIXED_A)1<<(sizeof(FIXED_T)*CHAR_BIT-1))+0.5)
+static const FIXED_T cos_table_fixed_8[128] = {
+	 F(0.7071067812), F(0.8314696123), F(0.9238795325), F(0.9807852804),
+	-F(1.0000000000), F(0.9807852804), F(0.9238795325), F(0.8314696123),
+	 F(0.7071067812), F(0.5555702330), F(0.3826834324), F(0.1950903220),
+	 F(0.0000000000), F(0.1950903220), F(0.3826834324), F(0.5555702330),
+
+	-F(0.7071067812),-F(0.1950903220), F(0.3826834324), F(0.8314696123),
+	-F(1.0000000000), F(0.8314696123), F(0.3826834324),-F(0.1950903220),
+	-F(0.7071067812),-F(0.9807852804),-F(0.9238795325),-F(0.5555702330),
+	-F(0.0000000000),-F(0.5555702330),-F(0.9238795325),-F(0.9807852804),
+
+	-F(0.7071067812),-F(0.9807852804),-F(0.3826834324), F(0.5555702330),
+	-F(1.0000000000), F(0.5555702330),-F(0.3826834324),-F(0.9807852804),
+	-F(0.7071067812), F(0.1950903220), F(0.9238795325), F(0.8314696123),
+	 F(0.0000000000), F(0.8314696123), F(0.9238795325), F(0.1950903220),
+
+	 F(0.7071067812),-F(0.5555702330),-F(0.9238795325), F(0.1950903220),
+	-F(1.0000000000), F(0.1950903220),-F(0.9238795325),-F(0.5555702330),
+	 F(0.7071067812), F(0.8314696123),-F(0.3826834324),-F(0.9807852804),
+	-F(0.0000000000),-F(0.9807852804),-F(0.3826834324), F(0.8314696123),
+
+	 F(0.7071067812), F(0.5555702330),-F(0.9238795325),-F(0.1950903220),
+	-F(1.0000000000),-F(0.1950903220),-F(0.9238795325), F(0.5555702330),
+	 F(0.7071067812),-F(0.8314696123),-F(0.3826834324), F(0.9807852804),
+	 F(0.0000000000), F(0.9807852804),-F(0.3826834324),-F(0.8314696123),
+
+	-F(0.7071067812), F(0.9807852804),-F(0.3826834324),-F(0.5555702330),
+	-F(1.0000000000),-F(0.5555702330),-F(0.3826834324), F(0.9807852804),
+	-F(0.7071067812),-F(0.1950903220), F(0.9238795325),-F(0.8314696123),
+	-F(0.0000000000),-F(0.8314696123), F(0.9238795325),-F(0.1950903220),
+
+	-F(0.7071067812), F(0.1950903220), F(0.3826834324),-F(0.8314696123),
+	-F(1.0000000000),-F(0.8314696123), F(0.3826834324), F(0.1950903220),
+	-F(0.7071067812), F(0.9807852804),-F(0.9238795325), F(0.5555702330),
+	-F(0.0000000000), F(0.5555702330),-F(0.9238795325), F(0.9807852804),
+
+	 F(0.7071067812),-F(0.8314696123), F(0.9238795325),-F(0.9807852804),
+	-F(1.0000000000),-F(0.9807852804), F(0.9238795325),-F(0.8314696123),
+	 F(0.7071067812),-F(0.5555702330), F(0.3826834324),-F(0.1950903220),
+	-F(0.0000000000),-F(0.1950903220), F(0.3826834324),-F(0.5555702330),
+};
+#undef F
+
+/* A2DP specification: Section 12.8 Tables
+ *
+ * Original values are premultiplied by 2 for better precision (that is the
+ * maximum which is possible without overflows)
+ *
+ * Note: in each block of 8 numbers sign was changed for elements 2 and 7
+ * in order to compensate the same change applied to cos_table_fixed_4
+ */
+#define SBC_PROTO_FIXED4_SCALE (sizeof(FIXED_T)*CHAR_BIT-1-SBC_FIXED8_EXTRA_BITS+1)
+#define F(x) (FIXED_A)((x*2)*((FIXED_A)1<<(sizeof(FIXED_T)*CHAR_BIT-1))+0.5)
+static const FIXED_T _sbc_proto_fixed4[40] = {
+	 F(0.00000000E+00), F(5.36548976E-04),-F(1.49188357E-03), F(2.73370904E-03),
+	 F(3.83720193E-03), F(3.89205149E-03), F(1.86581691E-03), F(3.06012286E-03),
+
+	 F(1.09137620E-02), F(2.04385087E-02),-F(2.88757392E-02), F(3.21939290E-02),
+	 F(2.58767811E-02), F(6.13245186E-03),-F(2.88217274E-02), F(7.76463494E-02),
+
+	 F(1.35593274E-01), F(1.94987841E-01),-F(2.46636662E-01), F(2.81828203E-01),
+	 F(2.94315332E-01), F(2.81828203E-01), F(2.46636662E-01),-F(1.94987841E-01),
+
+	-F(1.35593274E-01),-F(7.76463494E-02), F(2.88217274E-02), F(6.13245186E-03),
+	 F(2.58767811E-02), F(3.21939290E-02), F(2.88757392E-02),-F(2.04385087E-02),
+
+	-F(1.09137620E-02),-F(3.06012286E-03),-F(1.86581691E-03), F(3.89205149E-03),
+	 F(3.83720193E-03), F(2.73370904E-03), F(1.49188357E-03),-F(5.36548976E-04),
+};
+#undef F
+
+/*
+ * To produce this cosine matrix in Octave:
+ *
+ * b = zeros(4, 8);
+ * for i = 0:3 for j = 0:7 b(i+1, j+1) = cos( (i + 0.5) * (j - 2) * (pi/4) ) endfor endfor;
+ * printf("F(%.10f), ", b');
+ *
+ * Note: in each block of 8 numbers sign was changed for elements 2 and 7.
+ * Change of sign for element 2 allows to replace constant 1.0 (not representable
+ * in Q15 format) with -1.0 (fine with Q15).
+ * Changed sign for element 7 allows to have more similar constants
+ * and simplify subband filter function code.
+ */
+#define SBC_COS_TABLE_FIXED4_SCALE (sizeof(FIXED_T)*CHAR_BIT-1+SBC_FIXED8_EXTRA_BITS)
+#define F(x) (FIXED_A)((x)*((FIXED_A)1<<(sizeof(FIXED_T)*CHAR_BIT-1))+0.5)
+static const FIXED_T cos_table_fixed_4[32] = {
+	 F(0.7071067812), F(0.9238795325),-F(1.0000000000), F(0.9238795325),
+	 F(0.7071067812), F(0.3826834324), F(0.0000000000), F(0.3826834324),
+
+	-F(0.7071067812), F(0.3826834324),-F(1.0000000000), F(0.3826834324),
+	-F(0.7071067812),-F(0.9238795325),-F(0.0000000000),-F(0.9238795325),
+
+	-F(0.7071067812),-F(0.3826834324),-F(1.0000000000),-F(0.3826834324),
+	-F(0.7071067812), F(0.9238795325), F(0.0000000000), F(0.9238795325),
+
+	 F(0.7071067812),-F(0.9238795325),-F(1.0000000000),-F(0.9238795325),
+	 F(0.7071067812),-F(0.3826834324),-F(0.0000000000),-F(0.3826834324),
+};
+#undef F

--Boundary-00=_jMCUJE9ycMHBWBD--
