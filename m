Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAB3C432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 17:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB7160F91
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 17:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhH3RpU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhH3RpT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 13:45:19 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17637C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 10:44:26 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id e9so11169508vst.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M1iiWDiS6rWnUGFTokuDjsDdVpcx8ZpH26wHAJLvLsA=;
        b=k3GN9sOF+Eirx++Voh9WjePlMOIZnaEzXwa0T1qh+LddztLIK0otbxh3bU8vMgSU0y
         FbUJXcxDVo6qRF6GHyTb2VD4xjO1Fx655a6KuPkLLDoqsShzVN6Y7MtmSaCL+CJ0H+Xu
         VRJtppvC1vhIQrdz8Xg14NabScNj6GrKFcLt7K4Xl3ZUTobks4uMjDfY6BqMSNQFNduY
         jytp3Sb58W0SssdAqsIGwBgAJnshkTfmT45oFi4fHwAby/7JWSuX93wbA/y8zD18IJ42
         j3g9XlBXxTktpNa+x61yS8kidMMiUN0SVx/5yx08WezwM6JSkaVFJkn1SQ2cZiTv9Rqi
         iwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M1iiWDiS6rWnUGFTokuDjsDdVpcx8ZpH26wHAJLvLsA=;
        b=rOtnQnePzXxKebhVuYOoydxhfWpjiasl7khSHb8PGT9OcjogGP9C/usqYGVsN6Y3GC
         bGXYyerM4d3vCInbvnNWKmM4BOrm/H1HZz+rHq+Jjbk+puomEiVEL9vbW2ewVCSXbJWi
         sxFGFJ+45xy3mZqTbFZCIHL6IPBAvzexsUox2gjN7JU5MNIcKKgEJBAmlUwwZI+0y5d1
         ld1bjJJTuuAihdb67crOTHc9XeXkeqSPYkiEWlEX21ufPFDDCjxnRpGxSJpeIz54Tse/
         nhawalPb+8j5b6BxOnemKh3YSyxLnZmc/0fPENas9ACO7O8ittKEgOeDKK5e3OME3OoP
         P8pw==
X-Gm-Message-State: AOAM5310/FNmQMWfXCJ0g9owQifc6KZsLeGhJy1L40pX9IhdjuPqaOdd
        GBe8wfPqQbXwfQ2Xf15DiHc7YimFy8uIRIBm+hTIzQmI
X-Google-Smtp-Source: ABdhPJx6eYN9TjfDrhB1xkBR/etjyBjFJy56jgVWK+O7B/oDtafv7MaNXt3rcgHfRaIXguR73NpCWRm6r1bI4wgHFtg=
X-Received: by 2002:a67:ebcc:: with SMTP id y12mr10826191vso.18.1630345465058;
 Mon, 30 Aug 2021 10:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210827165332.1562474-1-luiz.dentz@gmail.com> <93F5BEBD-E11E-46F4-BB96-DF7F7C6C9361@holtmann.org>
