Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Audio & Bluetooth
From: Martin List-Petersen <martin@list-petersen.net>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1100222815.12168.54.camel@pegasus>
References: <418FC205.7070102@tootai.net>
	 <1099943857.29330.27.camel@pegasus>
	 <1100206677.4193d255a3140@support.tuxbox.dk>
	 <1100208476.12168.31.camel@pegasus>  <1100221786.28744.36.camel@loke>
	 <1100222815.12168.54.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FxbsnNnq0W651O23OCIm"
Message-Id: <1100223616.28734.56.camel@loke>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 12 Nov 2004 01:40:16 +0000


--=-FxbsnNnq0W651O23OCIm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-11-12 at 01:26, Marcel Holtmann wrote:

> > How can the mapping be changed, if I may ask. I've been looking around
> > and the only material that i found of it, is actually that you stated a=
t
> > some point, that they have to match, but not how it can be changed.
>=20
> It must be set to SCO over HCI to get it working. Most dongles sold now
> uses this setting by default. Some older don't. So this is a CSR chip
> and all settings are in the persistant storage (PS). So you only have to
> set the PS key for this one to HCI instead of PCM.
>=20
> Said this there is a Windows program called pstool that can do this for
> you, but it is not freely available. This is CSR specific and if you dig
> deep enough into the source code of BlueZ and also the OpenBT project,
> you can get the knowledge on how to change it. I don't provide a tool
> for it and I also won't answer any further questions about this.

Windows isn't an option, but this should be clarifying enough. Thanks
for the effort.

/Martin

--=-FxbsnNnq0W651O23OCIm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBlBR/p8B84hoWbO4RAvfXAJoC0ks4Sb4ljtcVYirFQghUMiZRPQCaAsMJ
DI52V0ycF2vqv5Qy18io5CU=
=6S2l
-----END PGP SIGNATURE-----

--=-FxbsnNnq0W651O23OCIm--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
