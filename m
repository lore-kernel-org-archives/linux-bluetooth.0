Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98102EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjFNRFr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 13:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjFNRFq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 13:05:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276B52103
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 10:05:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1a66e71f9so13042331fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686762341; x=1689354341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miEFYyc/lemQYqhiOZh0XMDB2aDsq+rG1ROz0EEQzl4=;
        b=Y/HsBta/OzZp5Ixylzfe8TL2bJzaMfETZXFkbglNQNFdsdUPnLhbqcpsRNwDaeUaeV
         3J9Pn8ShKw3BUrgocuq/zXrcr0k+zCPKd9gess1n6bllRAnKJWWJLL7HvBFVus9/uxxU
         NlxMo72hOBnCD8xPKe4T0JQmbipY1IoFmYJPV7F38LLIY2XdYDSVCPp2Ek5MkQtz2rcD
         j28+li/hJi2v5hYwlmjk7Ov7ZiVjOqoVTJ/tE1sTX8gH8swV69ez03XEWhZ2yRRmbelY
         EkXqjdfH3ren8mFxoeR27+MfJvpkODn1HhqByw+PvCRPDxn4QE0lxOm5nMBD5Qz1GqfQ
         gy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686762341; x=1689354341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miEFYyc/lemQYqhiOZh0XMDB2aDsq+rG1ROz0EEQzl4=;
        b=Z7VvlORnsvrwUT8WIe4xQRbJxpC74ceDpjOwj17rYqQGrLjSnrgzNv7M/xhgyvz4Kh
         HcX97SiXn0Qh7R+3fK5ssDAVwgs/kWy/S9jWbcZ/ElRDg0rWO5WDSfiSyELGyZnNZrdn
         4sHtOoRJyIsnUlPnotr7HgyeqS9yUx4TonuRJoRzw8bT3++jEGY29E8AZ5F0Top1j4Vn
         ukBZJFUNHz5in8u+aRUrZbfn4qJ9ssymnsLuPf4j/bO57Lp2EKDB9/gIwiWFcuIIPUpY
         tjx0NnYlPsAPW8WM/BYCXVHvBt0Gh3B86hLsB7cE9li+MEOuH8FWhVqcuzlfy7aBQTfu
         9bbg==
X-Gm-Message-State: AC+VfDxj5siiJ5zeyfCer/gnItZiDODm9f+qwDiKxPbmOBuVvjfIfjDo
        whkvhWC0FRrjou9DQxA2i4gqQV4+ZlpLTIc7raiKAWXH0dPntLH/
X-Google-Smtp-Source: ACHHUZ4fYMdywqKRO+9kVSlx89Jf5XEpNcZCv02rWK2PCCZNOr0Lr5ZD29Z8pJ3uvLDB8gf6Kqjrpk40HXiSnXaDMGA=
X-Received: by 2002:a05:651c:14f:b0:2af:2871:9a66 with SMTP id
 c15-20020a05651c014f00b002af28719a66mr7806479ljd.39.1686762340720; Wed, 14
 Jun 2023 10:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230613142017.9337-1-iulia.tanasescu@nxp.com> <20230613142017.9337-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20230613142017.9337-2-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Jun 2023 10:05:28 -0700
Message-ID: <CABBYNZJhuteqCd8cam+_WDXAe2-ozLMhCRRKpO1WyYZx1JO+wQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Support multiple BIGs
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        silviu.barbulescu@nxp.com, andrei.istodorescu@nxp.com,
        mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Tue, Jun 13, 2023 at 7:26=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This adds support for creating multiple BIGs. According to
