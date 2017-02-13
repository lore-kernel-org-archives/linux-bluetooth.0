Return-Path: <sre@kernel.org>
Date: Mon, 13 Feb 2017 06:55:05 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linux-Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Hugues <morisset.hugues@gmail.com>
Subject: Re: Bose Quiet Comfort 35 Remaining Battery Reporting
Message-ID: <20170213055504.kworoylsusadecl7@earth>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m62bf276nn7xsoop"
In-Reply-To: <F332B3A2-F715-4526-A161-0B13CFBACEFE@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--m62bf276nn7xsoop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

FWIW I was also interested in battery level of my Bose QC35 and
checked this some time ago. That time I only checked the low
energy stuff, since the Android application seems to know the
battery status with only LE being connected.

Marcel Holtman wrote:
>> This headset do have dual mode, I searched around using gatttool ant the
>> gatt specification but I find nothing about Battery Level
>> (org.bluetooth.characteristic.battery_level.xml) or Battery Service
>> (org.bluetooth.service.battery_service.xml).

Bose QC35 does not expose battery status through standard battery_level
characteristic. There is a proprietary primary service 0xfebe (which
is assigned to Bose) with a couple of custom services. I assume battery
level can be read through them, but the required commands are unknown.

>> How could I read what's in the Apple HFP extensions?
>
> Start with this one. It describes the extra HFP AT commands that iOS uses:
>
> https://developer.apple.com/hardwaredrivers/BluetoothDesignGuidelines.pdf

Thanks for the documentation link! That is actually implemented for
the Bose QC35. Here is a quick hack providing battery status info
in pulseaudio log:

https://github.com/sre/pulseaudio/commit/d66b66d20e9bc73e6d0ca89283cf2b5675304b00

-- Sebastian

--m62bf276nn7xsoop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlihSjYACgkQ2O7X88g7
+pqJ2Q/7Bw8ZdoFTlFwrgNmrXFZJvCTzO6QxF4oPPS6g5eav5osgsnxmqOClRkdR
SLZX32sW5MxXgFQh+BewM2VxUUk+hhCoFNlo4jWXEs56T8eW3rAjBMEFJm19arR7
lXQ6rsgxY8PmmhIOJf7cbqKngE6xasHNn6VoRqhsTkwDsRAVPw5fr/MDBMFjtT1J
Egm/QsT12AI5UD22ioHdjK4BpMqQgwNXBIBlBFG3bxnhhuPbXH+dlHAJtXldb2/q
/JwY2Yh8KJ1J5EjgnjNvoqbPZYbxpEPY3L6n6gYo7ruvVxgnydcTWLAcwX5eNADJ
l0Mbp7s/nPDlohAZArvK/NYdXYsrQa9r2YHHaq/SZ7LDel3oBFQsty1ApsC4kpc1
HKQurPobNbbtmreAbBhX+xiYgNZWCXwWObAMgc/rIjKsZpfFK6F55Zf5fz/BNV/Z
C3+2YkSmx6XnV84y3DXlU8DzkX6L00Sxex2tOKMsq+KcRNMg6+flokd+kA5DaYHD
eQEq04crydzOcPtaDG9dkbq29FHEVRtp32xFLnQJOn5ghKM6xON6W/kcE3BU1F2c
Mx/S7Hkwzdt0bs9cAeteZ+MuGbEWaHajk39nV91vD2Q0hE9WL+/hVphqneIrvStW
1mt34/QOqnE4Egv499tlHaFetKYThwqaUKIJFwXNMsK5lJR59Js=
=6YS2
-----END PGP SIGNATURE-----

--m62bf276nn7xsoop--
