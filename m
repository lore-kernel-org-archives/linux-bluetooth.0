Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO stuck on a Netgear WGT634U (mips)
Message-Id: <20060306090140.e1e882d5.henryk@ploetzli.ch>
In-Reply-To: <440BE81C.5040902@porthome.nl>
References: <20060303011433.c498e85e.henryk@ploetzli.ch>
	<4407C5CF.6060208@xmission.com>
	<20060304024114.38d9b29f.henryk@ploetzli.ch>
	<20060304084732.1ee8b518.henryk@ploetzli.ch>
	<440BE81C.5040902@porthome.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__6_Mar_2006_09_01_40_+0100_NPfZojm=eoszyojT"
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
Date: Mon, 6 Mar 2006 09:01:40 +0100

--Signature=_Mon__6_Mar_2006_09_01_40_+0100_NPfZojm=eoszyojT
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

Am Mon, 06 Mar 2006 08:43:24 +0100 schrieb Pieter Poorthuis:

> I'm using a Energic BT-001 headset (bluetooth 1.1, Motorale chipset)
> and had a terrible distortion as well. After having disabled
> automatic endianness fixup in the snd_bt_sco kernel module (line 32
> btsco.c:=20
> #undef AUTO_FIXUP_BYTESHIFT) it works flawlessly :).

Yeah, I found that part of the code suspicious too.

My current problem is that sending sound from the Netgear to the
headset works, but only some of the time (about 10% of it) and
non-reproducible too. When playing back a sound file sometimes I hear
something and most of the time I don't. Sound seems to come and go at
will. (Note: It's not a speaker problem. When there is no sound I still
hear the background static noise.)

I looked at the outgoing SCO stream with hcidump and that seems to be
fine. (E.g. I grabbed the raw data from the stream and played it back
on my Laptop's sound card and there the sound is continuously OK.)

I tried two different dongles (both work fine with the headset when
attached to my Laptop) but have yet to find a different headset to try.

The byteshift doesn't seem to have anything to do with it, despite
there being a minor correlation between sound switching on and off and
"Shift problem detected! Fixing to 1."/"Shift problem detected! Fixing
to 0." in the log (they _always_ come in pairs on the Netgear). I
experimentally changed the code to switch between byteshift on and off
every 15s and that didn't have any effect whatsoever.

(Note: Recording sound from the microphone seems to work always. But I
didn't test that very extensively.)

Next step would be for me to read more on the Headset profile to better
understand the hcidump output (and look for errors) and get a headset
emulator running on my laptop to check the SCO stream that is actually
received by the headset. When I have more time ...

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Mon__6_Mar_2006_09_01_40_+0100_NPfZojm=eoszyojT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEC+xuvI90l8kWns8RAmXjAJ9TeuaEstkzcIWKKSBSVnWtVNsUewCgpnDE
O3k2lrYF1C7eZSjz5b0Z6SI=
=aPqN
-----END PGP SIGNATURE-----

--Signature=_Mon__6_Mar_2006_09_01_40_+0100_NPfZojm=eoszyojT--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
