Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO stuck on a Netgear WGT634U (mips)
Message-Id: <20060304084732.1ee8b518.henryk@ploetzli.ch>
In-Reply-To: <20060304024114.38d9b29f.henryk@ploetzli.ch>
References: <20060303011433.c498e85e.henryk@ploetzli.ch>
	<4407C5CF.6060208@xmission.com>
	<20060304024114.38d9b29f.henryk@ploetzli.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__4_Mar_2006_08_47_32_+0100_SpyC//nVJW=0Bekq"
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
Date: Sat, 4 Mar 2006 08:47:32 +0100

--Signature=_Sat__4_Mar_2006_08_47_32_+0100_SpyC//nVJW=0Bekq
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Sat, 4 Mar 2006 02:41:14 +0100 schrieb Henryk Pl=F6tz:

> I just remembered the scotest program and tried it: Sending from the
> Netgear and receiving on my Laptop works, but not the other way round.

Hmm, suddenly started working and I'm not completely sure why. I was
debugging and broke everything (apparantly enabling BT_HCI_CORE_DEBUG
lead to a deadlock) and then hastily disabled all debugging. After that
scotest receive somehow began to work on the Netgear although I didn't
do anything which could possibly have caused it to. That's funny.


Not completely solved yet, since the sound I hear in my headset is
anything from inaudible to heavily distorted, but at least the SCO
packets happily go in and out, so that should be solvable for me.

Also: recording from the headset's microphone works just fine.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Sat__4_Mar_2006_08_47_32_+0100_SpyC//nVJW=0Bekq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFECUYgvI90l8kWns8RAvfzAJ4hw3oxISlv4vdieBL8QHI3A7knwQCgmsEG
+3988u/7Bzceuy/9zwD3X58=
=Zorj
-----END PGP SIGNATURE-----

--Signature=_Sat__4_Mar_2006_08_47_32_+0100_SpyC//nVJW=0Bekq--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
