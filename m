Return-Path: <cyrus@holtmann.org>
From: =?ISO-8859-1?Q?=C0lex?= Fiestas <afiestas@kde.org>
To: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: Re: Adapters power management
Date: Sun, 23 Mar 2014 01:45:42 +0100
Message-ID: <1458063.fJ1RYS5iKm@minibad>
In-Reply-To: <2963801.adpd6n3SPJ@minibad>
References: <2963801.adpd6n3SPJ@minibad>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1423041.5PURuV1fO0"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--nextPart1423041.5PURuV1fO0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 23 March 2014 01:42:49 you wrote:
> I'm finishing the port of KDE's bluez interface to BlueZ5 and I am wondering
> a few things about power management.
> 
> First thing is, why is Adapter::powered not hook into rfkill? Is there any
> difference power consumption-wise whether the power state is true or false?
> I look  into the source code and only saw code to monitor the rfkill state
> but not for modifying it.
> 
> In the case that Adapter::powered has an impact on power consumption, then
> the ideal state is to have it to false as much as possible. Are there any
> plans to make that easy for frontend developers? In a sense this is very
> similar to Inhibitions in systemd[1] so I was thinking
That bluez could implement something similar so when the application that 
changed Adapter::powered to true exists the state is set back to false.

Sorry for the double email.

Cheers.
[1]http://www.freedesktop.org/wiki/Software/systemd/inhibit/
--nextPart1423041.5PURuV1fO0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTLi67AAoJEGCsZ2zsJAWeDkUP/icLSeAb74z+5gQCKk7MQ/jb
/Us58YYeYZDM8ybiuaGRIEiPyYbJeHIG6R4icPNpB3JpL83xZsVL/q+O2zo+FwJA
50e6HH4JNKrLc4tOVG66dtSFrp83frbZ1l2OwXPBD7UwN1LT494gGqb4ttumHJfO
CiB9oRjzJJTX/c36XwYivWqhYH4ZS/gVZzjH6nLtXTG+q6OYx1+yHYHBNE30MI6b
M3qS4KnPWH7286HTQAWj05mHwpzm4VGzOC3F467CrBFVgL7v4ypcEgpmhguBbqNM
NWtqhCDBLaj23cd2UgwID3zkVkNyVvXYWB97aPpb2vhxFA1UqSm/+Pds9+s+HMK5
9H2x1Jq/r3D4ef/XtWMKLZgc23l3GnDenPvbHjysjoCeCijOgA4ZGn8/2L6oU7uq
T0fLJoIVN7yxyz+y/f6KzOdgyD14M7SvmyyHyqAesUE1/VpqweRTsbLWGf/yuwJo
E+F4gupl2FXpRTY+HL2HR1cz3jKGJjzbXYYD7jM1tQEGJ2Bd3B9ALKut/BFhulW6
M9Bawveh0UMQS98Fl9kfOBTNQUp9gRL+cSbualsagpDLnBtMkK3iMRe24xNmolf/
HvZx0sXkDzFSzRe6kozi3eKqE7XSc8BZ9uO6iiXhxqEmv5LAdstd7/ahxGYXO0RF
OReQiAbjKRgHyOkAfz21
=cMtp
-----END PGP SIGNATURE-----

--nextPart1423041.5PURuV1fO0--

