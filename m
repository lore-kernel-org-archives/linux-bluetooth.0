Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: StormByte <stormbyte@gmail.com>
Subject: [Patch 1/1] Fix Clang compilation of BlueZ
Message-ID: <ef6beb0a-e40d-8b3a-9ebb-0d0489f2ca00@gmail.com>
Date: Tue, 7 Aug 2018 13:34:20 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ctNOC1DBwXJ20mm1NFUvZRgwIKPgaFmX9"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ctNOC1DBwXJ20mm1NFUvZRgwIKPgaFmX9
Content-Type: multipart/mixed; boundary="lFOkNuE9g61JXOUaCEDIzpjg9fda1EKEF";
 protected-headers="v1"
From: StormByte <stormbyte@gmail.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <ef6beb0a-e40d-8b3a-9ebb-0d0489f2ca00@gmail.com>
Subject: [Patch 1/1] Fix Clang compilation of BlueZ

--lFOkNuE9g61JXOUaCEDIzpjg9fda1EKEF
Content-Type: multipart/mixed;
 boundary="------------E90FF3AE70E12F5E7C50115E"
Content-Language: es-ES

This is a multi-part message in MIME format.
--------------E90FF3AE70E12F5E7C50115E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When trying to compile as much as I can in Gentoo with CLang, I realized
that Bluez is not compiling due to a function definition inside a
function, which is not allowed by clang.

I am not sure if this may be the best solution, but I've made a patch
that makes it compile without errors (not sure if it runs good yet though=
).

I hope it is useful for reviewing and applying if you consider necesary,

Thanks,


David C. Manuelda


--------------E90FF3AE70E12F5E7C50115E
Content-Type: text/x-patch;
 name="fix-clang-build.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="fix-clang-build.patch"

diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
index 1ee5cb16f..8414e900f 100644
--- a/profiles/midi/midi.c
+++ b/profiles/midi/midi.c
@@ -71,20 +71,20 @@ struct midi {
 	struct midi_write_parser midi_out;
 };
=20
+void foreach_cb(const struct midi_write_parser *parser, void *user_data)=
 {
+	struct midi *midi =3D user_data;
+	bt_gatt_client_write_without_response(midi->client,
+	                                      midi->midi_io_handle,
+	                                      false,
+	                                      midi_write_data(parser),
+	                                      midi_write_data_size(parser));
+}
+
 static bool midi_write_cb(struct io *io, void *user_data)
 {
 	struct midi *midi =3D user_data;
 	int err;
=20
-	void foreach_cb(const struct midi_write_parser *parser, void *user_data=
) {
-		struct midi *midi =3D user_data;
-		bt_gatt_client_write_without_response(midi->client,
-		                                      midi->midi_io_handle,
-		                                      false,
-		                                      midi_write_data(parser),
-		                                      midi_write_data_size(parser));
-	};
-
 	do {
 		snd_seq_event_t *event =3D NULL;
=20

--------------E90FF3AE70E12F5E7C50115E--

--lFOkNuE9g61JXOUaCEDIzpjg9fda1EKEF--

--ctNOC1DBwXJ20mm1NFUvZRgwIKPgaFmX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1fzRmFboMaAkYd+DAkiTivHmfkAFAltpg7wACgkQAkiTivHm
fkDwUQ/8CR0897ANE3IyTCwOMJ3gYEQAYkHswgK2+YBKNFa2csaa4R516zfg7wBM
gqFcPOS+oMfsVHbLGWADsGmN3E1vaVs1l2lgKdn7Arfnda136sBXZvXiRieW/Qhi
GBaBADVWhcgEvqSjLAcsPGUYXUGFSY8r2tpVrSnXF0+gzuJXtclHRMjn2SlCs90D
AKFHK2hyyXbiumhHReY9dhfg8kFPxDQVpOPLgh7o9rhy3AhyNoK1/YVFH89RIxXQ
UDPsk+KO+g7Mg5CpRRwdir5As1AU5+vbr7NDoGLPCvMTwdSokxQv+R9Q+Jwmlo2D
C+PSnTDlVKRc4ez+AvLY+lbE7cdXPsPzAmVEvWaiwcUGPeZ6c7KaCHKb5e90C7I1
zSvR+Z2ceB5d+N1AIlsAebvoF29xejHwyyOnWHvoGqpIC+EWXOr0NuT3GFamh2m+
gzMeXTdE3LuI7NrhUCd/XTWnste1ZIfDZ5Uk/2MLfX/3q6gS3SLO3hqVwMMPBNaj
Am+kjKfuNoVtxERcxszWesyqnM2tlQG1sgIMQ7FvQkW+iI+5PCjI6/8s79JKv+nR
Smet4OZpfJO0rrLFgbTXtqlwTvZoonoU8mJn/5e9qP7dIontlj5FsOLtLMOEEwGz
GxF29zhw69yDfVn/g0KMsaL9m4hDHRkvRb+axHP1eAE4+kTtG3s=
=E6XR
-----END PGP SIGNATURE-----

--ctNOC1DBwXJ20mm1NFUvZRgwIKPgaFmX9--
