Return-Path: <grantma@anathoth.gen.nz>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Matthew Grant <grantma@anathoth.gen.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1098676528.6465.68.camel@pegasus>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RmMxkN/dzFSHBN3a8xs/"
Message-Id: <1099721547.5132.70.camel@localhost>
Mime-Version: 1.0
Date: Sat, 06 Nov 2004 19:12:27 +1300
List-ID: <bluez-users.lists.sourceforge.net>


--=-RmMxkN/dzFSHBN3a8xs/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcel,

Finally figured out what is wrong.  There is definitely a Powerpc
problem with the BT HIDPGETCONNLIST ioctl on the powerpc arch.

The HID ioctl HIDPGETCONNLIST is not returning any HID device entries
from the kernel on the Powerpc architecture, even when a blue-tooth
keyboard and mouse are working.

In Debian's boot scripts hidd --killall  is used to nicely close the
connections so that the devices will reconnect cleanly on next boot.=20
This is not working for me as the above ioctl is not returning a list if
addresses to be acted on.

Work around for me will be to explicitly kill each device address before
stopping hidd, as hidd --kill <device address> works.  Does this mean
that the devices are registering in the hidp module, but there is a
problem in passing the list back out of the kernel?

Do you have access to a powerpc machine to test this on?  Could you give
me any instructions on getting the hidp.ko module to produce the debug
that would be useful?

It would be good to get this one solved, as I would like to look at
shallower bugs which I can knock off myself. First look at the hidp code
with this one freaked me out a bit.

(Eg: like fixing the transfer from USB hid compatibility mode to HCI
mode for the BT Apple keyboard - it seems to get stuck in some mode that
could be fixed by sending it a BT instruction to tell it to reset or
switch modes.  The second one is fixing it so that the special Apple
only keys work 100% as expected.  Sounds like a simple job of altering
the keymap if an Apple BT keyboard is detected.)

Thanks v. much for all your work and for your help!

Cheers,

Matthew Grant

On Mon, 2004-10-25 at 16:55, Marcel Holtmann wrote:
> Hi Matthew,
>=20
> > Running 2.6.8 mh2, bluz-utils 2.10 on Debian Sarge.  Marcel, please
> > excuse me for mailing you directly as wellas the list, as I want to sen=
d
> > you a binary hcidump output so you can get maximum debug info.
>=20
> don't care about that. If you exceed the mailing list limited I will
> accept the post manually and let it through.
>=20
> > I am having problems with the keyboard not reconnecting on reboot when
> > hciattach switches the internal dongle from USB HID emulation to HCI.
>=20
> It is not hciattach that is switching, it is hid2hci.
>=20
> > The Lower level layer is definitely connected, but the keyboard events
> > are not generating keyboard input at all.  I have to switch the keyboar=
d
> > off, and then switch it back on, and it renegotiates, and it all starts
> > working.
>=20
> What does "hidd --show" tell you when the keyboard is connected, but not
> working?
>=20
> > This test is not using security mode 3 yet, though I will be doing this
> > to prevent people sniffing passwords.... but the same problem happens
> > then.
>=20
> Actually I thought, that the Apple keyboard is always in security mode
> three, but from your dumps it looks like that this is not true when it
> reconnects. What does "hcitool con" say about the reconnect ACL link?
>=20
> > When I boot from OS X back into Linux, the problem does not occur.
>=20
> This is strange and actually I never had any problems with the Apple HID
> stuff, but I used it on a normal Intel machine.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out mo=
re
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Matthew Grant        /\  ^/\^   grantma@anathoth.gen.nz      /~~~~\
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\
=3D=3D=3DGPG KeyID: 2EE20270  FingerPrint: 8C2535E1A11DF3EA5EA19125BA4E790E=
2EE20270=3D=3D


--=-RmMxkN/dzFSHBN3a8xs/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBjGtKuk55Di7iAnARAoVGAKCPUefiAboU8qzNp/mT5g/c2/D/3QCgn5m9
/ATWHLwR5JzIadOw6LUTxFc=
=9Y+x
-----END PGP SIGNATURE-----

--=-RmMxkN/dzFSHBN3a8xs/--
