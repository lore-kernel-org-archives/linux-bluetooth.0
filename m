Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Colin Pinkney <bluez-devel@cpinkney.org.uk>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200402232030.22616.bluez-devel@cpinkney.org.uk>
Subject: [Bluez-devel] Ambicom BT2000C CF Card
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 23 Feb 2004 20:30:19 +0000

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

Is anyone working on a driver for the Ambicom BT2000C CF card or even got a=
=20
working card? I know the BT2000E works fine with the bt950 driver, but that=
=20
CF card used the OXCF950 uart chipset. The BT2000C uses a CSR chipset, but =
I=20
do not know any more than that. Anyone got any datasheets? Here's the=20
'cardctl ident' output:

Socket 0:
  product info: "AmbiCom BT2000C", "Bluetooth PC/CF Card", "", ""
  manfid: 0x022d, 0x2000
  function: 2 (serial)

A kind person has loaned me their BT2000C card in the hope I can get it=20
working with the Sharp Zaurus. I've tried all the uart drivers with it sinc=
e=20
there seems to be different drivers for different CSR chipsets, but with no=
=20
luck. So it looks like I might have to start hacking away at a driver. It=20
would be easier if I had a laptop with Linux (Got a WinXP laptop with a=20
CF->PCMCIA adaptor but that is my wife's toy :) - why does Knoppix only hav=
e=20
the bluez kernel modules and not the user space tools?)

Regards,

=2D --=20
Colin Pinkney
http://www.cpinkney.org.uk
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAOmLeioDqRlN9/eURAo1iAJ9OHOHkUY4v+kvTZaq8Eba6Y7tYzQCfUXYk
7R0DJYTMASMwXnIMiSdZ4Hs=3D
=3Du1Ey
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
