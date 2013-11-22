Return-Path: <cyrus@holtmann.org>
Message-ID: <1385124462.18208.12.camel@philip-work-laptop.cbg.collabora.co.uk>
Subject: [PATCH] bluetoothctl: Fix handling of (G_IO_IN | G_IO_HUP) input
 case
From: Philip Withnall <philip.withnall@gmail.com>
Reply-To: philip@tecnocode.co.uk
To: linux-bluetooth@vger.kernel.org
Date: Fri, 22 Nov 2013 12:47:42 +0000
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-7LHSdXu5YCb5tkeNzN/g"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-7LHSdXu5YCb5tkeNzN/g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If running bluetoothctl as a subprocess from another process, and piping
input to it, it=E2=80=99s possible for the stdin pipe to be closed by the p=
arent
process while there=E2=80=99s still data pending in its buffer. This result=
s in
input handler callbacks with condition (G_IO_IN | G_IO_HUP). All of the
pending input should be handled before closing bluetoothctl.
---
 client/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/client/main.c b/client/main.c
index 0dd1510..0ec40c7 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1197,12 +1197,16 @@ done:
 static gboolean input_handler(GIOChannel *channel, GIOCondition condition,
 							gpointer user_data)
 {
+	if (condition & G_IO_IN) {
+		rl_callback_read_char();
+		return TRUE;
+	}
+
 	if (condition & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
 		g_main_loop_quit(main_loop);
 		return FALSE;
 	}
=20
-	rl_callback_read_char();
 	return TRUE;
 }
=20
--=20
1.8.3.1

--=-7LHSdXu5YCb5tkeNzN/g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iF4EABEIAAYFAlKPUm4ACgkQ8JQuiUsur6Bh9AEAlLVKqZge6GbJ1L372SGDKiGI
wQsoaOLz+I4K5NPaO9MA/j1sgUmrfQfX16RXZ0OlzyKFOokNEf3BdcrEBJh0J0Af
=Rh6U
-----END PGP SIGNATURE-----

--=-7LHSdXu5YCb5tkeNzN/g--

