Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Nov 2011 18:36:09 +0100
From: Antonio Ospite <ospite@studenti.unina.it>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Regression with Bluetooth HID devices.
Message-Id: <20111115183609.747041b96429e26080e6de43@studenti.unina.it>
In-Reply-To: <CABBYNZLnhfPxN78D0vFJ_3b+ni7y+44k9zrb4pAJCELU1-ec7Q@mail.gmail.com>
References: <20111115003748.21b23ec1532619ff3363a845@studenti.unina.it>
	<CABBYNZLnhfPxN78D0vFJ_3b+ni7y+44k9zrb4pAJCELU1-ec7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__15_Nov_2011_18_36_09_+0100_QEOrcnx2RhpcnJ9Q"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Tue__15_Nov_2011_18_36_09_+0100_QEOrcnx2RhpcnJ9Q
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Nov 2011 11:59:12 +0200
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi Antonio,
>=20
> On Tue, Nov 15, 2011 at 1:37 AM, Antonio Ospite
> <ospite@studenti.unina.it> wrote:
> > Hi,
> >
> > with master (a267bc2) I am getting this in dmesg for Sixaxis
> > controllers:
> >
> > input: PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:02.0/.=
..
> > generic-bluetooth 0005:0000:0000.0018: input,hidraw1: BLUETOOTH HID v0.=
00 ...
> > ^^^^^^^^^^^^^^^^^ =A0 =A0 =A0^^^^ ^^^^
> >
> > generic driver is used because vendor_id and product_id are 0000!
> > while I would expect this:
> >
> > input: PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:02.0/.=
..
> > sony 0005:054C:0268.0017: input,hidraw1: BLUETOOTH HID v0.00 ...
> > ^^^^ =A0 =A0 =A0^^^^ ^^^^
> >
> > Having vendor_id and product_id set to 0000 was making the device not
> > working, the story is briefly like that:
> > =A0- the hid-sony kernel driver makes the controller operational;
> > =A0- devices are bound to hid drivers using vendor_id and product_id;
> > =A0- with those set to 0000, hid-sony ends up not being used at all.
>=20
> That is probably a bug in the code, does the device properties got the
> right values?
>

Yes they do right after read_device_id_from_did(), I have investigated
a little more.

The 'did' file for the device contains:

00:1B:FB:XX:XX:XX FFFF 054C 0268 0000

Only now I realize that the source field (the one now set to FFFF)
is supposed to be either 0x0001 ore 0x0002 like said in [1, section
5.6] about VendorIDSource, so I was doing it wrong. Setting the value to
0x0002 (as the vendor is taken from the USB device) make the device
working.

But _maybe_ this error on my side exposed something inaccurate in BLueZ
too, please keep reading.

This is what was happening in device_cerate(): read_device_id() failed
and this block was never called.

	if (read_device_id(srcaddr, address, NULL, &vendor, &product,
						&version) =3D=3D 0) {
		device_set_vendor(device, vendor);
		device_set_product(device, product);
		device_set_version(device, version);
	}


However, the values were taken correctly in read_device_id_from_did(),
but this snippet makes read_device_id() return with an error
regardeless:

	err =3D read_device_id_from_did(srcaddr, dstaddr, &lsource,
					vendor, product,version);
	if (!err) {
		if (lsource =3D=3D 0xffff)
			err =3D -ENOENT;

		return err;
	}

Now, the reference to the special value FFFF I can find in [1] is
about VendorID [1, section 5.2], NOT VendorIDSource, so my wrong value
in the 'did' file might have exposed a spec misinterpretation here.

Should the check be:
		if (*vendor =3D=3D 0xffff)
			err =3D -ENOENT;
? Changing the other assignment of this value in the code too.

And what about issuing a warning if the 'source' field stored by
store_device_id() is not 0x0001 or 0x0002?

Thanks,
   Antonio

[1]
https://developer.bluetooth.org/KnowledgeCenter/TechnologyOverview/Document=
s/DeviceID_SPEC.pdf

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__15_Nov_2011_18_36_09_+0100_QEOrcnx2RhpcnJ9Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7CowkACgkQ5xr2akVTsAHs4gCfZT6y/6RfDAF7Q27+96uIYoM0
X3QAoKnlKC5C5mwkDjx1bMWgCxC3EyVI
=nKNR
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Nov_2011_18_36_09_+0100_QEOrcnx2RhpcnJ9Q--
