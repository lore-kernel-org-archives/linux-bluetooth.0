Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001601c5b09c$df79dee0$0201a8c0@NBVICTOR>
From: "Victor Shcherbatyuk" <victor@win.tue.nl>
To: <bluez-devel@lists.sourceforge.net>
References: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local>
Subject: Re: [Bluez-devel] sbc and fixed-point progress
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0013_01C5B0AD.A2E87020"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 3 Sep 2005 17:33:45 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0013_01C5B0AD.A2E87020
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Brad,

The patch includes restructured and cleaned up code for 8-subband fixed 
point encoder (I didn't touch a2play yet). I've removed some of your code 
(if you need it let me know), moved fixed tables to sbc_tables.h (manually), 
merged floating and fixed point filter code. Now all the math is in 
sbc_math.h, an option added for 32 bit fixed point, but I could not make it 
sound any good, it is uses ~0% cpu producing sound of 0 quality - looks 
fair, so if someone wants to experiment with it... :)

I will do 4 subband encoder too. Can not promise any dates, depends how easy 
it goes...

I've played with Philips codec and I've noticed one thing. With the same 
value of bitpool our codec produces bitrate half of what the Philips codec 
does... So, if I set bitpool 15 for the Philips codec it will produce the 
same bitrate and sound quality as our encoder produces with bitpool eq. 32 - 
something might be wrong with bitallocation?

Regards,
      Victor.

P.S. There is no real need in rmagnitude() as we can test the filter code 
for overflowing using an test app, supplying all kind of inputs and 
comparing its output with that of the floating point filer. I've done it and 
currently it does not overflow, later if we need more precision? we can 
tweak SCALE_STAGE1 and SCALE_STAGE2 to get maximum of precision without 
overflowing....

------=_NextPart_000_0013_01C5B0AD.A2E87020
Content-Type: application/octet-stream;
	name="sbc_fixed.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sbc_fixed.patch"

? sbc/sbc_math.h=0A=
Index: sbc/gen_fixed.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/gen_fixed.c,v=0A=
retrieving revision 1.5=0A=
diff -u -r1.5 gen_fixed.c=0A=
--- sbc/gen_fixed.c	27 Aug 2005 02:17:54 -0000	1.5=0A=
+++ sbc/gen_fixed.c	3 Sep 2005 14:57:05 -0000=0A=
@@ -1,5 +1,3 @@=0A=
-#define USE_FIXED=0A=
-=0A=
 #include <math.h>=0A=
 #include "sbc.h"=0A=
 #include "sbc_tables.h"=0A=
@@ -10,16 +8,15 @@=0A=
 	int i;=0A=
 	int j;=0A=
 	int bits;=0A=
+	char* scalestr;=0A=
 } tables[] =3D {=0A=
 	//{"sbc_proto_4_40_f", (void *)sbc_proto_4_40, 40, 1, 28},=0A=
 	//{"sbc_proto_8_80_f", (void *)sbc_proto_8_80, 80, 1, 28},=0A=
-	{"synmatrix4_f", (void *)synmatrix4, 8, 4, 28},=0A=
-	{"synmatrix8_f", (void *)synmatrix8, 16, 8, 28},=0A=
+// 	{"synmatrix4_f", (void *)synmatrix4, 8, 4, 28},=0A=
+// 	{"synmatrix8_f", (void *)synmatrix8, 16, 8, 28},=0A=
 	//{"anamatrix4_f", (void *)anamatrix4, 4, 8, 28},=0A=
-	{"_sbc_proto_8_f", (void *)_sbc_proto_8, 40, 1, 33},=0A=
-	{"_anamatrix8_f", (void *)_anamatrix8, 8, 1, 30},=0A=
-	{"_sbc_proto_4_f", (void *)_sbc_proto_4, 20, 1, 33},=0A=
-	{"_anamatrix4_f", (void *)_anamatrix4, 4, 1, 30},=0A=
+	{"_sbc_proto_8", (void *)_sbc_proto_8, 40, 1, 33, "SP8"},=0A=
+	{"_anamatrix8", (void *)_anamatrix8, 8, 1, 30, "SA8"},=0A=
 	{0, 0, 0, 0}=0A=
 };=0A=
 =0A=
