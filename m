Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 26 Jul 2006 11:49:06 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060726094906.GB6549@esaurito.net>
References: <20060725165124.GB14679@esaurito.net>
	<1153848241.31069.31.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1153848241.31069.31.camel@localhost>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Felix Homann <fexpop@onlinehome.de>,
        bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] bluez udev rules for pcmcia devices
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0285237458=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0285237458==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2006 at 07:24:01PM +0200, Marcel Holtmann wrote:
> the first thing is that every line for dtl1_cs, bt3c_cs, bluecard_cs,
> bt950_cs and btuart_cs must be removed. These are not TTY drivers and
> totally useless lines anyway.
>=20
> Second is that I prefer to call the script "bluetooth_hciattach" or
> better maybe "bluetooth_serial", because this is what it is doing. It is
> not a generic udev helper for Bluetooth. The job is to attach the serial
> port to the hci_uart driver. We can also strip the "/lib/udev/" prefix
> and the ".sh" suffix.
>=20
> Calling /etc/init.d/bluetooth from the script must go away. Either the
> support for Bluetooth is enabled or not. The udev helper shouldn't care
> about it at all.
>=20
> Also the line "DEVICE=3D`echo $DEVNAME|sed -e 's_/dev/__'`" in the script
> is not needed at all, because hciattach can handle full device names
> without any problems. And in case of some crazy persistent naming rules
> it is the safer choice.

agreed, I've fixed this in
http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/bluetooth=
_serial?op=3Dfile&rev=3D0&sc=3D0
and
http://svn.debian.org/wsvn/pkg-bluetooth/bluez-utils/trunk/debian/bluez-pcm=
cia-support.udev?op=3Dfile&rev=3D0&sc=3D0

>=20
> >From a programming perspective, the TYPEID should be moved into
> start_serial, because it is its only user.

I'm failing to understand this :(

>=20
> If this script isn't distributed via bluez-utils, then the script must
> check if hciattach is installed. Otherwise you will see errors and this
> might not be what users expect.

fixed as well

>=20
> And we should actually only call hciattach instances using the specified
> device. Don't kill something that you didn't start.

agreed but since the script is (supposed to be) invoked only by udev on
add/remove pcmcia bt cards, I think we can assume the script is the only us=
er of
$DEVNAME.

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

Computer Science is no more about computers than astronomy is about telesco=
pes.
-- Edsger Dijkstra

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD4DBQFExzqSABzeamt51AERAkEcAJdwefFCBmdghV3jm5n8mut4x6J9AKDOmWaP
dC9q67tB2kSH53sVrxNGzQ==
=EBHr
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--


--===============0285237458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0285237458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0285237458==--
