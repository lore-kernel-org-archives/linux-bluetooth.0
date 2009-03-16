Return-Path: <cyrus@holtmann.org>
From: Siarhei Siamashka <siarhei.siamashka@nokia.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] sbc: ensure 16-byte buffer position alignment for 4 subbands encoding
Date: Mon, 16 Mar 2009 21:35:02 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mnqvJTgASDnqTlj"
Message-Id: <200903162135.02064.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_mnqvJTgASDnqTlj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Buffer position in X array was not always 16-bytes aligned. Strict 16-byte 
alignment is strictly required for powerpc altivec simd optimizations because
altivec does not have support for unaligned vector loads at all.

-- 
Best regards,
Siarhei Siamashka

--Boundary-00=_mnqvJTgASDnqTlj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="0003-sbc-ensure-16-byte-buffer-position-alignment-for-4.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0003-sbc-ensure-16-byte-buffer-position-alignment-for-4.patch"

=46rom b8570469477f1a92089cd12bcf6c07247ca110d4 Mon Sep 17 00:00:00 2001
=46rom: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Date: Mon, 16 Mar 2009 02:27:26 +0200
Subject: [PATCH] sbc: ensure 16-byte buffer position alignment for 4 subban=
ds encoding

Buffer position in X array was not always 16-bytes aligned.
Strict 16-byte alignment is strictly required for powerpc altivec
simd optimizations because altivec does not have support for
unaligned vector loads at all.
=2D--
 sbc/sbc.c            |    2 +-
 sbc/sbc_primitives.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index a33ed57..f40def8 100644
=2D-- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -924,7 +924,7 @@ static void sbc_encoder_init(struct sbc_encoder_state *=
state,
 				const struct sbc_frame *frame)
 {
 	memset(&state->X, 0, sizeof(state->X));
=2D	state->position =3D SBC_X_BUFFER_SIZE - frame->subbands * 9;
+	state->position =3D (SBC_X_BUFFER_SIZE - frame->subbands * 9) & ~7;
=20
 	sbc_init_primitives(state);
 }
diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index 6b0be3f..2105280 100644
=2D-- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -231,12 +231,12 @@ static SBC_ALWAYS_INLINE int sbc_encoder_process_inpu=
t_s4_internal(
 	/* handle X buffer wraparound */
 	if (position < nsamples) {
 		if (nchannels > 0)
=2D			memcpy(&X[0][SBC_X_BUFFER_SIZE - 36], &X[0][position],
+			memcpy(&X[0][SBC_X_BUFFER_SIZE - 40], &X[0][position],
 							36 * sizeof(int16_t));
 		if (nchannels > 1)
=2D			memcpy(&X[1][SBC_X_BUFFER_SIZE - 36], &X[1][position],
+			memcpy(&X[1][SBC_X_BUFFER_SIZE - 40], &X[1][position],
 							36 * sizeof(int16_t));
=2D		position =3D SBC_X_BUFFER_SIZE - 36;
+		position =3D SBC_X_BUFFER_SIZE - 40;
 	}
=20
 	#define PCM(i) (big_endian ? \
=2D-=20
1.5.6.5


--Boundary-00=_mnqvJTgASDnqTlj--