@@ -29,10 +26,6 @@=0A=
 	for(entry =3D 0; tables[entry].name; entry++) {=0A=
 		if(tables[entry].j =3D=3D 1) {=0A=
 			if (tables[entry].ref =3D=3D (void *)_sbc_proto_8 || =
tables[entry].ref =3D=3D (void *)_anamatrix8) {=0A=
-				if (tables[entry].ref =3D=3D (void *)_sbc_proto_8)=0A=
-					printf("#define FIXED64_STAGE1 %d\n", 24);=0A=
-				else=0A=
-					printf("#define FIXED64_STAGE2 %d\n", 7);=0A=
 				printf("static const int32_t %s[%d] =3D {\n",=0A=
 				       tables[entry].name, tables[entry].i);=0A=
 			}=0A=
@@ -54,7 +47,10 @@=0A=
 					printf("OVERFLOW (%f)!\n", res);=0A=
 					exit(1);=0A=
 				}=0A=
-				printf("0x%08x", (int32_t)res);=0A=
+				if (tables[entry].scalestr)=0A=
+					printf("%s(0x%08x)", tables[entry].scalestr, (int32_t)res);=0A=
+				else=0A=
+					printf("0x%08x", (int32_t)res);=0A=
 			}=0A=
 			printf("\n};\n\n");=0A=
 		} else {=0A=
Index: sbc/sbc.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc.c,v=0A=
retrieving revision 1.53=0A=
diff -u -r1.53 sbc.c=0A=
--- sbc/sbc.c	28 Aug 2005 05:32:19 -0000	1.53=0A=
+++ sbc/sbc.c	3 Sep 2005 14:57:06 -0000=0A=
@@ -58,80 +58,9 @@=0A=
 #include <sys/types.h>=0A=
 =0A=
 #include "sbc.h"=0A=
+#include "sbc_math.h"=0A=
 #include "sbc_tables.h"=0A=
 =0A=
-#define fabs(x) ((x) < 0 ?-(x) : (x))=0A=
-=0A=
-#ifdef USE_FIXED=0A=
-#include "sbc_tables_f.h"=0A=
-=0A=
-static int assertf(int debug, float a, sbc_fixed_t b, char *msg) {=0A=
-	float c =3D fixedtod(b);=0A=
-	float diff =3D fabs(a-c);=0A=
-	if(fabs(diff/a) > 0.2 && diff > 0.5) {=0A=
-		fprintf(stderr, "compare failed float=3D%f fixed=3D%f in %s\n", a, c, =
msg);=0A=
-		if(debug) return 1;=0A=
-		exit(1);=0A=
-	} else if(debug =3D=3D 1 && fabs(a) + fabs(c) > 0.001) {=0A=
-		fprintf(stderr, "float=3D%8.8f fixed=3D%8.8f in %s\n", a, c, msg);=0A=
-	}=0A=
-	return 0;=0A=
-}=0A=
-#endif=0A=
-=0A=
-struct magnitude {=0A=
-	int min;=0A=
-	int max;=0A=
-	char *name;=0A=
-};=0A=
-=0A=
-/* =0A=
- * record the magnitude range of a float over many samples=0A=
- */=0A=
-=0A=
-static void rmagnitude(float f, int idx, char *n) {=0A=
-#if 0=0A=
-	static struct magnitude *mags =3D NULL;=0A=
-	f =3D fabs(f);=0A=
-	int m =3D 0;=0A=
-=0A=
-	// virtually zero=0A=
-	if(f < .0001) return;=0A=
-=0A=
-	if(mags =3D=3D NULL) {=0A=
-		int size =3D sizeof(struct magnitude)*10;=0A=
-		mags =3D malloc(size);=0A=
-		memset(mags, 0, size);=0A=
-	}=0A=
-	if(idx < 0) {=0A=
-		printf("\n");=0A=
-		for(idx =3D 0; mags[idx].name !=3D NULL; idx++)=0A=
-			printf("%s magnitude range is (%d,%d)\n", mags[idx].name, =
mags[idx].min, mags[idx].max);=0A=
-		return;=0A=
-	}=0A=
-	if(n =3D=3D NULL) {=0A=
-		printf("%s magnitude range is (%d,%d)\n", mags[idx].name, =
mags[idx].min, mags[idx].max);=0A=
-		return;=0A=
-	}=0A=
-	while(f > 2.0) {=0A=
-		f/=3D2.0;=0A=
-		m++;=0A=
-	}=0A=
-	while(f < 1.0) {=0A=
-		f*=3D2.0;=0A=
-		m--;=0A=
-	}=0A=
-	if(m < mags[idx].min || mags[idx].min =3D=3D 0) {=0A=
-		mags[idx].min =3D m;=0A=
-		mags[idx].name =3D n;=0A=
-	}=0A=
-	if(m > mags[idx].max || mags[idx].max =3D=3D 0) {=0A=
-		mags[idx].max =3D m;=0A=
-		mags[idx].name =3D n;=0A=
-	}=0A=
-#endif=0A=
-}=0A=
-=0A=
 #define SBC_SYNCWORD 0x9C=0A=
 =0A=
 /* sampling frequency */=0A=
@@ -163,28 +92,26 @@=0A=
 /* This structure contains an unpacked SBC frame. =0A=
    Yes, there is probably quite some unused space herein */=0A=
 struct sbc_frame {=0A=
-	u_int16_t sampling_frequency;	/* in kHz */=0A=
-	u_int8_t blocks;=0A=
+	uint16_t sampling_frequency;	/* in kHz */=0A=
+	uint8_t blocks;=0A=
 	enum {=0A=
 		MONO		=3D SBC_CM_MONO,=0A=
 		DUAL_CHANNEL	=3D SBC_CM_DUAL_CHANNEL,=0A=
 		STEREO		=3D SBC_CM_STEREO,=0A=
 		JOINT_STEREO	=3D SBC_CM_JOINT_STEREO=0A=
 	} channel_mode;=0A=
-	u_int8_t channels;=0A=
+	uint8_t channels;=0A=
 	enum {=0A=
 		LOUDNESS	=3D SBC_AM_LOUDNESS,=0A=
 		SNR		=3D SBC_AM_SNR=0A=
 	} allocation_method;=0A=
-	u_int8_t subbands;=0A=
-	u_int8_t bitpool;=0A=
-	u_int8_t join;				/* bit number x set means joint stereo has been used =
in subband x */=0A=
-	u_int8_t scale_factor[2][8];		/* only the lower 4 bits of every =
element are to be used */=0A=
-	u_int16_t audio_sample[16][2][8];	/* raw integer subband samples in =
the frame */=0A=
-#ifdef USE_FIXED=0A=
+	uint8_t subbands;=0A=
+	uint8_t bitpool;=0A=
+	uint8_t join;				/* bit number x set means joint stereo has been used =
in subband x */=0A=
+	uint8_t scale_factor[2][8];		/* only the lower 4 bits of every element =
are to be used */=0A=
+	uint16_t audio_sample[16][2][8];	/* raw integer subband samples in the =
frame */=0A=
+=0A=
 	sbc_fixed_t sb_sample_f[16][2][8];=0A=
-	sbc_fixed_t pcm_sample_f[2][16*8];=0A=
-#endif=0A=
 	double sb_sample[16][2][8];		/* modified subband samples */=0A=
 	int16_t pcm_sample[2][16*8];		/* original pcm audio samples */=0A=
 };=0A=
@@ -206,7 +133,7 @@=0A=
 /*=0A=
  * Calculates the CRC-8 of the first len bits in data=0A=
  */=0A=
-static const u_int8_t crc_table[256] =3D {=0A=
+static const uint8_t crc_table[256] =3D {=0A=
 	0x00, 0x1D, 0x3A, 0x27, 0x74, 0x69, 0x4E, 0x53,=0A=
 	0xE8, 0xF5, 0xD2, 0xCF, 0x9C, 0x81, 0xA6, 0xBB,=0A=
 	0xCD, 0xD0, 0xF7, 0xEA, 0xB9, 0xA4, 0x83, 0x9E,=0A=
@@ -241,11 +168,11 @@=0A=
 	0x97, 0x8A, 0xAD, 0xB0, 0xE3, 0xFE, 0xD9, 0xC4=0A=
 };=0A=
 =0A=
-static u_int8_t sbc_crc8(const u_int8_t * data, size_t len)=0A=
+static uint8_t sbc_crc8(const uint8_t * data, size_t len)=0A=
 {=0A=
-	u_int8_t crc =3D 0x0f;=0A=
+	uint8_t crc =3D 0x0f;=0A=
 	size_t i;=0A=
-	u_int8_t octet;=0A=
+	uint8_t octet;=0A=
 =0A=
 	for (i =3D 0; i < len / 8; i++)=0A=
 		crc =3D crc_table[crc ^ data[i]];=0A=
@@ -266,7 +193,7 @@=0A=
  * Code straight from the spec to calculate the bits array =0A=
  * Takes a pointer to the frame in question, a pointer to the bits =
array and the sampling frequency (as 2 bit integer)=0A=
  */=0A=
-static void sbc_calculate_bits(const struct sbc_frame *frame, int =
(*bits)[8], u_int8_t sf)=0A=
+static void sbc_calculate_bits(const struct sbc_frame *frame, int =
(*bits)[8], uint8_t sf)=0A=
 {=0A=
 	if (frame->channel_mode =3D=3D MONO || frame->channel_mode =3D=3D =
DUAL_CHANNEL) {=0A=
 		int bitneed[2][8], loudness, max_bitneed, bitcount, slicecount, =
bitslice;=0A=
@@ -477,14 +404,14 @@=0A=
  *  -3   CRC8 incorrect=0A=
  *  -4   Bitpool value out of bounds=0A=
  */=0A=
-static int sbc_unpack_frame(const u_int8_t * data, struct sbc_frame =
*frame, size_t len)=0A=
+static int sbc_unpack_frame(const uint8_t * data, struct sbc_frame =
*frame, size_t len)=0A=
 {=0A=
 	int consumed;=0A=
 	/* Will copy the parts of the header that are relevant to crc =
calculation here */=0A=
-	u_int8_t crc_header[11] =3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };=0A=
+	uint8_t crc_header[11] =3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };=0A=
 	int crc_pos =3D 0;=0A=
 =0A=
-	u_int8_t sf;		/* sampling_frequency, temporarily needed as array index =
*/=0A=
+	uint8_t sf;		/* sampling_frequency, temporarily needed as array index =
*/=0A=
 =0A=
 	int ch, sb, blk, bit;	/* channel, subband, block and bit standard =
counters */=0A=
 	int bits[2][8];		/* bits distribution */=0A=
@@ -634,9 +561,6 @@=0A=
 					frame->sb_sample[blk][ch][sb] =3D=0A=
 						scalefactor[ch][sb] * ((frame->audio_sample[blk][ch][sb] * 2.0 + =
1.0) /=0A=
 								       levels[ch][sb] - 1.0);=0A=
-					rmagnitude(frame->sb_sample[blk][ch][sb], 0, =
"frame->sb_sample[][][]");=0A=
-					rmagnitude(scalefactor[ch][sb], 1, "scalefactor[][]");=0A=
-					rmagnitude(levels[ch][sb], 2, "levels[][]");=0A=
 				} else {=0A=
 					frame->sb_sample[blk][ch][sb] =3D 0;=0A=
 				}=0A=
@@ -744,8 +668,6 @@=0A=
 		state->V[ch][k] =3D 0;=0A=
 		for (i =3D 0; i < 8; i++) {=0A=
 			state->V[ch][k] +=3D synmatrix8[k][i] * state->S[ch][i];=0A=
-			rmagnitude(state->V[ch][k], 3, "state->V[ch][k]");=0A=
-			rmagnitude(synmatrix8[k][i], 7, "synmatrix8[k][i]");=0A=
 		}=0A=
 	}=0A=
 =0A=
@@ -754,15 +676,12 @@=0A=
 		for (j =3D 0; j < 8; j++) {=0A=
 			state->U[ch][i * 16 + j] =3D state->V[ch][i * 32 + j];=0A=
 			state->U[ch][i * 16 + j + 8] =3D state->V[ch][i * 32 + j + 24];=0A=
-			rmagnitude(state->U[ch][i * 16 + j], 4, "state->U[ch][i * 16 + j]");=0A=
 		}=0A=
 	}=0A=
 =0A=
 	/* Window by 80 coefficients */=0A=
 	for (i =3D 0; i < 80; i++) {=0A=
 		state->W[ch][i] =3D state->U[ch][i] * sbc_proto_8_80[i] * (-4);=0A=
-		rmagnitude(state->W[ch][i], 5, "state->W[ch][i]");=0A=
-		rmagnitude(sbc_proto_8_80[i]*4.0, 8, "sbc_proto_8_80[i]*4");=0A=
 	}=0A=
 =0A=
 	/* Calculate 8 audio samples */=0A=
@@ -770,7 +689,6 @@=0A=
 		state->X[ch][j] =3D 0;=0A=
 		for (i =3D 0; i < 10; i++) {=0A=
 			state->X[ch][j] +=3D state->W[ch][j + 8 * i];=0A=
-			rmagnitude(state->X[ch][j], 6, "state->X[ch][j]");=0A=
 		}=0A=
 	}=0A=
 =0A=
@@ -821,20 +739,6 @@=0A=
 	state->subbands =3D frame->subbands;=0A=
 }=0A=
 =0A=
-#ifdef USE_FIXED=0A=
-static inline void _sbc_analyze_four(int32_t in[40], int32_t out[4])=0A=
-{=0A=
-}=0A=
-#else=0A=
-static inline void _sbc_analyze_four(int32_t in[40], double out[4])=0A=
-{=0A=
-	double t1,t2,t3,t4,t5,t6,t7,t8, in1, in2;=0A=
-	double =
a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20=
;=0A=
-=0A=
-	out[0] =3D out[1] =3D out[2] =3D out[3] =3D 0;=0A=
-}=0A=
-#endif=0A=
-=0A=
 static inline void sbc_analyze_four(struct sbc_encoder_state *state,=0A=
 				struct sbc_frame *frame, int ch, int blk)=0A=
 {=0A=
@@ -845,11 +749,6 @@=0A=
 		state->X[ch][i] =3D state->X[ch][i - 4];=0A=
 	for (i =3D 3; i >=3D 0; i--)=0A=
 		state->X[ch][i] =3D frame->pcm_sample[ch][blk * 4 + (3 - i)];=0A=
-#ifdef USE_FIXED=0A=
-	_sbc_analyze_four(state->X[ch], frame->sb_sample_f[blk][ch]);=0A=
-#else=0A=
-	_sbc_analyze_four(state->X[ch], frame->sb_sample[blk][ch]);=0A=
-#endif=0A=
 =0A=
 	/* Windowing by 40 coefficients */=0A=
 	for (i =3D 0; i < 40; i++)=0A=
@@ -874,300 +773,174 @@=0A=
 		frame->sb_sample[blk][ch][i] =3D state->S[ch][i];=0A=
 }=0A=
 =0A=
