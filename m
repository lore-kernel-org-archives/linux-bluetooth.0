Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001001c5a680$cfb641e0$0201a8c0@NBVICTOR>
From: "Victor Shcherbatyuk" <victor@win.tue.nl>
To: <bluez-devel@lists.sourceforge.net>
References: <C70061B183DE09419568AB2060C52A95980BDC@arion.intra.local> <42E8F2B6.6090804@xmission.com>
Subject: Re: [Bluez-devel] sbc and fixed-point progress
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000D_01C5A691.9290F790"
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
Date: Sun, 21 Aug 2005 20:47:40 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_000D_01C5A691.9290F790
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit

Hello Brad,

In the attachment is the patch to support fixed point encoding for 8-subband 
sbc codec. To compie ARM specific version USE_FIXED_ARM should be defined 
(currently in sbc/sbc.c should be in configuration?). It is possible I broke 
your fixed point tables cause I've changed gen_fixed.c, but it should be 
easy fixable.

Floating point implementation is optimized too, runs 30% faster on my 
AthlonXP. General fixed point (long long) runs slower than floating on my 
PC, which is strange... I do not have HW to test arm specific version real 
time, hope no suprises there, but I could have missed something when 
integrating it into sbc code (it decodes well, but how fast, I will try only 
monday evening).

Using a2play needs to tweak 87 magic number, otherwise it drops samples?

Regards,
     Victor.

P.S. There are a lot of changes, I hope I didn't miss any... Please take a 
look, and let me know if something is wrong with it...

----- Original Message ----- 
From: "Brad Midgley" <bmidgley@xmission.com>
To: <bluez-devel@lists.sourceforge.net>
Sent: Thursday, July 28, 2005 16:59
Subject: Re: [Bluez-devel] sbc and fixed-point progress


> Victor,
>
> Great! Can you send me the output of "cvs diff -u" or the resulting sbc.c?
>
> Even if it's noisy, we will just make it optional using the compile-time 
> option and improve it over time. Right now we have no way at all to encode 
> on arm, so even a noisy encoder would be going in the right direction.
>
> I started working on the decoder but got stuck when I found that the 
> state->W and state->X variables sometimes needed large precision and 
> sometimes had large integer parts (ie in a naive fixed-point 
> implementation, they would need more than 32 bits). I was contemplating 
> keeping a large precision in the fixed point type but using a separate 
> integer for those variables' integer part.
>
> Brad
>
> Victor Shcherbatyuk wrote:
>> Hello Brad,
>>
>> FYI,
>>
>> Yesterday I converted encoder to fixed point (I did it a dirty way, so
>> probably it doesn't have much of the value). I've converted each of the
>> tables with different precision in such a way that the operations
>> involving the tables (mults and adds) will not overflow 32 bit, and
>> where necessary I pre-shift intermediate results to prevent overlowing.
>> Currently the output  is a slightly noisy, but the purpose was to
>> estimate required performance. The result is, in the current
>> implementation, using fixed point it is just about to be enough to run
>> on 400Mhz arm combined with mp3 decoder (mp3 piped though mad mp3
>> decoder to sbc encoder to a2play). This means either something is wrong
>> :) or SBC codec should be heavily optimized (3 - 5 times ?) to make it
>> reasonable (memcopies is the first thing to optimize probably)...
>>
>> Regards,
>>      Victor.
>>
>>
>> -----Original Message-----
>> From: bluez-devel-admin@lists.sourceforge.net
>> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
>> Midgley
>> Sent: Monday, July 04, 2005 6:03 AM
>> To: BlueZ Mailing List
>> Subject: [Bluez-devel] sbc and fixed-point progress
>>
>> Guys,
>>
>> just FYI...
>>
>> I found a decent fixed point multiply that preshifts the values before
>> multiplying them. It keeps things in 32 bits. Most of the roundoff error
>> is taken care of in two additional terms. I think the result is
>> reasonable.
>> (http://www.accu.org/acornsig/public/caugers/volume2/issue6/fixedpoint.h
>> tml)
>>
>> If you compile with fixed-point on, libsbc will run both the fixed and
>> floating point calculations and flag errors when they differ too much.
>> It seems to be working well and has helped me catch a couple of
>> fixed-point calculation problems.
>>
>> I have the decoder almost finished but I probably need to split some
>> terms into integer and fixed-point components. Loading up 
>> frame->sb_sample for example can have a big integer part but we want to
>> use most of the 32 bit fixed-point type for the fractional part.
>>
>> Brad
>>
>>
>>
>> -------------------------------------------------------
>> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>> from IBM. Find simple to follow Roadmaps, straightforward articles,
>> informative Webcasts and more! Get everything you need to get up to
>> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>>
>> This e-mail message contains information which is confidential and may be 
>> privileged. It is intended for use by the addressee only. If you are not 
>> the intended addressee, we request that you notify the sender immediately 
>> and delete or destroy this e-mail message and any attachment(s), without 
>> copying, saving, forwarding, disclosing or using its contents in any 
>> other way. TomTom N.V., TomTom International BV or any other company 
>> belonging to the TomTom group of companies will not be liable for damage 
>> relating to the communication by e-mail of data, documents or any other 
>> information.
>>
>>
>> -------------------------------------------------------
>> SF.Net email is Sponsored by the Better Software Conference & EXPO 
>> September
>> 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
>> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & 
>> QA
>> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO 
> September
> 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel 

------=_NextPart_000_000D_01C5A691.9290F790
Content-Type: application/octet-stream;
	name="sbc-fixed.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sbc-fixed.patch"

? sbc/play=0A=
? sbc/test.pcm=0A=
? sbc/test.sbc=0A=
? sbc/test1.sbc=0A=
Index: sbc/gen_fixed.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/gen_fixed.c,v=0A=
retrieving revision 1.2=0A=
diff -u -r1.2 gen_fixed.c=0A=
--- sbc/gen_fixed.c	22 Jun 2005 18:08:45 -0000	1.2=0A=
+++ sbc/gen_fixed.c	21 Aug 2005 18:26:31 -0000=0A=
@@ -1,5 +1,6 @@=0A=
 #define USE_FIXED=0A=
 =0A=
+#include <math.h>=0A=
 #include "sbc.h"=0A=
 #include "sbc_tables.h"=0A=
 =0A=
@@ -8,13 +9,15 @@=0A=
 	void *ref;=0A=
 	int i;=0A=
 	int j;=0A=
+	int bits;=0A=
 } tables[] =3D {=0A=
-	{"sbc_proto_4_40_f", (void *)sbc_proto_4_40, 40, 1},=0A=
-	{"sbc_proto_8_80_f", (void *)sbc_proto_8_80, 80, 1},=0A=
-	{"synmatrix4_f", (void *)synmatrix4, 8, 4},=0A=
-	{"synmatrix8_f", (void *)synmatrix8, 16, 8},=0A=
-	{"anamatrix4_f", (void *)anamatrix4, 4, 8},=0A=
-	{"anamatrix8_f", (void *)anamatrix8, 8, 16},=0A=
+	{"sbc_proto_4_40_f", (void *)sbc_proto_4_40, 40, 1, 28},=0A=
+	{"sbc_proto_8_80_f", (void *)sbc_proto_8_80, 80, 1, 28},=0A=
+	{"synmatrix4_f", (void *)synmatrix4, 8, 4, 28},=0A=
+	{"synmatrix8_f", (void *)synmatrix8, 16, 8, 28},=0A=
+	{"anamatrix4_f", (void *)anamatrix4, 4, 8, 28},=0A=
+	{"_sbc_proto_8_f", (void *)_sbc_proto_8, 40, 1, 33},=0A=
+	{"_anamatrix8_f", (void *)_anamatrix8, 8, 1, 30},=0A=
 	{0, 0, 0, 0}=0A=
 };=0A=
 =0A=
@@ -23,15 +26,33 @@=0A=
 	float *array;=0A=
 	for(entry =3D 0; tables[entry].name; entry++) {=0A=
 		if(tables[entry].j =3D=3D 1) {=0A=
-			printf("static const sbc_fixed_t %s[%d] =3D {\n",=0A=
-			       tables[entry].name, tables[entry].i);=0A=
+			if (tables[entry].ref =3D=3D (void *)_sbc_proto_8 || =
tables[entry].ref =3D=3D (void *)_anamatrix8) {=0A=
+				if (tables[entry].ref =3D=3D (void *)_sbc_proto_8)=0A=
+					printf("#define FIXED64_STAGE1 %d\n", 24);=0A=
+				else=0A=
+					printf("#define FIXED64_STAGE2 %d\n", 7);=0A=
+				printf("static const int32_t %s[%d] =3D {\n",=0A=
+				       tables[entry].name, tables[entry].i);=0A=
+			}=0A=
+			else=0A=
+				printf("static const sbc_fixed_t %s[%d] =3D {\n",=0A=
+				       tables[entry].name, tables[entry].i);=0A=
 			array =3D (float *)tables[entry].ref;=0A=
 			for(i =3D 0; i < tables[entry].i; i++) {=0A=
 				if(i>0) {=0A=
 					printf(", ");=0A=
 					if(i%8 =3D=3D 0) printf("\n");=0A=
 				}=0A=
-				printf("0x%08x", dtofixed(array[i]));=0A=
+				double res =3D array[i]*pow(2, tables[entry].bits);=0A=
+				if (res > 0 )=0A=
+					res +=3D 0.5;=0A=
+				else=0A=
+					res +=3D -0.5;=0A=
+				if (fabs(res) > (double)(0xFFFFFFFF / 2.0)) {=0A=
+					printf("OVERFLOW (%f)!\n", res);=0A=
+					exit(1);=0A=
+				}=0A=
+				printf("0x%08x", (int32_t)res);=0A=
 			}=0A=
 			printf("\n};\n\n");=0A=
 		} else {=0A=
@@ -47,7 +68,16 @@=0A=
 						printf(", ");=0A=
 						if(j%8 =3D=3D 0) printf("\n");=0A=
 					}=0A=
-					printf("0x%08x", dtofixed(array[idx++]));=0A=
+					double res =3D array[idx++]*pow(2, tables[entry].bits);=0A=
+					if (res > 0 )=0A=
+						res +=3D 0.5;=0A=
+					else=0A=
+						res +=3D -0.5;=0A=
+					if (fabs(res) > (double)(0xFFFFFFFF / 2.0)) {=0A=
+						printf("OVERFLOW (%f)!\n", res);=0A=
+						exit(1);=0A=
+					}=0A=
+					printf("0x%08x", (int32_t)res);=0A=
 				}=0A=
 				printf(" }");=0A=
 			}=0A=
