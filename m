Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 May 2012 03:09:12 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Cristian Chilipirea <cristian.chilipirea@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH] bluetooth: Fixed checkpatch warnings
Message-ID: <20120509060912.GE2362@joana>
References: <1336542292-15258-1-git-send-email-cristian.chilipirea@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
In-Reply-To: <1336542292-15258-1-git-send-email-cristian.chilipirea@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Cristian,

* Cristian Chilipirea <cristian.chilipirea@gmail.com> [2012-05-09 08:44:52 =
+0300]:

> Fixed some checkpatch warnings in mgmt.c.
>=20
> Signed-off-by: Cristian Chilipirea <cristian.chilipirea@gmail.com>
> ---
>  net/bluetooth/mgmt.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
>  mode change 100644 =3D> 100755 net/bluetooth/mgmt.c
>=20
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> old mode 100644
> new mode 100644
> index 4bb03b1..494004d
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1122,8 +1122,8 @@ static int set_ssp(struct sock *sk, struct hci_dev =
*hdev, void *data, u16 len)
>  	}
> =20
>  	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
> -	     err =3D cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
> -			      MGMT_STATUS_BUSY);
> +		err =3D cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
> +				 MGMT_STATUS_BUSY);
>  		goto failed;
>  	}
> =20
> @@ -2884,7 +2884,8 @@ int mgmt_write_scan_failed(struct hci_dev *hdev, u8=
 scan, u8 status)
>  	return 0;
>  }
> =20
> -int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key, bool p=
ersistent)
> +int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
> +		      bool persistent)

It turns out that all your proposed fixes but this were already fixed in
bluetooth-next. I went ahead and applied only this one, patch is now upstre=
am.
Thanks.

	Gustavo

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqgoIAAoJEPs3PUX4s20oweQQAKzT8DVx9NFp/8t+ou0aMRcu
XXQb4KEh8jEczfoWVYykKmqHQWWM82o6GOFlPB8H09G5f0elvQ8hqVLwZpF57CKl
lZVBaiLahb+cQB9gT+Wt9tIWIalctShtIY7sSDJPpwz9r0eVuNq0ZWc3inQrTg6b
Q2mYRPzjyeFOb7a2/HgD4t04ZhfOmmrX6wWVyd+T1g2+8RdeLQ8t7MWBOP/ZobmQ
wD+IKigzWTB61gCI0o+4tfEbSXkb65vO8CCvxvHcVbmIu/9uds5Y/D7Q1CukivHK
rML0qXc7HXisDTClpDFBg7ooeueYuQvHyBWFf/Md6nmwdq1ygcaj1DC4sfnG1ONN
LP8UrP1zXlPPyckDov6qyjNHJd5jfetz0Bn0rjS6845rjkD8EVwJa57pHgPiQ/IM
Qg3ePaD6qw2IEWAV5jN+7ZGRwdxM1Jtm3pguTWetQuO1yiOMcnzSATBQMxBY5n5b
Zq4XMLf0z+lZg1KzzhbbYFbahZ3THUTpCFmt5L43Lg3MDQNQ3A4SoUL2Ub3icYGX
2mmMKZdh/VwZ4h0STv3HapjGnzaxTGwCBLvNmcgPP4pPSQN/xYGpWpdMcs1CwQj/
gaEca1Pv+keUSjsbfYE8Iv69D5PII63og/NzR4dbnVUwCl6MUn/dcfqHMha4mF2U
S25EBZ9x042q+DM0IrU2
=iVR4
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
