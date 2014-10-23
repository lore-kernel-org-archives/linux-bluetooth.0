Return-Path: <cyrus@holtmann.org>
From: Ryan Du Bois <rdub@kamama.com>
Content-Type: multipart/signed; boundary="Apple-Mail=_2E96F623-ECE3-4DCA-8AB8-AB96F462F41F"; protocol="application/pgp-signature"; micalg=pgp-sha512
Subject: GATT + DBus API Questions
Message-Id: <35EC48BC-A069-4F13-94E8-32A1533BB15C@kamama.com>
Date: Thu, 23 Oct 2014 16:41:06 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_2E96F623-ECE3-4DCA-8AB8-AB96F462F41F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hey There,

I've been trying to create a GATT service via the DBus BlueZ API =
(org.bluez.GattManager1 + org.bluez.GattService1/GattCharacteristic1).  =
I'm currently using dbus-python to do this.

What I have been able to accomplish thus far (with much exploring of the =
source code, and additional DBG() messages added to illuminate where I =
had been going wrong) is the following:
	- Created proper DBus Proxy objects for GattService1 & =
GattCharacteristic1
		- Each object vends the org.freedesktop.DBus.Properties =
interface, to allow BlueZ to retrieve the UUID and other properties on =
each instance.
	- Created a proper ObjectManager proxy object to allow BlueZ to =
retrieve the aforementioned GattService1 and GattCharacteristic1 =
objects.
	- Called GattManager1's RegisterService() method with =
appropriate arguments.
	- Observed that BlueZ's GattManager1 instance calls my =
ObjectManager's GetManagedObjects() method, and receives the appropriate =
object paths/handles/properties.
	- Observed that BlueZ accomplishes all the internal machinery =
necessary to register the GATT Service in src/gatt-dbus.c (namely, I get =
the "Added GATT service /com/kamama/blargh..." printout on the console, =
when running in debug mode).

What I'm not able to see is the GATT service being listed when I explore =
the GATT services on my device via a BTLE exploration tool (I'm using =
LightBlue on Mac OS X to explore this device).

Looking closer at the code, it looks to me like src/gatt-dbus.c is not =
hooked up to attrib/gatt-service.c, which is probably why my GATT =
Service and Characteristic are not showing up when exploring the device.

Am I missing something, or is this not yet implemented?

Thanks!
--
+Ryan Du Bois
rdub@kamama.com


--Apple-Mail=_2E96F623-ECE3-4DCA-8AB8-AB96F462F41F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJUSZISAAoJEK4Z1vjpzDGSMLAIAMEYs0ZWvblF97afysz3rH32
hoQeUeWiDkMFHYXrQmXsaVimjcOmVxI5NjdZMWOx5rRuQTmdh3iV2oE5pk7ils8R
WmHdKy2kcDJofGGLVuQh4FGEOdwQK0UY0WpBSjmNGZq9nGXAXHQDulTrmGeEc1S1
H7F9/fNPnUIjXdQnY3gIhr483xyOPQ81C9xPX1yo+CGIdu2KMmkM+IdNehFDAkKV
ynZBVuvct1hJoaB7YKTN7BoGLfQyiFDFu0Q1+fhbOsQD+huKl12JB2p1nu3NY6Pa
XOGayvt9a0ZlYyC6ePj5lL/ww5WeTo8jcLyGSppUlcatnoZKgVyGlU3ufb32Dvs=
=sMCw
-----END PGP SIGNATURE-----

--Apple-Mail=_2E96F623-ECE3-4DCA-8AB8-AB96F462F41F--
