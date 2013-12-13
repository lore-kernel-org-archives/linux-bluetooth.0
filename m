Return-Path: <cyrus@holtmann.org>
Message-ID: <1386949827.23365.9.camel@pc.interlinx.bc.ca>
Subject: Re: Failed to connect: org.bluez.Error.NotReady
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 13 Dec 2013 10:50:27 -0500
In-Reply-To: <1386949351.6234.0.camel@nuvo>
References: <1386948800.23365.2.camel@pc.interlinx.bc.ca>
	 <1386949351.6234.0.camel@nuvo>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-+8C3bKX88ZtPDCJ7Z/6Z"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-+8C3bKX88ZtPDCJ7Z/6Z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2013-12-13 at 16:42 +0100, Bastien Nocera wrote:
> Looks like the mouse doesn't accept to be connected through remotely.

But why would it (a) all of a sudden become disconnected while I was
using it and (b) a problem today, after having been using this mouse
successfully for a few days now, including have it reconnect after being
idle for long periods of time (i.e. overnight)?

> Turning it off an on should make it connect back to the machine

Unfortunately not.  After turning it off and then on again, still no
connection and none possible:

# info 7C:1E:52:6E:59:D2
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

I have this same problem with my previously paired headset also.  Not
connected and won't connect.

Cheers,
b.


--=-+8C3bKX88ZtPDCJ7Z/6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQEcBAABAgAGBQJSqyzDAAoJENrB0DQWy8igftoIAKN/DmbSk0fnlDO1jczDdy0J
Xzj/wZT5qPN2qevCqJkiyEKwwO2P+by3aYNVVSNQBtM8M1tbiWW+qkiqjCc6D4Xx
A++Bla6Seg7WMrxNPmJFztOIn2CEYcN+eLp/V5U2xBAb4vQNpNrqzFcN9J/F1awo
PjwrT/gEetCe5QPmJ3VlL1bXCI65KM9Wwy0x0YEoDsxDtrtwkDjP+A9MdZ22U7bx
p/DB7EZiklF+i+vg2hQ3JONFBMIK620iRnYS72+gbXpQ0LLBr/Lnxl94yq3dMfIl
JsyxRhzzZnYgFiHj4mbaiF0r2glno6ORd3ZnRzoTJjiHjsCi5jqj+MXLQZ86/3U=
=riEM
-----END PGP SIGNATURE-----

--=-+8C3bKX88ZtPDCJ7Z/6Z--

