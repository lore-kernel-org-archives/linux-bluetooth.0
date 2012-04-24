Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Apr 2012 01:16:52 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, linville@tuxdriver.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: properly use pr_fmt() on lib.c
Message-ID: <20120424041652.GF18564@joana>
References: <1335235506-32243-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
In-Reply-To: <1335235506-32243-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

* Luis R. Rodriguez <mcgrof@do-not-panic.com> [2012-04-23 19:45:06 -0700]:

> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>=20
> pr_fmt() is either defined or we redefine it. Typically
> drivers define it prior to including printk.h but this
> is done under the assumption that no other subsystem
> it uses has already defined pr_fmt(). In such cases
> pr_fmt() should be undefined and redefined.
>=20
> Doing this properly shaves down compilation time quite
> considerably.
>=20
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
>  net/bluetooth/lib.c |    2 ++
>  1 file changed, 2 insertions(+)

Patch has been applie, thanks.

	Gustavo

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlik0AAoJEPs3PUX4s20oi7EQAKtZ+91Wphb/nsvrgM6uO2pB
nHcl830oLPFYLUej+iSeBbWLFsGPRO2/8QjL77PHsqArzXGc79jNbm2PGIUxqK9i
pxBKDqxh5dhnqKfRSLZIIrXowpB6TUnnbn39+mBHcpG6BAtw91DkFLfMA+MXv2K1
TIXFaBKyO41gTlogwUz+28v/zuzP081JW98+DM+7MLu1ZYm04yvByPOSr0a8xBPG
P6iVI5sQ6DfmDadbHkW8l4OsNGoqituQtHdu7RhznOyoCdjYHwqCFpplChiAFfz3
xYGejofrFty79irG0WyNuZUiG3ZfdglRNFWtSKYpbzHCHSiQFN3yIadx42/82PEl
b729fJ8IdXH+dkKKkdbFaa5hUdeFVmsECtbOjPbXq8WcNzmnmuJgPjMlMGnXNsDk
xCzf5kIUox90bwxSGaI92GK8cN1zLdAMh0LukhlfxHMiaiRZyCZh9WeqDtZJIrFa
GwiT4q1Xc48rjjcq9S0CuuKP5iLTMBcDCTtizLn13gY2DP4iWpQfgdSM2NV4C5Y/
oXm6phwl6MROsZCoXWxbLjQqwB+Ia4TTc+w9vw3WsrvZLJUDAJ9UP1q/hRjfZoy7
X3VtGUEYgiq++IbpJwfgnK8eJ2bYbZnzYoo43dKwICuO1GPiFgUj5LGNUL4VGfzb
DbpGw4sOIygtvf6I5daY
=4uz+
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
