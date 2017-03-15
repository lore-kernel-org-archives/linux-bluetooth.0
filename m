Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 14 Mar 2017 20:11:36 -0600
From: Tal <jkarni@gmail.com>
To: Barry Byford <31baz66@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Integration (-ish) testing with BlueZ D-Bus API
Message-ID: <20170315021136.qvam4ceik5baeqje@Tal>
References: <20170313171952.sqmm6fhqranalkf7@Tal>
 <CAAu3APZTmCs8iFWTOEaF8Z-9p+wnUHc5744MS+Th3bBVWC3eTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="frirthqhcng3axeg"
In-Reply-To: <CAAu3APZTmCs8iFWTOEaF8Z-9p+wnUHc5744MS+Th3bBVWC3eTw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--frirthqhcng3axeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Barry,

On Mon, Mar 13, 2017 at 06:33:23PM +0000, Barry Byford wrote:
> Hello Julian,
>
> This sounds like the functionality of the DBUS Mock library.
> https://github.com/martinpitt/python-dbusmock
>
> There is a BlueZ example/template in the library although they are
> slightly out of date with the latest BlueZ.
> I have started to work on updating and adding some GATT functionality
> although have not got that far.
> However it does allow me to run integration tests on GitHub.
>

I think this will do nicely, thanks!

--
Julian K. Arni
Haskell Consultant, Turing Jump
https://turingjump.com

--frirthqhcng3axeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJYyKLYAAoJEGGSd4xJPRK2Mw0IAIwblme35bt3Us1wNkYosoFp
EOOplAuCMt1ZmremXR0kV8u61987cY2f3cR68JdWDVLTk3ZkjMhJpuTVf2x1KYeR
SXnopZn25q8bpqsyo7UaZk83fNNtxgbeL90m35UlArpEPPyJbJ/k41pCW/uxyJPa
ti2DA/HSkiJ5SGTe2wLxo4wBYkTYPFPURHZfEOHhqAJ11H/cKkak5dF03t7OkdN0
oD624ZdqEABCThaabfSpFzh8gHKIvX5r622DPAwesusXjIg1jOWp5WJaJCG0EbGq
u3w5/je0eY0Jzr2Z4wnBQez0Rsn61nRS9hZbYOS0C5rvOT0ckLb8HQ/5arFXO9k=
=CIoN
-----END PGP SIGNATURE-----

--frirthqhcng3axeg--
