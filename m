Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Audio & Bluetooth
From: Martin List-Petersen <martin@list-petersen.net>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1099956503.29330.35.camel@pegasus>
References: <418FC205.7070102@tootai.net>
	 <1099943857.29330.27.camel@pegasus>  <1099954588.6339.144.camel@loke>
	 <1099956503.29330.35.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CaAEfpjc+hu+2qx1RluZ"
Message-Id: <1099965952.27159.7.camel@loke>
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
Date: Tue, 09 Nov 2004 02:05:52 +0000


--=-CaAEfpjc+hu+2qx1RluZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-08 at 23:28, Marcel Holtmann wrote:
> Hi Martin,
>=20
> > > > I have a question: for my mobile I use an HAMA Bluetooth headset. I=
f I=20
> > > > buy a bluetooth PCMCIA card for my notebook, will I be able to use =
this=20
> > > > headset with this card? recognized as a second soundcard? as a norm=
al=20
> > > > headset for my integrate soundcard? recognized by my software phone=
=20
> > > > clients? If I buy an USB bluetooth device, would it be the same? be=
tter?
> > >=20
> > > actually this is not an easy to answer question. First thing is that =
you
> > > should get a Bluetooth device with a CSR chip and at least HCI 16.x
> > > firmware on it. The second is that it must route the SCO traffic thro=
ugh
> > > the HCI and via a PCM. Then it should be possible.
> >=20
> > How to identify version 16.x or higher ? hciconfig -a only gives a
> > hexadecimal value, that not really gives me get a clue on the firmware
> > version.
> >=20
> > HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc
>=20
> you are kidding me? Use "hciconfig hci0 revision" or look at my webpage
> where most of the build ids are decoded.

Must be blind. Anyhow, i guess this doesn't sound good for sound:

# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:60:57:02:7F:E1 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 12.7
        Chip version: BlueCore01b
        SCO mapping:  PCM

I have problems with no audio on this dongle. So i take it, that it
might be the oldish firmware.

Kind regards,
Martin List-Petersen


--=-CaAEfpjc+hu+2qx1RluZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBkCYAp8B84hoWbO4RAn/7AJ0W5CYAVHDT4P59js1NYTsd5NHQcACdE7kw
+d1uqn4FWVishWMFHL/wxe8=
=Hdgw
-----END PGP SIGNATURE-----

--=-CaAEfpjc+hu+2qx1RluZ--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
