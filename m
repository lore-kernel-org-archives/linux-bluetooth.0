Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801300819k583a931codf6cf224aebd8db3@mail.gmail.com>
Date: Wed, 30 Jan 2008 09:19:07 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300801291107y15ba6888n65c6841f8c95088f@mail.gmail.com>
MIME-Version: 1.0
References: <50282bd30801290946l359dc7a6j29bb3b891ab35f9a@mail.gmail.com>
	<d89ddf300801291107y15ba6888n65c6841f8c95088f@mail.gmail.com>
Subject: Re: [Bluez-devel] ARM optimization
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel

Cidorvan has a new proposal. It shifts MUL/MULA around so the
assignment happens outside the macro. The good news is the assembly is
now limited to a single ifdef around the macro definition. If we had
to define eg MIPS code or something specialized it would be relatively
quick & clean.

The tricky part is he nests the use of the macro. I'll show you how he
formatted it. Formatting it in a traditional way will get messy
quickly unfortunately.

Index: sbc.c
===================================================================
RCS file: /cvsroot/bluez/utils/sbc/sbc.c,v
retrieving revision 1.57
diff -u -p -r1.57 sbc.c
--- sbc.c	29 Jan 2008 19:47:49 -0000	1.57
+++ sbc.c	30 Jan 2008 13:22:53 -0000
 -614,7 +614,8 @@ static inline void sbc_synthesize_four(s
 		/* Distribute the new matrix value to the shifted position */
 		SBC_FIXED_0(res);
 		for (j = 0; j < 4; j++)
-			MULA(res, synmatrix4[i][j], frame->sb_sample[blk][ch][j]);
+			res = MULA(synmatrix4[i][j],
+					frame->sb_sample[blk][ch][j], res);
 		state->V[ch][state->offset[ch][i]] = SCALE4_STAGED1(res);
 	}

 -623,10 +624,10 @@ static inline void sbc_synthesize_four(s
 		k = (i + 4) & 0xf;
 		SBC_FIXED_0(res);
 		for (j = 0; j < 10; idx++) {
-			MULA(res, state->V[ch][state->offset[ch][i]+j++],
-					sbc_proto_4_40m0[idx]);
-			MULA(res, state->V[ch][state->offset[ch][k]+j++],
-					sbc_proto_4_40m1[idx]);
+			res = MULA(state->V[ch][state->offset[ch][i]+j++],
+					sbc_proto_4_40m0[idx], res);
+			res = MULA(state->V[ch][state->offset[ch][k]+j++],
+					sbc_proto_4_40m1[idx], res);
 		}

 		/* Store in output, Q0 */
 -655,7 +656,8 @@ static inline void sbc_synthesize_eight(
 		SBC_FIXED_0(res);
 		for (j = 0; j < 8; j++) {
 			/* Q28 = Q15 * Q13 */
-			MULA(res, synmatrix8[i][j], frame->sb_sample[blk][ch][j]);
+			res = MULA(synmatrix8[i][j],
+					frame->sb_sample[blk][ch][j], res);
 		}
 		/* Q10 */
 		state->V[ch][state->offset[ch][i]] = SCALE8_STAGED1(res);
 -666,8 +668,10 @@ static inline void sbc_synthesize_eight(
 		k = (i + 8) & 0xf;
 		SBC_FIXED_0(res);
 		for (j = 0; j < 10; idx++) {
-			MULA(res, state->V[ch][state->offset[ch][i]+j++], sbc_proto_8_80m0[idx]);
-			MULA(res, state->V[ch][state->offset[ch][k]+j++], sbc_proto_8_80m1[idx]);
+			res = MULA(state->V[ch][state->offset[ch][i]+j++],
+					sbc_proto_8_80m0[idx], res);
+			res = MULA(state->V[ch][state->offset[ch][k]+j++],
+					sbc_proto_8_80m1[idx], res);
 		}
 		/* Store in output */
 		frame->pcm_sample[ch][blk * 8 + i] = SCALE8_STAGED2(res); // Q0
 -708,67 +712,66 @@ static void sbc_encoder_init(struct sbc_
 	state->position[0] = state->position[1] = 9 * frame->subbands;
 }

-
 static inline void _sbc_analyze_four(const int32_t *in, int32_t *out)
 {
-	sbc_extended_t res;
 	sbc_fixed_t t[8];
 	sbc_extended_t s[5];

-	MUL(res, _sbc_proto_4[0], in[8] - in[32]); /* Q18 */
-	MULA(res, _sbc_proto_4[1], in[16] - in[24]);
-	t[0] = SCALE4_STAGE1(res); /* Q8 */
-
-	MUL(res, _sbc_proto_4[2], in[1]);
-	MULA(res, _sbc_proto_4[3], in[9]);
-	MULA(res, _sbc_proto_4[4], in[17]);
-	MULA(res, _sbc_proto_4[5], in[25]);
-	MULA(res, _sbc_proto_4[6], in[33]);
-	t[1] = SCALE4_STAGE1(res);
-
-	MUL(res, _sbc_proto_4[7], in[2]);
-	MULA(res, _sbc_proto_4[8], in[10]);
-	MULA(res, _sbc_proto_4[9], in[18]);
-	MULA(res, _sbc_proto_4[10], in[26]);
-	MULA(res, _sbc_proto_4[11], in[34]);
-	t[2] = SCALE4_STAGE1(res);
-
-	MUL(res, _sbc_proto_4[12], in[3]);
-	MULA(res, _sbc_proto_4[13], in[11]);
-	MULA(res, _sbc_proto_4[14], in[19]);
-	MULA(res, _sbc_proto_4[15], in[27]);
-	MULA(res, _sbc_proto_4[16], in[35]);
-	t[3] = SCALE4_STAGE1(res);
-
-	MUL(res, _sbc_proto_4[17], in[4] + in[36]);
-	MULA(res, _sbc_proto_4[18], in[12] + in[28]);
-	MULA(res, _sbc_proto_4[19], in[20]);
-	t[4] = SCALE4_STAGE1(res);
-
-	MUL(res, _sbc_proto_4[16], in[5]);
-	MULA(res, _sbc_proto_4[15], in[13]);
-	MULA(res, _sbc_proto_4[14], in[21]);
-	MULA(res, _sbc_proto_4[13], in[29]);
-	MULA(res, _sbc_proto_4[12], in[37]);
-	t[5] = SCALE4_STAGE1(res);
+	t[0] = SCALE4_STAGE1( /* Q8 */
+		MULA(_sbc_proto_4[0], in[8] - in[32], /* Q18 */
+		MUL( _sbc_proto_4[1], in[16] - in[24])));
+
+	t[1] = SCALE4_STAGE1(
+		MULA(_sbc_proto_4[2], in[1],
+		MULA(_sbc_proto_4[3], in[9],
+		MULA(_sbc_proto_4[4], in[17],
+		MULA(_sbc_proto_4[5], in[25],
+		MUL( _sbc_proto_4[6], in[33]))))));
+
+	t[2] = SCALE4_STAGE1(
+		MULA(_sbc_proto_4[7], in[2],
+		MULA(_sbc_proto_4[8], in[10],
+		MULA(_sbc_proto_4[9], in[18],
+		MULA(_sbc_proto_4[10], in[26],
+		MUL( _sbc_proto_4[11], in[34]))))));
+
+	t[3] = SCALE4_STAGE1(
+		MULA(_sbc_proto_4[12], in[3],
+		MULA(_sbc_proto_4[13], in[11],
+		MULA(_sbc_proto_4[14], in[19],
+		MULA(_sbc_proto_4[15], in[27],
+		MUL( _sbc_proto_4[16], in[35]))))));
+
+	t[4] = SCALE4_STAGE1(
+		MULA(_sbc_proto_4[17], in[4] + in[36],
+		MULA(_sbc_proto_4[18], in[12] + in[28],
+		MUL( _sbc_proto_4[19], in[20]))));
+
+	t[5] = SCALE4_STAGE1(
+		MULA(_sbc_proto_4[16], in[5],
+		MULA(_sbc_proto_4[15], in[13],
+		MULA(_sbc_proto_4[14], in[21],
+		MULA(_sbc_proto_4[13], in[29],
+		MUL( _sbc_proto_4[12], in[37]))))));

 	/* don't compute t[6]... this term always multiplies
 	 * with cos(pi/2) = 0 */

-	MUL(res, _sbc_proto_4[6], in[7]);
-	MULA(res, _sbc_proto_4[5], in[15]);
-	MULA(res, _sbc_proto_4[4], in[23]);
-	MULA(res, _sbc_proto_4[3], in[31]);
-	MULA(res, _sbc_proto_4[2], in[39]);
-	t[7] = SCALE4_STAGE1(res);
-
-	MUL(s[0], _anamatrix4[0], t[0] + t[4]);
-	MUL(s[1], _anamatrix4[2], t[2]);
-	MUL(s[2], _anamatrix4[1], t[1] + t[3]);
-	MULA(s[2], _anamatrix4[3], t[5]);
-	MUL(s[3], _anamatrix4[3], t[1] + t[3]);
-	MULA(s[3], _anamatrix4[1], - t[5] + t[7]);
-	MUL(s[4], _anamatrix4[3], t[7]);
+	t[7] = SCALE4_STAGE1(
+		MULA(_sbc_proto_4[6], in[7],
+		MULA(_sbc_proto_4[5], in[15],
+		MULA(_sbc_proto_4[4], in[23],
+		MULA(_sbc_proto_4[3], in[31],
+		MUL( _sbc_proto_4[2], in[39]))))));
+
+	s[0] = MUL( _anamatrix4[0], t[0] + t[4]);
+	s[1] = MUL( _anamatrix4[2], t[2]);
+	s[2] = MULA(_anamatrix4[1], t[1] + t[3],
+		MUL(_anamatrix4[3], t[5]));
+	s[3] = MULA(_anamatrix4[3], t[1] + t[3],
+		MUL(_anamatrix4[1], -t[5] + t[7]));
+	s[4] = MUL( _anamatrix4[3], t[7]);
+
 	out[0] = SCALE4_STAGE2( s[0] + s[1] + s[2] + s[4]); /* Q0 */
 	out[1] = SCALE4_STAGE2(-s[0] + s[1] + s[3]);
 	out[2] = SCALE4_STAGE2(-s[0] + s[1] - s[3]);
 -796,117 +799,117 @@ static inline void sbc_analyze_four(stru

 static inline void _sbc_analyze_eight(const int32_t *in, int32_t *out)
 {
-	sbc_extended_t res;
 	sbc_fixed_t t[8];
 	sbc_extended_t s[8];

-	MUL(res,  _sbc_proto_8[0], (in[16] - in[64])); /* Q18 = Q18 * Q0 */
-	MULA(res, _sbc_proto_8[1], (in[32] - in[48]));
-	MULA(res, _sbc_proto_8[2], in[4]);
-	MULA(res, _sbc_proto_8[3], in[20]);
-	MULA(res, _sbc_proto_8[4], in[36]);
-	MULA(res, _sbc_proto_8[5], in[52]);
-	t[0] = SCALE8_STAGE1(res); /* Q10 */
-
-	MUL(res,   _sbc_proto_8[6], in[2]);
-	MULA(res,  _sbc_proto_8[7], in[18]);
-	MULA(res,  _sbc_proto_8[8], in[34]);
-	MULA(res,  _sbc_proto_8[9], in[50]);
-	MULA(res, _sbc_proto_8[10], in[66]);
-	t[1] = SCALE8_STAGE1(res);
-
-	MUL(res,  _sbc_proto_8[11], in[1]);
-	MULA(res, _sbc_proto_8[12], in[17]);
-	MULA(res, _sbc_proto_8[13], in[33]);
-	MULA(res, _sbc_proto_8[14], in[49]);
-	MULA(res, _sbc_proto_8[15], in[65]);
-	MULA(res, _sbc_proto_8[16], in[3]);
-	MULA(res, _sbc_proto_8[17], in[19]);
-	MULA(res, _sbc_proto_8[18], in[35]);
-	MULA(res, _sbc_proto_8[19], in[51]);
-	MULA(res, _sbc_proto_8[20], in[67]);
-	t[2] = SCALE8_STAGE1(res);
-
-	MUL(res,   _sbc_proto_8[21], in[5]);
-	MULA(res,  _sbc_proto_8[22], in[21]);
-	MULA(res,  _sbc_proto_8[23], in[37]);
-	MULA(res,  _sbc_proto_8[24], in[53]);
-	MULA(res,  _sbc_proto_8[25], in[69]);
-	MULA(res, -_sbc_proto_8[15], in[15]);
-	MULA(res, -_sbc_proto_8[14], in[31]);
-	MULA(res, -_sbc_proto_8[13], in[47]);
-	MULA(res, -_sbc_proto_8[12], in[63]);
-	MULA(res, -_sbc_proto_8[11], in[79]);
-	t[3] = SCALE8_STAGE1(res);
-
-	MUL(res,   _sbc_proto_8[26], in[6]);
-	MULA(res,  _sbc_proto_8[27], in[22]);
-	MULA(res,  _sbc_proto_8[28], in[38]);
-	MULA(res,  _sbc_proto_8[29], in[54]);
-	MULA(res,  _sbc_proto_8[30], in[70]);
-	MULA(res, -_sbc_proto_8[10], in[14]);
-	MULA(res,  -_sbc_proto_8[9], in[30]);
-	MULA(res,  -_sbc_proto_8[8], in[46]);
-	MULA(res,  -_sbc_proto_8[7], in[62]);
-	MULA(res,  -_sbc_proto_8[6], in[78]);
-	t[4] = SCALE8_STAGE1(res);
-
-	MUL(res,   _sbc_proto_8[31], in[7]);
-	MULA(res,  _sbc_proto_8[32], in[23]);
-	MULA(res,  _sbc_proto_8[33], in[39]);
-	MULA(res,  _sbc_proto_8[34], in[55]);
-	MULA(res,  _sbc_proto_8[35], in[71]);
-	MULA(res, -_sbc_proto_8[20], in[13]);
-	MULA(res, -_sbc_proto_8[19], in[29]);
-	MULA(res, -_sbc_proto_8[18], in[45]);
-	MULA(res, -_sbc_proto_8[17], in[61]);
-	MULA(res, -_sbc_proto_8[16], in[77]);
-	t[5] = SCALE8_STAGE1(res);
-
-	MUL(res,   _sbc_proto_8[36], in[8] + in[72]);
-	MULA(res,  _sbc_proto_8[37], in[24] + in[56]);
-	MULA(res,  _sbc_proto_8[38], in[40]);
-	MULA(res, -_sbc_proto_8[39], in[12]);
-	MULA(res,  -_sbc_proto_8[5], in[28]);
-	MULA(res,  -_sbc_proto_8[4], in[44]);
-	MULA(res,  -_sbc_proto_8[3], in[60]);
-	MULA(res,  -_sbc_proto_8[2], in[76]);
-	t[6] = SCALE8_STAGE1(res);
-
-	MUL(res,   _sbc_proto_8[35], in[9]);
-	MULA(res,  _sbc_proto_8[34], in[25]);
-	MULA(res,  _sbc_proto_8[33], in[41]);
-	MULA(res,  _sbc_proto_8[32], in[57]);
-	MULA(res,  _sbc_proto_8[31], in[73]);
-	MULA(res, -_sbc_proto_8[25], in[11]);
-	MULA(res, -_sbc_proto_8[24], in[27]);
-	MULA(res, -_sbc_proto_8[23], in[43]);
-	MULA(res, -_sbc_proto_8[22], in[59]);
-	MULA(res, -_sbc_proto_8[21], in[75]);
-	t[7] = SCALE8_STAGE1(res);
-
-	MUL(s[0], _anamatrix8[0], t[0]); /* = Q14 * Q10 */
-	MULA(s[0], _anamatrix8[1], t[6]);
-	MUL(s[1], _anamatrix8[7], t[1]);
-	MUL(s[2], _anamatrix8[2], t[2]);
-	MULA(s[2], _anamatrix8[3], t[3]);
-	MULA(s[2], _anamatrix8[4], t[5]);
-	MULA(s[2], _anamatrix8[5], t[7]);
-	MUL(s[3], _anamatrix8[6], t[4]);
-	MUL(s[4], _anamatrix8[3], t[2]);
-	MULA(s[4], -_anamatrix8[5], t[3]);
-	MULA(s[4], -_anamatrix8[2], t[5]);
-	MULA(s[4], -_anamatrix8[4], t[7]);
-	MUL(s[5], _anamatrix8[4], t[2]);
-	MULA(s[5], -_anamatrix8[2], t[3]);
-	MULA(s[5], _anamatrix8[5], t[5]);
-	MULA(s[5], _anamatrix8[3], t[7]);
-	MUL(s[6], _anamatrix8[1], t[0]);
-	MULA(s[6], -_anamatrix8[0], t[6]);
-	MUL(s[7], _anamatrix8[5], t[2]);
-	MULA(s[7], -_anamatrix8[4], t[3]);
-	MULA(s[7], _anamatrix8[3], t[5]);
-	MULA(s[7], -_anamatrix8[2], t[7]);
+	t[0] = SCALE8_STAGE1( /* Q10 */
+		MULA(_sbc_proto_8[0], (in[16] - in[64]), /* Q18 = Q18 * Q0 */
+		MULA(_sbc_proto_8[1], (in[32] - in[48]),
+		MULA(_sbc_proto_8[2], in[4],
+		MULA(_sbc_proto_8[3], in[20],
+		MULA(_sbc_proto_8[4], in[36],
+		MUL( _sbc_proto_8[5], in[52])))))));
+
+	t[1] = SCALE8_STAGE1(
+		MULA(_sbc_proto_8[6], in[2],
+		MULA(_sbc_proto_8[7], in[18],
+		MULA(_sbc_proto_8[8], in[34],
+		MULA(_sbc_proto_8[9], in[50],
+		MUL(_sbc_proto_8[10], in[66]))))));
+
+	t[2] = SCALE8_STAGE1(
+		MULA(_sbc_proto_8[11], in[1],
+		MULA(_sbc_proto_8[12], in[17],
+		MULA(_sbc_proto_8[13], in[33],
+		MULA(_sbc_proto_8[14], in[49],
+		MULA(_sbc_proto_8[15], in[65],
+		MULA(_sbc_proto_8[16], in[3],
+		MULA(_sbc_proto_8[17], in[19],
+		MULA(_sbc_proto_8[18], in[35],
+		MULA(_sbc_proto_8[19], in[51],
+		MUL( _sbc_proto_8[20], in[67])))))))))));
+
+	t[3] = SCALE8_STAGE1(
+		MULA( _sbc_proto_8[21], in[5],
+		MULA( _sbc_proto_8[22], in[21],
+		MULA( _sbc_proto_8[23], in[37],
+		MULA( _sbc_proto_8[24], in[53],
+		MULA( _sbc_proto_8[25], in[69],
+		MULA(-_sbc_proto_8[15], in[15],
+		MULA(-_sbc_proto_8[14], in[31],
+		MULA(-_sbc_proto_8[13], in[47],
+		MULA(-_sbc_proto_8[12], in[63],
+		MUL( -_sbc_proto_8[11], in[79])))))))))));
+
+	t[4] = SCALE8_STAGE1(
+		MULA( _sbc_proto_8[26], in[6],
+		MULA( _sbc_proto_8[27], in[22],
+		MULA( _sbc_proto_8[28], in[38],
+		MULA( _sbc_proto_8[29], in[54],
+		MULA( _sbc_proto_8[30], in[70],
+		MULA(-_sbc_proto_8[10], in[14],
+		MULA(-_sbc_proto_8[9], in[30],
+		MULA(-_sbc_proto_8[8], in[46],
+		MULA(-_sbc_proto_8[7], in[62],
+		MUL( -_sbc_proto_8[6], in[78])))))))))));
+
+	t[5] = SCALE8_STAGE1(
+		MULA( _sbc_proto_8[31], in[7],
+		MULA( _sbc_proto_8[32], in[23],
+		MULA( _sbc_proto_8[33], in[39],
+		MULA( _sbc_proto_8[34], in[55],
+		MULA( _sbc_proto_8[35], in[71],
+		MULA(-_sbc_proto_8[20], in[13],
+		MULA(-_sbc_proto_8[19], in[29],
+		MULA(-_sbc_proto_8[18], in[45],
+		MULA(-_sbc_proto_8[17], in[61],
+		MUL( -_sbc_proto_8[16], in[77])))))))))));
+
+	t[6] = SCALE8_STAGE1(
+		MULA( _sbc_proto_8[36], (in[8] + in[72]),
+		MULA( _sbc_proto_8[37], (in[24] + in[56]),
+		MULA( _sbc_proto_8[38], in[40],
+		MULA(-_sbc_proto_8[39], in[12],
+		MULA(-_sbc_proto_8[5], in[28],
+		MULA(-_sbc_proto_8[4], in[44],
+		MULA(-_sbc_proto_8[3], in[60],
+		MUL( -_sbc_proto_8[2], in[76])))))))));
+
+	t[7] = SCALE8_STAGE1(
+		MULA( _sbc_proto_8[35], in[9],
+		MULA( _sbc_proto_8[34], in[25],
+		MULA( _sbc_proto_8[33], in[41],
+		MULA( _sbc_proto_8[32], in[57],
+		MULA( _sbc_proto_8[31], in[73],
+		MULA(-_sbc_proto_8[25], in[11],
+		MULA(-_sbc_proto_8[24], in[27],
+		MULA(-_sbc_proto_8[23], in[43],
+		MULA(-_sbc_proto_8[22], in[59],
+		MUL( -_sbc_proto_8[21], in[75])))))))))));
+
+	s[0] = MULA(  _anamatrix8[0], t[0],
+		MUL(  _anamatrix8[1], t[6]));
+	s[1] = MUL(   _anamatrix8[7], t[1]);
+	s[2] = MULA(  _anamatrix8[2], t[2],
+		MULA( _anamatrix8[3], t[3],
+		MULA( _anamatrix8[4], t[5],
+		MUL(  _anamatrix8[5], t[7]))));
+	s[3] = MUL(   _anamatrix8[6], t[4]);
+	s[4] = MULA(  _anamatrix8[3], t[2],
+		MULA(-_anamatrix8[5], t[3],
+		MULA(-_anamatrix8[2], t[5],
+		MUL( -_anamatrix8[4], t[7]))));
+	s[5] = MULA(  _anamatrix8[4], t[2],
+		MULA(-_anamatrix8[2], t[3],
+		MULA( _anamatrix8[5], t[5],
+		MUL(  _anamatrix8[3], t[7]))));
+	s[6] = MULA(  _anamatrix8[1], t[0],
+		MUL( -_anamatrix8[0], t[6]));
+	s[7] = MULA(  _anamatrix8[5], t[2],
+		MULA(-_anamatrix8[4], t[3],
+		MULA( _anamatrix8[3], t[5],
+		MUL( -_anamatrix8[2], t[7]))));
+
 	out[0] = SCALE8_STAGE2( s[0] + s[1] + s[2] + s[3]);
 	out[1] = SCALE8_STAGE2( s[1] - s[3] + s[4] + s[6]);
 	out[2] = SCALE8_STAGE2( s[1] - s[3] + s[5] - s[6]);
Index: sbc_math.h
===================================================================
RCS file: /cvsroot/bluez/utils/sbc/sbc_math.h,v
retrieving revision 1.12
diff -u -p -r1.12 sbc_math.h
--- sbc_math.h	28 Jan 2008 18:00:51 -0000	1.12
+++ sbc_math.h	30 Jan 2008 13:22:53 -0000
 -64,6 +64,17 @@ typedef long long sbc_extended_t;
 #define SBC_FIXED_0(val) { val = 0; }
 #define ADD(dst, src)    { dst += src; }
 #define SUB(dst, src)    { dst -= src; }
-#define MUL(dst, a, b)   { dst = (sbc_extended_t) (a) * (b); }
+#define MUL(a, b)        ((sbc_extended_t)(a) * (b))
 #define DIV2(dst, src)   { dst = ASR(src, 1); }
-#define MULA(dst, a, b)  { dst += (sbc_extended_t) (a) * (b); }
+
+#ifdef __arm__
+#define MULA(a, b, res) ({				\
+		long long tmp = res;			\
+		__asm__(				\
+			"smlal %Q0, %R0, %2, %3"	\
+			: "=&r" (tmp)			\
+			: "0" (tmp), "r" (a), "r" (b));	\
+		tmp; })
+#else
+#define MULA(a, b, res)  ((sbc_extended_t)(a) * (b) + (res))
+#endif

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
