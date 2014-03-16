Return-Path: <cyrus@holtmann.org>
Message-ID: <1395003913.15764.118.camel@deadeye.wl.decadent.org.uk>
Subject: Re: linux-firmware: Update Intel BT devices firmware patch files
 (7260/3160)
From: Ben Hutchings <ben@decadent.org.uk>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: dwmw2@infradead.org,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	Don Fry <don.fry@intel.com>
Date: Sun, 16 Mar 2014 21:05:13 +0000
In-Reply-To: <20140314135254.2edf9d2e@han1-desk-dev>
References: <20140314135254.2edf9d2e@han1-desk-dev>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gTRNPUaJL8iv7ze4G+S9"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-gTRNPUaJL8iv7ze4G+S9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2014-03-14 at 13:52 -0700, Tedd Ho-Jeong An wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>=20
> This patch updates firmware patch files for following Intel Bluetooth Dev=
ices:
> - Intel Wireless Bluetooth 7260
> - Intel Wireless Bluetooth 3160
>=20
> This firmwares fixes
> - No SCO data over EHCI
>=20
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
>  WHENCE                                  |   4 ++--
>  intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq  | Bin 18145 -> 21121 bytes
>  intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq | Bin 17917 -> 21001 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/WHENCE b/WHENCE
> index 4bcb3b5..7876548 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -2254,9 +2254,9 @@ Driver: btusb - Bluetooth USB driver
>  File: intel/ibt-hw-37.7.bseq
>  Version: 1316.02.00
>  File: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> -Version: 1344.01.33
> +Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)=20
>  File: intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
> -Version: 1344.01.33
> +Version: auto.WP_1303_02_patch_0.1.54.1 (0x36)
[...]

Why has the version format changed?  Are all the different parts
actually significant?

Ben.

--=20
Ben Hutchings
Computers are not intelligent.	They only think they are.

--=-gTRNPUaJL8iv7ze4G+S9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAUyYSCee/yOyVhhEJAQpf6Q/9HsFqXJd+2UZX4EwXWX0CnwALKMeg6VHK
Tb7MmbjZJsZQrBvDsn+uZ7LuIymcQYuQ8q1B9fEU+YCJ3HkQWrN0E0jOaZS1xEJ/
YH7Hq3W7Fte0PwfbULV5FZjoyPmwbGIpaiC485FToQ9RszZuXetIexoX6cMl4UbX
bhllRNukcXKd23Idloucvn5K9PDp1m58dZmEqQEFIiADGsbY+F0FaXQxdiqTjpUK
SF51BMz7vTuv+LPQtXb4C6iRk2xG499mddtVm2drxyZXb7Va1pjJRcHjhEKHLsTa
Va3Be6Sfh5KcIdoNYaU9whO1UGg724RrryudhSW2KgCHobBZrGZVJD3XTRhS0HrV
ZAyJkJF5D4JhZCpUKVk+HcMyUXAmsN4OzFQjJP6aW5BAoQPlzA1BJwlwsQhfqnTn
p0PVM7jscKSxi5w3qY56BbgPM9CJkEUagzTrCzVo8NODKVtUHz5GAbsRWuxvY7LH
JzeUa6NgC9Mlaea8+o8MPjYBvOyOoNQmeDSNoPKxQhv/euWxirq9HDa22G8RxhME
3r9HeEg1s+4mAM598/Sl8E2k9s71Gv2kjQe5wJRjJcxtHloGvoAYzQDDE3dBSUWJ
3dfvxv3XpWpXnsAe3myxVrW8dRKr3M7iiKZ1gL8qNGSwmsmUM5UyWsUs0VT1cc4y
o8LRgs6WeWY=
=Cpd6
-----END PGP SIGNATURE-----

--=-gTRNPUaJL8iv7ze4G+S9--
