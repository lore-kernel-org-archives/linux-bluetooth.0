Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA44EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 22:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFUWXY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 18:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFUWXV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 18:23:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952241BC3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 15:23:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b45d7ec066so393591fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687386196; x=1689978196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU/ToE7IwtJ/Hp/ImDBQG+BLsQ83/1QiQzobQTg9734=;
        b=G1E/8xtM4CCRqXif3ymKIne6voHEw4rSVMuuspCuSNxdCKtA0Ngk2uU6jt4ISYkflX
         ZMI2w1elaq/EW/Z5dWRzEdNuUPafurumCOSM4R+zkAKwk0eA5zUwQZRdJK47vgbrAAt2
         wRV3uUyExq8PyCnx+lq6aY552PN+kJ9y4SAcnarCKN5uuNfhK8vPqwj8QgZ/Y+YY1gkX
         fqSSvKWwAA1IaKBWC3Srj73h8ldd5TDRO9dBm5ACFMo4fgsZyRD2ATk8AXblbvB4oegM
         WloLp+ppohMiFchrQAyNES9mmOZz3qJUmIEQMSh+vARWxBbWMDu3cUOjvDi7KjuC5LMC
         259Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687386196; x=1689978196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU/ToE7IwtJ/Hp/ImDBQG+BLsQ83/1QiQzobQTg9734=;
        b=HMVWAf1zk9Gpe04hAhw/8pLd8GkT28kptMJYgxpiFtZJVDyBRa9ivfz8SJeGvo2t83
         sp1lrVes97S19a5Fy9tDGr91TnhCrZd/qai9Bw1KHXLJVPhb2/IxpCIV89Ckk3nMEwWt
         2yKhTwzEAOrx3na/muAQUZg5UHRpwfWjJYdSUPaO5DpY6rrGLXApdUavvuB48+mpQcrL
         laQDeNn3Z2Jbsd1zuTs+jfqRY5+1h+jOTUBEtSwhoFDdLmVN/i327akfguaokkrbsSXJ
         OlcnV03WMwIdZQ3Ghpe5pB5EiQlYl+0IVxXigXmlD1tTrnN5T/jVIBS6PS8gLBOdivE0
         0Caw==
X-Gm-Message-State: AC+VfDyszOI2ShCLi/1WPhLMWFWaTO1dUwXM3J72QPK0i3Xqk5l43c9X
        jzdVrtQsaVSxaNYSvIiCUkZlZ3KoEvYFztwymQ5zob4/tUc=
X-Google-Smtp-Source: ACHHUZ4COKtL/HuPFr/gpKVDg0mkkQv+mx00oGAzo5xOInaO/aeMEGI3Y3G6c9PBhsLhEC/NUpm9f7jevEJtXJ5NCX4=
X-Received: by 2002:a2e:b5ad:0:b0:2b4:6da8:e83b with SMTP id
 f13-20020a2eb5ad000000b002b46da8e83bmr4222525ljn.23.1687386195433; Wed, 21
 Jun 2023 15:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230621195407.977001-1-luiz.dentz@gmail.com> <66add9bf780aca773d41cce3ea42589388de2543.camel@iki.fi>
 <CABBYNZ+nGaeGmiAdneF7UEwG0Q8D6Bi1mnGOY66HcM5JwE1hiw@mail.gmail.com> <2990d0d245e76864854495cfdab1731c54dfabfb.camel@iki.fi>
