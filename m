Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sebastian Henschel <linux@kodeaffe.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050307153436.GB13771@fuchi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Subject: [Bluez-users] Billionton CF card (bt950)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 7 Mar 2005 16:34:36 +0100


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

howdy folks...

i have a CF card from Billionton here with the P/N CFBT02-B2.
cardctl ident reveals:
    product info: "Compact Flash", "Bluetooth Card", "", ""
    manfid: 0x0279, 0x950b
    function: 2 (serial)

/etc/pcmcia/bluetooth.conf reads:
    card "Billionton Bluetooth Card"
        version "Compact Flash", "Bluetooth Card"
        bind "serial_cs"

having read in the archives, bt950_cs and btuart_cs should not be used
nowadays, but serial_cs with the combination of hciattach. you
should forget about the other two, right?

first, i tried to get it going in an Apple Powerbook (Alu, 2nd gen)
with kernel 2.6.11. but as others with similar cards (i believe the card
=66rom Socket mentioned here
http://sourceforge.net/mailarchive/forum.php?thread_id=3D6735172&forum_id=
=3D1883
to be more or less the same), it does not work. it is believed to have
something to do with the serial support in 2.6 kernels.

then, i tried with the machine the card shall actually work with:
Zaurus SL-5500 with OpenZaurus 3.5.2, kernel 2.4.18-rmk7-pxa3-embedix.
unfortunately, the situation isn't any better. so far, serial_cs
recognizes the device:
    ttyS03 at port 0xc48602f8 (irq=3D35) is a 16C950/954

but using hciattach with type "csr" always fails with
    Initialization timed out.

trying with type "ericsson" and all kinds of speeds, it fails when
issueing "hciconfig hci0 up" with the message
    Can't init device hci0. Connection timet out(110)
and the kernel log is filled to message
nearly identical to these seen on the Powerbook with kernel 2.6:
    h4_recv: Unknown HCI packet type 00
    h4_recv: Unknown HCI packet type 00
    h4_recv: Unknown HCI packet type 80
    h4_recv: Unknown HCI packet type f8
    h4_recv: Unknown HCI packet type 00
    h4_recv: Unknown HCI packet type 78

the other types have not been tried on the Zaurus, but on the Powerbook.
bt950_cs and btuart_cs have also been tried on the Zaurus, with different,
but somewhat similar error messages (replace h4_recv by btuart_cs for
instance).

so, it does not seem to be a problem of 2.6 only. 2.4 does not work,
too. well, i fear this will be nothing more than a "metoo". at least,
others are warned about this specific card. :)

thanks,
 Sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCLHSMreHfL3pi+bQRAu7rAJ476vdc5aW1y5AkzXFX+Uvu6rQSpgCbBgZB
WWydafBlQyQHAWhXEztSsec=
=JX4e
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
