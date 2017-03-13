Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 13 Mar 2017 11:19:52 -0600
From: Tal <jkarni@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Integration (-ish) testing with BlueZ D-Bus API
Message-ID: <20170313171952.sqmm6fhqranalkf7@Tal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4jl2ukjrio6ociie"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--4jl2ukjrio6ociie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hey list,

  I just wrote a little Haskell library wrapping the GATT API [0]. It's been a
surprisingly smooth experience - thanks for the API and documentation!

  One issue that remains, though, is decent testing. Right now the tests limit
themselves to calling d-bus methods and just checking that they don't throw an
error. I don't see how I can do more than that - check that BlueZ in fact
registered an application with the data I'm expecting, or check that it's
handling notifications, etc. (Without, that is, pulling out my phone and trying
it manually.) Tapping into dbus-monitor in some cases would provide some help,
but everyone who wants to run the tests would need there dbus config files, the
tests would have to run as root, I'd have to do fairly fragile parsing of the
logs that would still only approximate the properties I really want to check
for.

  If I could register an application on a computer and interact with it as if
it were a remote peripheral (essentially having the computer be both the
central and the peripheral), then testing would be much easier and more
comprehensive. In this particular case, I know the communication would only go
as far as DBus, and not through the hardware layers of the bluetooth stack, but
that's okay.

  Is this at all possible?

[0] http://hackage.haskell.org/package/ble

--
Julian K. Arni
Haskell Consultant, Turing Jump
https://turingjump.com


--4jl2ukjrio6ociie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJYxtS0AAoJEGGSd4xJPRK2R8MIAIao/WNGM7aMPOr7Yex15c5F
D59Fl3RuMIJDD32ev16yu9p9LG3JGq2I9CwGqBFQvcxDz7ApRQiHLg73zXMAJ8zz
gLdPGx+elx46ky9JtnZBzxPtPayRt4R1ntIfG9ky8Mv5hyRlTl8TO6ufqz8d2s9L
iNNlH7UcGgd+gxtduzkKBvKFzM2MW+B6Ki1EAvsfmbr8MgxQMuwVaLRGtmI5kWs0
bPiD4M/bo+XFBtrk+3xxGez+fHNFezxGkp9882qv3igJbumoKr+xTJTOhEcIR7pv
Kk7fI20bQQCCYKPxz8LDy0Gjtxvb02ZhLXpX7zwMymuC+lVlULQQb9QMXRoCEzw=
=iArC
-----END PGP SIGNATURE-----

--4jl2ukjrio6ociie--
