Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruben Jenster <ruben@hotheads.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <200411270038.51554.ruben@hotheads.de>
Content-Type: multipart/signed;
  boundary="nextPart1978108.X6KSLvMk4V";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Subject: [Bluez-devel] snd-bt-sco - unknown symbol snd_hwdep_new undefined!
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
Date: Sat, 27 Nov 2004 00:38:45 +0100

--nextPart1978108.X6KSLvMk4V
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,=20
I have problems compiling the snd-bt-sco module aginst
gentoo-dev-sources-2.6.9-r6.
Does anyone knows what's the reason for this warning?
=2D Is it due to a change in the kernel or in the btsco sources?


>> modprobe snd-bt-sco

=46ATAL: Error inserting snd_bt_sco=20
(/lib/modules/2.6.9-gentoo-r6/extra/snd-bt-sco.ko): Unknown symbol in modul=
e,=20
or unknown parameter (see dmesg)


>>dmesg:

snd_bt_sco: Unknown symbol snd_hwdep_new


>>compile process of the kernel module:

22:57 root [/home/ruben/temp/btsco/btsco/kernel] : make
make[1]: Entering directory `/usr/src/linux-2.6.9-gentoo-r6'
=A0 CC [M] =A0/home/ruben/temp/btsco/btsco/kernel/btsco.o
/home/ruben/temp/btsco/btsco/kernel/btsco.c: In Funktion=20
=BBsnd_card_bt_sco_thread=AB:
/home/ruben/temp/btsco/btsco/kernel/btsco.c:809: Warnung: ISO C90 forbids=20
mixed declarations and code
=A0 LD [M] =A0/home/ruben/temp/btsco/btsco/kernel/snd-bt-sco.o
=A0 Building modules, stage 2.
=A0 MODPOST
*** Warning:=20
"snd_hwdep_new" [/home/ruben/temp/btsco/btsco/kernel/snd-bt-sco.ko]=20
undefined!
=A0 CC =A0 =A0 =A0/home/ruben/temp/btsco/btsco/kernel/snd-bt-sco.mod.o
=A0 LD [M] =A0/home/ruben/temp/btsco/btsco/kernel/snd-bt-sco.ko
make[1]: Leaving directory `/usr/src/linux-2.6.9-gentoo-r6'


Ruben

--nextPart1978108.X6KSLvMk4V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBp76L0gsecz4c07sRAkDqAJ9BM8X6DH2WPzSiRLGRyjj1n3LN8gCdGkcb
8OJRpMPZ266Sa1ySDRp+UXw=
=cd+b
-----END PGP SIGNATURE-----

--nextPart1978108.X6KSLvMk4V--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
