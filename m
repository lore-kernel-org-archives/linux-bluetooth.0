Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Colin Pinkney <bluez-devel@cpinkney.org.uk>
To: bluez-users@lists.sourceforge.net
References: <200403022202.19259.mitsu@syntheticzero.com> <200403091754.52270.mitsu@syntheticzero.com> <1078877075.30990.2.camel@pegasus>
In-Reply-To: <1078877075.30990.2.camel@pegasus>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200403101825.28236.bluez-devel@cpinkney.org.uk>
Subject: [Bluez-users] Re: [Bluez-devel] Suspend/resume issues with bluez
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Mar 2004 18:25:24 +0000

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 10 Mar 2004 00:04, Marcel Holtmann wrote:
> Hi Mitsu,
>
> > Just a note to the list regarding suspend/resume.  I have a Thinkpad T4=
0p
> > which was having problems with bluez and suspend/resume.  I just tried
> > installing the Affix drivers on my Thinkpad T40p; but I had the same
> > problem (well, it was slightly different, but the upshot was, Bluetooth
> > didn't work when I came back from suspend).
>
> I think the problem is in the USB subsystem at the moment. There are
> some outstanding issues with some USB cards, but Alan Stern is going to
> fix them. This will only happen for 2.6.x and I don't think that these
> issues can be solved in 2.4, too.

This also happens with CF cards on the Sharp Zaurus. The only way I have fo=
und=20
to get Bluetooth cards to come back after a suspend is to do:

cardctl eject
cardctl insert

I think the Bluetooth kernel modules are 'busy' after a suspend so you cann=
ot=20
remove them and insmod them again.

The Affix drivers survive suspend/resume fine on the Zaurus, but I much pre=
fer=20
the BlueZ drivers.

=2D --=20
Colin Pinkney
http://www.cpinkney.org.uk
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAT12YioDqRlN9/eURAk2EAJ9XrmIdyTEwxEYPpGM+KOyq1+r1qgCfUVlL
kdfRBgh5ZVP//GjGXcADaCQ=3D
=3DxaYQ
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
