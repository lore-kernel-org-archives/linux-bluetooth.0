Return-Path: <Olivier.Bornet@smartdata.ch>
Date: Wed, 29 Oct 2003 10:24:02 +0100
From: Olivier Bornet <Olivier.Bornet@smartdata.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: diNovo LT information
Message-ID: <20031029092401.GA10447@smartdata.ch>
References: <20031028232335.GA6411@smartdata.ch> <1067386611.24043.201.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
In-Reply-To: <1067386611.24043.201.camel@pegasus>
Sender: Olivier Bornet <Olivier.Bornet@smartdata.ch>
List-ID: <bluez-users.lists.sourceforge.net>


--Qbvjkv9qwOGw/5Fx
Content-Type: multipart/mixed; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> I am working on the design document of the HID parser userspace to
> kernel interface. My userspace bthid daemon is almost ready for daily
> use, but the modification of the USB HID parser will take some time. I
> am thinking of copying the needed HID stuff into an extra module.

I'm impatient to try this new userspace bthid daemon. :-)

> Is there any chance that you can tell Logitech to send some demo or beta
> devices to me for testing with Linux. I like to play with the devices to
> see how they have done some things.

I'm looking this point now. I hope answer soon. Stay tuned... :-)

> > > If you have some extra time, please compile the new libs2 from CVS and
> > > run "sdptest records ..." and/or "sdptest browse ..." for me.

FYI: ltmain.sh is missing in the libs2 CVS. I have copyed the one from
libs at this time.