> spec, each BIG shall have an unique handle, and each BIG should
> be associated with a different advertising handle. Otherwise,
> the LE Create BIG command will fail, with error code
> Command Disallowed (for reusing a BIG handle), or
> Unknown Advertising Identifier (for reusing an advertising
> handle).
>
> The btmon snippet below shows an exercise for creating two BIGs
> for the same controller, by opening two isotest instances with
> the following command:
>         tools/isotest -i hci0 -s 00:00:00:00:00:00
>
> < HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068) plen 3=
1
>         Handle: 0x00
>         Advertising Handle: 0x01
>         Number of BIS: 1
>         SDU Interval: 10000 us (0x002710)
>         Maximum SDU size: 40
>         Maximum Latency: 10 ms (0x000a)
>         RTN: 0x02
>         PHY: LE 2M (0x02)
>         Packing: Sequential (0x00)
>         Framing: Unframed (0x00)
>         Encryption: 0x00
>         Broadcast Code: 00000000000000000000000000000000
>
> > HCI Event: Command Status (0x0f) plen 4
>       LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
>         Status: Success (0x00)
>
> > HCI Event: LE Meta Event (0x3e) plen 21
>       LE Broadcast Isochronous Group Complete (0x1b)
>         Status: Success (0x00)
>         Handle: 0x00
>         BIG Synchronization Delay: 912 us (0x000390)
>         Transport Latency: 912 us (0x000390)
>         PHY: LE 2M (0x02)
>         NSE: 3
>         BN: 1
>         PTO: 1
>         IRC: 3
>         Maximum PDU: 40
>         ISO Interval: 10.00 msec (0x0008)
>         Connection Handle #0: 10
>
> < HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
>         Handle: 0x01
>         Advertising Handle: 0x02
>         Number of BIS: 1
>         SDU Interval: 10000 us (0x002710)
>         Maximum SDU size: 40
>         Maximum Latency: 10 ms (0x000a)
>         RTN: 0x02
>         PHY: LE 2M (0x02)
>         Packing: Sequential (0x00)
>         Framing: Unframed (0x00)
>         Encryption: 0x00
>         Broadcast Code: 00000000000000000000000000000000
>
> > HCI Event: Command Status (0x0f) plen 4
>       LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
>         Status: Success (0x00)
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/hci_core.h |  6 ++---
>  net/bluetooth/hci_conn.c         | 40 ++++++++++++++------------------
>  net/bluetooth/hci_event.c        | 30 ++++++++++++++++++++----
>  net/bluetooth/hci_sync.c         |  9 +++++--
>  4 files changed, 52 insertions(+), 33 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 683666ea210c..b5af9be70771 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -240,6 +240,7 @@ struct adv_info {
>         bool    enabled;
>         bool    pending;
>         bool    periodic;
> +       bool    per_enabled;

Can't we just reuse the enabled flag or we really need to have 2 to
track the EA and the PA states separately?

>         __u8    mesh;
>         __u8    instance;
>         __u32   flags;
> @@ -1096,8 +1097,7 @@ static inline __u8 hci_conn_lookup_type(struct hci_=
dev *hdev, __u16 handle)
>  }
>
>  static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *=
hdev,
> -                                                       bdaddr_t *ba,
> -                                                       __u8 big, __u8 bi=
s)
> +                                                       bdaddr_t *ba, __u=
8 bis)
>  {
>         struct hci_conn_hash *h =3D &hdev->conn_hash;
>         struct hci_conn  *c;
> @@ -1108,7 +1108,7 @@ static inline struct hci_conn *hci_conn_hash_lookup=
_bis(struct hci_dev *hdev,
>                 if (bacmp(&c->dst, ba) || c->type !=3D ISO_LINK)
>                         continue;
>
> -               if (c->iso_qos.bcast.big =3D=3D big && c->iso_qos.bcast.b=
is =3D=3D bis) {
> +               if (c->iso_qos.bcast.bis =3D=3D bis) {
>                         rcu_read_unlock();
>                         return c;
>                 }
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 7d4941e6dbdf..8cd2ef0ab1d0 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -927,9 +927,7 @@ static void bis_cleanup(struct hci_conn *conn)
>                 /* Check if ISO connection is a BIS and terminate adverti=
sing
>                  * set and BIG if there are no other connections using it=
.
>                  */
> -               bis =3D hci_conn_hash_lookup_bis(hdev, BDADDR_ANY,
> -                                              conn->iso_qos.bcast.big,
> -                                              conn->iso_qos.bcast.bis);
> +               bis =3D hci_conn_hash_lookup_big(hdev, conn->iso_qos.bcas=
t.big);
>                 if (bis)
>                         return;
>
> @@ -1449,25 +1447,23 @@ static int hci_explicit_conn_params_set(struct hc=
i_dev *hdev,
>
>  static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
>  {
> -       struct iso_list_data data;
> +       struct hci_conn *conn;
> +       u8  big;
>
>         /* Allocate a BIG if not set */
>         if (qos->bcast.big =3D=3D BT_ISO_QOS_BIG_UNSET) {
> -               for (data.big =3D 0x00; data.big < 0xef; data.big++) {
> -                       data.count =3D 0;
> -                       data.bis =3D 0xff;
> +               for (big =3D 0x00; big < 0xef; big++) {
>
> -                       hci_conn_hash_list_state(hdev, bis_list, ISO_LINK=
,
> -                                                BT_BOUND, &data);
> -                       if (!data.count)
> +                       conn =3D hci_conn_hash_lookup_big(hdev, big);
> +                       if (!conn)
>                                 break;
>                 }
>
> -               if (data.big =3D=3D 0xef)
> +               if (big =3D=3D 0xef)
>                         return -EADDRNOTAVAIL;
>
>                 /* Update BIG */
> -               qos->bcast.big =3D data.big;
> +               qos->bcast.big =3D big;
>         }
>
>         return 0;
> @@ -1475,28 +1471,27 @@ static int qos_set_big(struct hci_dev *hdev, stru=
ct bt_iso_qos *qos)
>
>  static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
>  {
> -       struct iso_list_data data;
> +       struct hci_conn *conn;
> +       u8  bis;
>
>         /* Allocate BIS if not set */
>         if (qos->bcast.bis =3D=3D BT_ISO_QOS_BIS_UNSET) {
>                 /* Find an unused adv set to advertise BIS, skip instance=
 0x00
>                  * since it is reserved as general purpose set.
>                  */
> -               for (data.bis =3D 0x01; data.bis < hdev->le_num_of_adv_se=
ts;
> -                    data.bis++) {
> -                       data.count =3D 0;
> +               for (bis =3D 0x01; bis < hdev->le_num_of_adv_sets;
> +                    bis++) {
>
> -                       hci_conn_hash_list_state(hdev, bis_list, ISO_LINK=
,
> -                                                BT_BOUND, &data);
> -                       if (!data.count)
> +                       conn =3D hci_conn_hash_lookup_bis(hdev, BDADDR_AN=
Y, bis);
> +                       if (!conn)
>                                 break;
>                 }
>
> -               if (data.bis =3D=3D hdev->le_num_of_adv_sets)
> +               if (bis =3D=3D hdev->le_num_of_adv_sets)
>                         return -EADDRNOTAVAIL;
>
>                 /* Update BIS */
> -               qos->bcast.bis =3D data.bis;
> +               qos->bcast.bis =3D bis;
>         }
>
>         return 0;
> @@ -1534,8 +1529,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev =
*hdev, bdaddr_t *dst,
>         /* Check BIS settings against other bound BISes, since all
>          * BISes in a BIG must have the same value for all parameters
>          */
> -       conn =3D hci_conn_hash_lookup_bis(hdev, dst, qos->bcast.big,
> -                                       qos->bcast.bis);
> +       conn =3D hci_conn_hash_lookup_big(hdev, qos->bcast.big);
>
>         if (conn && (memcmp(qos, &conn->iso_qos, sizeof(*qos)) ||
>                      base_len !=3D conn->le_per_adv_data_len ||
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 7c199f7361f7..45525963e932 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3938,24 +3938,44 @@ static u8 hci_cc_le_set_per_adv_enable(struct hci=
_dev *hdev, void *data,
>                                        struct sk_buff *skb)
>  {
>         struct hci_ev_status *rp =3D data;
> -       __u8 *sent;
> +       struct hci_cp_le_set_per_adv_enable *cp;
> +       struct adv_info *adv =3D NULL, *n;
>
>         bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
>
>         if (rp->status)
>                 return rp->status;
>
> -       sent =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE);
> -       if (!sent)
> +       cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE);
> +       if (!cp)
>                 return rp->status;
>
>         hci_dev_lock(hdev);
>
> -       if (*sent)
> +       adv =3D hci_find_adv_instance(hdev, cp->handle);
> +
> +       if (cp->enable) {
>                 hci_dev_set_flag(hdev, HCI_LE_PER_ADV);
> -       else
> +
> +               if (adv)
> +                       adv->per_enabled =3D true;
> +       } else {
> +               if (adv)
> +                       adv->per_enabled =3D false;
> +
> +               /* If just one instance was disabled check if there are
> +                * any other instance enabled before clearing HCI_LE_PER_=
ADV
> +                */
> +               list_for_each_entry_safe(adv, n, &hdev->adv_instances,
> +                                        list) {
> +                       if (adv->per_enabled)
> +                               goto unlock;
> +               }
> +
>                 hci_dev_clear_flag(hdev, HCI_LE_PER_ADV);
> +       }
>
> +unlock:
>         hci_dev_unlock(hdev);
>
>         return rp->status;
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 97da5bcaa904..2fd7ab377d30 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3,6 +3,7 @@
>   * BlueZ - Bluetooth protocol stack for Linux
>   *
>   * Copyright (C) 2021 Intel Corporation
> + * Copyright 2023 NXP
>   */
>
>  #include <linux/property.h>
> @@ -1319,9 +1320,11 @@ int hci_start_ext_adv_sync(struct hci_dev *hdev, u=
8 instance)
>  static int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 ins=
tance)
>  {
>         struct hci_cp_le_set_per_adv_enable cp;
> +       struct adv_info *adv =3D NULL;
>
>         /* If periodic advertising already disabled there is nothing to d=
o. */
> -       if (!hci_dev_test_flag(hdev, HCI_LE_PER_ADV))
> +       adv =3D hci_find_adv_instance(hdev, instance);
> +       if (!adv || !adv->per_enabled)
>                 return 0;
>
>         memset(&cp, 0, sizeof(cp));
> @@ -1386,9 +1389,11 @@ static int hci_set_per_adv_data_sync(struct hci_de=
v *hdev, u8 instance)
>  static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 inst=
ance)
>  {
>         struct hci_cp_le_set_per_adv_enable cp;
> +       struct adv_info *adv =3D NULL;
>
>         /* If periodic advertising already enabled there is nothing to do=
. */
> -       if (hci_dev_test_flag(hdev, HCI_LE_PER_ADV))
> +       adv =3D hci_find_adv_instance(hdev, instance);
> +       if (adv && adv->per_enabled)
>                 return 0;
>
>         memset(&cp, 0, sizeof(cp));
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
