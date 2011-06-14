Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 12:24:03 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] Add function to get default adapter ID
Message-Id: <20110614122403.15a13073.ospite@studenti.unina.it>
In-Reply-To: <1307627589-25786-1-git-send-email-hadess@hadess.net>
References: <1307627589-25786-1-git-send-email-hadess@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__14_Jun_2011_12_24_03_+0200_qseMxCHj4zbHTiA2"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Tue__14_Jun_2011_12_24_03_+0200_qseMxCHj4zbHTiA2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu,  9 Jun 2011 14:53:08 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> Combined with manager_find_adapter_by_id(), it is now possible
> to get the btd_adapter struct for the default adapter:
> manager_find_adapter_by_id (manager_get_default_adapter_id ());
> ---

Ping, if this gets it I will use it in the next version of the Sixaxis
plugin.

Thanks,
   Antonio


>  src/manager.c |    8 ++++++++
>  src/manager.h |    1 +
>  2 files changed, 9 insertions(+), 0 deletions(-)
>=20
> diff --git a/src/manager.c b/src/manager.c
> index e805e0c..9d0de25 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -288,6 +288,11 @@ static void manager_remove_adapter(struct btd_adapte=
r *adapter)
>  		btd_start_exit_timer();
>  }
> =20
> +int manager_get_default_adapter_id(void)
> +{
> +	return default_adapter_id;
> +}
> +
>  void manager_cleanup(DBusConnection *conn, const char *path)
>  {
>  	g_slist_foreach(adapters, (GFunc) manager_remove_adapter, NULL);
> @@ -331,6 +336,9 @@ struct btd_adapter *manager_find_adapter_by_id(int id)
>  {
>  	GSList *match;
> =20
> +	if (id < 0)
> +		return NULL;
> +
>  	match =3D g_slist_find_custom(adapters, GINT_TO_POINTER(id),
>  							adapter_id_cmp);
>  	if (!match)
> diff --git a/src/manager.h b/src/manager.h
> index 05c38b3..52bf36b 100644
> --- a/src/manager.h
> +++ b/src/manager.h
> @@ -41,3 +41,4 @@ struct btd_adapter *btd_manager_register_adapter(int id=
);
>  int btd_manager_unregister_adapter(int id);
>  void manager_add_adapter(const char *path);
>  void btd_manager_set_did(uint16_t vendor, uint16_t product, uint16_t ver=
sion);
> +int manager_get_default_adapter_id(void);
> --=20

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__14_Jun_2011_12_24_03_+0200_qseMxCHj4zbHTiA2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk33NsMACgkQ5xr2akVTsAEmygCgkLviFdZ3s8c6p3V+DUhb5krR
GmkAn0I80a+8v+OuhSHavO9dFfobxr6v
=6RqK
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Jun_2011_12_24_03_+0200_qseMxCHj4zbHTiA2--
