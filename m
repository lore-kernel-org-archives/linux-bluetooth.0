Return-Path: <maxime.chevallier@openwide.fr>
Date: Wed, 25 Nov 2015 09:28:40 +0100 (CET)
From: Maxime Chevallier <maxime.chevallier@openwide.fr>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Message-ID: <376946759.4217820.1448440120591.JavaMail.zimbra@openwide.fr>
In-Reply-To: <1443101028-4064-1-git-send-email-maxime.chevallier@openwide.fr>
References: <1443101028-4064-1-git-send-email-maxime.chevallier@openwide.fr>
Subject: Re: [PATCH] lib: Add HCI command "LE_SET_ADVERTISING_PARAMETERS"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

I was wondering if this patch is still relevant to your interests,
I do think this is something accidentally missing in hci lib.

Please tell me if I have done anything incorrect in this code,
I conduced some more testing and used it daily since I implemented
it, and it works just fine on my setup.

Sorry for my poor english,

Regards,

Maxime Chevallier

----- Mail original -----
> De: "Maxime Chevallier" <maxime.chevallier@openwide.fr>
> =C3=80: linux-bluetooth@vger.kernel.org
> Cc: "Maxime Chevallier" <maxime.chevallier@openwide.fr>
> Envoy=C3=A9: Jeudi 24 Septembre 2015 15:23:48
> Objet: [PATCH] lib: Add HCI command "LE_SET_ADVERTISING_PARAMETERS"

> Added missing HCI 'LE_SET_ADVERTISING_PARAMETERS' command wrapper in
> lib, in function hci_le_set_advertising_parameters().
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@openwide.fr>
> ---
> lib/hci.c     | 39 +++++++++++++++++++++++++++++++++++++++
> lib/hci_lib.h |  5 +++++
> 2 files changed, 44 insertions(+)
>=20
> diff --git a/lib/hci.c b/lib/hci.c
> index c25be9e..ac6f1f8 100644
> --- a/lib/hci.c
> +++ b/lib/hci.c
> @@ -2996,6 +2996,45 @@ int hci_le_set_advertise_enable(int dd, uint8_t en=
able,
> int to)
> =09return 0;
> }
>=20
> +int hci_le_set_advertising_parameters(int dd, uint16_t min_interval,
> +=09=09=09=09=09uint16_t max_interval, uint8_t advtype,
> +=09=09=09=09=09uint8_t own_bdaddr_type, uint8_t direct_bdaddr_type,
> +=09=09=09=09=09const bdaddr_t *direct_bdaddr, uint8_t chan_map,
> +=09=09=09=09=09uint8_t filter, int to)
> +{
> +=09struct hci_request rq;
> +=09le_set_advertising_parameters_cp param_cp;
> +=09uint8_t status;
> +
> +=09memset(&param_cp, 0, sizeof(param_cp));
> +=09param_cp.min_interval =3D min_interval;
> +=09param_cp.max_interval =3D max_interval;
> +=09param_cp.advtype =3D advtype;
> +=09param_cp.own_bdaddr_type =3D own_bdaddr_type;
> +=09param_cp.direct_bdaddr_type =3D direct_bdaddr_type;
> +=09bacpy(&param_cp.direct_bdaddr, direct_bdaddr);
> +=09param_cp.chan_map =3D chan_map;
> +=09param_cp.filter =3D filter;
> +
> +=09memset(&rq, 0, sizeof(rq));
> +=09rq.ogf =3D OGF_LE_CTL;
> +=09rq.ocf =3D OCF_LE_SET_ADVERTISING_PARAMETERS;
> +=09rq.cparam =3D &param_cp;
> +=09rq.clen =3D LE_SET_ADVERTISING_PARAMETERS_CP_SIZE;
> +=09rq.rparam =3D &status;
> +=09rq.rlen =3D 1;
> +
> +=09if (hci_send_req(dd, &rq, to) < 0)
> +=09=09return -1;
> +
> +=09if (status) {
> +=09=09errno =3D EIO;
> +=09=09return -1;
> +=09}
> +
> +=09return 0;
> +}
> +
> int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
> =09=09uint8_t initiator_filter, uint8_t peer_bdaddr_type,
> =09=09bdaddr_t peer_bdaddr, uint8_t own_bdaddr_type,
> diff --git a/lib/hci_lib.h b/lib/hci_lib.h
> index 55aeb17..9fd7505 100644
> --- a/lib/hci_lib.h
> +++ b/lib/hci_lib.h
> @@ -120,6 +120,11 @@ int hci_le_set_scan_parameters(int dev_id, uint8_t t=
ype,
> uint16_t interval,
> =09=09=09=09=09uint16_t window, uint8_t own_type,
> =09=09=09=09=09uint8_t filter, int to);
> int hci_le_set_advertise_enable(int dev_id, uint8_t enable, int to);
> +int hci_le_set_advertising_parameters(int dd, uint16_t min_interval,
> +=09=09=09=09=09uint16_t max_interval, uint8_t advtype,
> +=09=09=09=09=09uint8_t own_bdaddr_type, uint8_t direct_bdaddr_type,
> +=09=09=09=09=09const bdaddr_t *direct_bdaddr, uint8_t chan_map,
> +=09=09=09=09=09uint8_t filter, int to);
> int hci_le_create_conn(int dd, uint16_t interval, uint16_t window,
> =09=09uint8_t initiator_filter, uint8_t peer_bdaddr_type,
> =09=09bdaddr_t peer_bdaddr, uint8_t own_bdaddr_type,
> --
> 2.1.4