-#ifdef USE_FIXED=0A=
-static inline void _sbc_analyze_eight(int32_t in[80], int32_t out[8])=0A=
+static inline void _sbc_analyze_eight(const int32_t in[80], sbc_fixed_t =
out[8])=0A=
 {=0A=
-	int32_t =
a0_hi,a1_hi,a2_hi,a3_hi,a4_hi,a5_hi,a6_hi,a7_hi,a8_hi,a9_hi,a10_hi,a11_hi=
,a12_hi,a13_hi,a14_hi,a15_hi,a16_hi,a17_hi,a18_hi,a19_hi,a20_hi, a21_hi;=0A=
-	int32_t =
a0_lo,a1_lo,a2_lo,a3_lo,a4_lo,a5_lo,a6_lo,a7_lo,a8_lo,a9_lo,a10_lo,a11_lo=
,a12_lo,a13_lo,a14_lo,a15_lo,a16_lo,a17_lo,a18_lo,a19_lo,a20_lo, a21_lo;=0A=
-	int32_t in1, in2, t1, t2, t3, t4, t5, t6, t7, t8;=0A=
-	int32_t t1_hi, t1_lo, t2_hi, t2_lo, t3_hi, t3_lo, t4_hi, t4_lo;=0A=
-	int32_t t5_hi, t5_lo, t6_hi, t6_lo, t7_hi, t7_lo, t8_hi, t8_lo;=0A=
-	int32_t out0_hi, out1_hi, out2_hi, out3_hi, out4_hi, out5_hi, out6_hi, =
out7_hi;=0A=
-	int32_t out0_lo, out1_lo, out2_lo, out3_lo, out4_lo, out5_lo, out6_lo, =
out7_lo;=0A=
-=0A=
-	t1_hi =3D t1_lo =3D t2_hi =3D t2_lo =3D t3_hi =3D t3_lo =3D t4_hi =3D =
t4_lo =3D 0;=0A=
-	t5_hi =3D t5_lo =3D t6_hi =3D t6_lo =3D t7_hi =3D t7_lo =3D t8_hi =3D =
t8_lo =3D 0;=0A=
-	out0_hi =3D out1_hi =3D out2_hi =3D out3_hi =3D out4_hi =3D out5_hi =
=3D out6_hi =3D out7_hi =3D 0;=0A=
-	out0_lo =3D out1_lo =3D out2_lo =3D out3_lo =3D out4_lo =3D out5_lo =
=3D out6_lo =3D out7_lo =3D 0;=0A=
-=0A=
-	in1 =3D in[16] - in[64]; in2 =3D in[32] - in[48];=0A=
-	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[0], in1);=0A=
-	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[1], in2);=0A=
-	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[2], in[4]);=0A=
-	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[3], in[20]);=0A=
-	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[4], in[36]);=0A=
-	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[5], in[52]);=0A=
-	t1 =3D SCALE64(t1_hi, t1_lo, FIXED64_STAGE1);=0A=
-=0A=
-	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[6], in[2]);=0A=
-	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[7], in[18]);=0A=
-	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[8], in[34]);=0A=
-	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[9], in[50]);=0A=
-	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[10], in[66]);=0A=
-	t2 =3D SCALE64(t2_hi, t2_lo, FIXED64_STAGE1);=0A=
-=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[11], in[1]);=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[12], in[17]);=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[13], in[33]);=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[14], in[49]);=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[15], in[65]);=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[16], in[3]);=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[17], in[19]);=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[18], in[35]);=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[19], in[51]);=0A=
-	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[20], in[67]);=0A=
-	t3 =3D SCALE64(t3_hi, t3_lo, FIXED64_STAGE1);=0A=
-=0A=
-	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[21], in[5]);=0A=
-	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[22], in[21]);=0A=
-	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[23], in[37]);=0A=
-	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[24], in[53]);=0A=
-	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[25], in[69]);=0A=
-	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[15], in[15]);=0A=
-	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[14], in[31]);=0A=
-	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[13], in[47]);=0A=
-	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[12], in[63]);=0A=
-	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[11], in[79]);=0A=
-	t4 =3D SCALE64(t4_hi, t4_lo, FIXED64_STAGE1);=0A=
-=0A=
-	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[26], in[6]);=0A=
-	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[27], in[22]);=0A=
-	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[28], in[38]);=0A=
-	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[29], in[54]);=0A=
-	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[30], in[70]);=0A=
-	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[10], in[14]);=0A=
-	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[9], in[30]);=0A=
-	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[8], in[46]);=0A=
-	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[7], in[62]);=0A=
-	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[6], in[78]);=0A=
-	t5 =3D SCALE64(t5_hi, t5_lo, FIXED64_STAGE1);=0A=
-=0A=
-	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[31], in[7]);=0A=
-	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[32], in[23]);=0A=
-	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[33], in[39]);=0A=
-	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[34], in[55]);=0A=
-	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[35], in[71]);=0A=
-	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[20], in[13]);=0A=
-	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[19], in[29]);=0A=
-	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[18], in[45]);=0A=
-	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[17], in[61]);=0A=
-	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[16], in[77]);=0A=
-	t6 =3D SCALE64(t6_hi, t6_lo, FIXED64_STAGE1);=0A=
-=0A=
-	in1 =3D in[8] + in[72];=0A=
-	MULA64(t7_hi, t7_lo, _sbc_proto_8_f[36], in1);=0A=
-	MULA64(t7_hi, t7_lo, _sbc_proto_8_f[37], in[24]);=0A=
-	MULA64(t7_hi, t7_lo, _sbc_proto_8_f[38], in[40]);=0A=
-	MULA64(t7_hi, t7_lo, _sbc_proto_8_f[37], in[56]);=0A=
-	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[39], in[12]);=0A=
-	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[5], in[28]);=0A=
-	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[4], in[44]);=0A=
-	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[3], in[60]);=0A=
-	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[2], in[76]);=0A=
-	t7 =3D SCALE64(t7_hi, t7_lo, FIXED64_STAGE1);=0A=
-=0A=
-	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[35], in[9]);=0A=
-	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[34], in[25]);=0A=
-	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[33], in[41]);=0A=
-	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[32], in[57]);=0A=
-	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[31], in[73]);=0A=
-	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[25], in[11]);=0A=
-	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[24], in[27]);=0A=
-	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[23], in[43]);=0A=
-	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[22], in[59]);=0A=
-	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[21], in[75]);=0A=
-	t8 =3D SCALE64(t8_hi, t8_lo, FIXED64_STAGE1);=0A=
-=0A=
-	MUL64(a0_hi, a0_lo, _anamatrix8_f[0], t1);=0A=
-	MUL64(a7_hi, a7_lo, _anamatrix8_f[1], t1);=0A=
-	ADD64(out0_hi, out0_lo, a0_hi, a0_lo);=0A=
-	ADD64(out7_hi, out7_lo, a0_hi, a0_lo);=0A=
-	SUB64(out3_hi, out3_lo, a0_hi, a0_lo);=0A=
-	SUB64(out4_hi, out4_lo, a0_hi, a0_lo);=0A=
-	ADD64(out1_hi, out1_lo, a7_hi, a7_lo);=0A=
-	ADD64(out6_hi, out6_lo, a7_hi, a7_lo);=0A=
-	SUB64(out5_hi, out5_lo, a7_hi, a7_lo);=0A=
-	SUB64(out2_hi, out2_lo, a7_hi, a7_lo);=0A=
-=0A=
-	MUL64(a21_hi, a21_lo, _anamatrix8_f[7], t2);=0A=
-	ADD64(out0_hi, out0_lo, a21_hi, a21_lo);=0A=
-	ADD64(out1_hi, out1_lo, a21_hi, a21_lo);=0A=
-	ADD64(out2_hi, out2_lo, a21_hi, a21_lo);=0A=
-	ADD64(out3_hi, out3_lo, a21_hi, a21_lo);=0A=
-	ADD64(out4_hi, out4_lo, a21_hi, a21_lo);=0A=
-	ADD64(out5_hi, out5_lo, a21_hi, a21_lo);=0A=
-	ADD64(out6_hi, out6_lo, a21_hi, a21_lo);=0A=
-	ADD64(out7_hi, out7_lo, a21_hi, a21_lo);=0A=
-=0A=
-	MUL64(a1_hi, a1_lo, _anamatrix8_f[2], t3);=0A=
-	MUL64(a8_hi, a8_lo, _anamatrix8_f[3], t3);=0A=
-	MUL64(a13_hi, a13_lo, _anamatrix8_f[4], t3);=0A=
-	MUL64(a17_hi, a17_lo, _anamatrix8_f[5], t3);=0A=
-	ADD64(out0_hi, out0_lo, a1_hi, a1_lo);=0A=
-	SUB64(out7_hi, out7_lo, a1_hi, a1_lo);=0A=
-	ADD64(out1_hi, out1_lo, a8_hi, a8_lo);=0A=
-	SUB64(out6_hi, out6_lo, a8_hi, a8_lo);=0A=
-	ADD64(out2_hi, out2_lo, a13_hi, a13_lo);=0A=
-	SUB64(out5_hi, out5_lo, a13_hi, a13_lo);=0A=
-	ADD64(out3_hi, out3_lo, a17_hi, a17_lo);=0A=
-	SUB64(out4_hi, out4_lo, a17_hi, a17_lo);=0A=
-=0A=
-	MUL64(a2_hi, a2_lo, _anamatrix8_f[3], t4);=0A=
-	MUL64(a9_hi, a9_lo, _anamatrix8_f[5], t4);=0A=
-	MUL64(a14_hi, a14_lo, _anamatrix8_f[2], t4);=0A=
-	MUL64(a18_hi, a18_lo, _anamatrix8_f[4], t4);=0A=
-	ADD64(out0_hi, out0_lo, a2_hi, a2_lo);=0A=
-	SUB64(out7_hi, out7_lo, a2_hi, a2_lo);=0A=
-	SUB64(out1_hi, out1_lo, a9_hi, a9_lo);=0A=
-	ADD64(out6_hi, out6_lo, a9_hi, a9_lo);=0A=
-	SUB64(out2_hi, out2_lo, a14_hi, a14_lo);=0A=
-	ADD64(out5_hi, out5_lo, a14_hi, a14_lo);=0A=
-	SUB64(out3_hi, out3_lo, a18_hi, a18_lo);=0A=
-	ADD64(out4_hi, out4_lo, a18_hi, a18_lo);=0A=
-=0A=
-	MUL64(a3_hi, a3_lo, _anamatrix8_f[6], t5);=0A=
-	ADD64(out0_hi, out0_lo, a3_hi, a3_lo);=0A=
-	ADD64(out7_hi, out7_lo, a3_hi, a3_lo);=0A=
-	ADD64(out3_hi, out3_lo, a3_hi, a3_lo);=0A=
-	ADD64(out4_hi, out4_lo, a3_hi, a3_lo);=0A=
-	SUB64(out1_hi, out1_lo, a3_hi, a3_lo);=0A=
-	SUB64(out2_hi, out2_lo, a3_hi, a3_lo);=0A=
-	SUB64(out5_hi, out5_lo, a3_hi, a3_lo);=0A=
-	SUB64(out6_hi, out6_lo, a3_hi, a3_lo);=0A=
-=0A=
-	MUL64(a4_hi, a4_lo, _anamatrix8_f[4], t6);=0A=
-	MUL64(a10_hi, a10_lo, _anamatrix8_f[2], t6);=0A=
-	MUL64(a15_hi, a15_lo, _anamatrix8_f[5], t6);=0A=
-	MUL64(a19_hi, a19_lo, _anamatrix8_f[3], t6);=0A=
-	ADD64(out0_hi, out0_lo, a4_hi, a4_lo);=0A=
-	SUB64(out7_hi, out7_lo, a4_hi, a4_lo);=0A=
-	SUB64(out1_hi, out1_lo, a10_hi, a10_lo);=0A=
-	ADD64(out6_hi, out6_lo, a10_hi, a10_lo);=0A=
-	ADD64(out2_hi, out2_lo, a15_hi, a15_lo);=0A=
-	SUB64(out5_hi, out5_lo, a15_hi, a15_lo);=0A=
-	ADD64(out3_hi, out3_lo, a19_hi, a19_lo);=0A=
-	SUB64(out4_hi, out4_lo, a19_hi, a19_lo);=0A=
-=0A=
-	MUL64(a5_hi, a5_lo, _anamatrix8_f[1], t7);=0A=
-	MUL64(a11_hi, a11_lo, _anamatrix8_f[0], t7);=0A=
-	ADD64(out0_hi, out0_lo, a5_hi, a5_lo);=0A=
-	ADD64(out7_hi, out7_lo, a5_hi, a5_lo);=0A=
-	SUB64(out3_hi, out3_lo, a5_hi, a5_lo);=0A=
-	SUB64(out4_hi, out4_lo, a5_hi, a5_lo);=0A=
-	SUB64(out1_hi, out1_lo, a11_hi, a11_lo);=0A=
-	SUB64(out6_hi, out6_lo, a11_hi, a11_lo);=0A=
-	ADD64(out2_hi, out2_lo, a11_hi, a11_lo);=0A=
-	ADD64(out5_hi, out5_lo, a11_hi, a11_lo);=0A=
-=0A=
-	MUL64(a6_hi, a6_lo, _anamatrix8_f[5], t8);=0A=
-	MUL64(a12_hi, a12_lo, _anamatrix8_f[4], t8);=0A=
-	MUL64(a16_hi, a16_lo, _anamatrix8_f[3], t8);=0A=
-	MUL64(a20_hi, a20_lo, _anamatrix8_f[2], t8);=0A=
-	ADD64(out0_hi, out0_lo, a6_hi, a6_lo);=0A=
-	SUB64(out7_hi, out7_lo, a6_hi, a6_lo);=0A=
-	SUB64(out1_hi, out1_lo, a12_hi, a12_lo);=0A=
-	ADD64(out6_hi, out6_lo, a12_hi, a12_lo);=0A=
-	ADD64(out2_hi, out2_lo, a16_hi, a16_lo);=0A=
-	SUB64(out5_hi, out5_lo, a16_hi, a16_lo);=0A=
-	SUB64(out3_hi, out3_lo, a20_hi, a20_lo);=0A=
-	ADD64(out4_hi, out4_lo, a20_hi, a20_lo);=0A=
-=0A=
-	// restore original scale=0A=
-	out[0] =3D out0_hi >> FIXED64_STAGE2;=0A=
-	out[1] =3D out1_hi >> FIXED64_STAGE2;=0A=
-	out[2] =3D out2_hi >> FIXED64_STAGE2;=0A=
-	out[3] =3D out3_hi >> FIXED64_STAGE2;=0A=
-	out[4] =3D out4_hi >> FIXED64_STAGE2;=0A=
-	out[5] =3D out5_hi >> FIXED64_STAGE2;=0A=
-	out[6] =3D out6_hi >> FIXED64_STAGE2;=0A=
-	out[7] =3D out7_hi >> FIXED64_STAGE2;=0A=
+	sbc_fixed_t res;=0A=
+	int32_t t1, t2, t3, t4, t5, t6, t7, t8;=0A=
 =0A=