In-Reply-To: <2990d0d245e76864854495cfdab1731c54dfabfb.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 21 Jun 2023 15:23:02 -0700
Message-ID: <CABBYNZ+ma8cM9-TV9c+COBNNCmxh9TGzh861SB1kVsxwOQNeSA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Fix parsing of CIS Established Event
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Wed, Jun 21, 2023 at 2:46=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2023-06-21 kello 14:12 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Wed, Jun 21, 2023 at 1:33=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Hi Luiz,
> > >
> > > ke, 2023-06-21 kello 12:54 -0700, Luiz Augusto von Dentz kirjoitti:
> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > >
> > > > The ISO Interval on CIS Established Event uses 1.25 ms slots:
> > > >
> > > >     BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> > > >     page 2304:
> > > >
> > > >       Time =3D N * 1.25 ms
> > > >
> > > > In addition to that this always update the QoS settings based on CI=
S
> > > > Established Event.
> > > >
> > > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > ---
> > > >  net/bluetooth/hci_event.c | 36 +++++++++++++++++++++++------------=
-
> > > >  1 file changed, 23 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > > index b1aefe4bb751..6fca6d9f1b34 100644
> > > > --- a/net/bluetooth/hci_event.c
> > > > +++ b/net/bluetooth/hci_event.c
> > > > @@ -6822,6 +6822,7 @@ static void hci_le_cis_estabilished_evt(struc=
t hci_dev *hdev, void *data,
> > > >  {
> > > >       struct hci_evt_le_cis_established *ev =3D data;
> > > >       struct hci_conn *conn;
> > > > +     struct bt_iso_qos *qos;
> > > >       bool pending =3D false;
> > > >       u16 handle =3D __le16_to_cpu(ev->handle);
> > > >
> > > > @@ -6846,21 +6847,30 @@ static void hci_le_cis_estabilished_evt(str=
uct hci_dev *hdev, void *data,
> > > >
> > > >       pending =3D test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->fl=
ags);
> > > >
> > > > -     if (conn->role =3D=3D HCI_ROLE_SLAVE) {
> > > > -             __le32 interval;
> > > > +     qos =3D &conn->iso_qos;
> > > >
> > > > -             memset(&interval, 0, sizeof(interval));
> > > > +     /* Convert ISO Interval (1.25 ms slots) to latency (ms) */
> > > > +     qos->ucast.in.latency =3D le16_to_cpu(ev->interval) * 125 / 1=
00;
> > > > +     /* Convert ISO Interval (1.25 ms slots) to latency (ms) */
> > > > +     qos->ucast.out.latency =3D le16_to_cpu(ev->interval) * 125 / =
100;
> > > >
> > > > -             memcpy(&interval, ev->c_latency, sizeof(ev->c_latency=
));
> > > > -             conn->iso_qos.ucast.in.interval =3D le32_to_cpu(inter=
val);
> > > > -             memcpy(&interval, ev->p_latency, sizeof(ev->p_latency=
));
> > > > -             conn->iso_qos.ucast.out.interval =3D le32_to_cpu(inte=
rval);
> > > > -             conn->iso_qos.ucast.in.latency =3D le16_to_cpu(ev->in=
terval);
> > > > -             conn->iso_qos.ucast.out.latency =3D le16_to_cpu(ev->i=
nterval);
> > > > -             conn->iso_qos.ucast.in.sdu =3D le16_to_cpu(ev->c_mtu)=
;
> > > > -             conn->iso_qos.ucast.out.sdu =3D le16_to_cpu(ev->p_mtu=
);
> > > > -             conn->iso_qos.ucast.in.phy =3D ev->c_phy;
> > > > -             conn->iso_qos.ucast.out.phy =3D ev->p_phy;
> > > > +     switch (conn->role) {
> > > > +     case HCI_ROLE_SLAVE:
> > > > +             qos->ucast.in.interval =3D get_unaligned_le24(ev->c_l=
atency);
> > > > +             qos->ucast.out.interval =3D get_unaligned_le24(ev->p_=
latency);
> > > > +             qos->ucast.in.sdu =3D le16_to_cpu(ev->c_mtu);
> > > > +             qos->ucast.out.sdu =3D le16_to_cpu(ev->p_mtu);
> > > > +             qos->ucast.in.phy =3D ev->c_phy;
> > > > +             qos->ucast.out.phy =3D ev->p_phy;
> > > > +             break;
> > >
> > > Are the ucast.latency and ucast.interval the right way around here?
> > >
> > > When I trying to use this in userspace, I expected ucast.interval
> > > contains the ISO interval, because in Set CIG Parameters we use
> > > ucast.interval to specify the SDU_Interval, and ucast.latency is used
> > > for the Transport_Latency_C_To_P and Transport_Latency_P_To_C.
> > >
> > > With real numbers the event (AX210<->AX210) looks like this
> > >
> > > > HCI Event: LE Meta Event (0x3e) plen 29               #3493 [hci0] =
486.978955
> > >       LE Connected Isochronous Stream Established (0x19)
> > >         Status: Success (0x00)
> > >         Connection Handle: 2560
> > >         CIG Synchronization Delay: 4020 us (0x000fb4)
> > >         CIS Synchronization Delay: 4020 us (0x000fb4)
> > >         Central to Peripheral Latency: 94020 us (0x016f44)
> > >         Peripheral to Central Latency: 94020 us (0x016f44)
> >
> > No idea why these values look like this, they are not what I expect
> > which is to match what the Central configured with Set CIG Parameters.
>
> Core v5.3 Vol 6 Part G Sec 3.2.2 has the formulas
>
> Transport_Latency_C_To_P =3D CIG_Sync_Delay + FT_C_To_P *
> ISO_Interval - SDU_Interval_C_To_P
>
> Transport_Latency_P_To_C =3D CIG_Sync_Delay + FT_P_To_C *
> ISO_Interval - SDU_Interval_P_To_C
>
> for unframed so looks these come from there. Don't know how the sync
> delays are chosen.
>
> The Central in this case specified Max Transport Latency of 100ms (BAP
> QoS 48_4_2) so they satisfy it.

Ok, I was afraid we were not printing the right value but if the
transport latency is 100ms having ~94ms is not that far off.

> Userspace wants to know the exact values since they matter for the
> total audio latency (Transport_Latency + Presentation_Delay), see
> Figure 3.1 in Core v5.4 Vol 6 Part G pp 3073 and Sec 7 in BAP v1.0.1.
>
> This we need to know for eg. lip sync in video playback. (I have some
> problems getting the latency right with the Samsung device, though,
> needs more looking into as its smaller than the above
> Transport_Latencies.)
>
> > >         Central to Peripheral PHY: LE 2M (0x02)
> > >         Peripheral to Central PHY: LE 2M (0x02)
> > >         Number of Subevents: 2
> > >         Central to Peripheral Burst Number: 1
> > >         Peripheral to Central Burst Number: 1
> > >         Central to Peripheral Flush Timeout: 10
> > >         Peripheral to Central Flush Timeout: 10
> > >         Central to Peripheral MTU: 240
> > >         Peripheral to Central MTU: 120
> > >         ISO Interval: 8
> >
> > These seems to be fine, so I wonder what is going on with CIS
> > Established event, this is what we are doing in the emulator:
> >
> >         /* TODO: Figure out if these values makes sense */
> >         memcpy(evt.cig_sync_delay, le_cig->params.c_interval,
> >                 sizeof(le_cig->params.c_interval));
> >         memcpy(evt.cis_sync_delay, le_cig->params.p_interval,
> >                 sizeof(le_cig->params.p_interval));
> >         memcpy(evt.c_latency, &le_cig->params.c_interval,
> >                 sizeof(le_cig->params.c_interval));
> >         memcpy(evt.p_latency, &le_cig->params.p_interval,
> >                 sizeof(le_cig->params.p_interval));
> >         evt.c_phy =3D le_cig->cis[cis_idx].c_phy;
> >         evt.p_phy =3D le_cig->cis[cis_idx].p_phy;
> >         evt.nse =3D 0x01;
> >         evt.c_bn =3D 0x01;
> >         evt.p_bn =3D 0x01;
> >         evt.c_ft =3D 0x01;
> >         evt.p_ft =3D 0x01;
> >         evt.c_mtu =3D le_cig->cis[cis_idx].c_sdu;
> >         evt.p_mtu =3D le_cig->cis[cis_idx].p_sdu;
> >         evt.interval =3D (le_cig->params.c_latency + 1) / 1.25;
>
> These probably assume zero sync delay in the formulas above.

Yep, we probably need to start using the formula that you pasted to
make sure they are in sync, that said I'd like to keep the QoS the
same so we don't have to change them in iso-test so we will probably
need to tune then to match exactly the suggested QoS even though in
real controllers they might be a little off.

>
> >
> > >
> > > > +     case HCI_ROLE_MASTER:
> > > > +             qos->ucast.out.interval =3D get_unaligned_le24(ev->c_=
latency);
> > > > +             qos->ucast.in.interval =3D get_unaligned_le24(ev->p_l=
atency);
> > > > +             qos->ucast.out.sdu =3D le16_to_cpu(ev->c_mtu);
> > > > +             qos->ucast.in.sdu =3D le16_to_cpu(ev->p_mtu);
> > > > +             qos->ucast.out.phy =3D ev->c_phy;
> > > > +             qos->ucast.in.phy =3D ev->p_phy;
> > > > +             break;
> > > >       }
> > > >
> > > >       if (!ev->status) {
> > >
> > > --
> > > Pauli Virtanen
> >
> >
> >
>


--=20
Luiz Augusto von Dentz