Results of sdptest records are attached. (browse is only a sub-set of
the records, so I don't attach them).

Good day.

		Olivier
--=20
Olivier Bornet                      http://www.smartdata.ch/
Olivier.Bornet@smartdata.ch         SMARTDATA SA
GPG key ID: C53D9218                CH Martigny/Lausanne

--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="keyboard-records.txt"

Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010000
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1124 - Human Interface Device Service
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
				UINT16 0x0011
			Sequence
				UUID16 0x0011 - HIDP
	Attribute 0x0006 - Language base attribute ID list
		Sequence
			UINT16 0x656e
			UINT16 0x006a
			UINT16 0x0100
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x0011 - HIDP
				UINT16 0x0100
	Attribute 0x000d - Additional protocol descriptor lists
		Sequence
			Sequence
				Sequence
					UUID16 0x0100 - L2CAP
					UINT16 0x0013
				Sequence
					UUID16 0x0011 - HIDP
	Attribute 0x0100
		String Bluetooth Keyboard
	Attribute 0x0101
		String Keyboard
	Attribute 0x0102
		String Logitech
	Attribute 0x0200
		UINT16 0x9941
	Attribute 0x0201
		UINT16 0x0100
	Attribute 0x0202
		UINT8 0x40
	Attribute 0x0203
		UINT8 0x00
	Attribute 0x0204
		Bool True
	Attribute 0x0205
		Bool True
	Attribute 0x0206
		Sequence
			Sequence
				UINT8 0x22
				String 05 01 09 06 a1 01 05 07 85 01 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01 75 08 81 01 95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 91 01 95 06 75 08 15 00 26 a4 00 05 07 19 00 29 a4 81 00 c0 05 0c 09 01 a1 01 85 03 75 10 95 02 15 01 26 00 11 19 01 2a 00 10 1b 01 00 09 00 2b ff 00 09 00 0a 01 10 81 60 c0 05 01 09 80 a1 01 85 04 15 01 25 03 75 02 95 01 09 82 09 81 09 83 81 60 75 06 81 03 c0 06 00 ff 09 01 a1 01 85 10 75 08 95 06 15 00 26 ff 00 09 01 81 00 09 01 91 00 c0 05 06 09 27 a1 01 85 ff 95 01 75 02 09 24 09 26 81 02 75 06 81 01 c0
	Attribute 0x0207
		Sequence
			Sequence
				UINT16 0x0409
				UINT16 0x0100
	Attribute 0x0208
		Bool False
	Attribute 0x0209
		Bool True
	Attribute 0x020a
		Bool True
	Attribute 0x020b
		UINT16 0x0100
	Attribute 0x020c
		UINT16 0x1f40
	Attribute 0x020d
		Bool False
	Attribute 0x020e
		Bool True
Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010001
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1200 - PNP Information
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
				UINT16 0x0001
			Sequence
				UUID16 0x0001 - SDP
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x1200 - PNP Information
				UINT16 0x0100
	Attribute 0x0200
		UINT16 0x0100
	Attribute 0x0201
		UINT16 0x046d
	Attribute 0x0202
		UINT16 0xb303
	Attribute 0x0203
		UINT16 0x9941
	Attribute 0x0204
		Bool True
	Attribute 0x0205
		UINT16 0x0002

--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mediapad-records.txt"

Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010000
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1124 - Human Interface Device Service
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
				UINT16 0x0011
			Sequence
				UUID16 0x0011 - HIDP
	Attribute 0x0006 - Language base attribute ID list
		Sequence
			UINT16 0x656e
			UINT16 0x006a
			UINT16 0x0100
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x0011 - HIDP
				UINT16 0x0100
	Attribute 0x000d - Additional protocol descriptor lists
		Sequence
			Sequence
				Sequence
					UUID16 0x0100 - L2CAP
					UINT16 0x0013
				Sequence
					UUID16 0x0011 - HIDP
	Attribute 0x0100
		String Bluetooth Numpad
	Attribute 0x0101
		String Numpad
	Attribute 0x0102
		String Logitech
	Attribute 0x0200
		UINT16 0x9810
	Attribute 0x0201
		UINT16 0x0100
	Attribute 0x0202
		UINT8 0x40
	Attribute 0x0203
		UINT8 0x00
	Attribute 0x0204
		Bool True
	Attribute 0x0205
		Bool True
	Attribute 0x0206
		Sequence
			Sequence
				UINT8 0x22
				String 05 01 09 06 a1 01 05 07 85 01 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01 75 08 81 01 95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 91 01 95 06 75 08 15 00 26 a4 00 05 07 19 00 29 a4 81 00 c0 05 0c 09 01 a1 01 85 03 75 10 95 02 15 01 26 00 11 19 01 2a 00 10 1b 01 00 09 00 2b ff 00 09 00 0a 01 10 81 60 c0 06 00 ff 09 01 a1 01 85 10 75 08 95 06 15 00 26 ff 00 09 01 81 00 09 01 91 00 c0 06 00 ff 09 02 a1 01 85 11 75 08 95 13 15 00 26 ff 00 09 02 81 00 09 02 91 00 c0 05 06 09 27 a1 01 85 ff 95 01 75 02 09 24 09 26 81 02 75 06 81 01 c0
	Attribute 0x0207
		Sequence
			Sequence
				UINT16 0x0409
				UINT16 0x0100
	Attribute 0x0208
		Bool False
	Attribute 0x0209
		Bool True
	Attribute 0x020a
		Bool True
	Attribute 0x020b
		UINT16 0x0100
	Attribute 0x020c
		UINT16 0x1f40
	Attribute 0x020d
		Bool True
	Attribute 0x020e
		Bool True
Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010001
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1200 - PNP Information
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
				UINT16 0x0001
			Sequence
				UUID16 0x0001 - SDP
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x1200 - PNP Information
				UINT16 0x0100
	Attribute 0x0200
		UINT16 0x0100
	Attribute 0x0201
		UINT16 0x046d
	Attribute 0x0202
		UINT16 0xb3e1
	Attribute 0x0203
		UINT16 0x9810
	Attribute 0x0204
		Bool True
	Attribute 0x0205
		UINT16 0x0002

--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mouse-records.txt"

Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010000
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1124 - Human Interface Device Service
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
				UINT16 0x0011
			Sequence
				UUID16 0x0011 - HIDP
	Attribute 0x0006 - Language base attribute ID list
		Sequence
			UINT16 0x656e
			UINT16 0x006a
			UINT16 0x0100
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x0011 - HIDP
				UINT16 0x0100
	Attribute 0x000d - Additional protocol descriptor lists
		Sequence
			Sequence
				Sequence
					UUID16 0x0100 - L2CAP
					UINT16 0x0013
				Sequence
					UUID16 0x0011 - HIDP
	Attribute 0x0100
		String Bluetooth Mouse
	Attribute 0x0101
		String Mouse
	Attribute 0x0102
		String Logitech
	Attribute 0x0200
		UINT16 0x9801
	Attribute 0x0201
		UINT16 0x0100
	Attribute 0x0202
		UINT8 0x80
	Attribute 0x0203
		UINT8 0x00
	Attribute 0x0204
		Bool True
	Attribute 0x0205
		Bool True
	Attribute 0x0206
		Sequence
			Sequence
				UINT8 0x22
				String 05 01 09 02 a1 01 85 02 09 01 a1 00 05 09 19 01 29 08 15 00 25 01 95 08 75 01 81 02 05 01 09 30 09 31 16 01 f8 26 ff 07 75 0c 95 02 81 06 09 38 15 81 25 7f 75 08 95 01 81 06 c0 c0 06 00 ff 09 01 a1 01 85 10 75 08 95 06 15 00 26 ff 00 09 01 81 00 09 01 91 00 c0
	Attribute 0x0207
		Sequence
			Sequence
				UINT16 0x0409
				UINT16 0x0100
	Attribute 0x0208
		Bool False
	Attribute 0x0209
		Bool True
	Attribute 0x020a
		Bool True
	Attribute 0x020b
		UINT16 0x0100
	Attribute 0x020c
		UINT16 0x1f40
	Attribute 0x020d
		Bool False
	Attribute 0x020e
		Bool True
Sequence
	Attribute 0x0000 - Service record handle
		UINT32 0x00010001
	Attribute 0x0001 - Service class ID list
		Sequence
			UUID16 0x1200 - PNP Information
	Attribute 0x0004 - Protocol descriptor list
		Sequence
			Sequence
				UUID16 0x0100 - L2CAP
				UINT16 0x0001
			Sequence
				UUID16 0x0001 - SDP
	Attribute 0x0009 - Bluetooth profile descriptor list
		Sequence
			Sequence
				UUID16 0x1200 - PNP Information
				UINT16 0x0100
	Attribute 0x0200
		UINT16 0x0100
	Attribute 0x0201
		UINT16 0x046d
	Attribute 0x0202
		UINT16 0xb001
	Attribute 0x0203
		UINT16 0x9801
	Attribute 0x0204
		Bool True
	Attribute 0x0205
		UINT16 0x0002

--4bRzO86E/ozDv8r1--

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/n4cxdj3R/MU9khgRAsa/AJ0SKjq2SlZ/poNaBE5jVO19GgSjvgCghtYa
0xoDkQYWP806u+5nJqjA/Ms=
=ct7/
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
