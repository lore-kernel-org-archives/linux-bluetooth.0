Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: amateur <ztl.post@gmail.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061214092546.GA6244@163.com>
References: <1166076796.3984.9.camel@localhost> <20061214092546.GA6244@163.com>
Date: Thu, 14 Dec 2006 21:05:09 -0500
Message-Id: <1166148309.3279.6.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Immediate disconnect after doing "hcitool cc"
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0394598605=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0394598605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-86OTrJdwceODZ9ufsVNX"


--=-86OTrJdwceODZ9ufsVNX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-12-14 at 17:25 +0800, amateur wrote:
> On Thu, Dec 14, 2006 at 01:13:16AM -0500, Jon Barnett wrote:
> > hcidump -X -V results for a hcitool cc command:
> > > HCI Event: Max Slots Change (0x1b) plen 3
> >     handle 12 slots 5
> > > HCI Event: Remote Name Req Complete (0x07) plen 255
> >     status 0x00 bdaddr 00:12:EE:E0:AB:CA name 'HBH-610a'
> > < HCI Command: Disconnect (0x01|0x0006) plen 3
> >     handle 12 reason 0x13
> >     Reason: Remote User Terminated Connection
> > > HCI Event: Command Status (0x0f) plen 4
> >     Disconnect (0x01|0x0006) status 0x00 ncmd 1
> > > HCI Event: Disconn Complete (0x05) plen 4
> >     status 0x00 handle 12 reason 0x16
> >     Reason: Connection Terminated by Local Host
> >=20
> How long does it takes for your computer to send the disconnect
> request? Maybe it is that bluez will automatically disconnect a
> connection after some idle time.
>=20

No. The disconnect happens at most maybe a couple of seconds after the
cc command has completed. I've tried:
hcitool cc 00:12:EE:E0:AB:CA; hcitool auth 00:12:EE:E0:AB:CA

And it disconnects before I can even enter the pin at the
gnome-bluetooth prompt.

As I said, it doesn't happen if I use the Kensington USB dongle. So
there is something different about the BCM2045 USB device.

--=-86OTrJdwceODZ9ufsVNX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFggLVu2cEic/xsEARApQRAJ9IBzzi6GrO54V4VmgBWA6/N4NMjQCeIuFa
cBKm7hQGRJJM/AEdHjWGPAM=
=NEbn
-----END PGP SIGNATURE-----

--=-86OTrJdwceODZ9ufsVNX--



--===============0394598605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0394598605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0394598605==--