Index: sbc/sbc.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc.c,v=0A=
retrieving revision 1.47=0A=
diff -u -r1.47 sbc.c=0A=
--- sbc/sbc.c	26 Jul 2005 20:30:52 -0000	1.47=0A=
+++ sbc/sbc.c	21 Aug 2005 18:26:32 -0000=0A=
@@ -36,6 +36,8 @@=0A=
 =0A=
 */=0A=
 =0A=
+//#define USE_FIXED_ARM=0A=
+=0A=
 #ifdef HAVE_CONFIG_H=0A=
 #include <config.h>=0A=
 #endif=0A=
@@ -68,7 +70,6 @@=0A=
 	}=0A=
 	return 0;=0A=
 }=0A=
-=0A=
 #endif=0A=
 =0A=
 struct magnitude {=0A=
@@ -155,7 +156,7 @@=0A=
 /* This structure contains an unpacked SBC frame. =0A=
    Yes, there is probably quite some unused space herein */=0A=
 struct sbc_frame {=0A=
-	double sampling_frequency;	/* in kHz */=0A=
+	u_int16_t sampling_frequency;	/* in kHz */=0A=
 	u_int8_t blocks;=0A=
 	enum {=0A=
 		MONO		=3D SBC_CM_MONO,=0A=
@@ -178,7 +179,7 @@=0A=
 	sbc_fixed_t pcm_sample_f[2][16*8];=0A=
 #endif=0A=
 	double sb_sample[16][2][8];		/* modified subband samples */=0A=
-	double pcm_sample[2][16*8];		/* original pcm audio samples */=0A=
+	int16_t pcm_sample[2][16*8];		/* original pcm audio samples */=0A=
 };=0A=
 =0A=
 struct sbc_decoder_state {=0A=
@@ -196,8 +197,9 @@=0A=
 =0A=
 struct sbc_encoder_state {=0A=
 	int subbands;=0A=
-	float S[2][8];				/* Subband samples */=0A=
-	float X[2][80], Y[2][16], Z[2][80];	/* Vectors */=0A=
+	double S[2][8];				/* Subband samples */=0A=
+	double Y[2][16], Z[2][80];		/* Vectors */=0A=
+	int32_t X[2][80];=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -497,16 +499,16 @@=0A=
 	sf =3D (data[1] >> 6) & 0x03;=0A=
 	switch (sf) {=0A=
 	case SBC_FS_16:=0A=
-		frame->sampling_frequency =3D 16;=0A=
+		frame->sampling_frequency =3D 16000;=0A=
 		break;=0A=
 	case SBC_FS_32:=0A=
-		frame->sampling_frequency =3D 32;=0A=
+		frame->sampling_frequency =3D 32000;=0A=
 		break;=0A=
 	case SBC_FS_44:=0A=
-		frame->sampling_frequency =3D 44.1;=0A=
+		frame->sampling_frequency =3D 44100;=0A=
 		break;=0A=
 	case SBC_FS_48:=0A=
-		frame->sampling_frequency =3D 48;=0A=
+		frame->sampling_frequency =3D 48000;=0A=
 		break;=0A=
 	}=0A=
 =0A=
@@ -794,7 +796,7 @@=0A=
 =0A=
 	/* Output 4 reconstructed Audio Samples */=0A=
 	for (i =3D 0; i < 4; i++) {=0A=
-		frame->pcm_sample[ch][blk * 4 + i] =3D state->X[ch][i];=0A=
+		frame->pcm_sample[ch][blk * 4 + i] =3D (int16_t)state->X[ch][i];=0A=
 #ifdef USE_FIXED=0A=
 		frame->pcm_sample_f[ch][blk * 4 + i] =3D state->X_f[ch][i];=0A=
 		assertf(0, frame->pcm_sample[ch][blk * 4 + i], =
frame->pcm_sample_f[ch][blk * 4 + i], "output samples");=0A=
@@ -891,7 +893,7 @@=0A=
 =0A=
 	/* Ouput 8 reconstructed Audio Samples */=0A=
 	for (i =3D 0; i < 8; i++) {=0A=
-		frame->pcm_sample[ch][blk * 8 + i] =3D state->X[ch][i];=0A=
+		frame->pcm_sample[ch][blk * 8 + i] =3D (int16_t)state->X[ch][i];=0A=
 #ifdef USE_FIXED=0A=
 		frame->pcm_sample_f[ch][blk * 8 + i] =3D state->X_f[ch][i];=0A=
 		assertf(0, frame->pcm_sample[ch][blk * 8 + i], =
frame->pcm_sample_f[ch][blk * 8 + i], "output samples");=0A=
@@ -973,39 +975,316 @@=0A=
 	for (i =3D 0; i < 4; i++)=0A=
 		frame->sb_sample[blk][ch][i] =3D state->S[ch][i];=0A=
 }=0A=
+#ifdef USE_FIXED=0A=
+static inline void _sbc_analyze_eight(int32_t in[80], int32_t out[8])=0A=
+{=0A=
+	int32_t =
a0_hi,a1_hi,a2_hi,a3_hi,a4_hi,a5_hi,a6_hi,a7_hi,a8_hi,a9_hi,a10_hi,a11_hi=
,a12_hi,a13_hi,a14_hi,a15_hi,a16_hi,a17_hi,a18_hi,a19_hi,a20_hi, a21_hi;=0A=
+	int32_t =
a0_lo,a1_lo,a2_lo,a3_lo,a4_lo,a5_lo,a6_lo,a7_lo,a8_lo,a9_lo,a10_lo,a11_lo=
,a12_lo,a13_lo,a14_lo,a15_lo,a16_lo,a17_lo,a18_lo,a19_lo,a20_lo, a21_lo;=0A=
+	int32_t in1, in2, t1, t2, t3, t4, t5, t6, t7, t8;=0A=
+	int32_t t1_hi, t1_lo, t2_hi, t2_lo, t3_hi, t3_lo, t4_hi, t4_lo;=0A=
+	int32_t t5_hi, t5_lo, t6_hi, t6_lo, t7_hi, t7_lo, t8_hi, t8_lo;=0A=
+	int32_t out0_hi, out1_hi, out2_hi, out3_hi, out4_hi, out5_hi, out6_hi, =
out7_hi;=0A=
+	int32_t out0_lo, out1_lo, out2_lo, out3_lo, out4_lo, out5_lo, out6_lo, =
out7_lo;=0A=
+=0A=
+	t1_hi =3D t1_lo =3D t2_hi =3D t2_lo =3D t3_hi =3D t3_lo =3D t4_hi =3D =
t4_lo =3D 0;=0A=
+	t5_hi =3D t5_lo =3D t6_hi =3D t6_lo =3D t7_hi =3D t7_lo =3D t8_hi =3D =
t8_lo =3D 0;=0A=
+	out0_hi =3D out1_hi =3D out2_hi =3D out3_hi =3D out4_hi =3D out5_hi =
=3D out6_hi =3D out7_hi =3D 0;=0A=
+	out0_lo =3D out1_lo =3D out2_lo =3D out3_lo =3D out4_lo =3D out5_lo =
=3D out6_lo =3D out7_lo =3D 0;=0A=
+=0A=
+	in1 =3D in[16] - in[64]; in2 =3D in[32] - in[48];=0A=
+	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[0], in1);=0A=
+	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[1], in2);=0A=
+	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[2], in[4]);=0A=
+	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[3], in[20]);=0A=
+	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[4], in[36]);=0A=
+	MULA64(t1_hi, t1_lo, _sbc_proto_8_f[5], in[52]);=0A=
+	t1 =3D SCALE64(t1_hi, t1_lo, FIXED64_STAGE1);=0A=
+=0A=
+	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[6], in[2]);=0A=
+	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[7], in[18]);=0A=
+	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[8], in[34]);=0A=
+	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[9], in[50]);=0A=
+	MULA64(t2_hi, t2_lo, _sbc_proto_8_f[10], in[66]);=0A=
+	t2 =3D SCALE64(t2_hi, t2_lo, FIXED64_STAGE1);=0A=
+=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[11], in[1]);=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[12], in[17]);=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[13], in[33]);=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[14], in[49]);=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[15], in[65]);=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[16], in[3]);=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[17], in[19]);=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[18], in[35]);=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[19], in[51]);=0A=
+	MULA64(t3_hi, t3_lo, _sbc_proto_8_f[20], in[67]);=0A=
+	t3 =3D SCALE64(t3_hi, t3_lo, FIXED64_STAGE1);=0A=
+=0A=
+	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[21], in[5]);=0A=
+	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[22], in[21]);=0A=
+	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[23], in[37]);=0A=
+	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[24], in[53]);=0A=
+	MULA64(t4_hi, t4_lo, _sbc_proto_8_f[25], in[69]);=0A=
+	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[15], in[15]);=0A=
+	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[14], in[31]);=0A=
+	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[13], in[47]);=0A=
+	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[12], in[63]);=0A=
+	MULA64(t4_hi, t4_lo, -_sbc_proto_8_f[11], in[79]);=0A=
+	t4 =3D SCALE64(t4_hi, t4_lo, FIXED64_STAGE1);=0A=
+=0A=
+	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[26], in[6]);=0A=
+	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[27], in[22]);=0A=
+	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[28], in[38]);=0A=
+	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[29], in[54]);=0A=
+	MULA64(t5_hi, t5_lo, _sbc_proto_8_f[30], in[70]);=0A=
+	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[10], in[14]);=0A=
+	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[9], in[30]);=0A=
+	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[8], in[46]);=0A=
+	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[7], in[62]);=0A=
+	MULA64(t5_hi, t5_lo, -_sbc_proto_8_f[6], in[78]);=0A=
+	t5 =3D SCALE64(t5_hi, t5_lo, FIXED64_STAGE1);=0A=
+=0A=
+	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[31], in[7]);=0A=
+	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[32], in[23]);=0A=
+	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[33], in[39]);=0A=
+	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[34], in[55]);=0A=
+	MULA64(t6_hi, t6_lo, _sbc_proto_8_f[35], in[71]);=0A=
+	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[20], in[13]);=0A=
+	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[19], in[29]);=0A=
+	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[18], in[45]);=0A=
+	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[17], in[61]);=0A=
+	MULA64(t6_hi, t6_lo, -_sbc_proto_8_f[16], in[77]);=0A=
+	t6 =3D SCALE64(t6_hi, t6_lo, FIXED64_STAGE1);=0A=
+=0A=
+	in1 =3D in[8] + in[72];=0A=
+	MULA64(t7_hi, t7_lo, _sbc_proto_8_f[36], in1);=0A=
+	MULA64(t7_hi, t7_lo, _sbc_proto_8_f[37], in[24]);=0A=
+	MULA64(t7_hi, t7_lo, _sbc_proto_8_f[38], in[40]);=0A=
+	MULA64(t7_hi, t7_lo, _sbc_proto_8_f[37], in[56]);=0A=
+	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[39], in[12]);=0A=
+	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[5], in[28]);=0A=
+	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[4], in[44]);=0A=
+	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[3], in[60]);=0A=
+	MULA64(t7_hi, t7_lo, -_sbc_proto_8_f[2], in[76]);=0A=
+	t7 =3D SCALE64(t7_hi, t7_lo, FIXED64_STAGE1);=0A=
+=0A=
+	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[35], in[9]);=0A=
+	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[34], in[25]);=0A=
+	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[33], in[41]);=0A=
+	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[32], in[57]);=0A=
+	MULA64(t8_hi, t8_lo, _sbc_proto_8_f[31], in[73]);=0A=
+	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[25], in[11]);=0A=
+	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[24], in[27]);=0A=
+	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[23], in[43]);=0A=
+	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[22], in[59]);=0A=
+	MULA64(t8_hi, t8_lo, -_sbc_proto_8_f[21], in[75]);=0A=
+	t8 =3D SCALE64(t8_hi, t8_lo, FIXED64_STAGE1);=0A=
+=0A=
+	MUL64(a0_hi, a0_lo, _anamatrix8_f[0], t1);=0A=
+	MUL64(a7_hi, a7_lo, _anamatrix8_f[1], t1);=0A=
+	ADD64(out0_hi, out0_lo, a0_hi, a0_lo);=0A=
+	ADD64(out7_hi, out7_lo, a0_hi, a0_lo);=0A=
+	SUB64(out3_hi, out3_lo, a0_hi, a0_lo);=0A=
+	SUB64(out4_hi, out4_lo, a0_hi, a0_lo);=0A=
+	ADD64(out1_hi, out1_lo, a7_hi, a7_lo);=0A=
+	ADD64(out6_hi, out6_lo, a7_hi, a7_lo);=0A=
+	SUB64(out5_hi, out5_lo, a7_hi, a7_lo);=0A=
+	SUB64(out2_hi, out2_lo, a7_hi, a7_lo);=0A=
+=0A=
+	MUL64(a21_hi, a21_lo, _anamatrix8_f[7], t2);=0A=
+	ADD64(out0_hi, out0_lo, a21_hi, a21_lo);=0A=
+	ADD64(out1_hi, out1_lo, a21_hi, a21_lo);=0A=
+	ADD64(out2_hi, out2_lo, a21_hi, a21_lo);=0A=
+	ADD64(out3_hi, out3_lo, a21_hi, a21_lo);=0A=
+	ADD64(out4_hi, out4_lo, a21_hi, a21_lo);=0A=
+	ADD64(out5_hi, out5_lo, a21_hi, a21_lo);=0A=
+	ADD64(out6_hi, out6_lo, a21_hi, a21_lo);=0A=
+	ADD64(out7_hi, out7_lo, a21_hi, a21_lo);=0A=
+=0A=
+	MUL64(a1_hi, a1_lo, _anamatrix8_f[2], t3);=0A=
+	MUL64(a8_hi, a8_lo, _anamatrix8_f[3], t3);=0A=
+	MUL64(a13_hi, a13_lo, _anamatrix8_f[4], t3);=0A=
+	MUL64(a17_hi, a17_lo, _anamatrix8_f[5], t3);=0A=
+	ADD64(out0_hi, out0_lo, a1_hi, a1_lo);=0A=
+	SUB64(out7_hi, out7_lo, a1_hi, a1_lo);=0A=
+	ADD64(out1_hi, out1_lo, a8_hi, a8_lo);=0A=
+	SUB64(out6_hi, out6_lo, a8_hi, a8_lo);=0A=
+	ADD64(out2_hi, out2_lo, a13_hi, a13_lo);=0A=
+	SUB64(out5_hi, out5_lo, a13_hi, a13_lo);=0A=
+	ADD64(out3_hi, out3_lo, a17_hi, a17_lo);=0A=
+	SUB64(out4_hi, out4_lo, a17_hi, a17_lo);=0A=
+=0A=
+	MUL64(a2_hi, a2_lo, _anamatrix8_f[3], t4);=0A=
+	MUL64(a9_hi, a9_lo, _anamatrix8_f[5], t4);=0A=
+	MUL64(a14_hi, a14_lo, _anamatrix8_f[2], t4);=0A=
+	MUL64(a18_hi, a18_lo, _anamatrix8_f[4], t4);=0A=
+	ADD64(out0_hi, out0_lo, a2_hi, a2_lo);=0A=
+	SUB64(out7_hi, out7_lo, a2_hi, a2_lo);=0A=
+	SUB64(out1_hi, out1_lo, a9_hi, a9_lo);=0A=
+	ADD64(out6_hi, out6_lo, a9_hi, a9_lo);=0A=
+	SUB64(out2_hi, out2_lo, a14_hi, a14_lo);=0A=
+	ADD64(out5_hi, out5_lo, a14_hi, a14_lo);=0A=
+	SUB64(out3_hi, out3_lo, a18_hi, a18_lo);=0A=
+	ADD64(out4_hi, out4_lo, a18_hi, a18_lo);=0A=
+=0A=
+	MUL64(a3_hi, a3_lo, _anamatrix8_f[6], t5);=0A=
+	ADD64(out0_hi, out0_lo, a3_hi, a3_lo);=0A=
+	ADD64(out7_hi, out7_lo, a3_hi, a3_lo);=0A=
+	ADD64(out3_hi, out3_lo, a3_hi, a3_lo);=0A=
+	ADD64(out4_hi, out4_lo, a3_hi, a3_lo);=0A=
+	SUB64(out1_hi, out1_lo, a3_hi, a3_lo);=0A=
+	SUB64(out2_hi, out2_lo, a3_hi, a3_lo);=0A=
+	SUB64(out5_hi, out5_lo, a3_hi, a3_lo);=0A=
+	SUB64(out6_hi, out6_lo, a3_hi, a3_lo);=0A=
+=0A=
+	MUL64(a4_hi, a4_lo, _anamatrix8_f[4], t6);=0A=
+	MUL64(a10_hi, a10_lo, _anamatrix8_f[2], t6);=0A=
+	MUL64(a15_hi, a15_lo, _anamatrix8_f[5], t6);=0A=
+	MUL64(a19_hi, a19_lo, _anamatrix8_f[3], t6);=0A=
+	ADD64(out0_hi, out0_lo, a4_hi, a4_lo);=0A=
+	SUB64(out7_hi, out7_lo, a4_hi, a4_lo);=0A=
+	SUB64(out1_hi, out1_lo, a10_hi, a10_lo);=0A=
+	ADD64(out6_hi, out6_lo, a10_hi, a10_lo);=0A=
+	ADD64(out2_hi, out2_lo, a15_hi, a15_lo);=0A=
+	SUB64(out5_hi, out5_lo, a15_hi, a15_lo);=0A=
+	ADD64(out3_hi, out3_lo, a19_hi, a19_lo);=0A=
+	SUB64(out4_hi, out4_lo, a19_hi, a19_lo);=0A=
+=0A=
+	MUL64(a5_hi, a5_lo, _anamatrix8_f[1], t7);=0A=
+	MUL64(a11_hi, a11_lo, _anamatrix8_f[0], t7);=0A=
+	ADD64(out0_hi, out0_lo, a5_hi, a5_lo);=0A=
+	ADD64(out7_hi, out7_lo, a5_hi, a5_lo);=0A=
+	SUB64(out3_hi, out3_lo, a5_hi, a5_lo);=0A=
+	SUB64(out4_hi, out4_lo, a5_hi, a5_lo);=0A=
+	SUB64(out1_hi, out1_lo, a11_hi, a11_lo);=0A=
+	SUB64(out6_hi, out6_lo, a11_hi, a11_lo);=0A=
+	ADD64(out2_hi, out2_lo, a11_hi, a11_lo);=0A=
+	ADD64(out5_hi, out5_lo, a11_hi, a11_lo);=0A=
+=0A=
+	MUL64(a6_hi, a6_lo, _anamatrix8_f[5], t8);=0A=
+	MUL64(a12_hi, a12_lo, _anamatrix8_f[4], t8);=0A=
+	MUL64(a16_hi, a16_lo, _anamatrix8_f[3], t8);=0A=
+	MUL64(a20_hi, a20_lo, _anamatrix8_f[2], t8);=0A=
+	ADD64(out0_hi, out0_lo, a6_hi, a6_lo);=0A=
+	SUB64(out7_hi, out7_lo, a6_hi, a6_lo);=0A=
+	SUB64(out1_hi, out1_lo, a12_hi, a12_lo);=0A=
+	ADD64(out6_hi, out6_lo, a12_hi, a12_lo);=0A=
+	ADD64(out2_hi, out2_lo, a16_hi, a16_lo);=0A=
+	SUB64(out5_hi, out5_lo, a16_hi, a16_lo);=0A=
+	SUB64(out3_hi, out3_lo, a20_hi, a20_lo);=0A=
+	ADD64(out4_hi, out4_lo, a20_hi, a20_lo);=0A=
+=0A=
+	// restore original scale=0A=
+	out[0] =3D out0_hi >> FIXED64_STAGE2;=0A=
+	out[1] =3D out1_hi >> FIXED64_STAGE2;=0A=
+	out[2] =3D out2_hi >> FIXED64_STAGE2;=0A=
+	out[3] =3D out3_hi >> FIXED64_STAGE2;=0A=
+	out[4] =3D out4_hi >> FIXED64_STAGE2;=0A=
+	out[5] =3D out5_hi >> FIXED64_STAGE2;=0A=
+	out[6] =3D out6_hi >> FIXED64_STAGE2;=0A=
+	out[7] =3D out7_hi >> FIXED64_STAGE2;=0A=
+=0A=
+}=0A=
+#else=0A=
+static inline void _sbc_analyze_eight(int32_t in[80], double out[8])=0A=
+{=0A=
+	double t1,t2,t3,t4,t5,t6,t7,t8, in1, in2;=0A=
+	double =
a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20=
;=0A=
+=0A=
+	out[0] =3D out[1] =3D out[2] =3D out[3] =3D out[4] =3D out[5] =3D =
out[6] =3D out[7] =3D 0;=0A=
+=0A=
+	in1 =3D in[16] - in[64]; in2 =3D in[32] - in[48];=0A=
+	t1 =3D _sbc_proto_8[0]*in1 + _sbc_proto_8[1]*in2 +\=0A=
+	     _sbc_proto_8[2]*in[4] + _sbc_proto_8[3]*in[20] +  =
_sbc_proto_8[4]*in[36] +\=0A=
+	     _sbc_proto_8[5]*in[52];=0A=
+=0A=
+	t2 =3D _sbc_proto_8[6]*in[2] + _sbc_proto_8[7]*in[18] + \=0A=
+	     _sbc_proto_8[8]*in[34] + _sbc_proto_8[9]*in[50] + =
_sbc_proto_8[10]*in[66];=0A=
+=0A=
+	t3 =3D _sbc_proto_8[11]*in[1] + _sbc_proto_8[12]*in[17] + \=0A=
+	     _sbc_proto_8[13]*in[33] + _sbc_proto_8[14]*in[49] + =
_sbc_proto_8[15]*in[65] +\=0A=
+	     _sbc_proto_8[16]*in[3] + _sbc_proto_8[17]*in[19] + =
_sbc_proto_8[18]*in[35] +\=0A=
+	     _sbc_proto_8[19]*in[51] + _sbc_proto_8[20]*in[67];=0A=
+=0A=
+	t4 =3D _sbc_proto_8[21]*in[5] + _sbc_proto_8[22]*in[21] + \=0A=
+	     _sbc_proto_8[23]*in[37] + _sbc_proto_8[24]*in[53] + =
_sbc_proto_8[25]*in[69] -\=0A=
+	     _sbc_proto_8[15]*in[15] - _sbc_proto_8[14]*in[31] - =
_sbc_proto_8[13]*in[47] -\=0A=
+	     _sbc_proto_8[12]*in[63] - _sbc_proto_8[11]*in[79];=0A=
+=0A=
+	t5 =3D _sbc_proto_8[26]*in[6] + _sbc_proto_8[27]*in[22] + \=0A=
+	     _sbc_proto_8[28]*in[38] + _sbc_proto_8[29]*in[54] + =
_sbc_proto_8[30]*in[70] -\=0A=
+	     _sbc_proto_8[10]*in[14] - _sbc_proto_8[9]*in[30] - =
_sbc_proto_8[8]*in[46] -\=0A=
+	     _sbc_proto_8[7]*in[62] - _sbc_proto_8[6]*in[78];=0A=
+=0A=
+	t6 =3D _sbc_proto_8[31]*in[7] + _sbc_proto_8[32]*in[23] + \=0A=
+	     _sbc_proto_8[33]*in[39] + _sbc_proto_8[34]*in[55] + =
_sbc_proto_8[35]*in[71] -\=0A=
+	     _sbc_proto_8[20]*in[13] - _sbc_proto_8[19]*in[29] - =
_sbc_proto_8[18]*in[45] -\=0A=
+	     _sbc_proto_8[17]*in[61] - _sbc_proto_8[16]*in[77];=0A=
+=0A=
+	in1 =3D in[8] + in[72];=0A=
+	t7 =3D _sbc_proto_8[36]*in1 + _sbc_proto_8[37]*in[24] + \=0A=
+	     _sbc_proto_8[38]*in[40] + _sbc_proto_8[37]*in[56] - =
_sbc_proto_8[39]*in[12] -\=0A=
+	     _sbc_proto_8[5]*in[28] - _sbc_proto_8[4]*in[44] - =
_sbc_proto_8[3]*in[60] -\=0A=
+	     _sbc_proto_8[2]*in[76];=0A=
+=0A=
+	t8 =3D _sbc_proto_8[35]*in[9] + _sbc_proto_8[34]*in[25] + \=0A=
+	     _sbc_proto_8[33]*in[41] + _sbc_proto_8[32]*in[57] + =
_sbc_proto_8[31]*in[73] -\=0A=
+	     _sbc_proto_8[25]*in[11] - _sbc_proto_8[24]*in[27] =
-_sbc_proto_8[23]*in[43] -\=0A=
+	     _sbc_proto_8[22]*in[59] - _sbc_proto_8[21]*in[75];=0A=
+=0A=
+	a0 =3D _anamatrix8[0]*t1;=0A=
+	a7 =3D _anamatrix8[1]*t1;=0A=
+	out[0] +=3D a0;	out[1] +=3D a7;	out[2] -=3D a7;	out[3] -=3D a0;	out[4] =
-=3D a0;	out[5] -=3D a7;	out[6] +=3D a7;	out[7] +=3D a0;=0A=
+=0A=
+	out[0] +=3D t2;	out[1] +=3D t2;	out[2] +=3D t2;	out[3] +=3D t2;	out[4] =
+=3D t2;	out[5] +=3D t2;	out[6] +=3D t2;	out[7] +=3D t2;=0A=
+=0A=
+	a1 =3D _anamatrix8[2]*t3;=0A=
+	a8 =3D _anamatrix8[3]*t3;=0A=
+	a13 =3D _anamatrix8[4]*t3;=0A=
+	a17 =3D _anamatrix8[5]*t3;=0A=
+	out[0] +=3D a1;	out[1] +=3D a8;	out[2] +=3D a13;	out[3] +=3D a17;	=
out[4] -=3D a17;	out[5] -=3D a13;	out[6] -=3D a8;	out[7] -=3D a1;=0A=
+=0A=
+	a2 =3D _anamatrix8[3]*t4;=0A=
+	a9 =3D _anamatrix8[5]*t4;=0A=
+	a14 =3D _anamatrix8[2]*t4;=0A=
+	a18 =3D _anamatrix8[4]*t4;=0A=
+	out[0] +=3D a2;	out[1] -=3D a9;	out[2] -=3D a14;	out[3] -=3D a18;	=
out[4] +=3D a18;	out[5] +=3D a14;	out[6] +=3D a9;	out[7] -=3D a2;=0A=
+=0A=
+	a4 =3D _anamatrix8[4]*t6;=0A=
+	a10 =3D _anamatrix8[2]*t6;=0A=
+	a15 =3D _anamatrix8[5]*t6;=0A=
+	a19 =3D _anamatrix8[3]*t6;=0A=
+	out[0] +=3D a4;	out[1] -=3D a10;	out[2] +=3D a15;	out[3] +=3D a19;	=
out[4] -=3D a19;	out[5] -=3D a15;	out[6] +=3D a10;	out[7] -=3D a4;=0A=
+=0A=
+	a3 =3D _anamatrix8[6]*t5;=0A=
+	out[0] +=3D a3;	out[1] -=3D a3;	out[2] -=3D a3;	out[3] +=3D a3;	out[4] =
+=3D a3;	out[5] -=3D a3;	out[6] -=3D a3;	out[7] +=3D a3;=0A=
+=0A=
+	a5 =3D _anamatrix8[1]*t7;=0A=
+	a11 =3D _anamatrix8[0]*t7;=0A=
+	out[0] +=3D a5;	out[1] -=3D a11;	out[2] +=3D a11;	out[3] -=3D a5;	=
out[4] -=3D a5;	out[5] +=3D a11;	out[6] -=3D a11;	out[7] +=3D a5;=0A=
+=0A=
+	a6 =3D _anamatrix8[5]*t8;=0A=
+	a12 =3D _anamatrix8[4]*t8;=0A=
+	a16 =3D _anamatrix8[3]*t8;=0A=
+	a20 =3D _anamatrix8[2]*t8;=0A=
+	out[0] +=3D a6;	out[1] -=3D a12;	out[2] +=3D a16;	out[3] -=3D a20;	=
out[4] +=3D a20;	out[5] -=3D a16;	out[6] +=3D a12;	out[7] -=3D a6;=0A=
+}=0A=
+#endif=0A=
 =0A=
 static inline void sbc_analyze_eight(struct sbc_encoder_state *state,=0A=
-				struct sbc_frame *frame, int ch, int blk)=0A=
+				     struct sbc_frame *frame, int ch, int blk)=0A=
 {=0A=
-	int i, k;=0A=
+	int i;=0A=
 =0A=
 	/* Input 8 Audio Samples */=0A=
 	for (i =3D 79; i >=3D 8; i--)=0A=
 		state->X[ch][i] =3D state->X[ch][i - 8];=0A=
 	for (i =3D 7; i >=3D 0; i--)=0A=
 		state->X[ch][i] =3D frame->pcm_sample[ch][blk * 8 + (7 - i)];=0A=
-=0A=
-	/* Windowing by 80 coefficients */=0A=
-	for (i =3D 0; i < 80; i++)=0A=
-		state->Z[ch][i] =3D sbc_proto_8_80[i] * state->X[ch][i];=0A=
-=0A=
-	/* Partial calculation */=0A=
-	for (i =3D 0; i < 16; i++) {=0A=
-		state->Y[ch][i] =3D 0;=0A=
-		for (k =3D 0; k < 5; k++)=0A=
-			state->Y[ch][i] +=3D state->Z[ch][i + k * 16];=0A=
-	}=0A=
-=0A=
-	/* Calculate 8 subband samples by Matrixing */=0A=
-	for (i =3D 0; i < 8; i++) {=0A=
-		state->S[ch][i] =3D 0;=0A=
-		for (k =3D 0; k < 16; k++)=0A=
-			state->S[ch][i] +=3D anamatrix8[i][k] * state->Y[ch][k];=0A=
-	}=0A=
-=0A=
-	/* Output 8 Subband Samples */=0A=
-	for (i =3D 0; i < 8; i++)=0A=
-		frame->sb_sample[blk][ch][i] =3D state->S[ch][i];=0A=
+#ifdef USE_FIXED=0A=
+	_sbc_analyze_eight(state->X[ch], frame->sb_sample_f[blk][ch]);=0A=
+#else=0A=
+	_sbc_analyze_eight(state->X[ch], frame->sb_sample[blk][ch]);=0A=
+#endif=0A=
 }=0A=
 =0A=
 static int sbc_analyze_audio(struct sbc_encoder_state *state, struct =
sbc_frame *frame)=0A=
@@ -1026,8 +1305,6 @@=0A=
 	case 8:=0A=
 		for (ch =3D 0; ch < frame->channels; ch++)=0A=
 			for (blk =3D 0; blk < frame->blocks; blk++) {=0A=
-				memset(frame->sb_sample[blk][ch], 0,=0A=
-					sizeof(frame->sb_sample[blk][ch]));=0A=
 				sbc_analyze_eight(state, frame, ch, blk);=0A=
 			}=0A=
 =0A=
