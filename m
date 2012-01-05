Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jan 2012 17:57:34 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: Thomas Perl <th.perl@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Device-initiated HID connections: How to pair? (PS Move)
Message-Id: <20120105175734.84f51f316f4069b9c4d5375d@studenti.unina.it>
In-Reply-To: <CA+uOhx5kPJd8efy+AOsMURN61buitD5v==n7Xfanr9RuNUywxw@mail.gmail.com>
References: <CA+uOhx5kPJd8efy+AOsMURN61buitD5v==n7Xfanr9RuNUywxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__5_Jan_2012_17_57_35_+0100_PT7PyUMtoL+EJojd"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Thu__5_Jan_2012_17_57_35_+0100_PT7PyUMtoL+EJojd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Jan 2012 14:07:25 +0100
Thomas Perl <th.perl@gmail.com> wrote:

> Hi,
>=20
> I'm working on getting the PS Move Controller to work with Linux[1].
> Right now, I'm disabling bluetoothd's "input" plugin and listen to the
> two l2cap sockets directly, which is ugly and prevents using "normal"
> Bluetooth HID devices together with a PS Move controller. Ideally, I
> want bluetoothd to accept the connection and use Linux' hidraw
> interface to communicate with the controller. The GUI pairing in GNOME
> 3 doesn't work, no matter what PIN mode (automatic, 0000, do not pair)
> I select. On Windows, it works after pairing it without PIN, and OS X
> apparently allows the connection without any question or pairing.
>

I worked on the Sixaxis pairing and the mechanism should be similar
read below.

> Is there any way to tell bluetoothd "here's a Bluetooth address, and
> if you get a HID connection from it, accept the connection"? I added
> an entry "XX:XX:XX:XX:XX:XX [all]" to
> /var/lib/bluetooth/YY:YY:YY:YY:YY:YY/trusts, but this entry gets
> removed at first connection (the X-address being the controller's
> address and the Y-address being my host adapter's address) and I'm
> pretty sure that I'm not supposed to hand-edit files in
> /var/lib/bluetooth/ ;) When pressing the PS button on the controller
> (which tries to establish a Bluetooth connection with the host), I
> get:
>=20
> bluetoothd[5487]: Refusing input device connect: No such file or director=
y (2)
>

Just setting the "trust" file is not enough TTBOMK, you have to set also
a "did" (device ID? ) file with the SDP record relative to the device.

> The pairing works about the same way as with the Sixaxis controller
> (use USB HID feature reports to "upload" the Bluetooth host address to
> the controller, and then the controller will connect to this address
> as HID device).
>

Are the Feature reports the same as the Sixaxis? (0xF2 to read the
device bdaddr and 0xF5 to read and write the master bdaddr?).

> I'd be also be grateful for any hints on where to start writing a
> patch if device-initiated HID connections are not supported - I dug
> around a bit in bluetoothd's input module code, but got stuck.
>=20

Check out these patches for the BlueZ playstation-peripheral plugin:

http://ao2.it/tmp/__tmp_bluez_playstation-peripheral_plugin.patch

(apply with "git am" on top of 474c85f), in particular the
btd_device_set_trusted() bits (use a clean /var/lib/bluetooth for a
sane run).

The plugin supports only the sixaxis for now, but it is written
with other devices in mind. Tell me if you want me to add you to the CC
list when I submit them again for inclusion in BlueZ.

Regards,
   Antonio

P.S. Thomas you can contact me on IRC or via XMPP/Gtalk as well, look at
http://ao2.it/en/contact

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__5_Jan_2012_17_57_35_+0100_PT7PyUMtoL+EJojd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8F1n8ACgkQ5xr2akVTsAEYgACfeN7TV+BtTnQez6a+tIuNGsrI
3VQAmQGbxgow6vAECdlYswJdixzk+6JD
=0mhw
-----END PGP SIGNATURE-----

--Signature=_Thu__5_Jan_2012_17_57_35_+0100_PT7PyUMtoL+EJojd--
