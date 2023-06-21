Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A3EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 21:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFUVMf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFUVMe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 17:12:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167DA173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 14:12:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b470330145so65944601fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687381951; x=1689973951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlMcBZaHWpUuMcXRCbMJQDLR75NLdjYhdOlBeKzZGqQ=;
        b=pPe+zRXMKd0evvSMM6JtVAN9wlNcTeycEFw4FGtr22fDq6kiGgBTXUUuqnhhXntyQN
         rwD23M+AnUxM8HkHh/sERPD1bBVtKnCLq9+z6L3LkoTDT9Q7dLRvBs/5ZAWZEq4+aVPe
         E0AzRqUFEYGiVymycrO+PopUk4ifZB0bAh+9fhi7wNy/lKORfUvqOjcfHy6mpFrdL0Fs
         9s8HXOI6WLySFINn2A5n8uWP8yvSuMvWp6oYEmpJThmjx4O/AgNAQ1rN5RRIwYY3FMOz
         L0xcRYqNEEYNEO6gE7CvbKk+bg/GAHY2ybMaZ9e4uJoQOSCBBens5Ecr8J72CSRH/cE9
         M/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687381951; x=1689973951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlMcBZaHWpUuMcXRCbMJQDLR75NLdjYhdOlBeKzZGqQ=;
        b=duowNa7ivlsiPrIa/MlOE2VAVr3WHyVSsnoSgSm3CUmFKVx8U/20acRB831sc6hRmq
         MSrMNqZKDs/xpNkbgAo6wTPMsgBsFYbRHwnAHu7Jami5FQOZihN1tRpi5UdJHJ53hZeB
         GbIyGlhUa8PPL4tS0JbfKv5CXgaz6J865b0KhLC6N1FesSPhGp03TuLzVLPq2E9CyPB+
         SCU4arAQasv4Wyh/wdg+fAF6M68aIRMqGSolb21qKK128L0sjewBWfiWRw3N7jTMBVnx
         Fl821vwoFWicet4OES0+rZRcFxpKSZmeeSj4Td5EDzulEUUtYqn4p38f18oCXArxwWAg
         Dn5Q==
X-Gm-Message-State: AC+VfDxDEPg5jsdsWW97/GkXBMXDCO7657gvAUoKIFbQ9sJt9Cn7RQZB
        sA4ee9N7SLsxPLO+kEUHdjuO38alolEgfqteVZSzYNLXyNnQIw==
X-Google-Smtp-Source: ACHHUZ6nWHR6+T2ADBhBuidQM07icT4brq9/YFLdSiR2ZzWiUGLazdF6CuMIF6mVYd0hXK0JISJRH2mUO4lOyZ8Rmj0=
X-Received: by 2002:a2e:b0d4:0:b0:2b5:7b58:b9d0 with SMTP id
 g20-20020a2eb0d4000000b002b57b58b9d0mr3956100ljl.8.1687381950996; Wed, 21 Jun
 2023 14:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230621195407.977001-1-luiz.dentz@gmail.com> <66add9bf780aca773d41cce3ea42589388de2543.camel@iki.fi>
In-Reply-To: <66add9bf780aca773d41cce3ea42589388de2543.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 21 Jun 2023 14:12:18 -0700
Message-ID: <CABBYNZ+nGaeGmiAdneF7UEwG0Q8D6Bi1mnGOY66HcM5JwE1hiw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Fix parsing of CIS Established Event
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Jun 21, 2023 at 1:33=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2023-06-21 kello 12:54 -0700, Luiz Augusto von Dentz kirjoitti:
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
> > index b1aefe4bb751..6fca6d9f1b34 100644
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
> > +     qos->ucast.in.latency =3D le16_to_cpu(ev->interval) * 125 / 100;
> > +     /* Convert ISO Interval (1.25 ms slots) to latency (ms) */
> > +     qos->ucast.out.latency =3D le16_to_cpu(ev->interval) * 125 / 100;
> >
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
>
> Are the ucast.latency and ucast.interval the right way around here?
>
> When I trying to use this in userspace, I expected ucast.interval
> contains the ISO interval, because in Set CIG Parameters we use
> ucast.interval to specify the SDU_Interval, and ucast.latency is used
> for the Transport_Latency_C_To_P and Transport_Latency_P_To_C.
>
> With real numbers the event (AX210<->AX210) looks like this
>
> > HCI Event: LE Meta Event (0x3e) plen 29               #3493 [hci0] 486.=
978955
>       LE Connected Isochronous Stream Established (0x19)
>         Status: Success (0x00)
>         Connection Handle: 2560
>         CIG Synchronization Delay: 4020 us (0x000fb4)
>         CIS Synchronization Delay: 4020 us (0x000fb4)
>         Central to Peripheral Latency: 94020 us (0x016f44)
>         Peripheral to Central Latency: 94020 us (0x016f44)

No idea why these values look like this, they are not what I expect
which is to match what the Central configured with Set CIG Parameters.

>         Central to Peripheral PHY: LE 2M (0x02)
>         Peripheral to Central PHY: LE 2M (0x02)
>         Number of Subevents: 2
>         Central to Peripheral Burst Number: 1
>         Peripheral to Central Burst Number: 1
>         Central to Peripheral Flush Timeout: 10
>         Peripheral to Central Flush Timeout: 10
>         Central to Peripheral MTU: 240
>         Peripheral to Central MTU: 120
>         ISO Interval: 8

These seems to be fine, so I wonder what is going on with CIS
Established event, this is what we are doing in the emulator:

        /* TODO: Figure out if these values makes sense */
        memcpy(evt.cig_sync_delay, le_cig->params.c_interval,
                sizeof(le_cig->params.c_interval));
        memcpy(evt.cis_sync_delay, le_cig->params.p_interval,
                sizeof(le_cig->params.p_interval));
        memcpy(evt.c_latency, &le_cig->params.c_interval,
                sizeof(le_cig->params.c_interval));
        memcpy(evt.p_latency, &le_cig->params.p_interval,
                sizeof(le_cig->params.p_interval));
        evt.c_phy =3D le_cig->cis[cis_idx].c_phy;
        evt.p_phy =3D le_cig->cis[cis_idx].p_phy;
        evt.nse =3D 0x01;
        evt.c_bn =3D 0x01;
        evt.p_bn =3D 0x01;
        evt.c_ft =3D 0x01;
        evt.p_ft =3D 0x01;
        evt.c_mtu =3D le_cig->cis[cis_idx].c_sdu;
        evt.p_mtu =3D le_cig->cis[cis_idx].p_sdu;
        evt.interval =3D (le_cig->params.c_latency + 1) / 1.25;

>
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
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