@@ -1066,7 +1343,7 @@=0A=
 	int bits[2][8];		/* bits distribution */=0A=
 	int levels[2][8];	/* levels are derived from that */=0A=
 =0A=
-	double scalefactor[2][8];	/* derived from frame->scale_factor */=0A=
+	u_int32_t scalefactor[2][8];	/* derived from frame->scale_factor */=0A=
 =0A=
 	if (len < 4) {=0A=
 		return -1;=0A=
@@ -1077,16 +1354,16 @@=0A=
 =0A=
 	data[0] =3D SBC_SYNCWORD;=0A=
 =0A=
-	if (frame->sampling_frequency =3D=3D 16) {=0A=
+	if (frame->sampling_frequency =3D=3D 16000) {=0A=
 		data[1] |=3D (SBC_FS_16 & 0x03) << 6;=0A=
 		sf =3D SBC_FS_16;=0A=
-	} else if (frame->sampling_frequency =3D=3D 32) {=0A=
+	} else if (frame->sampling_frequency =3D=3D 32000) {=0A=
 		data[1] |=3D (SBC_FS_32 & 0x03) << 6;=0A=
 		sf =3D SBC_FS_32;=0A=
-	} else if (frame->sampling_frequency =3D=3D 44.1) {=0A=
+	} else if (frame->sampling_frequency =3D=3D 44100) {=0A=
 		data[1] |=3D (SBC_FS_44 & 0x03) << 6;=0A=
 		sf =3D SBC_FS_44;=0A=
-	} else if (frame->sampling_frequency =3D=3D 48) {=0A=
+	} else if (frame->sampling_frequency =3D=3D 48000) {=0A=
 		data[1] |=3D (SBC_FS_48 & 0x03) << 6;=0A=
 		sf =3D SBC_FS_48;=0A=
 	} else {=0A=
@@ -1149,7 +1426,11 @@=0A=
 			frame->scale_factor[ch][sb] =3D 0;=0A=
 			scalefactor[ch][sb] =3D 2;=0A=
 			for (blk =3D 0; blk < frame->blocks; blk++) {=0A=
+#ifdef USE_FIXED=0A=
+				while (scalefactor[ch][sb] < fabs(frame->sb_sample_f[blk][ch][sb])) =
{=0A=
+#else=0A=
 				while (scalefactor[ch][sb] < fabs(frame->sb_sample[blk][ch][sb])) {=0A=
+#endif=0A=
 					frame->scale_factor[ch][sb]++;=0A=
 					scalefactor[ch][sb] *=3D 2;=0A=
 				}=0A=
@@ -1252,9 +1533,15 @@=0A=
 		for (ch =3D 0; ch < frame->channels; ch++) {=0A=
 			for (sb =3D 0; sb < frame->subbands; sb++) {=0A=
 				if (levels[ch][sb] > 0) {=0A=
+#ifdef USE_FIXED=0A=
+					frame->audio_sample[blk][ch][sb] =3D=0A=
+						(u_int16_t) ((((frame->sb_sample_f[blk][ch][sb]*levels[ch][sb]) =
>> (frame->scale_factor[ch][sb] + 1)) +=0A=
+						levels[ch][sb]) >> 1);=0A=
+#else=0A=
 					frame->audio_sample[blk][ch][sb] =3D=0A=
-					    (u_int16_t) (((frame->sb_sample[blk][ch][sb] / =
scalefactor[ch][sb] +=0A=
-							   1.0) * levels[ch][sb]) / 2.0);=0A=
+						(u_int16_t) (((frame->sb_sample[blk][ch][sb] / =
scalefactor[ch][sb] +=0A=
+						1.0) * levels[ch][sb]) / 2.0);=0A=
+#endif=0A=
 				} else {=0A=
 					frame->audio_sample[blk][ch][sb] =3D 0;=0A=
 				}=0A=
@@ -1339,7 +1626,7 @@=0A=
 		sbc_decoder_init(&priv->dec_state, &priv->frame);=0A=
 		priv->init =3D 1;=0A=
 =0A=
-		sbc->rate =3D priv->frame.sampling_frequency * 1000;=0A=
+		sbc->rate =3D priv->frame.sampling_frequency;=0A=
 		sbc->channels =3D priv->frame.channels;=0A=
 		sbc->subbands =3D priv->frame.subbands;=0A=
 		sbc->blocks =3D priv->frame.blocks;=0A=
@@ -1367,11 +1654,11 @@=0A=
 =0A=
 	for (i =3D 0; i < samples; i++) {=0A=
 		for (ch =3D 0; ch < priv->frame.channels; ch++) {=0A=
-			uint16_t s;=0A=
+			int16_t s;=0A=
 #ifdef USE_FIXED=0A=
 			s =3D (uint16_t)fixedtoi(priv->frame.pcm_sample_f[ch][i]);=0A=
 #else=0A=
-			s =3D (uint16_t)(priv->frame.pcm_sample[ch][i]);=0A=
+			s =3D priv->frame.pcm_sample[ch][i];=0A=
 #endif=0A=
 			*ptr++ =3D (s & 0xff00) >> 8;=0A=
 			*ptr++ =3D (s & 0x00ff);=0A=
@@ -1397,7 +1684,7 @@=0A=
 	priv =3D sbc->priv;=0A=
 =0A=
 	if (!priv->init) {=0A=
-		priv->frame.sampling_frequency =3D ((double) sbc->rate) / 1000;=0A=
+		priv->frame.sampling_frequency =3D sbc->rate;=0A=
 		=0A=
 		priv->frame.channels =3D sbc->channels;=0A=
 =0A=
@@ -1420,7 +1707,7 @@=0A=
 		for (ch =3D 0; ch < sbc->channels; ch++) {=0A=
 			int16_t s =3D (ptr[0] & 0xff) << 8 | (ptr[1] & 0xff);=0A=
 			ptr +=3D 2;=0A=
-			priv->frame.pcm_sample[ch][i] =3D ((double) s);=0A=
+			priv->frame.pcm_sample[ch][i] =3D s;=0A=
 		}=0A=
 	}=0A=
 =0A=
Index: sbc/sbc.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc.h,v=0A=
retrieving revision 1.20=0A=
diff -u -r1.20 sbc.h=0A=
--- sbc/sbc.h	4 Jul 2005 03:56:51 -0000	1.20=0A=
+++ sbc/sbc.h	21 Aug 2005 18:26:32 -0000=0A=
@@ -97,6 +97,44 @@=0A=
 =0A=
 //overflow problems?=0A=
 //static inline sbc_fixed_t fxdiv(sbc_fixed_t a, sbc_fixed_t b) { =
return (a<<FRAC)/b; }=0A=
+=0A=
+#define ADD64(dhi, dlo, shi, slo)  { dlo +=3D slo; dhi +=3D shi; if ( =
(unsigned long)dlo < (unsigned long)slo ) dhi++;}=0A=
+#define SUB64(dhi, dlo, shi, slo)  { dlo -=3D slo; dhi -=3D shi; if ( =
(unsigned long)dlo > (unsigned long)slo ) dhi--;}=0A=
+=0A=
+#ifdef USE_FIXED_ARM=0A=
+// arm specific (should be fast on arm)=0A=
+=0A=
+#define MUL64(hi, lo, x, y) \=0A=
+    asm ("smull	%0, %1, %2, %3"  \=0A=
+	 : "=3D&r" (lo), "=3D&r" (hi)  \=0A=
+	 : "%r" (x), "r" (y))=0A=
+=0A=
+#define MULA64(hi, lo, x, y)  \=0A=
+    asm ("smlal	%0, %1, %2, %3"  \=0A=
+	 : "+r" (lo), "+r" (hi)  \=0A=
+	 : "%r" (x), "r" (y))=0A=
+=0A=
+#define SCALE64(hi, lo, bits) \=0A=
+    ({ int32_t __result;  \=0A=
+    asm ("movs	%0, %1, lsr %3\n\t"  \=0A=
+	 "adc	%0, %0, %2, lsl %4"  \=0A=
+	 : "=3D&r" (__result)  \=0A=
+	 : "r" (lo), "r" (hi), \=0A=
+	 "M" (bits), "M" (32 - bits)  \=0A=
+	 : "cc");  \=0A=
+    __result;  \=0A=
+    })=0A=
+=0A=
+#else=0A=
+//general purpose (slow?)=0A=
+=0A=
+#define MUL64(hi, lo, a, b) {long long x; x =3D (long long)a * b; hi =
=3D (long)(x >> 32); lo =3D (long)x;}=0A=
+#define MULA64(hi, lo, a, b)  {long long x; x =3D (long long)a * b; hi =
+=3D (long)(x >> 32); lo +=3D (long)x; if ((unsigned long)lo < (unsigned =
long)x) hi++;}=0A=
+#define SCALE64(hi, lo, bits) ((int32_t)((hi << (32 - bits)) | ((lo >> =
bits) & (0xFFFFFFFF >> bits))))=0A=
+=0A=
+#endif=0A=
+=0A=
+=0A=
 #endif=0A=
 =0A=
 int sbc_init(sbc_t *sbc, unsigned long flags);=0A=
