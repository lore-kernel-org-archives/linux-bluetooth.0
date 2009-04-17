Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] sbc: added saturated clipping of decoder output to 16-bit
Date: Fri, 17 Apr 2009 19:26:07 +0300
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_f2K6JgxMVTMVD6I"
Message-Id: <200904171926.07378.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_f2K6JgxMVTMVD6I
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

This is a bugfix for SBC decoder.

-- 
Best regards,
Siarhei Siamashka

--Boundary-00=_f2K6JgxMVTMVD6I
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0001-sbc-added-saturated-clipping-of-decoder-output-to-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0001-sbc-added-saturated-clipping-of-decoder-output-to-1.patch"

=46rom 3f9180b9b32c17b6f6594ac7e7b03fa0d665c7f8 Mon Sep 17 00:00:00 2001
=46rom: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Fri, 17 Apr 2009 18:27:38 +0300
Subject: [PATCH] sbc: added saturated clipping of decoder output to 16-bit

This prevents overflows and audible artefacts for the audio files which
originally had loudness maximized. Music from audio CD disks is an
example of such files, see http://en.wikipedia.org/wiki/Loudness_war
=2D--
 sbc/sbc.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index a6b6563..14e5869 100644
=2D-- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -534,6 +534,16 @@ static void sbc_decoder_init(struct sbc_decoder_state =
*state,
 			state->offset[ch][i] =3D (10 * i + 10);
 }
=20
+static SBC_ALWAYS_INLINE int16_t sbc_clip16(int32_t s)
+{
+	if (s > 0x7FFF)
+		return 0x7FFF;
+	else if (s < -0x8000)
+		return -0x8000;
+	else
+		return s;
+}
+
 static inline void sbc_synthesize_four(struct sbc_decoder_state *state,
 				struct sbc_frame *frame, int ch, int blk)
 {
@@ -562,7 +572,7 @@ static inline void sbc_synthesize_four(struct sbc_decod=
er_state *state,
 		k =3D (i + 4) & 0xf;
=20
 		/* Store in output, Q0 */
=2D		frame->pcm_sample[ch][blk * 4 + i] =3D SCALE4_STAGED1(
+		frame->pcm_sample[ch][blk * 4 + i] =3D sbc_clip16(SCALE4_STAGED1(
 			MULA(v[offset[i] + 0], sbc_proto_4_40m0[idx + 0],
 			MULA(v[offset[k] + 1], sbc_proto_4_40m1[idx + 0],
 			MULA(v[offset[i] + 2], sbc_proto_4_40m0[idx + 1],
@@ -572,7 +582,7 @@ static inline void sbc_synthesize_four(struct sbc_decod=
er_state *state,
 			MULA(v[offset[i] + 6], sbc_proto_4_40m0[idx + 3],
 			MULA(v[offset[k] + 7], sbc_proto_4_40m1[idx + 3],
 			MULA(v[offset[i] + 8], sbc_proto_4_40m0[idx + 4],
=2D			MUL( v[offset[k] + 9], sbc_proto_4_40m1[idx + 4])))))))))));
+			MUL( v[offset[k] + 9], sbc_proto_4_40m1[idx + 4]))))))))))));
 	}
 }
=20
@@ -607,8 +617,8 @@ static inline void sbc_synthesize_eight(struct sbc_deco=
der_state *state,
 	for (idx =3D 0, i =3D 0; i < 8; i++, idx +=3D 5) {
 		k =3D (i + 8) & 0xf;
=20
=2D		/* Store in output */
=2D		frame->pcm_sample[ch][blk * 8 + i] =3D SCALE8_STAGED1( // Q0
+		/* Store in output, Q0 */
+		frame->pcm_sample[ch][blk * 8 + i] =3D sbc_clip16(SCALE8_STAGED1(
 			MULA(state->V[ch][offset[i] + 0], sbc_proto_8_80m0[idx + 0],
 			MULA(state->V[ch][offset[k] + 1], sbc_proto_8_80m1[idx + 0],
 			MULA(state->V[ch][offset[i] + 2], sbc_proto_8_80m0[idx + 1],
@@ -618,7 +628,7 @@ static inline void sbc_synthesize_eight(struct sbc_deco=
der_state *state,
 			MULA(state->V[ch][offset[i] + 6], sbc_proto_8_80m0[idx + 3],
 			MULA(state->V[ch][offset[k] + 7], sbc_proto_8_80m1[idx + 3],
 			MULA(state->V[ch][offset[i] + 8], sbc_proto_8_80m0[idx + 4],
=2D			MUL( state->V[ch][offset[k] + 9], sbc_proto_8_80m1[idx + 4]))))))))))=
);
+			MUL( state->V[ch][offset[k] + 9], sbc_proto_8_80m1[idx + 4]))))))))))));
 	}
 }
=20
=2D-=20
1.5.6.5


--Boundary-00=_f2K6JgxMVTMVD6I--
