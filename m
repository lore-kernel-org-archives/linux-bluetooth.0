Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3103FEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 19:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFWT7U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjFWT7T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 15:59:19 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE510F1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 12:59:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b46a06c553so17865701fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 12:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687550356; x=1690142356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA0Sbq2WMM0K/aJPj+pPdtOTKBc+g4pdC/TXhmCdsM4=;
        b=emV6gxyUFmMe7EjsAdn1iXFz/SOHluLOyiBbAT/feXoY6hSOPB+WZAxdlW4sT78grA
         5ty7/P9+g3w9LOHww0G8xMGtWHWxWJ5+YKG6WZUSZqzv7Yx0AYlfPde/b4xcMZtME5u+
         xpn+lvyw7pksngqq8dHo78rerVqNLZAimSpBUunZ2aUUxEE9klu7/eIALfFmYUltFiYk
         cNVKwhx2/+hStdhSmpTctXsgFgPTkWuec1Cisdc2ZoQ91AtuiSMZM0kQxOodFgtsNj/4
         PPVZddiLUq6ArByhig39svq4bLmNdO/UxjDC74npomOz4XB0wd2Ff2iUFCy2Khnws0eQ
         DYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687550356; x=1690142356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA0Sbq2WMM0K/aJPj+pPdtOTKBc+g4pdC/TXhmCdsM4=;
        b=ib2Q3e0m+nuexCmZq2x4YlQoHo8x2euoUU7RjrihdXcG4pEitHJLDzyVZkpFE/VUTE
         GrHe7G8bVOlTayGDunpglrcmvIzw8gNMQzrc6CZ8ozBAmaXXuYqoGyrpS7I9RYzJ1+J0
         RxLz0g+MhOHfy5/b5g4KrM3bgfCP2UFYQwDVPNDeBQksbxIXC9CVMuYczARqvWKPkwG6
         X0bVh6dpTkufDIqExq5Kkj7tpmNZhwdSeFq8TwZL+mT1jG0RSdIOXVMVK+3sxHHTBwXl
         74//15a0UbFMXOxw6yT+YJhjBSYkHkP5wUyoNEaq9tZ2/bnh02lbjoHmgnW2Emk31L7S
         YZdg==
X-Gm-Message-State: AC+VfDwbikhQ7slyYGD+YbBHwUxA/ONdr5lswQrVpzVesy72EpbKXyUD
        7u/QDsd3AuTkIZ2AQIM6Nis/vNDIWBaq6IDw2jM=
X-Google-Smtp-Source: ACHHUZ4/0u9ucKBUBaEp/vaeDmEEsSJZg1uqkDvOcJLG970LO2nPH7y3y6UWe6rj8wCKWlzZN1PCQwrkZo1oj+OuOrU=
X-Received: by 2002:a2e:9593:0:b0:2b5:9bf9:b1c5 with SMTP id
 w19-20020a2e9593000000b002b59bf9b1c5mr1632413ljh.8.1687550355554; Fri, 23 Jun
 2023 12:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230622192722.1248374-1-luiz.dentz@gmail.com> <512cf6a2dd110bf634e391f92aa613ca44a7a756.camel@iki.fi>
