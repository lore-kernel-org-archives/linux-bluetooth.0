Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: <linux-bluetooth@vger.kernel.org>
Subject: Fix for not decoding a too small SBC frame
Date: Mon, 22 Dec 2008 17:16:21 +0100
Message-ID: <011b01c96450$a0b927e0$e22b77a0$@de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_011C_01C96459.027D8FE0"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dies ist eine mehrteilige Nachricht im MIME-Format.

------=_NextPart_000_011C_01C96459.027D8FE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

is it for any good that SBC tries to decode a frame even if it is too =
small
or missing?
Attached you find a patch.

Greetings

 Christian


--------------------------------------------------------
Dr.-Ing. Christian Hoene
Computer Networks and Internet, University of T=FCbingen
Sand 13, 72076 T=FCbingen, Germany, Phone +49 7071 2970532
http://net.informatik.uni-tuebingen.de/~hoene



------=_NextPart_000_011C_01C96459.027D8FE0
Content-Type: application/octet-stream;
	name="do_not_decode_frame_that_is_too_small.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="do_not_decode_frame_that_is_too_small.patch"

diff --git a/sbc/sbc.c b/sbc/sbc.c=0A=
index 5411893..263d46a 100644=0A=
--- a/sbc/sbc.c=0A=
+++ b/sbc/sbc.c=0A=
@@ -1196,6 +1196,9 @@ int sbc_decode(sbc_t *sbc, void *input, int =
input_len, void *output,=0A=
 	if (written)=0A=
 		*written =3D 0;=0A=
 =0A=
+	if (framelen<=3D0)=0A=
+		return framelen;=0A=
+=0A=
 	samples =3D sbc_synthesize_audio(&priv->dec_state, &priv->frame);=0A=
 =0A=
 	ptr =3D output;=0A=

------=_NextPart_000_011C_01C96459.027D8FE0--

