Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20060303011433.c498e85e.henryk@ploetzli.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__3_Mar_2006_01_14_33_+0100_4riyvunZ6hOGAbBO"
Subject: [Bluez-devel] SCO stuck on a Netgear WGT634U (mips)
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
Date: Fri, 3 Mar 2006 01:14:33 +0100

--Signature=_Fri__3_Mar_2006_01_14_33_+0100_4riyvunZ6hOGAbBO
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin,

I'm currently trying to get btsco working on a my Netgear WGT634U
running OpenWgt (with a lot of custom packages) on kernel 2.6.12-rc3
and current btsco cvs. I can't seem to get it working: Each program
that wants to play audio simply stalls (when using aplay it stops in a
poll(), when using oss the write blocks).

The syslog says:
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 16002 count: 4000=20
snd-bt-sco: playback_trigger 1=20
snd-bt-sco: setting playback to bspcm

hcidump says:
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  0000: 2a 00 e0 00                                       *...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 01                                          *..
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2d 00 ed 03 30 f4 08  00 00 00                 .-...0.....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 03                                          *..

When looking through kernel/btsco.c this caught my attention:
 /* This will block until we receive data or a signal */
 len =3D sock_recvmsg(sock, &msg, BUF_SIZE,0);

I added a dprintk("foo\n"); and a dprintk("bar\n"); after that line and
get foo, bar, foo in the logs, so yes, it is blocking at this line.

At this point I'm stuck. Any hints as to in what direction I should
investigate further would be highly appreciated.

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~

--Signature=_Fri__3_Mar_2006_01_14_33_+0100_4riyvunZ6hOGAbBO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEB4pvvI90l8kWns8RAmGJAJ4yjLmrqY3pomomct1BLXk9WRd04ACfdsxp
efe1PNFHtnN9VW8Q2foVofY=
=ocI6
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Mar_2006_01_14_33_+0100_4riyvunZ6hOGAbBO--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