Index: sbc/sbc_tables.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc_tables.h,v=0A=
retrieving revision 1.2=0A=
diff -u -r1.2 sbc_tables.h=0A=
--- sbc/sbc_tables.h	24 Nov 2004 06:45:21 -0000	1.2=0A=
+++ sbc/sbc_tables.h	21 Aug 2005 18:26:32 -0000=0A=
@@ -175,4 +175,19 @@=0A=
 	  -0.382683432365091,  0.555570233019606, -0.707106781186548,  =
0.831469612302547 }=0A=
 };=0A=
 =0A=
+static const float _anamatrix8[8] =3D {=0A=
+	0.923879532511287, 0.382683432365091, 0.980785280403231, =
0.831469612302547, 0.555570233019602,=0A=
+	0.195090322016128, 0.707106781186547, 1=0A=
+};=0A=
+=0A=
+static const float _sbc_proto_8[40] =3D {=0A=
+	5.65949455E-03, 6.79989457E-02, 8.23919487E-04, 1.46525260E-02, =
1.23264551E-01,-1.46404076E-02,=0A=
+	3.43256426E-04, 1.04584442E-02, 9.75753888E-02, -3.90751399E-02, =
-1.64973096E-03, 1.56575392E-04,=0A=
+	8.02941155E-03, 8.29847604E-02, -5.31873032E-02, -3.49717448E-03, =
5.54620230E-04, 1.27472337E-02,=0A=
+	1.11196689E-01, -2.61098761E-02, -1.78805363E-04, 1.13992509E-03, =
1.59045607E-02, 1.33264422E-01,=0A=
+	-4.91578039E-03, 1.61656283E-03, 1.47640170E-03, 1.62208471E-02, =
1.40753508E-01, 2.92408443E-03,=0A=
+	1.99454557E-03, 1.78371731E-03, 1.53184105E-02, 1.45389840E-01, =
8.85757525E-03, 2.10371986E-03,=0A=
+	2.01182533E-03, 1.29371807E-02, 1.46955073E-01, 9.02154483E-04=0A=
+};=0A=
+=0A=
 #endif /* __SBC_TABLES_H */=0A=
