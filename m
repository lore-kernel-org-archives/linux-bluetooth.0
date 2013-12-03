Return-Path: <cyrus@holtmann.org>
Message-ID: <1386107032.8730.22.camel@pc.interlinx.bc.ca>
Subject: Re: have to re-pair mouse every few hours (update: mouse needs
 periodic authorization?)
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 03 Dec 2013 16:43:52 -0500
In-Reply-To: <1385843856.12122.5.camel@pc.interlinx.bc.ca>
References: <1385843856.12122.5.camel@pc.interlinx.bc.ca>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-uigWSC4d8dfvLscFbgM5"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-uigWSC4d8dfvLscFbgM5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2013-11-30 at 15:37 -0500, Brian J. Murrell wrote:=20
> Hi,
>=20
> I'm using a Microsoft Sculpt Touch Mouse on a Fedora 19 machine
> (kernel-3.11.9-200.fc19.x86_64 and bluez-4.101-9.fc19.x86_64) with a:
>=20
> Bus 002 Device 019: ID 0a5c:2148 Broadcom Corp. BCM92046DG-CL1ROM Bluetoo=
th 2.1 Adapter
>=20
> bluetooth adapter.  This exact same configuration worked for months just
> fine with a Logitech bluetooth mouse.  But sadly that mouse was crap
> (second one to fail within the warranty period of one of them) so
> replaced it with this MS one.
>=20
> The problem with this MS mouse is that it just goes AWOL and needs to be
> delete and re-paired with the machine every few hours.  Typically it's
> after I have gotten up from the computer and have come back to it.  But
> I have also had it just happen while using it.
>=20
> When this happens, the messages log reports messages such as:
>=20
> Nov 30 12:42:03 pc kernel: [2500032.028982] Bluetooth: Unexpected continu=
ation frame (len 0)
> Nov 30 12:42:03 pc kernel: [2500032.115027] Bluetooth: Unexpected continu=
ation frame (len 0)
>=20
> Any ideas what the problem might be here?

So an interesting development in this is that after a reboot, I am now
starting to see notification bubbles pop up when the mouse goes AWOL
that say:

Authorization request from 'Microsoft Sculpt Touch Mouse' with a "Check
authorization" button it.  When I click that I get a dialog popping up
that says:

Grant access to '<uuid>'

Device 'Microsoft Sculpt Touch Mouse' (<MAC address>) wants access to
the service '<uuid>'.

With both a Reject and a Grant button as well as an "Always grant
access" checkbox.

Clicking Grant restores the functionality of the mouse and clearly I
could click the Always grant access checkbox to have this automatic.

I just wonder what this functionality is.  I never had it with my
previous Logitech bluetooth mouse.

Cheers,
b.


--=-uigWSC4d8dfvLscFbgM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQEcBAABAgAGBQJSnlCYAAoJENrB0DQWy8ig56AIAJPW+4Q52aFqw3uM7SNGDsgc
o9S7vN196eegIwE9U0ofK4Gm4k17nYqdwT8tswFy2vHL39cosOdBJviuwNLzoxKu
f+Jre2kxsXS9xu2uYqrGTMNndBSgU8Cb954TxPLJJUO0Y6HkfqJT5fLHlJqpq5YR
5ekJC1NgMerVYeUGthAzLy7ltJo5dMB6MYF1SbtcvOEAbD8m2jjdEQNeGWtJIUBy
gV6w9lZXAtaW/2AUrLfqFfcMRUXHY9OopXpMm1X5tTdMaMQDhkJX3Do8/awZ1M+O
iWxNAX5btKufpIibc6zNGgBaa6aNVhZt7uCtWcWwAVc/0XMrfHPISa3lJnHpFC4=
=4PV8
-----END PGP SIGNATURE-----

--=-uigWSC4d8dfvLscFbgM5--

