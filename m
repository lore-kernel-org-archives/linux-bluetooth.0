Return-Path: <cyrus@holtmann.org>
Content-Type: multipart/signed; boundary="Apple-Mail=_AF95197C-57F2-426E-8C65-399A1B46AE75"; protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Getting started with BLE device
From: Rick Mann <rmann@latencyzero.com>
In-Reply-To: <1399057367.24457.11.camel@SejoLaptop>
Date: Mon, 5 May 2014 12:18:07 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9E061E41-3F1F-4929-A9A7-A9B64618CF75@latencyzero.com>
References: <35E2DFE7-B463-4A15-8148-F7E30A201646@latencyzero.com> <1399057367.24457.11.camel@SejoLaptop>
To: Sejo Ruiz <sejoruiz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_AF95197C-57F2-426E-8C65-399A1B46AE75
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Thanks, Sejo.

Looks like it's not seen:

# hciconfig
#

But bluetoothd *is* running:

# ps axww | grep blue
  243 ?        Ss     0:00 /usr/sbin/bluetoothd


The device is not a USB device. It's an LSR TiWi-BLE module connected =
directly to the processor via UART (or SPI bus, not sure which).

On May 2, 2014, at 12:02 , Sejo Ruiz <sejoruiz@gmail.com> wrote:

> Hi Rick.
> First of all, you should make sure that the device is recognized as a =
BT
> device. Run hciconfig as sudo user to see if it returns something as
> hci0. If you can see it, then you can do hciconfig hci0 up to set up =
the
> interface and start playing. If not, then you could try to do lsusb =
and
> see what devices are connected to the USB. If you cannot see your =
device
> there, or something goes wrong, you can always try to check what is
> going on by plugging the device off and on again and then type dmesg |
> tail. Finally, make sure the bluetooth daemon is running. You can do
> that by executing /etc/init.d/bluetoothd status (I'm not sure about =
this
> last one)
> NOTE: I suggest to execute all the commands with sudo.
>=20


--=20
Rick




--Apple-Mail=_AF95197C-57F2-426E-8C65-399A1B46AE75
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlNn4+8ACgkQBzBA/9aDmJsv5ACfVdxDZQtV72CiipCRLXinh9kq
dp4AoKwkwBR1rAjiYMqXTSZRRv2sVpF6
=LRJR
-----END PGP SIGNATURE-----

--Apple-Mail=_AF95197C-57F2-426E-8C65-399A1B46AE75--
