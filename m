Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco and Nokia HDW-3 headset not working
From: James Fitzsimons <james.fitzsimons@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4241FBEE.9060408@xmission.com>
References: <1111528750.12076.18.camel@localhost>
	 <42409B3B.1080906@xmission.com> <f68b8ee1050323043862bc4c6d@mail.gmail.com>
	 <1111619908.16128.6.camel@localhost>  <4241FBEE.9060408@xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-85As0A0C/00PAKog9d3c"
Message-Id: <1112131242.11558.9.camel@localhost>
Mime-Version: 1.0
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
Date: Tue, 29 Mar 2005 21:20:42 +0000


--=-85As0A0C/00PAKog9d3c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Brad,

On Wed, 2005-03-23 at 23:29, Brad Midgley wrote:
> > Ok, I've just rebuilt using the latest cvs version. I am still having
> > the same issue where I can connect to the headset, volume etc works, bu=
t
> > no sound (eg from XMMS).
>=20
> You're using the current kernel module too, right?
I think so. This is in cvs too right?

athos synce-librapi2-0.9.0 # modinfo snd_bt_sco
author:         Jonathan Paisley <jp@dcs.gla.ac.uk>
description:    Bluetooth SCO Headset Soundcard
license:        GPL
vermagic:       2.6.9-gentoo-r14 gcc-3.3
depends:

> I think I remember having troubles like this when my alsa configuration=20
> wasn't quite right, the alsa stuff wasn't run at bootup, or something=20
> like that. fwiw, my /etc/alsa/modutils/1.0 looks like:
...

Ok, I changed a couple of things in my /etc/modules.d/alsa file now
looks like yours (your /etc/alsa/modutils/1.0) but still no luck. It
connects, but I can't get any sound.

What do I try next?

Cheers,
James
--=20
It's 5.50 a.m.... Do you know where your stack pointer is ?

--=-85As0A0C/00PAKog9d3c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCScaqtf4qL6AoafMRAnwuAJ99Rb0evj2phN9JW69y8LBss40wngCbBS6y
Gb8A8EUSlbcSLhCv5khBV8o=
=tQOX
-----END PGP SIGNATURE-----

--=-85As0A0C/00PAKog9d3c--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
