Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1449070602.4523.12.camel@tecnocode.co.uk>
Subject: [PATCH] gdbus: Drop message replies if the sender requested no reply
From: Philip Withnall <philip.withnall@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 02 Dec 2015 15:36:42 +0000
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-a2hvl8WDpuX4iO2urhED"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-a2hvl8WDpuX4iO2urhED
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If the sender flags a D-Bus message as not expecting a reply, it is
against system bus policy to send a reply =E2=80=94 sending one will result=
 in
errors being sent to us by dbus-daemon.

Magically drop all replies to messages which request no reply.

ofonod is one process which sends BlueZ messages which request no
reply,
when it is setting up a hands-free agent.

This is not a complete fix. In an ideal world, the existing check for
G_DBUS_METHOD_FLAG_NOREPLY would be dropped, as the server should be
prepared to return a reply to every method, if the client requests and
expects one =E2=80=94 otherwise the client will time out. However, that=E2=
=80=99s a
much
bigger change with a much bigger risk of breaking things, so I=E2=80=99ll s=
tick
with this for now.

Signed-off-by: Philip Withnall <philip.withnall@collabora.co.uk>
Reviewed-by: Simon McVittie <simon.mcvittie@collabora.co.uk>
---
=C2=A0gdbus/object.c | 3 ++-
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 4cf2e2f..945dbdb 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -258,7 +258,8 @@ static DBusHandlerResult
process_message(DBusConnection *connection,
=C2=A0
=C2=A0	reply =3D method->function(connection, message,
iface_user_data);
=C2=A0
-	if (method->flags & G_DBUS_METHOD_FLAG_NOREPLY) {
+	if (method->flags & G_DBUS_METHOD_FLAG_NOREPLY ||
+	=C2=A0=C2=A0=C2=A0=C2=A0dbus_message_get_no_reply(message)) {
=C2=A0		if (reply !=3D NULL)
=C2=A0			dbus_message_unref(reply);
=C2=A0		return DBUS_HANDLER_RESULT_HANDLED;
--=20
2.5.0
--=-a2hvl8WDpuX4iO2urhED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iF4EABEKAAYFAlZfEAoACgkQ8JQuiUsur6D6KAD+PdrJ9T9E4hJYmVWWiKl4sF+8
wpTFc/Ev4XycMwvyKCABAIEhmkk+IOSC2UtKzzTNKsWqxzk7p07gz/Uj2jYF43s8
=Pwgl
-----END PGP SIGNATURE-----

--=-a2hvl8WDpuX4iO2urhED--

