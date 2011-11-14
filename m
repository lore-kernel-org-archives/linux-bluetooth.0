Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Nov 2011 00:37:48 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Regression with Bluetooth HID devices.
Message-Id: <20111115003748.21b23ec1532619ff3363a845@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__15_Nov_2011_00_37_48_+0100_5ohTezB4iaiHY6/h"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Tue__15_Nov_2011_00_37_48_+0100_5ohTezB4iaiHY6/h
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

with master (a267bc2) I am getting this in dmesg for Sixaxis
controllers:

input: PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:02.0/...
generic-bluetooth 0005:0000:0000.0018: input,hidraw1: BLUETOOTH HID v0.00 .=
..
^^^^^^^^^^^^^^^^^      ^^^^ ^^^^

generic driver is used because vendor_id and product_id are 0000!
while I would expect this:

input: PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:02.0/...
sony 0005:054C:0268.0017: input,hidraw1: BLUETOOTH HID v0.00 ...
^^^^      ^^^^ ^^^^

Having vendor_id and product_id set to 0000 was making the device not
working, the story is briefly like that:
  - the hid-sony kernel driver makes the controller operational;
  - devices are bound to hid drivers using vendor_id and product_id;
  - with those set to 0000, hid-sony ends up not being used at all.

I bisected the problem to this commit:

73952ca597960043de7c32bd172bc5bc816b324e is the first bad commit
commit 73952ca597960043de7c32bd172bc5bc816b324e
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Sep 22 18:51:51 2011 +0300

    Remove use of read_device_id in input plugin
   =20
    Make use of btd_device_get_vendor, btd_device_get_product and
    btd_device_get_version intead.


Reverting it fixes the problem for me, but is a better fix possible?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__15_Nov_2011_00_37_48_+0100_5ohTezB4iaiHY6/h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7BpkwACgkQ5xr2akVTsAGaogCaA0k3997pl8W7J6Hc3T1PeIXS
d/cAniJ0P7jsPKezFURR7GHRZhLFYbVK
=lOoT
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Nov_2011_00_37_48_+0100_5ohTezB4iaiHY6/h--
