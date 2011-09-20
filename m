Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Sep 2011 14:49:22 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC PATCH BlueZ 1/3] Add a
 btd_manager_get_default_adapter_str() call
Message-Id: <20110920144922.8e3ad2dbb2a21e06b611fdfc@studenti.unina.it>
In-Reply-To: <CABBYNZL4wmb=ZvwDZasoZVx939-HZkv=u8xzZZR_jdqnF_+aLw@mail.gmail.com>
References: <1316454126-32614-1-git-send-email-ospite@studenti.unina.it>
	<1316454126-32614-2-git-send-email-ospite@studenti.unina.it>
	<CABBYNZL4wmb=ZvwDZasoZVx939-HZkv=u8xzZZR_jdqnF_+aLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__20_Sep_2011_14_49_22_+0200_.q7eu09DWOaE3Z1m"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--Signature=_Tue__20_Sep_2011_14_49_22_+0200_.q7eu09DWOaE3Z1m
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Sep 2011 14:30:42 +0300
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi Antonio,
>=20
> On Mon, Sep 19, 2011 at 8:42 PM, Antonio Ospite
> <ospite@studenti.unina.it> wrote:
> > Add a new btd_* call to get the default adapter address as a string,
> > this is going to be used by the external playstation-peripheral plugin.
> > ---
> > =A0src/manager.h | =A0 =A01 +
> > =A0src/manager.c | =A0 16 ++++++++++++++++
> > =A02 files changed, 17 insertions(+), 0 deletions(-)
> >
> > diff --git a/src/manager.h b/src/manager.h
> > index 4f92d2f..91d9894 100644
> > --- a/src/manager.h
> > +++ b/src/manager.h
> > @@ -36,6 +36,7 @@ const char *manager_get_base_path(void);
> > =A0struct btd_adapter *manager_find_adapter(const bdaddr_t *sba);
> > =A0struct btd_adapter *manager_find_adapter_by_id(int id);
> > =A0struct btd_adapter *manager_get_default_adapter(void);
> > +char *btd_manager_get_default_adapter_str(void);
> > =A0void manager_foreach_adapter(adapter_cb func, gpointer user_data);
> > =A0GSList *manager_get_adapters(void);
> > =A0struct btd_adapter *btd_manager_register_adapter(int id);
> > diff --git a/src/manager.c b/src/manager.c
> > index 464b0ca..8947f85 100644
> > --- a/src/manager.c
> > +++ b/src/manager.c
> > @@ -270,6 +270,22 @@ struct btd_adapter *manager_get_default_adapter(vo=
id)
> > =A0 =A0 =A0 =A0return manager_find_adapter_by_id(default_adapter_id);
> > =A0}
> >
> > +char *btd_manager_get_default_adapter_str(void)
> > +{
> > + =A0 =A0 =A0 struct btd_adapter *adapter;
> > + =A0 =A0 =A0 bdaddr_t adapter_bdaddr;
> > + =A0 =A0 =A0 char *str =3D bt_malloc(18);
> > +
> > + =A0 =A0 =A0 adapter =3D manager_get_default_adapter();
> > + =A0 =A0 =A0 if (adapter =3D=3D NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 adapter_get_address(adapter, &adapter_bdaddr);
> > + =A0 =A0 =A0 ba2str(&adapter_bdaddr, str);
> > + =A0 =A0 =A0 return str;
> > +}
> > +
>=20
> It doesn't seems that gonna be very useful for the core daemon,
> besides you can always get the bdaddr and convert yourself, if the
> purpose is just to be a helper function then perhaps we should find
> another place. Btw are you sure you need the adapter address and not
> the remote device address?
>=20

The point of the helper function here is to avoid making
adapter_get_address() and ba2str() public/global symbols for external
plugins to use. That's why it is prefixed with btd_*, unfortunately
I couldn't find a rule which explains the rationale behind the btd_
prefix, and the conditions where it should be used, for now I just
follow the rule "if you want it in an external plugin then it must be
prefixed with btd_".

I need the adapter address because of how the association works on
those PlayStation peripherals: the _adapter_ bt address needs to
be stored into the _device_ (via USB) before it can communicate with
it.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Tue__20_Sep_2011_14_49_22_+0200_.q7eu09DWOaE3Z1m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk54i9IACgkQ5xr2akVTsAHWngCdF4MV2yabQ9qApjdMjnRRD3YD
nXoAoJ2GRwR2DeY/t1WWQER7s4SqQKog
=oqm5
-----END PGP SIGNATURE-----

--Signature=_Tue__20_Sep_2011_14_49_22_+0200_.q7eu09DWOaE3Z1m--
