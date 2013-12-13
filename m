Return-Path: <cyrus@holtmann.org>
Message-ID: <1386948800.23365.2.camel@pc.interlinx.bc.ca>
Subject: Failed to connect: org.bluez.Error.NotReady
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 13 Dec 2013 10:33:20 -0500
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Xw4hY2O24lHDTwu09mXn"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-Xw4hY2O24lHDTwu09mXn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So I was happily chugging along using bluez5 on F20 with the previously
mentioned mouse and all of a sudden it stopped working.  So to
bluetoothctl I go:

$ bluetoothctl=20
[NEW] Controller 00:02:72:1E:E0:12 pc.interlinx.bc.ca-0 [default]
[NEW] Device 00:0D:E6:68:B4:6F Samsung WEP850
[NEW] Device 70:F3:95:3E:92:34 brian-laptop
[NEW] Device 7C:1E:52:6E:59:D2 Microsoft Sculpt Touch Mouse
[bluetooth]# info 7C:1E:52:6E:59:D2
Device 7C:1E:52:6E:59:D2
	Name: Microsoft Sculpt Touch Mouse
	Alias: Microsoft Sculpt Touch Mouse
	Class: 0x000580
	Icon: input-mouse
	Paired: yes
	Trusted: yes
	Blocked: no
	Connected: no
	LegacyPairing: no
	UUID: Service Discovery Serve.. (00001000-0000-1000-8000-00805f9b34fb)
	UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v045Ep077Cd011E
[bluetooth]# connect 7C:1E:52:6E:59:D2
Attempting to connect to 7C:1E:52:6E:59:D2
Failed to connect: org.bluez.Error.NotReady

I've tried unplugging and plugging in the dongle.  Not sure what else to
do at this point.

Any ideas?

Cheers,
b.


--=-Xw4hY2O24lHDTwu09mXn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQEcBAABAgAGBQJSqyjBAAoJENrB0DQWy8igPZAH+wdDowijPyRchUet9r6qdT06
euhxvPP4uODxnHGC7CYdicmGu+I/WX8BxT2dINB5qQa8VagbsI8WKLtRzbnzzeio
+ZCjP+BAcDNC9sDl/Mbs9G5nG9HDHdKWXTqaVoMuYYuNWWyu0zsi/OLur17W9F6E
frRI2uUQktprxEfkHClfl4dxGbwPnOjTSVPWsMpYWV3YqWMILae9A5LMrwhuJc7l
x5P4x5Qqz+6c1zhoQhekSMa95n2XNYQ/AMEz55+S//TlapHcIw2a04aPfgJ0vplw
Rtzy7s3rynd9ZKrfQFdCqA5iRHwE0HrkE1I1JvqyUNTdcFd+m4g14eYwUPSDnVU=
=9n3z
-----END PGP SIGNATURE-----

--=-Xw4hY2O24lHDTwu09mXn--