Index: sbc/sbc_tables_f.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbc_tables_f.h,v=0A=
retrieving revision 1.6=0A=
diff -u -r1.6 sbc_tables_f.h=0A=
--- sbc/sbc_tables_f.h	4 Jul 2005 03:56:51 -0000	1.6=0A=
+++ sbc/sbc_tables_f.h	21 Aug 2005 18:26:32 -0000=0A=
@@ -1,77 +1,72 @@=0A=
 static const sbc_fixed_t sbc_proto_4_40_f[40] =3D {=0A=
-0x00000000, 0x00000232, 0x0000061c, 0x00000b32, 0x00000fb7, 0x00000ff1, =
0x000007a4, 0xfffff378, =0A=
-0x00002cb3, 0x000053b7, 0x00007646, 0x000083dd, 0x000069fd, 0x0000191e, =
0xffff89f3, 0xfffec1f6, =0A=
-0x00022b63, 0x00031eab, 0x0003f239, 0x0004825e, 0x0004b584, 0x0004825e, =
0x0003f239, 0x00031eab, =0A=
-0xfffdd49d, 0xfffec1f6, 0xffff89f3, 0x0000191e, 0x000069fd, 0x000083dd, =
0x00007646, 0x000053b7, =0A=
-0xffffd34d, 0xfffff378, 0x000007a4, 0x00000ff1, 0x00000fb7, 0x00000b32, =
0x0000061c, 0x00000232=0A=
+0x00000000, 0x0002329d, 0x00061c5a, 0x000b3280, 0x000fb799, 0x000ff11d, =
0x0007a473, 0xfff3773a, =0A=
+0x002cb3e9, 0x0053b755, 0x00764668, 0x0083ddc8, 0x0069fdc6, 0x00191e58, =
0xff89f23a, 0xfec1f5e6, =0A=
+0x022b63dc, 0x031eab94, 0x03f23948, 0x04825e48, 0x04b58400, 0x04825e48, =
0x03f23948, 0x031eab94, =0A=
+0xfdd49c24, 0xfec1f5e6, 0xff89f23a, 0x00191e58, 0x0069fdc6, 0x0083ddc8, =
0x00764668, 0x0053b755, =0A=
+0xffd34c17, 0xfff3773a, 0x0007a473, 0x000ff11d, 0x000fb799, 0x000b3280, =
0x00061c5a, 0x0002329d=0A=
 };=0A=
 =0A=
 static const sbc_fixed_t sbc_proto_8_80_f[80] =3D {=0A=
-0x00000000, 0x000000a4, 0x00000167, 0x00000245, 0x0000035f, 0x000004ab, =
0x0000060c, 0x0000074e, =0A=
-0x0000083d, 0x0000089d, 0x0000082b, 0x0000069f, 0x000003b1, 0xffffff45, =
0xfffff93f, 0xfffff1ad, =0A=
-0x0000172e, 0x000020e3, 0x00002ad6, 0x00003436, 0x00003c04, 0x00004125, =
0x00004270, 0x00003ebe, =0A=
-0x000034fd, 0x00002447, 0x00000bfa, 0xffffebde, 0xffffc409, 0xffff950e, =
0xffff5ff3, 0xffff2626, =0A=
-0x00011686, 0x000153e7, 0x00018fab, 0x0001c776, 0x0001f8e4, 0x000221d9, =
0x00024086, 0x00025384, =0A=
-0x000259ed, 0x00025384, 0x00024086, 0x000221d9, 0x0001f8e4, 0x0001c776, =
0x00018fab, 0x000153e7, =0A=
-0xfffee97a, 0xffff2626, 0xffff5ff3, 0xffff950e, 0xffffc409, 0xffffebde, =
0x00000bfa, 0x00002447, =0A=
-0x000034fd, 0x00003ebe, 0x00004270, 0x00004125, 0x00003c04, 0x00003436, =
0x00002ad6, 0x000020e3, =0A=
-0xffffe8d2, 0xfffff1ad, 0xfffff93f, 0xffffff45, 0x000003b1, 0x0000069f, =
0x0000082b, 0x0000089d, =0A=
-0x0000083d, 0x0000074e, 0x0000060c, 0x000004ab, 0x0000035f, 0x00000245, =
0x00000167, 0x000000a4=0A=
+0x00000000, 0x0000a42e, 0x000167ee, 0x00024590, 0x00035ff1, 0x0004ab4c, =
0x00060c1f, 0x00074e5d, =0A=
+0x00083d8d, 0x00089de9, 0x00082b6f, 0x00069f17, 0x0003b1fa, 0xffff4482, =
0xfff93e22, 0xfff1acf2, =0A=
+0x00172e69, 0x0020e373, 0x002ad679, 0x00343672, 0x003c044a, 0x00412524, =
0x004270cb, 0x003ebe85, =0A=
+0x0034fd9e, 0x002447d7, 0x000bfa20, 0xffebdd6e, 0xffc4086b, 0xff950dcf, =
0xff5ff2bf, 0xff262512, =0A=
+0x01168610, 0x0153e7d4, 0x018fab36, 0x01c7762e, 0x01f8e440, 0x0221d9e0, =
0x024086c0, 0x0253844c, =0A=
+0x0259ed90, 0x0253844c, 0x024086c0, 0x0221d9e0, 0x01f8e440, 0x01c7762e, =
0x018fab36, 0x0153e7d4, =0A=
+0xfee979f0, 0xff262512, 0xff5ff2bf, 0xff950dcf, 0xffc4086b, 0xffebdd6e, =
0x000bfa20, 0x002447d7, =0A=
+0x0034fd9e, 0x003ebe85, 0x004270cb, 0x00412524, 0x003c044a, 0x00343672, =
0x002ad679, 0x0020e373, =0A=
+0xffe8d197, 0xfff1acf2, 0xfff93e22, 0xffff4482, 0x0003b1fa, 0x00069f17, =
0x00082b6f, 0x00089de9, =0A=
+0x00083d8d, 0x00074e5d, 0x00060c1f, 0x0004ab4c, 0x00035ff1, 0x00024590, =
0x000167ee, 0x0000a42e=0A=
 };=0A=
 =0A=
 static const sbc_fixed_t synmatrix4_f[8][4] =3D {=0A=
-{ 0x000b504f, 0xfff4afb1, 0xfff4afb1, 0x000b504f },=0A=
-{ 0x00061f78, 0xfff137cb, 0x000ec835, 0xfff9e088 },=0A=
+{ 0x0b504f30, 0xf4afb0d0, 0xf4afb0d0, 0x0b504f30 },=0A=
+{ 0x061f78a8, 0xf137ca20, 0x0ec835e0, 0xf9e08758 },=0A=
 { 0x00000000, 0x00000000, 0x00000000, 0x00000000 },=0A=
-{ 0xfff9e088, 0x000ec835, 0xfff137cb, 0x00061f78 },=0A=
-{ 0xfff4afb1, 0x000b504f, 0x000b504f, 0xfff4afb1 },=0A=
-{ 0xfff137cb, 0xfff9e088, 0x00061f78, 0x000ec835 },=0A=
-{ 0xfff00000, 0xfff00000, 0xfff00000, 0xfff00000 },=0A=
-{ 0xfff137cb, 0xfff9e088, 0x00061f78, 0x000ec835 }=0A=
+{ 0xf9e08758, 0x0ec835e0, 0xf137ca20, 0x061f78a8 },=0A=
+{ 0xf4afb0d0, 0x0b504f30, 0x0b504f30, 0xf4afb0d0 },=0A=
+{ 0xf137ca20, 0xf9e08758, 0x061f78a8, 0x0ec835e0 },=0A=
+{ 0xf0000000, 0xf0000000, 0xf0000000, 0xf0000000 },=0A=
+{ 0xf137ca20, 0xf9e08758, 0x061f78a8, 0x0ec835e0 }=0A=
 };=0A=
 =0A=
 static const sbc_fixed_t synmatrix8_f[16][8] =3D {=0A=
-{ 0x000b504f, 0xfff4afb1, 0xfff4afb1, 0x000b504f, 0x000b504f, =
0xfff4afb1, 0xfff4afb1, 0x000b504f },=0A=
-{ 0x0008e39d, 0xfff04eb5, 0x00031f17, 0x000d4db3, 0xfff2b24d, =
0xfffce0e9, 0x000fb14b, 0xfff71c63 },=0A=
-{ 0x00061f78, 0xfff137cb, 0x000ec835, 0xfff9e088, 0xfff9e088, =
0x000ec835, 0xfff137cb, 0x00061f78 },=0A=
-{ 0x00031f17, 0xfff71c63, 0x000d4db3, 0xfff04eb5, 0x000fb14b, =
0xfff2b24d, 0x0008e39d, 0xfffce0e9 },=0A=
+{ 0x0b504f30, 0xf4afb0d0, 0xf4afb0d0, 0x0b504f30, 0x0b504f30, =
0xf4afb0d0, 0xf4afb0d0, 0x0b504f30 },=0A=
+{ 0x08e39da0, 0xf04eb420, 0x031f1708, 0x0d4db310, 0xf2b24cf0, =
0xfce0e8f8, 0x0fb14be0, 0xf71c6260 },=0A=
+{ 0x061f78a8, 0xf137ca20, 0x0ec835e0, 0xf9e08758, 0xf9e08758, =
0x0ec835e0, 0xf137ca20, 0x061f78a8 },=0A=
+{ 0x031f1708, 0xf71c6260, 0x0d4db310, 0xf04eb420, 0x0fb14be0, =
0xf2b24cf0, 0x08e39da0, 0xfce0e8f8 },=0A=
 { 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, =
0x00000000, 0x00000000, 0x00000000 },=0A=
-{ 0xfffce0e9, 0x0008e39d, 0xfff2b24d, 0x000fb14b, 0xfff04eb5, =
0x000d4db3, 0xfff71c63, 0x00031f17 },=0A=
-{ 0xfff9e088, 0x000ec835, 0xfff137cb, 0x00061f78, 0x00061f78, =
0xfff137cb, 0x000ec835, 0xfff9e088 },=0A=
-{ 0xfff71c63, 0x000fb14b, 0xfffce0e9, 0xfff2b24d, 0x000d4db3, =
0x00031f17, 0xfff04eb5, 0x0008e39d },=0A=
-{ 0xfff4afb1, 0x000b504f, 0x000b504f, 0xfff4afb1, 0xfff4afb1, =
0x000b504f, 0x000b504f, 0xfff4afb1 },=0A=
-{ 0xfff2b24d, 0x00031f17, 0x000fb14b, 0x0008e39d, 0xfff71c63, =
0xfff04eb5, 0xfffce0e9, 0x000d4db3 },=0A=
-{ 0xfff137cb, 0xfff9e088, 0x00061f78, 0x000ec835, 0x000ec835, =
0x00061f78, 0xfff9e088, 0xfff137cb },=0A=
-{ 0xfff04eb5, 0xfff2b24d, 0xfff71c63, 0xfffce0e9, 0x00031f17, =
0x0008e39d, 0x000d4db3, 0x000fb14b },=0A=
-{ 0xfff00000, 0xfff00000, 0xfff00000, 0xfff00000, 0xfff00000, =
0xfff00000, 0xfff00000, 0xfff00000 },=0A=
-{ 0xfff04eb5, 0xfff2b24d, 0xfff71c63, 0xfffce0e9, 0x00031f17, =
0x0008e39d, 0x000d4db3, 0x000fb14b },=0A=
-{ 0xfff137cb, 0xfff9e088, 0x00061f78, 0x000ec835, 0x000ec835, =
0x00061f78, 0xfff9e088, 0xfff137cb },=0A=
-{ 0xfff2b24d, 0x00031f17, 0x000fb14b, 0x0008e39d, 0xfff71c63, =
0xfff04eb5, 0xfffce0e9, 0x000d4db3 }=0A=
+{ 0xfce0e8f8, 0x08e39da0, 0xf2b24cf0, 0x0fb14be0, 0xf04eb420, =
0x0d4db310, 0xf71c6260, 0x031f1708 },=0A=
+{ 0xf9e08758, 0x0ec835e0, 0xf137ca20, 0x061f78a8, 0x061f78a8, =
0xf137ca20, 0x0ec835e0, 0xf9e08758 },=0A=
+{ 0xf71c6260, 0x0fb14be0, 0xfce0e8f8, 0xf2b24cf0, 0x0d4db310, =
0x031f1708, 0xf04eb420, 0x08e39da0 },=0A=
+{ 0xf4afb0d0, 0x0b504f30, 0x0b504f30, 0xf4afb0d0, 0xf4afb0d0, =
0x0b504f30, 0x0b504f30, 0xf4afb0d0 },=0A=
+{ 0xf2b24cf0, 0x031f1708, 0x0fb14be0, 0x08e39da0, 0xf71c6260, =
0xf04eb420, 0xfce0e8f8, 0x0d4db310 },=0A=
+{ 0xf137ca20, 0xf9e08758, 0x061f78a8, 0x0ec835e0, 0x0ec835e0, =
0x061f78a8, 0xf9e08758, 0xf137ca20 },=0A=
+{ 0xf04eb420, 0xf2b24cf0, 0xf71c6260, 0xfce0e8f8, 0x031f1708, =
0x08e39da0, 0x0d4db310, 0x0fb14be0 },=0A=
+{ 0xf0000000, 0xf0000000, 0xf0000000, 0xf0000000, 0xf0000000, =
0xf0000000, 0xf0000000, 0xf0000000 },=0A=
+{ 0xf04eb420, 0xf2b24cf0, 0xf71c6260, 0xfce0e8f8, 0x031f1708, =
0x08e39da0, 0x0d4db310, 0x0fb14be0 },=0A=
+{ 0xf137ca20, 0xf9e08758, 0x061f78a8, 0x0ec835e0, 0x0ec835e0, =
0x061f78a8, 0xf9e08758, 0xf137ca20 },=0A=
+{ 0xf2b24cf0, 0x031f1708, 0x0fb14be0, 0x08e39da0, 0xf71c6260, =
0xf04eb420, 0xfce0e8f8, 0x0d4db310 }=0A=
 };=0A=
 =0A=
 static const sbc_fixed_t anamatrix4_f[4][8] =3D {=0A=
-{ 0x000b504f, 0x000ec835, 0x00100000, 0x000ec835, 0x000b504f, =
0x00061f78, 0x00000000, 0xfff9e088 },=0A=
-{ 0xfff4afb1, 0x00061f78, 0x00100000, 0x00061f78, 0xfff4afb1, =
0xfff137cb, 0x00000000, 0x000ec835 },=0A=
-{ 0xfff4afb1, 0xfff9e088, 0x00100000, 0xfff9e088, 0xfff4afb1, =
0x000ec835, 0x00000000, 0xfff137cb },=0A=
-{ 0x000b504f, 0xfff137cb, 0x00100000, 0xfff137cb, 0x000b504f, =
0xfff9e088, 0x00000000, 0x00061f78 }=0A=
-};=0A=
-=0A=
-static const sbc_fixed_t anamatrix8_f[8][16] =3D {=0A=
-{ 0x000ec835, 0x000fb14b, 0x00100000, 0x000fb14b, 0x000ec835, =
0x000d4db3, 0x000b504f, 0x0008e39d, =0A=
-0x00061f78, 0x00031f17, 0x00000000, 0xfffce0e9, 0xfff9e088, 0xfff71c63, =
0xfff4afb1, 0xfff2b24d },=0A=
-{ 0x00061f78, 0x000d4db3, 0x00100000, 0x000d4db3, 0x00061f78, =
0xfffce0e9, 0xfff4afb1, 0xfff04eb5, =0A=
-0xfff137cb, 0xfff71c63, 0x00000000, 0x0008e39d, 0x000ec835, 0x000fb14b, =
0x000b504f, 0x00031f17 },=0A=
-{ 0xfff9e088, 0x0008e39d, 0x00100000, 0x0008e39d, 0xfff9e088, =
0xfff04eb5, 0xfff4afb1, 0x00031f17, =0A=
-0x000ec835, 0x000d4db3, 0x00000000, 0xfff2b24d, 0xfff137cb, 0xfffce0e9, =
0x000b504f, 0x000fb14b },=0A=
-{ 0xfff137cb, 0x00031f17, 0x00100000, 0x00031f17, 0xfff137cb, =
0xfff71c63, 0x000b504f, 0x000d4db3, =0A=
-0xfff9e088, 0xfff04eb5, 0x00000000, 0x000fb14b, 0x00061f78, 0xfff2b24d, =
0xfff4afb1, 0x0008e39d },=0A=
-{ 0xfff137cb, 0xfffce0e9, 0x00100000, 0xfffce0e9, 0xfff137cb, =
0x0008e39d, 0x000b504f, 0xfff2b24d, =0A=
-0xfff9e088, 0x000fb14b, 0x00000000, 0xfff04eb5, 0x00061f78, 0x000d4db3, =
0xfff4afb1, 0xfff71c63 },=0A=
-{ 0xfff9e088, 0xfff71c63, 0x00100000, 0xfff71c63, 0xfff9e088, =
0x000fb14b, 0xfff4afb1, 0xfffce0e9, =0A=
-0x000ec835, 0xfff2b24d, 0x00000000, 0x000d4db3, 0xfff137cb, 0x00031f17, =
0x000b504f, 0xfff04eb5 },=0A=
-{ 0x00061f78, 0xfff2b24d, 0x00100000, 0xfff2b24d, 0x00061f78, =
0x00031f17, 0xfff4afb1, 0x000fb14b, =0A=
-0xfff137cb, 0x0008e39d, 0x00000000, 0xfff71c63, 0x000ec835, 0xfff04eb5, =
0x000b504f, 0xfffce0e9 },=0A=
-{ 0x000ec835, 0xfff04eb5, 0x00100000, 0xfff04eb5, 0x000ec835, =
0xfff2b24d, 0x000b504f, 0xfff71c63, =0A=
-0x00061f78, 0xfffce0e9, 0x00000000, 0x00031f17, 0xfff9e088, 0x0008e39d, =
0xfff4afb1, 0x000d4db3 }=0A=
+{ 0x0b504f30, 0x0ec835e0, 0x10000000, 0x0ec835e0, 0x0b504f30, =
0x061f78a8, 0x00000000, 0xf9e08758 },=0A=
+{ 0xf4afb0d0, 0x061f78a8, 0x10000000, 0x061f78a8, 0xf4afb0d0, =
0xf137ca20, 0x00000000, 0x0ec835e0 },=0A=
+{ 0xf4afb0d0, 0xf9e08758, 0x10000000, 0xf9e08758, 0xf4afb0d0, =
0x0ec835e0, 0x00000000, 0xf137ca20 },=0A=
+{ 0x0b504f30, 0xf137ca20, 0x10000000, 0xf137ca20, 0x0b504f30, =
0xf9e08758, 0x00000000, 0x061f78a8 }=0A=
+};=0A=
+=0A=
+#define FIXED64_STAGE1 24=0A=
+static const int32_t _sbc_proto_8_f[40] =3D {=0A=
+0x02e5cd20, 0x22d0c200, 0x006bfe27, 0x07808930, 0x3f1c8800, 0xf8810d70, =
0x002cfdc6, 0x055acf28, =0A=
+0x31f566c0, 0xebfe57e0, 0xff27c437, 0x001485cc, 0x041c6e58, 0x2a7cfa80, =
0xe4c4a240, 0xfe359e4c, =0A=
+0x0048b1f8, 0x0686ce30, 0x38eec5c0, 0xf2a1b9f0, 0xffe8904a, 0x0095698a, =
0x0824a480, 0x443b3c00, =0A=
+0xfd7badc8, 0x00d3e2d9, 0x00c183d2, 0x084e1950, 0x4810d800, 0x017f43fe, =
0x01056dd8, 0x00e9cb9f, =0A=
+0x07d7d090, 0x4a708980, 0x0488fae8, 0x0113bd20, 0x0107b1a8, 0x069fb3c0, =
0x4b3db200, 0x00763f48=0A=
+};=0A=
+=0A=
+#define FIXED64_STAGE2 7=0A=
+static const int32_t _anamatrix8_f[8] =3D {=0A=
+0x3b20d780, 0x187de2a0, 0x3ec52f80, 0x3536cc40, 0x238e7680, 0x0c7c5c20, =
0x2d413cc0, 0x40000000=0A=
 };=0A=
 =0A=
