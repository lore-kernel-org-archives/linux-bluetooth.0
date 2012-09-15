Return-Path: <cyrus@holtmann.org>
Subject: bluetoothd: Refusing input device connect: Operation already in
 progress (114)
From: Pacho Ramos <pacho@gentoo.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uIvwwzyNmNtx+ZOjENBu"
Date: Sat, 15 Sep 2012 12:15:53 +0200
Message-ID: <1347704153.24322.11.camel@belkin4>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-uIvwwzyNmNtx+ZOjENBu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

Downstream we got the following report:
https://bugs.gentoo.org/show_bug.cgi?id=3D431624

After adding mouse (via Blueman's "Add device" dialog) it works fine
until sleeping or powering off. After that it fails reconnecting.
In /var/log/messages appears strings like these:

Aug 16 15:40:31 user bluetoothd[3222]: Refusing input device connect:
Operation already in progress (114)
Aug 16 15:45:13 user bluetoothd[3222]: Refusing input device connect:
Operation already in progress (114)
Aug 16 15:45:16 user bluetoothd[3222]: Refusing input device connect:
Operation already in progress (114)
Aug 16 15:45:17 user bluetoothd[3222]: Refusing input device connect:
Operation already in progress (114)
Aug 16 15:45:19 user bluetoothd[3222]: Refusing input device connect:
Operation already in progress (114)
Aug 16 15:47:46 user bluetoothd[3222]: Refusing input device connect:
Operation already in progress (114)

Searching, I found this thread that pointed to the culprit, but I
haven't found what finally occurred with it, if patch was reverted or a
different fix was pulled in:
http://www.spinics.net/lists/linux-bluetooth/msg26442.html

Thanks

--=-uIvwwzyNmNtx+ZOjENBu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlBUVVkACgkQCaWpQKGI+9TcPwCdFuI9c2oIK8L02XgtIWphVVt3
ezMAn0sq+JVxCB47j0iVquvD9iXI72ON
=x7Tf
-----END PGP SIGNATURE-----

--=-uIvwwzyNmNtx+ZOjENBu--