In-Reply-To: <512cf6a2dd110bf634e391f92aa613ca44a7a756.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 23 Jun 2023 12:59:03 -0700
Message-ID: <CABBYNZ+9bP15aOu9Us9g3cC98Y_GidLnTJS-Y0fUhV9WNdUjdQ@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_event: Fix parsing of CIS Established Event
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Fri, Jun 23, 2023 at 10:37=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> to, 2023-06-22 kello 12:27 -0700, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > The ISO Interval on CIS Established Event uses 1.25 ms slots:
> >
> >     BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> >     page 2304:
> >
> >       Time =3D N * 1.25 ms
> >
> > In addition to that this always update the QoS settings based on CIS
> > Established Event.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/hci_event.c | 36 +++++++++++++++++++++++-------------
> >  1 file changed, 23 insertions(+), 13 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index b1aefe4bb751..049aa7f6a7c5 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6822,6 +6822,7 @@ static void hci_le_cis_estabilished_evt(struct hc=
i_dev *hdev, void *data,
> >  {
> >       struct hci_evt_le_cis_established *ev =3D data;
> >       struct hci_conn *conn;
> > +     struct bt_iso_qos *qos;
> >       bool pending =3D false;
> >       u16 handle =3D __le16_to_cpu(ev->handle);
> >
> > @@ -6846,21 +6847,30 @@ static void hci_le_cis_estabilished_evt(struct =
hci_dev *hdev, void *data,
> >
> >       pending =3D test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags)=
;
> >
> > -     if (conn->role =3D=3D HCI_ROLE_SLAVE) {
> > -             __le32 interval;
> > +     qos =3D &conn->iso_qos;
> >
> > -             memset(&interval, 0, sizeof(interval));
> > +     /* Convert ISO Interval (1.25 ms slots) to latency (ms) */
> > +     qos->ucast.in.latency =3D DIV_ROUND_CLOSEST(le16_to_cpu(ev->inter=
val) *
> > +                                               125, 100);
> > +     qos->ucast.out.latency =3D qos->ucast.in.latency;
>
> In Set CIG Parameters:
> u16 ucast.latency =3D Max_Transport_Latency (ms)
> u32 ucast.interval =3D SDU_Interval (us)
>
> Here:
> u16 ucast.latency =3D ISO_Interval (ms)
> u32 ucast.interval =3D Transport_Latency (us)

Yeah, it sounds like we should keep the same logic as in Set CIG
Parameters, this event is sort of weird because it does change the
units for whatever reason, anyway I will swap these around so they are
the same, anyway with the latest code it does pass all the iso-tester
tests.

> Currently BlueZ seems to not account for this swapping of the meanings
> of the QoS fields, eg. in client/player.c it has
>
>     num =3D (qos.ucast.out.latency * 1000 / qos.ucast.out.interval);
>     ...
>     ts.it_value.tv_nsec =3D qos->ucast.out.latency * 1000000
>
> and writes num packets in each interval. In the AX210 example it seems
> this would give num =3D=3D 0. I guess this and other places that use thes=
e
> need to be updated.
>
> Since field meanings anyway change, would 1.25ms unit for the
> ISO_Interval be better than 1ms so user side doesn't need to know how
> kernel rounds the number and undo that to get the actual value?
>
> > -             memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
> > -             conn->iso_qos.ucast.in.interval =3D le32_to_cpu(interval)=
;
> > -             memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
> > -             conn->iso_qos.ucast.out.interval =3D le32_to_cpu(interval=
);
> > -             conn->iso_qos.ucast.in.latency =3D le16_to_cpu(ev->interv=
al);
> > -             conn->iso_qos.ucast.out.latency =3D le16_to_cpu(ev->inter=
val);
> > -             conn->iso_qos.ucast.in.sdu =3D le16_to_cpu(ev->c_mtu);
> > -             conn->iso_qos.ucast.out.sdu =3D le16_to_cpu(ev->p_mtu);
> > -             conn->iso_qos.ucast.in.phy =3D ev->c_phy;
> > -             conn->iso_qos.ucast.out.phy =3D ev->p_phy;
> > +     switch (conn->role) {
> > +     case HCI_ROLE_SLAVE:
> > +             qos->ucast.in.interval =3D get_unaligned_le24(ev->c_laten=
cy);
> > +             qos->ucast.out.interval =3D get_unaligned_le24(ev->p_late=
ncy);
> > +             qos->ucast.in.sdu =3D le16_to_cpu(ev->c_mtu);
> > +             qos->ucast.out.sdu =3D le16_to_cpu(ev->p_mtu);
> > +             qos->ucast.in.phy =3D ev->c_phy;
> > +             qos->ucast.out.phy =3D ev->p_phy;
> > +             break;
> > +     case HCI_ROLE_MASTER:
> > +             qos->ucast.out.interval =3D get_unaligned_le24(ev->c_late=
ncy);
> > +             qos->ucast.in.interval =3D get_unaligned_le24(ev->p_laten=
cy);
> > +             qos->ucast.out.sdu =3D le16_to_cpu(ev->c_mtu);
> > +             qos->ucast.in.sdu =3D le16_to_cpu(ev->p_mtu);
> > +             qos->ucast.out.phy =3D ev->c_phy;
> > +             qos->ucast.in.phy =3D ev->p_phy;
> > +             break;
> >       }
> >
> >       if (!ev->status) {
>


--=20
Luiz Augusto von Dentz
