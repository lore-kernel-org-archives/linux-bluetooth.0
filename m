Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Colin Pinkney <bluez-devel@cpinkney.org.uk>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Suspend/resume issues with bluez
References: <200403022202.19259.mitsu@syntheticzero.com>
In-Reply-To: <200403022202.19259.mitsu@syntheticzero.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200403032224.08229.bluez-devel@cpinkney.org.uk>
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
Date: Wed, 3 Mar 2004 22:24:04 +0000

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 03 Mar 2004 03:02, Mitsu Hadeishi wrote:
> Hi, just thought I'd run this issue past you folks.  I'm running the bluez
> stack and utilities from Debian unstable on kernel 2.4.22-x1 (Xandros
> Desktop 2)=20
=2E..
> The problem is bluez never seems to work again after a suspend/resume.  I
> have tried shutting down the Bluetooth card (you can do with with Fn-F5 on
> a Thinkpad) before suspending, as well as doing hciconfig hci0 down, and
> even rmmod rfcomm, rmmod hci_usb (rmmod l2cap never seems to work) before
> suspending, and then modprobe them back afterwards. =20

We get that on the Sharp Zaurus Linux PDA with any Bluetooth CF card. After=
 a=20
suspend/resume of the PDA, all operations on the Bluetooth card just timeou=
t.

> Rebooting the system causes bluez to work again.

Since the Zaurus does not have builtin Bluetooth, every Zaurus must use=20
Bluetooth CF cards so we're able to eject the card and reinsert it. Nothing=
=20
else brings it back (apart from a reboot of course), not even things like=20
'cardctl reset'. But at least the ejecting and reinserting can be automated=
=20
which I put into a script that is run on every resume. I guess you don't ha=
ve=20
this option though if the Bluetooth device is built into your laptop.

BTW the Affix Bluetooth drivers have no problem with suspending and resumin=
g.=20
Is your Bluetooth device supported by Affix?

=2D --=20
Colin Pinkney
http://www.cpinkney.org.uk
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFARlsIioDqRlN9/eURAqT7AKDPD9uUEcDw4TezKbAf3h+EgSMwlgCfTOXK
ttu8XI/LaXZKvCFlANA0Wmc=3D
=3DnKSA
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