Index: sbc/sbcdec.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvsroot/bluetooth-alsa/btsco/sbc/sbcdec.c,v=0A=
retrieving revision 1.5=0A=
diff -u -r1.5 sbcdec.c=0A=
--- sbc/sbcdec.c	1 May 2005 16:36:44 -0000	1.5=0A=
+++ sbc/sbcdec.c	21 Aug 2005 18:26:32 -0000=0A=
@@ -40,7 +40,7 @@=0A=
=20
 #define BUF_SIZE 2048
=20
-static void decode(char *filename, char *audiodevice)
+static void decode(char *filename, char *audiodevice, int tofile)
 {
 	unsigned char buf[BUF_SIZE], *stream;
 	struct stat st;
@@ -82,7 +82,7 @@=0A=
 	pos =3D 0;
 	streamlen =3D st.st_size;
=20
-	ad =3D open(audiodevice, O_WRONLY, 0);
+	ad =3D open(audiodevice, O_WRONLY | (tofile ? (O_CREAT | O_TRUNC) : =
0), tofile ? 0644 : 0);
 	if (ad < 0) {
 		fprintf(stderr, "Can't open audio device %s: %s\n",
 						audiodevice, strerror(errno));
@@ -93,25 +93,25 @@=0A=
=20
 	framelen =3D sbc_decode(&sbc, stream, streamlen);
 	printf("%d Hz, %d channels\n", sbc.rate, sbc.channels);
+	if (!tofile) {
+		if (ioctl(ad, SNDCTL_DSP_SETFMT, &format) < 0) {
+			fprintf(stderr, "Can't set audio format on %s: %s\n",
+							audiodevice, strerror(errno));
+			goto close;
+		}
=20
-	if (ioctl(ad, SNDCTL_DSP_SETFMT, &format) < 0) {
-		fprintf(stderr, "Can't set audio format on %s: %s\n",
-						audiodevice, strerror(errno));
-		goto close;
-	}
-
-	if (ioctl(ad, SNDCTL_DSP_CHANNELS, &sbc.channels) < 0) {
-		fprintf(stderr, "Can't set number of channels on %s: %s\n",
-						audiodevice, strerror(errno));
-		goto close;
-	}
+		if (ioctl(ad, SNDCTL_DSP_CHANNELS, &sbc.channels) < 0) {
+			fprintf(stderr, "Can't set number of channels on %s: %s\n",
+							audiodevice, strerror(errno));
+			goto close;
+		}
=20
-	if (ioctl(ad, SNDCTL_DSP_SPEED, &sbc.rate) < 0) {
-		fprintf(stderr, "Can't set audio rate on %s: %s\n",
-						audiodevice, strerror(errno));
-		goto close;
+		if (ioctl(ad, SNDCTL_DSP_SPEED, &sbc.rate) < 0) {
+			fprintf(stderr, "Can't set audio rate on %s: %s\n",
+							audiodevice, strerror(errno));
+			goto close;
+		}
 	}
-
 	count =3D 0;
=20
 	while (framelen > 0) {
@@ -152,6 +152,7 @@=0A=
 		"\t-h, --help           Display help\n"
 		"\t-d, --device <dsp>   Sound device\n"
 		"\t-v, --verbose        Verbose mode\n"
+		"\t-f, --file           Decode to a file\n"
 		"\n");
 }
=20
@@ -159,15 +160,17 @@=0A=
 	{ "help",	0, 0, 'h' },
 	{ "device",	1, 0, 'd' },
 	{ "verbose",	0, 0, 'v' },
+	{ "file",	1, 0, 'f' },
 	{ 0, 0, 0, 0 }
 };
=20
 int main(int argc, char *argv[])
 {
 	char *device =3D NULL;
-	int i, opt, verbose =3D 0;
+	char *file =3D NULL;
+	int i, opt, verbose =3D 0, tofile =3D 0;
=20
-	while ((opt =3D getopt_long(argc, argv, "+hd:v", main_options, NULL)) =
!=3D -1) {
+	while ((opt =3D getopt_long(argc, argv, "+hd:vf:", main_options, =
NULL)) !=3D -1) {
 		switch(opt) {
 		case 'h':
 			usage();
@@ -180,6 +183,10 @@=0A=
 		case 'v':
 			verbose =3D 1;
 			break;
+		case 'f' :
+			file =3D strdup(optarg);
+			tofile =3D 1;
+			break;
=20
 		default:
 			exit(1);
@@ -196,7 +203,7 @@=0A=
 	}
=20
 	for (i =3D 0; i < argc; i++)
-		decode(argv[i], device ? device : "/dev/dsp");
+		decode(argv[i], device ? device : file ? file : "/dev/dsp", tofile);
=20
 	if (device)
 		free(device);

------=_NextPart_000_000D_01C5A691.9290F790--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