-}=0A=
-#else=0A=
-static inline void _sbc_analyze_eight(int32_t in[80], double out[8])=0A=
-{=0A=
-	double t1,t2,t3,t4,t5,t6,t7,t8, in1, in2;=0A=
-	double =
a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20=
;=0A=
+	=
SBC_FIXED_0(out[0]);SBC_FIXED_0(out[1]);SBC_FIXED_0(out[2]);SBC_FIXED_0(o=
ut[3]);=0A=
+	=
SBC_FIXED_0(out[4]);SBC_FIXED_0(out[5]);SBC_FIXED_0(out[6]);SBC_FIXED_0(o=
ut[7]);=0A=
+=0A=
+	MUL(res, _sbc_proto_8[0], (in[16] - in[64]));=0A=
+	MULA(res, _sbc_proto_8[1], (in[32] - in[48]));=0A=
+	MULA(res, _sbc_proto_8[2], in[4]);=0A=
+	MULA(res, _sbc_proto_8[3], in[20]);=0A=
+	MULA(res, _sbc_proto_8[4], in[36]);=0A=
+	MULA(res, _sbc_proto_8[5], in[52]);=0A=
+	t1 =3D SCALE_STAGE1(res);=0A=
+=0A=
+	MUL(res, _sbc_proto_8[6], in[2]);=0A=
+	MULA(res, _sbc_proto_8[7], in[18]);=0A=
+	MULA(res, _sbc_proto_8[8], in[34]);=0A=
+	MULA(res, _sbc_proto_8[9], in[50]);=0A=
+	MULA(res, _sbc_proto_8[10], in[66]);=0A=
+	t2 =3D SCALE_STAGE1(res);=0A=
+=0A=
+	MUL(res, _sbc_proto_8[11], in[1]);=0A=
+	MULA(res, _sbc_proto_8[12], in[17]);=0A=
+	MULA(res, _sbc_proto_8[13], in[33]);=0A=
+	MULA(res, _sbc_proto_8[14], in[49]);=0A=
+	MULA(res, _sbc_proto_8[15], in[65]);=0A=
+	MULA(res, _sbc_proto_8[16], in[3]);=0A=
+	MULA(res, _sbc_proto_8[17], in[19]);=0A=
+	MULA(res, _sbc_proto_8[18], in[35]);=0A=
+	MULA(res, _sbc_proto_8[19], in[51]);=0A=
+	MULA(res, _sbc_proto_8[20], in[67]);=0A=
+	t3 =3D SCALE_STAGE1(res);=0A=
+=0A=
+	MUL(res, _sbc_proto_8[21], in[5]);=0A=
+	MULA(res, _sbc_proto_8[22], in[21]);=0A=
+	MULA(res, _sbc_proto_8[23], in[37]);=0A=
+	MULA(res, _sbc_proto_8[24], in[53]);=0A=
+	MULA(res, _sbc_proto_8[25], in[69]);=0A=
+	MULA(res, -_sbc_proto_8[15], in[15]);=0A=
+	MULA(res, -_sbc_proto_8[14], in[31]);=0A=
+	MULA(res, -_sbc_proto_8[13], in[47]);=0A=
+	MULA(res, -_sbc_proto_8[12], in[63]);=0A=
+	MULA(res, -_sbc_proto_8[11], in[79]);=0A=
+	t4 =3D SCALE_STAGE1(res);=0A=
+=0A=
+	MUL(res, _sbc_proto_8[26], in[6]);=0A=
+	MULA(res, _sbc_proto_8[27], in[22]);=0A=
+	MULA(res, _sbc_proto_8[28], in[38]);=0A=
+	MULA(res, _sbc_proto_8[29], in[54]);=0A=
+	MULA(res, _sbc_proto_8[30], in[70]);=0A=
+	MULA(res, -_sbc_proto_8[10], in[14]);=0A=
+	MULA(res, -_sbc_proto_8[9], in[30]);=0A=
+	MULA(res, -_sbc_proto_8[8], in[46]);=0A=
+	MULA(res, -_sbc_proto_8[7], in[62]);=0A=
+	MULA(res, -_sbc_proto_8[6], in[78]);=0A=
+	t5 =3D SCALE_STAGE1(res);=0A=
+=0A=
+	MUL(res, _sbc_proto_8[31], in[7]);=0A=
+	MULA(res, _sbc_proto_8[32], in[23]);=0A=
+	MULA(res, _sbc_proto_8[33], in[39]);=0A=
+	MULA(res, _sbc_proto_8[34], in[55]);=0A=
+	MULA(res, _sbc_proto_8[35], in[71]);=0A=
+	MULA(res, -_sbc_proto_8[20], in[13]);=0A=
+	MULA(res, -_sbc_proto_8[19], in[29]);=0A=
+	MULA(res, -_sbc_proto_8[18], in[45]);=0A=
+	MULA(res, -_sbc_proto_8[17], in[61]);=0A=
+	MULA(res, -_sbc_proto_8[16], in[77]);=0A=
+	t6 =3D SCALE_STAGE1(res);=0A=
+=0A=
+	MUL(res, _sbc_proto_8[36], (in[8] + in[72]));=0A=
+	MULA(res, _sbc_proto_8[37], in[24]);=0A=
+	MULA(res, _sbc_proto_8[38], in[40]);=0A=
+	MULA(res, _sbc_proto_8[37], in[56]);=0A=
+	MULA(res, -_sbc_proto_8[39], in[12]);=0A=
+	MULA(res, -_sbc_proto_8[5], in[28]);=0A=
+	MULA(res, -_sbc_proto_8[4], in[44]);=0A=
+	MULA(res, -_sbc_proto_8[3], in[60]);=0A=
+	MULA(res, -_sbc_proto_8[2], in[76]);=0A=
+	t7 =3D SCALE_STAGE1(res);=0A=
+=0A=
+	MUL(res, _sbc_proto_8[35], in[9]);=0A=
+	MULA(res, _sbc_proto_8[34], in[25]);=0A=
+	MULA(res, _sbc_proto_8[33], in[41]);=0A=
+	MULA(res, _sbc_proto_8[32], in[57]);=0A=
+	MULA(res, _sbc_proto_8[31], in[73]);=0A=
+	MULA(res, -_sbc_proto_8[25], in[11]);=0A=
+	MULA(res, -_sbc_proto_8[24], in[27]);=0A=
+	MULA(res, -_sbc_proto_8[23], in[43]);=0A=
+	MULA(res, -_sbc_proto_8[22], in[59]);=0A=
+	MULA(res, -_sbc_proto_8[21], in[75]);=0A=
+	t8 =3D SCALE_STAGE1(res);=0A=
+=0A=
+	MUL(out[0], _anamatrix8[0], t1);=0A=
+	MULA(out[0], _anamatrix8[7], t2);=0A=
+	MULA(out[0], _anamatrix8[2], t3);=0A=
+	MULA(out[0], _anamatrix8[3], t4);=0A=
+	MULA(out[0], _anamatrix8[6], t5);=0A=
+	MULA(out[0], _anamatrix8[4], t6);=0A=
+	MULA(out[0], _anamatrix8[1], t7);=0A=
+	MULA(out[0], _anamatrix8[5], t8);=0A=
+=0A=
+	MUL(out[1], _anamatrix8[1], t1);=0A=
+	MULA(out[1], _anamatrix8[7], t2);=0A=
+	MULA(out[1], _anamatrix8[3], t3);=0A=
+	MULA(out[1], -_anamatrix8[5], t4);=0A=
+	MULA(out[1], -_anamatrix8[6], t5);=0A=
+	MULA(out[1], -_anamatrix8[2], t6);=0A=
+	MULA(out[1], -_anamatrix8[0], t7);=0A=
+	MULA(out[1], -_anamatrix8[4], t8);=0A=
+=0A=
+	MUL(out[2], -_anamatrix8[1], t1);=0A=
+	MULA(out[2], _anamatrix8[7], t2);=0A=
+	MULA(out[2], _anamatrix8[4], t3);=0A=
+	MULA(out[2], -_anamatrix8[2], t4);=0A=
+	MULA(out[2], -_anamatrix8[6], t5);=0A=
+	MULA(out[2], _anamatrix8[5], t6);=0A=
+	MULA(out[2], _anamatrix8[0], t7);=0A=
+	MULA(out[2], _anamatrix8[3], t8);=0A=
+=0A=
+	MUL(out[3], -_anamatrix8[0], t1);=0A=
+	MULA(out[3], _anamatrix8[7], t2);=0A=
+	MULA(out[3], _anamatrix8[5], t3);=0A=
+	MULA(out[3], -_anamatrix8[4], t4);=0A=
+	MULA(out[3], _anamatrix8[6], t5);=0A=
+	MULA(out[3], _anamatrix8[3], t6);=0A=
+	MULA(out[3], -_anamatrix8[1], t7);=0A=
+	MULA(out[3], -_anamatrix8[2], t8);=0A=
+=0A=
+	MUL(out[4], -_anamatrix8[0], t1);=0A=
+	MULA(out[4], _anamatrix8[7], t2);=0A=
+	MULA(out[4], -_anamatrix8[5], t3);=0A=
+	MULA(out[4], _anamatrix8[4], t4);=0A=
+	MULA(out[4], _anamatrix8[6], t5);=0A=
+	MULA(out[4], -_anamatrix8[3], t6);=0A=
+	MULA(out[4], -_anamatrix8[1], t7);=0A=
+	MULA(out[4], _anamatrix8[2], t8);=0A=
+=0A=
+	MUL(out[5], -_anamatrix8[1], t1);=0A=
+	MULA(out[5], _anamatrix8[7], t2);=0A=
+	MULA(out[5], -_anamatrix8[4], t3);=0A=
+	MULA(out[5], _anamatrix8[2], t4);=0A=
+	MULA(out[5], -_anamatrix8[6], t5);=0A=
+	MULA(out[5], -_anamatrix8[5], t6);=0A=
+	MULA(out[5], _anamatrix8[0], t7);=0A=
+	MULA(out[5], -_anamatrix8[3], t8);=0A=
+=0A=
+	MUL(out[6], _anamatrix8[1], t1);=0A=
+	MULA(out[6], _anamatrix8[7], t2);=0A=
+	MULA(out[6], -_anamatrix8[3], t3);=0A=
+	MULA(out[6], _anamatrix8[5], t4);=0A=
+	MULA(out[6], -_anamatrix8[6], t5);=0A=
+	MULA(out[6], _anamatrix8[2], t6);=0A=
+	MULA(out[6], -_anamatrix8[0], t7);=0A=
+	MULA(out[6], _anamatrix8[4], t8);=0A=
+=0A=
+	MUL(out[7], _anamatrix8[0], t1);=0A=
+	MULA(out[7], _anamatrix8[7], t2);=0A=
+	MULA(out[7], -_anamatrix8[2], t3);=0A=
+	MULA(out[7], -_anamatrix8[3], t4);=0A=
+	MULA(out[7], _anamatrix8[6], t5);=0A=
+	MULA(out[7], -_anamatrix8[4], t6);=0A=
+	MULA(out[7], _anamatrix8[1], t7);=0A=
+	MULA(out[7], -_anamatrix8[5], t8);=0A=
 =0A=
-	out[0] =3D out[1] =3D out[2] =3D out[3] =3D out[4] =3D out[5] =3D =
out[6] =3D out[7] =3D 0;=0A=
 =0A=
-	in1 =3D in[16] - in[64]; in2 =3D in[32] - in[48];=0A=
-	t1 =3D _sbc_proto_8[0]*in1 + _sbc_proto_8[1]*in2 +\=0A=
-	     _sbc_proto_8[2]*in[4] + _sbc_proto_8[3]*in[20] +  =
_sbc_proto_8[4]*in[36] +\=0A=
-	     _sbc_proto_8[5]*in[52];=0A=
-=0A=
-	t2 =3D _sbc_proto_8[6]*in[2] + _sbc_proto_8[7]*in[18] + \=0A=
-	     _sbc_proto_8[8]*in[34] + _sbc_proto_8[9]*in[50] + =
_sbc_proto_8[10]*in[66];=0A=
-=0A=
-	t3 =3D _sbc_proto_8[11]*in[1] + _sbc_proto_8[12]*in[17] + \=0A=
-	     _sbc_proto_8[13]*in[33] + _sbc_proto_8[14]*in[49] + =
_sbc_proto_8[15]*in[65] +\=0A=
-	     _sbc_proto_8[16]*in[3] + _sbc_proto_8[17]*in[19] + =
_sbc_proto_8[18]*in[35] +\=0A=
-	     _sbc_proto_8[19]*in[51] + _sbc_proto_8[20]*in[67];=0A=
-=0A=
-	t4 =3D _sbc_proto_8[21]*in[5] + _sbc_proto_8[22]*in[21] + \=0A=
-	     _sbc_proto_8[23]*in[37] + _sbc_proto_8[24]*in[53] + =
_sbc_proto_8[25]*in[69] -\=0A=
-	     _sbc_proto_8[15]*in[15] - _sbc_proto_8[14]*in[31] - =
_sbc_proto_8[13]*in[47] -\=0A=
-	     _sbc_proto_8[12]*in[63] - _sbc_proto_8[11]*in[79];=0A=
-=0A=
-	t5 =3D _sbc_proto_8[26]*in[6] + _sbc_proto_8[27]*in[22] + \=0A=
-	     _sbc_proto_8[28]*in[38] + _sbc_proto_8[29]*in[54] + =
_sbc_proto_8[30]*in[70] -\=0A=
-	     _sbc_proto_8[10]*in[14] - _sbc_proto_8[9]*in[30] - =
_sbc_proto_8[8]*in[46] -\=0A=
-	     _sbc_proto_8[7]*in[62] - _sbc_proto_8[6]*in[78];=0A=
-=0A=
-	t6 =3D _sbc_proto_8[31]*in[7] + _sbc_proto_8[32]*in[23] + \=0A=
-	     _sbc_proto_8[33]*in[39] + _sbc_proto_8[34]*in[55] + =
_sbc_proto_8[35]*in[71] -\=0A=
-	     _sbc_proto_8[20]*in[13] - _sbc_proto_8[19]*in[29] - =
_sbc_proto_8[18]*in[45] -\=0A=
-	     _sbc_proto_8[17]*in[61] - _sbc_proto_8[16]*in[77];=0A=
-=0A=
-	in1 =3D in[8] + in[72];=0A=
-	t7 =3D _sbc_proto_8[36]*in1 + _sbc_proto_8[37]*in[24] + \=0A=
-	     _sbc_proto_8[38]*in[40] + _sbc_proto_8[37]*in[56] - =
_sbc_proto_8[39]*in[12] -\=0A=
-	     _sbc_proto_8[5]*in[28] - _sbc_proto_8[4]*in[44] - =
_sbc_proto_8[3]*in[60] -\=0A=
-	     _sbc_proto_8[2]*in[76];=0A=
-=0A=
-	t8 =3D _sbc_proto_8[35]*in[9] + _sbc_proto_8[34]*in[25] + \=0A=
-	     _sbc_proto_8[33]*in[41] + _sbc_proto_8[32]*in[57] + =
_sbc_proto_8[31]*in[73] -\=0A=
-	     _sbc_proto_8[25]*in[11] - _sbc_proto_8[24]*in[27] =
-_sbc_proto_8[23]*in[43] -\=0A=
-	     _sbc_proto_8[22]*in[59] - _sbc_proto_8[21]*in[75];=0A=
-=0A=
-	a0 =3D _anamatrix8[0]*t1;=0A=
-	a7 =3D _anamatrix8[1]*t1;=0A=
-	out[0] +=3D a0;	out[1] +=3D a7;	out[2] -=3D a7;	out[3] -=3D a0;	out[4] =
-=3D a0;	out[5] -=3D a7;	out[6] +=3D a7;	out[7] +=3D a0;=0A=
-=0A=
-	out[0] +=3D t2;	out[1] +=3D t2;	out[2] +=3D t2;	out[3] +=3D t2;	out[4] =
+=3D t2;	out[5] +=3D t2;	out[6] +=3D t2;	out[7] +=3D t2;=0A=
-=0A=
-	a1 =3D _anamatrix8[2]*t3;=0A=
-	a8 =3D _anamatrix8[3]*t3;=0A=
-	a13 =3D _anamatrix8[4]*t3;=0A=
-	a17 =3D _anamatrix8[5]*t3;=0A=
-	out[0] +=3D a1;	out[1] +=3D a8;	out[2] +=3D a13;	out[3] +=3D a17;	=
out[4] -=3D a17;	out[5] -=3D a13;	out[6] -=3D a8;	out[7] -=3D a1;=0A=
-=0A=
-	a2 =3D _anamatrix8[3]*t4;=0A=
-	a9 =3D _anamatrix8[5]*t4;=0A=
-	a14 =3D _anamatrix8[2]*t4;=0A=
-	a18 =3D _anamatrix8[4]*t4;=0A=
-	out[0] +=3D a2;	out[1] -=3D a9;	out[2] -=3D a14;	out[3] -=3D a18;	=
out[4] +=3D a18;	out[5] +=3D a14;	out[6] +=3D a9;	out[7] -=3D a2;=0A=
-=0A=
-	a4 =3D _anamatrix8[4]*t6;=0A=
-	a10 =3D _anamatrix8[2]*t6;=0A=
-	a15 =3D _anamatrix8[5]*t6;=0A=
-	a19 =3D _anamatrix8[3]*t6;=0A=
-	out[0] +=3D a4;	out[1] -=3D a10;	out[2] +=3D a15;	out[3] +=3D a19;	=
out[4] -=3D a19;	out[5] -=3D a15;	out[6] +=3D a10;	out[7] -=3D a4;=0A=
-=0A=
-	a3 =3D _anamatrix8[6]*t5;=0A=
-	out[0] +=3D a3;	out[1] -=3D a3;	out[2] -=3D a3;	out[3] +=3D a3;	out[4] =
+=3D a3;	out[5] -=3D a3;	out[6] -=3D a3;	out[7] +=3D a3;=0A=
-=0A=
-	a5 =3D _anamatrix8[1]*t7;=0A=
-	a11 =3D _anamatrix8[0]*t7;=0A=
-	out[0] +=3D a5;	out[1] -=3D a11;	out[2] +=3D a11;	out[3] -=3D a5;	=
out[4] -=3D a5;	out[5] +=3D a11;	out[6] -=3D a11;	out[7] +=3D a5;=0A=
-=0A=
-	a6 =3D _anamatrix8[5]*t8;=0A=
-	a12 =3D _anamatrix8[4]*t8;=0A=
-	a16 =3D _anamatrix8[3]*t8;=0A=
-	a20 =3D _anamatrix8[2]*t8;=0A=
-	out[0] +=3D a6;	out[1] -=3D a12;	out[2] +=3D a16;	out[3] -=3D a20;	=
out[4] +=3D a20;	out[5] -=3D a16;	out[6] +=3D a12;	out[7] -=3D a6;=0A=
 }=0A=
