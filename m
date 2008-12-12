Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY114-DS7ECAF56F5E639623E22B2B1F90@phx.gbl>
From: "shy" <shyboysby@hotmail.com>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
References: <15A39AF0EC0CC0418BE4B70B810E61B70143C694@zmy16exm72.ds.mot.com> <1229046401.22285.23.camel@violet.holtmann.net>
Subject: RE: how bluez supports ESCO link?
Date: Fri, 12 Dec 2008 11:22:44 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
In-Reply-To: <1229046401.22285.23.camel@violet.holtmann.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Marcel
Thanks for your response. In the latest stable kernel code, this code =
has
been modified and can answer for my question.
Brs
Shi Buyun=20

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: 2008=C4=EA12=D4=C212=C8=D5 09:47
To: Shi Buyun-FVBP83
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: how bluez supports ESCO link?

Hi,

> In the current linux 2.6.25 kernel code, can Bluez setup ESCO link?
> I found in net/bluetooth/sco.c, sco_connect defined as:
>=20
> static int sco_connect(struct sock *sk) {  if (lmp_esco_capable(hdev)=20
> && !disable_esco)
>   type =3D ESCO_LINK;
>  else
>   type =3D SCO_LINK;
> =20
>  hcon =3D hci_connect(hdev, type, dst, HCI_AT_NO_BONDING);  } this =
code=20
> shows bluez supports ESCO link.
> =20
> But in function struct hci_conn * hci_connect(struct hci_dev *hdev,=20
> int type, bdaddr_t *dst) {  if (type =3D=3D SCO_LINK) {
>   struct hci_conn *sco;
> =20
>   if (!(sco =3D hci_conn_hash_lookup_ba(hdev, SCO_LINK, dst))) {
>    if (!(sco =3D hci_conn_add(hdev, SCO_LINK, dst))) {
>     hci_conn_put(acl);
>     return NULL;
>    }
>   }
>   acl->link =3D sco;
>   sco->link =3D acl;
> =20
>   hci_conn_hold(sco);
> =20
>   if (acl->state =3D=3D BT_CONNECTED &&=20
>     (sco->state =3D=3D BT_OPEN || sco->state =3D=3D BT_CLOSED))
>    hci_add_sco(sco, acl->handle);
> =20
>   return sco;
>  } else {
>   return acl;
>  }
> }
> the else switch shows it does nothing when type NOT equal to SCO_LINK.
> Should this code need to modify or this is intended to designed?

the hci_connect from a 2.6.27 kernel looks different. So you might wanna
test with a later kernel.

Regards

Marcel