In-Reply-To: <93F5BEBD-E11E-46F4-BB96-DF7F7C6C9361@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 30 Aug 2021 10:44:14 -0700
Message-ID: <CABBYNZJmRGBvQYSm-p4UaEPMRV8iG7jzWGZZo9R8USvf9YqpDg@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Fix using address type from events
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Aug 30, 2021 at 7:57 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > Address types ADDR_LE_DEV_PUBLIC_RESOLVED and
> > ADDR_LE_DEV_RANDOM_RESOLVED shall be converted to ADDR_LE_PUBLIC and
> > ADDR_LE_RANDOM repectively since they are not safe to be used beyond
> > the scope of the events themselves.
> >
> > Also don't connect using RPA as peer address when LL Privacy is
> > enabled since the controller will be resolving the addresses it should
> > be able to generate the RPA.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > net/bluetooth/hci_conn.c  | 10 +++++---
> > net/bluetooth/hci_core.c  |  9 -------
> > net/bluetooth/hci_event.c | 52 ++++++++++++++++++---------------------
> > 3 files changed, 30 insertions(+), 41 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index bdaa64cb2f3a..28f23654b8a6 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1087,10 +1087,12 @@ struct hci_conn *hci_connect_le(struct hci_dev =
*hdev, bdaddr_t *dst,
> >        * be resolved back into the original identity address
> >        * from the connect request.
> >        */
> > -     irk =3D hci_find_irk_by_addr(hdev, dst, dst_type);
> > -     if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
> > -             dst =3D &irk->rpa;
> > -             dst_type =3D ADDR_LE_DEV_RANDOM;
> > +     if (!hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
>
> I do not understand this pre-caution with HCI_LL_RPA_RESOLUTION. What is =
this for?

At least with Intel controllers I could not reconnect if we keep using
the RPA when the IRK has been added to the resolving list, I suspect
it may be a bug in the firmware but in the other hand it may not be
necessary to use the original RPA as the controller has the IRK as
well it can generate the RPA before connecting.

> > +             irk =3D hci_find_irk_by_addr(hdev, dst, dst_type);
> > +             if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
> > +                     dst =3D &irk->rpa;
> > +                     dst_type =3D ADDR_LE_DEV_RANDOM;
> > +             }
> >       }
> >
> >       if (conn) {
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 6ab0ff3cd4bc..e83a3accfc33 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3562,15 +3562,6 @@ struct hci_conn_params *hci_pend_le_action_looku=
p(struct list_head *list,
> > {
> >       struct hci_conn_params *param;
> >
> > -     switch (addr_type) {
> > -     case ADDR_LE_DEV_PUBLIC_RESOLVED:
> > -             addr_type =3D ADDR_LE_DEV_PUBLIC;
> > -             break;
> > -     case ADDR_LE_DEV_RANDOM_RESOLVED:
> > -             addr_type =3D ADDR_LE_DEV_RANDOM;
> > -             break;
> > -     }
> > -
> >       list_for_each_entry(param, list, action) {
> >               if (bacmp(&param->addr, addr) =3D=3D 0 &&
> >                   param->addr_type =3D=3D addr_type)
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 24d0773b861a..028cdf7ef075 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2411,6 +2411,24 @@ static void hci_cs_disconnect(struct hci_dev *hd=
ev, u8 status)
> >       hci_dev_unlock(hdev);
> > }
> >
> > +static u8 ev_bdaddr_type(struct hci_dev *hdev, u8 type)
> > +{
> > +     /* When using controller based address resolution, then the new
> > +      * address types 0x02 and 0x03 are used. These types need to be
> > +      * converted back into either public address or random address ty=
pe
> > +      */
> > +     if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
> > +             switch (type) {
> > +             case ADDR_LE_DEV_PUBLIC_RESOLVED:
> > +                     return ADDR_LE_DEV_PUBLIC;
> > +             case ADDR_LE_DEV_RANDOM_RESOLVED:
> > +                     return ADDR_LE_DEV_RANDOM;
> > +             }
> > +     }
> > +
>
> The check for HCI_LL_RPA_RESOLUTION makes no sense to me. It is always sa=
fe to convert addr_type 0x02 and 0x03. You really only see them if resolvin=
g list usage is active.

I will remove it, it was part of the original code but you are right
we should convert these types regardless.

> > +     return type;
> > +}
> > +
> > static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr=
,
> >                             u8 peer_addr_type, u8 own_address_type,
> >                             u8 filter_policy)
> > @@ -2422,20 +2440,7 @@ static void cs_le_create_conn(struct hci_dev *hd=
ev, bdaddr_t *peer_addr,
> >       if (!conn)
> >               return;
> >
> > -     /* When using controller based address resolution, then the new
> > -      * address types 0x02 and 0x03 are used. These types need to be
> > -      * converted back into either public address or random address ty=
pe
> > -      */
> > -     if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
> > -             switch (own_address_type) {
> > -             case ADDR_LE_DEV_PUBLIC_RESOLVED:
> > -                     own_address_type =3D ADDR_LE_DEV_PUBLIC;
> > -                     break;
> > -             case ADDR_LE_DEV_RANDOM_RESOLVED:
> > -                     own_address_type =3D ADDR_LE_DEV_RANDOM;
> > -                     break;
> > -             }
> > -     }
> > +     own_address_type =3D ev_bdaddr_type(hdev, own_address_type);
> >
> >       /* Store the initiator and responder address information which
> >        * is needed for SMP. These values will not change during the
> > @@ -5333,20 +5338,7 @@ static void le_conn_complete_evt(struct hci_dev =
*hdev, u8 status,
> >               conn->dst_type =3D irk->addr_type;
> >       }
> >
> > -     /* When using controller based address resolution, then the new
> > -      * address types 0x02 and 0x03 are used. These types need to be
> > -      * converted back into either public address or random address ty=
pe
> > -      */
> > -     if (hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
> > -             switch (conn->dst_type) {
> > -             case ADDR_LE_DEV_PUBLIC_RESOLVED:
> > -                     conn->dst_type =3D ADDR_LE_DEV_PUBLIC;
> > -                     break;
> > -             case ADDR_LE_DEV_RANDOM_RESOLVED:
> > -                     conn->dst_type =3D ADDR_LE_DEV_RANDOM;
> > -                     break;
> > -             }
> > -     }
> > +     conn->dst_type =3D ev_bdaddr_type(hdev, conn->dst_type);
> >
>
> I see, it comes from the original code.
>
> Frankly, I fail to see why any of these checks are needed. When we get th=
at value, we need to convert it. So we better remove these pointless checks=
 unless someone tells me the reason for it. Greping through the code seems =
we have even more and even more complex ones.

Yep, I tried making all of them use the same function so 0x02 and 0x03
are never passed around without being converted first.

> >       if (status) {
> >               hci_le_conn_failed(conn, status);
> > @@ -5663,6 +5655,8 @@ static void process_adv_report(struct hci_dev *hd=
ev, u8 type, bdaddr_t *bdaddr,
> >        * controller address.
> >        */
> >       if (direct_addr) {
> > +             direct_addr_type =3D ev_bdaddr_type(hdev, direct_addr_typ=
e);
> > +
> >               /* Only resolvable random addresses are valid for these
> >                * kind of reports and others can be ignored.
> >                */
> > @@ -5690,6 +5684,8 @@ static void process_adv_report(struct hci_dev *hd=
ev, u8 type, bdaddr_t *bdaddr,
> >               bdaddr_type =3D irk->addr_type;
> >       }
> >
> > +     bdaddr_type =3D ev_bdaddr_type(hdev, bdaddr_type);
> > +
> >       /* Check if we have been requested to connect to this device.
> >        *
> >        * direct_addr is set only for directed advertising reports (it i=
s NULL
>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