-#endif=0A=
 =0A=
 static inline void sbc_analyze_eight(struct sbc_encoder_state *state,=0A=
 				     struct sbc_frame *frame, int ch, int blk)=0A=
@@ -1179,11 +952,7 @@=0A=
 		state->X[ch][i] =3D state->X[ch][i - 8];=0A=
 	for (i =3D 7; i >=3D 0; i--)=0A=
 		state->X[ch][i] =3D frame->pcm_sample[ch][blk * 8 + (7 - i)];=0A=
-#ifdef USE_FIXED=0A=
 	_sbc_analyze_eight(state->X[ch], frame->sb_sample_f[blk][ch]);=0A=
-#else=0A=
-	_sbc_analyze_eight(state->X[ch], frame->sb_sample[blk][ch]);=0A=
-#endif=0A=
 }=0A=
 =0A=
 static int sbc_analyze_audio(struct sbc_encoder_state *state, struct =
sbc_frame *frame)=0A=
@@ -1229,14 +998,14 @@=0A=
  * -99 not implemented=0A=
  */=0A=
 =0A=
-static int sbc_pack_frame(u_int8_t * data, struct sbc_frame *frame, =
size_t len)=0A=
+static int sbc_pack_frame(uint8_t * data, struct sbc_frame *frame, =
size_t len)=0A=
 {=0A=
 	int produced;=0A=
 	/* Will copy the header parts for CRC-8 calculation here */=0A=
-	u_int8_t crc_header[11] =3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };=0A=
+	uint8_t crc_header[11] =3D { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };=0A=
 	int crc_pos =3D 0;=0A=
 =0A=
