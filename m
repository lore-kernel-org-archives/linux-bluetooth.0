Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E073CEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 21:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFUVqR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjFUVqQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 17:46:16 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326379B
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 14:46:14 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 634D5240027
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 23:46:11 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmcWk650Hz9rxL;
        Wed, 21 Jun 2023 23:46:10 +0200 (CEST)
Message-ID: <2990d0d245e76864854495cfdab1731c54dfabfb.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Fix parsing of CIS Established
 Event
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 21 Jun 2023 21:46:10 +0000
In-Reply-To: <CABBYNZ+nGaeGmiAdneF7UEwG0Q8D6Bi1mnGOY66HcM5JwE1hiw@mail.gmail.com>
References: <20230621195407.977001-1-luiz.dentz@gmail.com>
         <66add9bf780aca773d41cce3ea42589388de2543.camel@iki.fi>
         <CABBYNZ+nGaeGmiAdneF7UEwG0Q8D6Bi1mnGOY66HcM5JwE1hiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ke, 2023-06-21 kello 14:12 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Wed, Jun 21, 2023 at 1:33 PM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Hi Luiz,
> > 
> > ke, 2023-06-21 kello 12:54 -0700, Luiz Augusto von Dentz kirjoitti:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > 
> > > The ISO Interval on CIS Established Event uses 1.25 ms slots:
> > > 
> > >     BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> > >     page 2304:
> > > 
> > >       Time = N * 1.25 ms
> > > 
> > > In addition to that this always update the QoS settings based on CIS
> > > Established Event.
> > > 
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  net/bluetooth/hci_event.c | 36 +++++++++++++++++++++++-------------
> > >  1 file changed, 23 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index b1aefe4bb751..6fca6d9f1b34 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -6822,6 +6822,7 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
> > >  {
> > >       struct hci_evt_le_cis_established *ev = data;
> > >       struct hci_conn *conn;
> > > +     struct bt_iso_qos *qos;
> > >       bool pending = false;
> > >       u16 handle = __le16_to_cpu(ev->handle);
> > > 
> > > @@ -6846,21 +6847,30 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
> > > 
> > >       pending = test_and_clear_bit(HCI_CONN_CREATE_CIS, &conn->flags);
> > > 
> > > -     if (conn->role == HCI_ROLE_SLAVE) {
> > > -             __le32 interval;
> > > +     qos = &conn->iso_qos;
> > > 
> > > -             memset(&interval, 0, sizeof(interval));
> > > +     /* Convert ISO Interval (1.25 ms slots) to latency (ms) */
> > > +     qos->ucast.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
> > > +     /* Convert ISO Interval (1.25 ms slots) to latency (ms) */
> > > +     qos->ucast.out.latency = le16_to_cpu(ev->interval) * 125 / 100;
> > > 
> > > -             memcpy(&interval, ev->c_latency, sizeof(ev->c_latency));
> > > -             conn->iso_qos.ucast.in.interval = le32_to_cpu(interval);
> > > -             memcpy(&interval, ev->p_latency, sizeof(ev->p_latency));
> > > -             conn->iso_qos.ucast.out.interval = le32_to_cpu(interval);
> > > -             conn->iso_qos.ucast.in.latency = le16_to_cpu(ev->interval);
> > > -             conn->iso_qos.ucast.out.latency = le16_to_cpu(ev->interval);
> > > -             conn->iso_qos.ucast.in.sdu = le16_to_cpu(ev->c_mtu);
> > > -             conn->iso_qos.ucast.out.sdu = le16_to_cpu(ev->p_mtu);
> > > -             conn->iso_qos.ucast.in.phy = ev->c_phy;
> > > -             conn->iso_qos.ucast.out.phy = ev->p_phy;
> > > +     switch (conn->role) {
> > > +     case HCI_ROLE_SLAVE:
> > > +             qos->ucast.in.interval = get_unaligned_le24(ev->c_latency);
> > > +             qos->ucast.out.interval = get_unaligned_le24(ev->p_latency);
> > > +             qos->ucast.in.sdu = le16_to_cpu(ev->c_mtu);
> > > +             qos->ucast.out.sdu = le16_to_cpu(ev->p_mtu);
> > > +             qos->ucast.in.phy = ev->c_phy;
> > > +             qos->ucast.out.phy = ev->p_phy;
> > > +             break;
> > 
> > Are the ucast.latency and ucast.interval the right way around here?
> > 
> > When I trying to use this in userspace, I expected ucast.interval
> > contains the ISO interval, because in Set CIG Parameters we use
> > ucast.interval to specify the SDU_Interval, and ucast.latency is used
> > for the Transport_Latency_C_To_P and Transport_Latency_P_To_C.
> > 
> > With real numbers the event (AX210<->AX210) looks like this
> > 
> > > HCI Event: LE Meta Event (0x3e) plen 29               #3493 [hci0] 486.978955
> >       LE Connected Isochronous Stream Established (0x19)
> >         Status: Success (0x00)
> >         Connection Handle: 2560
> >         CIG Synchronization Delay: 4020 us (0x000fb4)
> >         CIS Synchronization Delay: 4020 us (0x000fb4)
> >         Central to Peripheral Latency: 94020 us (0x016f44)
> >         Peripheral to Central Latency: 94020 us (0x016f44)
> 
> No idea why these values look like this, they are not what I expect
> which is to match what the Central configured with Set CIG Parameters.

Core v5.3 Vol 6 Part G Sec 3.2.2 has the formulas

Transport_Latency_C_To_P = CIG_Sync_Delay + FT_C_To_P *
ISO_Interval - SDU_Interval_C_To_P

Transport_Latency_P_To_C = CIG_Sync_Delay + FT_P_To_C *
ISO_Interval - SDU_Interval_P_To_C

for unframed so looks these come from there. Don't know how the sync
delays are chosen.

The Central in this case specified Max Transport Latency of 100ms (BAP
QoS 48_4_2) so they satisfy it.

Userspace wants to know the exact values since they matter for the
total audio latency (Transport_Latency + Presentation_Delay), see
Figure 3.1 in Core v5.4 Vol 6 Part G pp 3073 and Sec 7 in BAP v1.0.1. 

This we need to know for eg. lip sync in video playback. (I have some
problems getting the latency right with the Samsung device, though,
needs more looking into as its smaller than the above
Transport_Latencies.)

> >         Central to Peripheral PHY: LE 2M (0x02)
> >         Peripheral to Central PHY: LE 2M (0x02)
> >         Number of Subevents: 2
> >         Central to Peripheral Burst Number: 1
> >         Peripheral to Central Burst Number: 1
> >         Central to Peripheral Flush Timeout: 10
> >         Peripheral to Central Flush Timeout: 10
> >         Central to Peripheral MTU: 240
> >         Peripheral to Central MTU: 120
> >         ISO Interval: 8
> 
> These seems to be fine, so I wonder what is going on with CIS
> Established event, this is what we are doing in the emulator:
> 
>         /* TODO: Figure out if these values makes sense */
>         memcpy(evt.cig_sync_delay, le_cig->params.c_interval,
>                 sizeof(le_cig->params.c_interval));
>         memcpy(evt.cis_sync_delay, le_cig->params.p_interval,
>                 sizeof(le_cig->params.p_interval));
>         memcpy(evt.c_latency, &le_cig->params.c_interval,
>                 sizeof(le_cig->params.c_interval));
>         memcpy(evt.p_latency, &le_cig->params.p_interval,
>                 sizeof(le_cig->params.p_interval));
>         evt.c_phy = le_cig->cis[cis_idx].c_phy;
>         evt.p_phy = le_cig->cis[cis_idx].p_phy;
>         evt.nse = 0x01;
>         evt.c_bn = 0x01;
>         evt.p_bn = 0x01;
>         evt.c_ft = 0x01;
>         evt.p_ft = 0x01;
>         evt.c_mtu = le_cig->cis[cis_idx].c_sdu;
>         evt.p_mtu = le_cig->cis[cis_idx].p_sdu;
>         evt.interval = (le_cig->params.c_latency + 1) / 1.25;

These probably assume zero sync delay in the formulas above.

> 
> > 
> > > +     case HCI_ROLE_MASTER:
> > > +             qos->ucast.out.interval = get_unaligned_le24(ev->c_latency);
> > > +             qos->ucast.in.interval = get_unaligned_le24(ev->p_latency);
> > > +             qos->ucast.out.sdu = le16_to_cpu(ev->c_mtu);
> > > +             qos->ucast.in.sdu = le16_to_cpu(ev->p_mtu);
> > > +             qos->ucast.out.phy = ev->c_phy;
> > > +             qos->ucast.in.phy = ev->p_phy;
> > > +             break;
> > >       }
> > > 
> > >       if (!ev->status) {
> > 
> > --
> > Pauli Virtanen
> 
> 
> 