-	u_int8_t sf;		/* Sampling frequency as temporary value for table =
lookup */=0A=
+	uint8_t sf;		/* Sampling frequency as temporary value for table lookup =
*/=0A=
 =0A=
 	int ch, sb, blk, bit;	/* channel, subband, block and bit counters */=0A=
 	int bits[2][8];		/* bits distribution */=0A=
@@ -1325,11 +1094,7 @@=0A=
 			frame->scale_factor[ch][sb] =3D 0;=0A=
 			scalefactor[ch][sb] =3D 2;=0A=
 			for (blk =3D 0; blk < frame->blocks; blk++) {=0A=
-#ifdef USE_FIXED=0A=
-				while (scalefactor[ch][sb] < fabs(frame->sb_sample_f[blk][ch][sb])) =
{=0A=
-#else=0A=
-				while (scalefactor[ch][sb] < fabs(frame->sb_sample[blk][ch][sb])) {=0A=
-#endif=0A=
+				while (scalefactor[ch][sb] < =
fabs(SCALE_STAGE2(frame->sb_sample_f[blk][ch][sb]))) {=0A=
 					frame->scale_factor[ch][sb]++;=0A=
 					scalefactor[ch][sb] *=3D 2;=0A=
 				}=0A=
@@ -1337,69 +1102,74 @@=0A=
 		}=0A=
 	}=0A=
 =0A=
-	if (frame->channel_mode =3D=3D JOINT_STEREO) {=0A=
-		float sb_sample_j[16][2][7]; /* like frame->sb_sample but joint =
stereo */=0A=
-		int scalefactor_j[2][7], scale_factor_j[2][7]; /* scalefactor and =
scale_factor in joint case */=0A=
-=0A=
-		/* Calculate joint stereo signal */=0A=
-		for (sb =3D 0; sb < frame->subbands - 1; sb++) {=0A=
+ 	if (frame->channel_mode =3D=3D JOINT_STEREO) {=0A=
+		sbc_fixed_t sb_sample_j[16][2][7]; /* like frame->sb_sample but joint =
stereo */=0A=
+		sbc_fixed_t tmp;=0A=
+ 		int scalefactor_j[2][7], scale_factor_j[2][7]; /* scalefactor and =
scale_factor in joint case */=0A=
+ =0A=
+ 		/* Calculate joint stereo signal */=0A=
+ 		for (sb =3D 0; sb < frame->subbands - 1; sb++) {=0A=
 			for (blk =3D 0; blk < frame->blocks; blk++) {=0A=
-				sb_sample_j[blk][0][sb] =3D (frame->sb_sample[blk][0][sb] =0A=
-							   + frame->sb_sample[blk][1][sb]) / 2;=0A=
-				sb_sample_j[blk][1][sb] =3D (frame->sb_sample[blk][0][sb] =0A=
-							   - frame->sb_sample[blk][1][sb]) / 2;=0A=
-			}=0A=
-		}=0A=
-=0A=
-		/* calculate scale_factor_j and scalefactor_j for joint case */=0A=
-		for (ch =3D 0; ch < 2; ch++) {=0A=
-			for (sb =3D 0; sb < frame->subbands - 1; sb++) {=0A=
-				scale_factor_j[ch][sb] =3D 0;=0A=
-				scalefactor_j[ch][sb] =3D 2;=0A=
-				for (blk =3D 0; blk < frame->blocks; blk++) {=0A=
-					while (scalefactor_j[ch][sb] < fabs(sb_sample_j[blk][ch][sb])) {=0A=
-						scale_factor_j[ch][sb]++;=0A=
-						scalefactor_j[ch][sb] *=3D 2;=0A=
-					}=0A=
-				}=0A=
-			}=0A=
-		}=0A=
-=0A=
-		/* decide which subbands to join */=0A=
-		frame->join =3D 0;=0A=
-		for (sb =3D 0; sb < frame->subbands - 1; sb++) {=0A=
-			if ( (scalefactor[0][sb] + scalefactor[1][sb]) > =0A=
-			     (scalefactor_j[0][sb] + scalefactor_j[1][sb]) ) {=0A=
-				/* use joint stereo for this subband */=0A=
-				frame->join |=3D 1 << sb;=0A=
-				frame->scale_factor[0][sb] =3D scale_factor_j[0][sb];=0A=
-				frame->scale_factor[1][sb] =3D scale_factor_j[1][sb];=0A=
-				scalefactor[0][sb] =3D scalefactor_j[0][sb];=0A=
-				scalefactor[1][sb] =3D scalefactor_j[1][sb];=0A=
-				for (blk =3D 0; blk < frame->blocks; blk++) {=0A=
-					frame->sb_sample[blk][0][sb] =3D sb_sample_j[blk][0][sb];=0A=
-					frame->sb_sample[blk][1][sb] =3D sb_sample_j[blk][1][sb];=0A=
-				}=0A=
-			}=0A=
-		}=0A=
-  =0A=
-		if (len * 8 < produced + frame->subbands) {=0A=
-			return -1;=0A=
-		} else {=0A=
-			data[4] =3D 0;=0A=
-			for (sb =3D 0; sb < frame->subbands - 1; sb++) {=0A=
-				data[4] |=3D ((frame->join >> sb) & 0x01) << (7 - sb);=0A=
-			}=0A=
-			if (frame->subbands =3D=3D 4) {=0A=
-				crc_header[crc_pos / 8] =3D data[4] & 0xf0;=0A=
-			} else {=0A=
-				crc_header[crc_pos / 8] =3D data[4];=0A=
-			}=0A=
-=0A=
-			produced +=3D frame->subbands;=0A=
-			crc_pos +=3D frame->subbands;=0A=
-		}=0A=
-	}=0A=
+				tmp =3D frame->sb_sample_f[blk][0][sb];=0A=
+				ADD(tmp, frame->sb_sample_f[blk][1][sb]);=0A=
+				DIV2(sb_sample_j[blk][0][sb], tmp);				=0A=
+//  				sb_sample_j[blk][0][sb] =3D (frame->sb_sample_f[blk][0][sb] + =
frame->sb_sample_f[blk][1][sb]) / 2;=0A=
+				tmp =3D frame->sb_sample_f[blk][0][sb];=0A=
+				SUB(tmp, frame->sb_sample_f[blk][1][sb]);=0A=
+				DIV2(sb_sample_j[blk][1][sb], tmp);				=0A=
+//  				sb_sample_j[blk][1][sb] =3D (frame->sb_sample_f[blk][0][sb] - =
frame->sb_sample_f[blk][1][sb]) / 2;=0A=
+ 			}=0A=
+ 		}=0A=
+ =0A=
+ 		/* calculate scale_factor_j and scalefactor_j for joint case */=0A=
+ 		for (ch =3D 0; ch < 2; ch++) {=0A=
+ 			for (sb =3D 0; sb < frame->subbands - 1; sb++) {=0A=
+ 				scale_factor_j[ch][sb] =3D 0;=0A=
+ 				scalefactor_j[ch][sb] =3D 2;=0A=
+ 				for (blk =3D 0; blk < frame->blocks; blk++) {=0A=
+ 					while (scalefactor_j[ch][sb] < =
fabs(SCALE_STAGE2(sb_sample_j[blk][ch][sb]))) {=0A=
+ 						scale_factor_j[ch][sb]++;=0A=
+ 						scalefactor_j[ch][sb] *=3D 2;=0A=
+ 					}=0A=
+ 				}=0A=
+ 			}=0A=
+ 		}=0A=
+ =0A=
+ 		/* decide which subbands to join */=0A=
+ 		frame->join =3D 0;=0A=
+ 		for (sb =3D 0; sb < frame->subbands - 1; sb++) {=0A=
+ 			if ( (scalefactor[0][sb] + scalefactor[1][sb]) > =0A=
+ 			     (scalefactor_j[0][sb] + scalefactor_j[1][sb]) ) {=0A=
+ 				/* use joint stereo for this subband */=0A=
+ 				frame->join |=3D 1 << sb;=0A=
+ 				frame->scale_factor[0][sb] =3D scale_factor_j[0][sb];=0A=
+ 				frame->scale_factor[1][sb] =3D scale_factor_j[1][sb];=0A=
+ 				scalefactor[0][sb] =3D scalefactor_j[0][sb];=0A=
+ 				scalefactor[1][sb] =3D scalefactor_j[1][sb];=0A=
+ 				for (blk =3D 0; blk < frame->blocks; blk++) {=0A=
+ 					frame->sb_sample_f[blk][0][sb] =3D sb_sample_j[blk][0][sb];=0A=
+ 					frame->sb_sample_f[blk][1][sb] =3D sb_sample_j[blk][1][sb];=0A=
+ 				}=0A=
+			}=0A=
+ 		}=0A=
+   =0A=
+ 		if (len * 8 < produced + frame->subbands) {=0A=
+ 			return -1;=0A=
+ 		} else {=0A=
+ 			data[4] =3D 0;=0A=
+ 			for (sb =3D 0; sb < frame->subbands - 1; sb++) {=0A=
+ 				data[4] |=3D ((frame->join >> sb) & 0x01) << (7 - sb);=0A=
+ 			}=0A=
+ 			if (frame->subbands =3D=3D 4) {=0A=
+ 				crc_header[crc_pos / 8] =3D data[4] & 0xf0;=0A=
+ 			} else {=0A=
+ 				crc_header[crc_pos / 8] =3D data[4];=0A=
+ 			}=0A=
+ =0A=
+ 			produced +=3D frame->subbands;=0A=
+ 			crc_pos +=3D frame->subbands;=0A=
+ 		}=0A=
+ 	}=0A=
 =0A=
 	if (len * 8 < produced + (4 * frame->subbands * frame->channels)) {=0A=
 		return -1;=0A=
@@ -1432,13 +1202,14 @@=0A=
 		for (ch =3D 0; ch < frame->channels; ch++) {=0A=
 			for (sb =3D 0; sb < frame->subbands; sb++) {=0A=
 				if (levels[ch][sb] > 0) {=0A=
+//PLEASECHECK: overflow possible? more elegant solution?=0A=
 #ifdef USE_FIXED=0A=
 					frame->audio_sample[blk][ch][sb] =3D=0A=
-						(u_int16_t) ((((frame->sb_sample_f[blk][ch][sb]*levels[ch][sb]) =
>> (frame->scale_factor[ch][sb] + 1)) +=0A=
+						(uint16_t) =
((((SCALE_STAGE2(frame->sb_sample_f[blk][ch][sb])*levels[ch][sb]) >> =
(frame->scale_factor[ch][sb] + 1)) +=0A=
 						levels[ch][sb]) >> 1);=0A=
 #else=0A=
 					frame->audio_sample[blk][ch][sb] =3D=0A=
-						(u_int16_t) (((frame->sb_sample[blk][ch][sb] / =
scalefactor[ch][sb] +=0A=
+						(uint16_t) (((frame->sb_sample_f[blk][ch][sb] / =
scalefactor[ch][sb] +=0A=
 						1.0) * levels[ch][sb]) / 2.0);=0A=
 #endif=0A=
 				} else {=0A=
@@ -1512,7 +1283,6 @@=0A=
 	struct sbc_priv *priv;=0A=
 	char *ptr;=0A=
 	int i, ch, framelen, samples;=0A=
-	static int modulo =3D 0;=0A=
 =0A=
 	if (!sbc)=0A=
 		return -EIO;=0A=
@@ -1562,8 +1332,6 @@=0A=
 =0A=
 	sbc->len =3D samples * priv->frame.channels * 2;=0A=
 =0A=
-	if(modulo++ % 256 =3D=3D 0) rmagnitude(1.0, -1, NULL);=0A=
-=0A=
 	return framelen;=0A=
 }=0A=
 =0A=
Index: sbc/sbc.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc.h,v=0A=
retrieving revision 1.21=0A=
diff -u -r1.21 sbc.h=0A=
--- sbc/sbc.h	22 Aug 2005 07:11:14 -0000	1.21=0A=
+++ sbc/sbc.h	3 Sep 2005 14:57:06 -0000=0A=
@@ -29,8 +29,6 @@=0A=
 extern "C" {=0A=
 #endif=0A=
 =0A=
-#include <stdint.h>=0A=
-=0A=
 #define SBC_NULL	0x00000001=0A=
 =0A=
 struct sbc_struct {=0A=
@@ -53,90 +51,6 @@=0A=
 =0A=
 typedef struct sbc_struct sbc_t;=0A=
 =0A=
-#ifdef USE_FIXED=0A=
-=0A=
-typedef int32_t sbc_fixed_t;=0A=
-=0A=
-// this must be an even number=0A=
-#define FRAC 20=0A=
-=0A=
-// FRAC/2 leading ones for sign-extended shift=0A=
-#define PAD (0xffffffff<<(32-(FRAC>>1)))=0A=
-=0A=
-// FRAC/2 trailing ones for finding the roundoff portion=0A=
-#define RMASK (0xffffffff>>(32-(FRAC>>1)))=0A=
-=0A=
-#define FIXED_ONE (1<<FRAC)=0A=
-=0A=
-// sign-extend half the number of shift (fractional) bits=0A=
-static inline sbc_fixed_t signextshift(sbc_fixed_t i) { =0A=
-	if(i<0) return (i>>(FRAC>>1)) | PAD;=0A=
-	return i>>(FRAC>>1); =0A=
-}=0A=
-=0A=
-static inline sbc_fixed_t itofixed(int i) { return i<<FRAC; }=0A=
-=0A=
-static inline int fixedtoi(sbc_fixed_t f) { return f>>FRAC; }=0A=
-=0A=
-static inline sbc_fixed_t dtofixed(double d) { return (sbc_fixed_t)(d * =
(double)FIXED_ONE); }=0A=
-=0A=
-static inline double fixedtod(sbc_fixed_t f) { return f / =
(double)FIXED_ONE; }=0A=
-=0A=
-static inline sbc_fixed_t fxmultquick(sbc_fixed_t a, sbc_fixed_t b) { =0A=
-	sbc_fixed_t p =3D signextshift(a)*signextshift(b);=0A=
-	return p;=0A=
-}=0A=
-=0A=
-static inline sbc_fixed_t fxmult(sbc_fixed_t a, sbc_fixed_t b) { =0A=
-	// don't lose as much roundoff precision=0A=
-	sbc_fixed_t ad =3D signextshift(a);=0A=
-	sbc_fixed_t bd =3D signextshift(b);=0A=
-	sbc_fixed_t p =3D (ad * bd) + signextshift(ad * (b & RMASK)) + =
signextshift(bd * (a & RMASK));=0A=
-	return p;=0A=
-}=0A=
-=0A=
-//overflow problems?=0A=
-//static inline sbc_fixed_t fxdiv(sbc_fixed_t a, sbc_fixed_t b) { =
return (a<<FRAC)/b; }=0A=
-=0A=
-#define ADD64(dhi, dlo, shi, slo)  { dlo +=3D slo; dhi +=3D shi; if ( =
(unsigned long)dlo < (unsigned long)slo ) dhi++;}=0A=
-#define SUB64(dhi, dlo, shi, slo)  { dlo -=3D slo; dhi -=3D shi; if ( =
(unsigned long)dlo > (unsigned long)slo ) dhi--;}=0A=
-=0A=
-#ifdef __arm__=0A=
-// arm specific (should be fast on arm)=0A=
-=0A=
-#define MUL64(hi, lo, x, y) \=0A=
-    asm ("smull	%0, %1, %2, %3"  \=0A=
-	 : "=3D&r" (lo), "=3D&r" (hi)  \=0A=
-	 : "%r" (x), "r" (y))=0A=
-=0A=
-#define MULA64(hi, lo, x, y)  \=0A=
-    asm ("smlal	%0, %1, %2, %3"  \=0A=
-	 : "+r" (lo), "+r" (hi)  \=0A=
-	 : "%r" (x), "r" (y))=0A=
-=0A=
-#define SCALE64(hi, lo, bits) \=0A=
-    ({ int32_t __result;  \=0A=
-    asm ("movs	%0, %1, lsr %3\n\t"  \=0A=
-	 "adc	%0, %0, %2, lsl %4"  \=0A=
-	 : "=3D&r" (__result)  \=0A=
-	 : "r" (lo), "r" (hi), \=0A=
-	 "M" (bits), "M" (32 - bits)  \=0A=
-	 : "cc");  \=0A=
-    __result;  \=0A=
-    })=0A=
-=0A=
-#else=0A=
-//general purpose (slow?)=0A=
-=0A=
-#define MUL64(hi, lo, a, b) {long long x; x =3D (long long)a * b; hi =
=3D (long)(x >> 32); lo =3D (long)x;}=0A=
-#define MULA64(hi, lo, a, b)  {long long x; x =3D (long long)a * b; hi =
+=3D (long)(x >> 32); lo +=3D (long)x; if ((unsigned long)lo < (unsigned =
long)x) hi++;}=0A=
-#define SCALE64(hi, lo, bits) ((int32_t)((hi << (32 - bits)) | ((lo >> =
bits) & (0xFFFFFFFF >> bits))))=0A=
-=0A=
-#endif=0A=
-=0A=
-=0A=
-#endif=0A=
-=0A=
 int sbc_init(sbc_t *sbc, unsigned long flags);=0A=
 int sbc_decode(sbc_t *sbc, void *data, int count);=0A=
 int sbc_encode(sbc_t *sbc, void *data, int count);=0A=
Index: sbc/sbc_tables.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc_tables.h,v=0A=
retrieving revision 1.5=0A=
diff -u -r1.5 sbc_tables.h=0A=
--- sbc/sbc_tables.h	28 Aug 2005 05:32:19 -0000	1.5=0A=
+++ sbc/sbc_tables.h	3 Sep 2005 14:57:06 -0000=0A=
@@ -25,6 +25,8 @@=0A=
 #ifndef __SBC_TABLES_H=0A=
 #define __SBC_TABLES_H=0A=
 =0A=
+#include "sbc_math.h"=0A=
+=0A=
 /* A2DP specification: Appendix B, page 69 */=0A=
 static const int sbc_offset4[4][4] =3D {=0A=
 	{ -1, 0, 0, 0 },=0A=
@@ -175,6 +177,34 @@=0A=
 	  -0.382683432365091,  0.555570233019606, -0.707106781186548,  =
0.831469612302547 }=0A=
 };=0A=
 =0A=
+#ifdef USE_FIXED=0A=
+=0A=
+#ifdef USE_FIXED32=0A=
+=0A=
+#define SP8(val) (val >> SCALE_PROTO8_TBL)=0A=
+#define SA8(val) (val >> SCALE_ANA8_TBL)=0A=
+=0A=
+#else // USE_FIXED32=0A=
+=0A=
+#define SP8(val) (val)=0A=
+#define SA8(val) (val)=0A=
+=0A=
+#endif // USE_FIXED32=0A=
+=0A=
+static const int32_t _sbc_proto_8[40] =3D {=0A=
+	SP8(0x02e5cd20), SP8(0x22d0c200), SP8(0x006bfe27), SP8(0x07808930), =
SP8(0x3f1c8800), SP8(0xf8810d70), SP8(0x002cfdc6), SP8(0x055acf28),=0A=
+	SP8(0x31f566c0), SP8(0xebfe57e0), SP8(0xff27c437), SP8(0x001485cc), =
SP8(0x041c6e58), SP8(0x2a7cfa80), SP8(0xe4c4a240), SP8(0xfe359e4c),=0A=
+	SP8(0x0048b1f8), SP8(0x0686ce30), SP8(0x38eec5c0), SP8(0xf2a1b9f0), =
SP8(0xffe8904a), SP8(0x0095698a), SP8(0x0824a480), SP8(0x443b3c00),=0A=
+	SP8(0xfd7badc8), SP8(0x00d3e2d9), SP8(0x00c183d2), SP8(0x084e1950), =
SP8(0x4810d800), SP8(0x017f43fe), SP8(0x01056dd8), SP8(0x00e9cb9f),=0A=
+	SP8(0x07d7d090), SP8(0x4a708980), SP8(0x0488fae8), SP8(0x0113bd20), =
SP8(0x0107b1a8), SP8(0x069fb3c0), SP8(0x4b3db200), SP8(0x00763f48)=0A=
+};=0A=
+=0A=
+static const int32_t _anamatrix8[8] =3D {=0A=
+	SA8(0x3b20d780), SA8(0x187de2a0), SA8(0x3ec52f80), SA8(0x3536cc40), =
SA8(0x238e7680), SA8(0x0c7c5c20), SA8(0x2d413cc0), SA8(0x40000000)=0A=
+};=0A=
+=0A=
+#else // USE_FIXED=0A=
+=0A=
 static const float _anamatrix8[8] =3D {=0A=
 	0.923879532511287, 0.382683432365091, 0.980785280403231, =
0.831469612302547, 0.555570233019602,=0A=
 	0.195090322016128, 0.707106781186547, 1=0A=
@@ -189,14 +219,7 @@=0A=
 	1.99454557E-03, 1.78371731E-03, 1.53184105E-02, 1.45389840E-01, =
8.85757525E-03, 2.10371986E-03,=0A=
 	2.01182533E-03, 1.29371807E-02, 1.46955073E-01, 9.02154483E-04=0A=
 };=0A=
-=0A=
-static const float _anamatrix4[4] =3D { =0A=
-	0., 0., 0., 0.=0A=
-};=0A=
-=0A=
-static const float _sbc_proto_4[20] =3D {=0A=
-	0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,=0A=
-        0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,=0A=
-};=0A=
+#endif // USE_FIXED=0A=
 =0A=
 #endif /* __SBC_TABLES_H */=0A=
+=0A=
Index: sbc/sbc_tables_f.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc_tables_f.h,v=0A=
retrieving revision 1.8=0A=
diff -u -r1.8 sbc_tables_f.h=0A=
--- sbc/sbc_tables_f.h	25 Aug 2005 23:14:50 -0000	1.8=0A=
+++ sbc/sbc_tables_f.h	3 Sep 2005 14:57:06 -0000=0A=
@@ -27,7 +27,7 @@=0A=
 { 0xf137ca20, 0xf9e08758, 0x061f78a8, 0x0ec835e0, 0x0ec835e0, =
0x061f78a8, 0xf9e08758, 0xf137ca20 },=0A=
 { 0xf2b24cf0, 0x031f1708, 0x0fb14be0, 0x08e39da0, 0xf71c6260, =
0xf04eb420, 0xfce0e8f8, 0x0d4db310 }=0A=
 };=0A=
-=0A=
+/*=0A=
 #define FIXED64_STAGE1 24=0A=
 static const int32_t _sbc_proto_8_f[40] =3D {=0A=
 0x02e5cd20, 0x22d0c200, 0x006bfe27, 0x07808930, 0x3f1c8800, 0xf8810d70, =
0x002cfdc6, 0x055acf28, =0A=
@@ -42,3 +42,4 @@=0A=
 0x3b20d780, 0x187de2a0, 0x3ec52f80, 0x3536cc40, 0x238e7680, 0x0c7c5c20, =
0x2d413cc0, 0x40000000=0A=
 };=0A=
 =0A=
+*/=0A=
\ No newline at end of file=0A=
--- /dev/null	2005-09-03 18:50:56.041670456 +0200=0A=
+++ sbc/sbc_math.h	2005-08-30 23:48:25.000000000 +0200=0A=
@@ -0,0 +1,108 @@=0A=
+#ifndef __SBC_MATH_H=0A=
+#define __SBC_MATH_H=0A=
+=0A=
+#include <stdint.h>=0A=
+=0A=
+#define fabs(x) ((x) < 0 ?-(x) : (x))=0A=
+=0A=
+#ifdef USE_FIXED=0A=
+=0A=
+#ifdef USE_FIXED32=0A=
+=0A=
+#define SCALE_PROTO8_TBL 18=0A=
+#define SCALE_ANA8_TBL 20=0A=
+#define SCALE_STAGE1_BITS 14=0A=
+#define SCALE_STAGE2_BITS 18=0A=
+=0A=
+typedef int32_t sbc_fixed_t;=0A=
+=0A=
+#define SBC_FIXED_0(val) {val =3D 0;}=0A=
+#define DIV2(dst, src) {dst =3D src >> 1;}=0A=
+=0A=
+#define ADD(dst, src)  {dst +=3D src;}=0A=
+#define SUB(dst, src)  {dst -=3D src;}=0A=
+#define MUL(dst, a, b) {dst =3D a*b;}=0A=
+#define MULA(dst, a, b)  {dst +=3D a*b;}=0A=
+#define SCALE_STAGE1(src) (src >> SCALE_STAGE1_BITS)=0A=
+#define SCALE_STAGE2(src) (src >> SCALE_STAGE2_BITS)=0A=
+=0A=
+#else // USE_FIXED32=0A=
+=0A=
+#define SCALE_STAGE1_BITS 24=0A=
+#define SCALE_STAGE2_BITS 7=0A=
+=0A=
+struct sbc_fixed_struct{=0A=
+	int32_t hi;=0A=
+	uint32_t lo;=0A=
+};=0A=
+typedef struct sbc_fixed_struct sbc_fixed_t;=0A=
+=0A=
+#define SBC_FIXED_0(val) {val.hi =3D 0;val.lo =3D 0;}=0A=
+#define DIV2(dst, src) {dst.hi =3D src.hi >> 1; dst.lo =3D (src.lo >> =
1); if (src.hi & 1) dst.lo |=3D 0x80000000; else dst.lo &=3D 0x7FFFFFFF;}=0A=
+=0A=
+#ifdef __arm__=0A=
+=0A=
+#define ADD(dst, src)  \=0A=
+    asm ("adds	%0, %0, %2\n\t"  \=0A=
+	 "adc	%1, %1, %3"	\=0A=
+	 : "+r" (dst.lo), "+r" (dst.hi)  \=0A=
+	 : "%r" (src.lo), "r" (src.hi))=0A=
+=0A=
+#define SUB(dst, src)  \=0A=
+    asm ("subs	%0, %0, %2\n\t"  \=0A=
+	 "sbc	%1, %1, %3"	\=0A=
+	 : "+r" (dst.lo), "+r" (dst.hi)  \=0A=
+	 : "%r" (src.lo), "r" (src.hi))=0A=
+=0A=
+#define MUL(dst, a, b) \=0A=
+    asm ("smull	%0, %1, %2, %3"  \=0A=
+	 : "=3D&r" (dst.lo), "=3D&r" (dst.hi)  \=0A=
+	 : "%r" (a), "r" (b))=0A=
+=0A=
+#define MULA(dst, a, b)  \=0A=
+    asm ("smlal	%0, %1, %2, %3"  \=0A=
+	 : "+r" (dst.lo), "+r" (dst.hi)  \=0A=
+	 : "%r" (a), "r" (b))=0A=
+=0A=
+#define SCALE_STAGE1(src) \=0A=
+    ({ int32_t __result;  \=0A=
+    asm ("movs	%0, %1, lsr %3\n\t"  \=0A=
+	 "adc	%0, %0, %2, lsl %4"  \=0A=
+	 : "=3D&r" (__result)  \=0A=
+	 : "r" (src.lo), "r" (src.hi), \=0A=
+	 "M" (SCALE_STAGE1_BITS), "M" (32 - SCALE_STAGE1_BITS)  \=0A=
+	 : "cc");  \=0A=
+    __result;  \=0A=
+    })=0A=
+=0A=
+#define SCALE_STAGE2(src) (src.hi >> SCALE_STAGE2_BITS)=0A=
+=0A=
+#else // _arm_=0A=
+=0A=
+#define ADD(dst, src)  {dst.lo +=3D src.lo; dst.hi +=3D src.hi; if ( =
dst.lo < src.lo ) dst.hi++;}=0A=
+#define SUB(dst, src)  {dst.hi -=3D src.hi; if ( dst.lo < src.lo ) =
dst.hi--; dst.lo -=3D src.lo;}=0A=
+#define MUL(dst, a, b) {int64_t x; x =3D (int64_t)a * b; dst.hi =3D x =
>> 32; dst.lo =3D x;}=0A=
+#define MULA(dst, a, b)  {int64_t x; x =3D (int64_t)a * b; dst.hi +=3D =
(x >> 32); dst.lo +=3D x; if (dst.lo < (uint32_t)x) dst.hi++;}=0A=
+#define SCALE_STAGE1(src) ((int32_t)((src.hi << (32 - =
SCALE_STAGE1_BITS)) | ((src.lo >> SCALE_STAGE1_BITS) & (0xFFFFFFFF >> =
SCALE_STAGE1_BITS))))=0A=
+#define SCALE_STAGE2(src) (src.hi >> SCALE_STAGE2_BITS)=0A=
+=0A=
+#endif // __arm__=0A=
+=0A=
+#endif // USE_FIXED32=0A=
+=0A=
+#else // USE_FIXED=0A=
+=0A=
+typedef double sbc_fixed_t;=0A=
+=0A=
+#define SBC_FIXED_0(val) {val =3D 0;}=0A=
+#define DIV2(dst, src) {dst =3D src / 2;}=0A=
+#define ADD(dst, src)  {dst +=3D src;}=0A=
+#define SUB(dst, src)  {dst -=3D src;}=0A=
+#define MUL(dst, a, b) {dst =3D a*b;}=0A=
+#define MULA(dst, a, b)  {dst +=3D a*b;}=0A=
+#define SCALE_STAGE1(src) (src)=0A=
+#define SCALE_STAGE2(src) (src)=0A=
+=0A=
+#endif // USE_FIXED=0A=
+=0A=
+#endif // __SBC_MATH_H=0A=

------=_NextPart_000_0013_01C5B0AD.A2E87020--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
