Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE285C7EE32
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 05:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCCFeI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Mar 2023 00:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCCFeH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Mar 2023 00:34:07 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BCF976B
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 21:34:05 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id h3so1194190lja.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 21:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8kx+4RDaTM8iOHE5Xvj0WZgHMWsSn2e14La0mXAFQM=;
        b=cuKN4TZyelwBKjdE+ljDNEktePIcKSyLJ7FRdP3feVfGH4KTHvod3FXdpJN5gqKqX6
         TzNFn4ab4svZO27tWllquvX50wlaVGarqysHu3pzRQiCVPol9GlrdpAyvA9u3TqNrAPV
         xmqcVjIg/mzmrGqiEq6G5PLKEgn11CDxeRjjTjF2G7hETYo1SFkUdplD7war01qRcfDB
         B94xVYMQdDEbberGNMmxu5UGaapxV0/Cz7smT1+wsfmhRJLI8worKVcpyQt64s0PmoDf
         mL0kAeFcultEfxcKoRiuXuuqJw4WRxq/vc8T6ffNVq+GOm7K3RLheZ1vGr6l2wU31evJ
         wwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8kx+4RDaTM8iOHE5Xvj0WZgHMWsSn2e14La0mXAFQM=;
        b=utmJwgQ0CDaWBVoPZuHWRwbGFHq67AO70vy7Mh+8A73aH0yttN/l/4oWGxiYoOMGie
         sKmCYjoFGUeBRd+3KYhNlQfDCOzSUaw87eSrXwp22mFZ2S3BSiq45SRb1JtvrzCX589h
         5U+XZSDs2W6lMMgQxoJBNCw35o72ZTvtMKZvIjVGDXYsIuPVJ1YFYgw5rBhKQFp5Z1iz
         LGhaCuwZyeC7fAH/PDfHeaBOmmS1IS6YTNfSncRJZiZtdvWcoP0fs9RHym12t/xLF1ex
         LL4cis65QUTgWuo5c8R8vTLIFMYckWvB4cAQoTp9IdFJbDS70jfAgCYU8u9EBzaMyO71
         hIXA==
X-Gm-Message-State: AO0yUKVGPSxulrVNdHFUIlE4QS9YMQ6SNMs2VL4QiWfca7qEeM5BDFZ1
        yY4lP56Ap6kI0hOcPD4UBkopl9Sli45JpCysNqNhLI+6wNI=
X-Google-Smtp-Source: AK7set/w8mbZwVcipyz/hEm1WcaRUlx/jjbac0ls4MXKADFcL1LXY6ZZgTHQ4uR/+ynmSPGg1hVvw2RPk41+HjOJKSw=
X-Received: by 2002:a2e:b5a9:0:b0:295:ab47:1196 with SMTP id
 f9-20020a2eb5a9000000b00295ab471196mr146545ljn.9.1677821643145; Thu, 02 Mar
 2023 21:34:03 -0800 (PST)
MIME-Version: 1.0
References: <1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi>
 <CABBYNZ+kGVtCXN1X7ZOG64mLfWfXBah_Qo5+cy2dGWQMbNidoA@mail.gmail.com>
 <cb4b657b13f21bd9f164a0c205e31e3a2184c6c8.camel@iki.fi> <CABBYNZ+CTfOTh8KVo6r8o6wzAny+wB9=VnzWb=8+_39F-CMRRg@mail.gmail.com>
 <b5e773ad0fc2a710356638d30ba7d3037948ad8c.camel@iki.fi>
In-Reply-To: <b5e773ad0fc2a710356638d30ba7d3037948ad8c.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Mar 2023 21:33:51 -0800
Message-ID: <CABBYNZL4B36SVrtm=nJ51nyeugSAzz0wvgZv+-OQ803R8BK6Cw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: fix timestamped HCI ISO data packet parsing
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Fri, Feb 24, 2023 at 2:55=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> pe, 2023-02-24 kello 12:41 -0800, Luiz Augusto von Dentz kirjoitti:
> > On Fri, Feb 24, 2023 at 11:52 AM Pauli Virtanen <pav@iki.fi> wrote:
> > > ti, 2023-02-21 kello 14:08 -0800, Luiz Augusto von Dentz kirjoitti:
> > > > > Hi Pauli,
> > > > >
> > > > > On Mon, Feb 20, 2023 at 11:42 AM Pauli Virtanen <pav@iki.fi> wrot=
e:
> > > > > > >
> > > > > > > Use correct HCI ISO data packet header struct when the packet=
 has
> > > > > > > timestamp. The timestamp, when present, goes before the other=
 fields
> > > > > > > (Core v5.3 4E 5.4.5), so the structs are not compatible.
> > > > > > >
> > > > > > > Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type"=
)
> > > > > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > > > > ---
> > > > > > >
> > > > > > > Notes:
> > > > > > >     My hardware doesn't seem to produce timestamped packets, =
so this is not
> > > > > > >     properly tested, except to the extent that it doesn't bre=
ak the
> > > > > > >     non-timestamped code path.
> > > > > > >
> > > > > > >     Regardless, the current state of things looks wrong, so s=
ending this to
> > > > > > >     the list in any case.
> > > > >
> > > > > Perhaps we should first attempt to enable this in the emulator, I=
d use
> > > > > BT_HCI_CMD_LE_READ_ISO_TX_SYNC as hint that the host is intereste=
d in
> > > > > knowing the timestamp:
> > > > >
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/emulator/=
btdev.c#n5752
> > >
> > > Yes, it probably would be best, and probably not too complicated to d=
o
> > > at least if we are happy with not per spec timestamps.
> > >
> > > > > > >  net/bluetooth/iso.c | 9 +++++++--
> > > > > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > > > > > > index 2dabef488eaa..cb959e8eac18 100644
> > > > > > > --- a/net/bluetooth/iso.c
> > > > > > > +++ b/net/bluetooth/iso.c
> > > > > > > @@ -1621,7 +1621,6 @@ static void iso_disconn_cfm(struct
> > > > > > > hci_conn *hcon, __u8 reason)
> > > > > > >  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u1=
6
> > > > > > > flags)
> > > > > > >  {
> > > > > > >         struct iso_conn *conn =3D hcon->iso_data;
> > > > > > > -       struct hci_iso_data_hdr *hdr;
> > > > > > >         __u16 pb, ts, len;
> > > > > > >
> > > > > > >         if (!conn)
> > > > > > > @@ -1643,6 +1642,8 @@ void iso_recv(struct hci_conn *hcon,
> > > > > > > struct sk_buff *skb, u16 flags)
> > > > > > >                 }
> > > > > > >
> > > > > > >                 if (ts) {
> > > > > > > +                       struct hci_iso_ts_data_hdr *hdr;
> > > > > > > +
> > > > > > >                         /* TODO: add timestamp to the packet?
> > > > > > > */
> > > > >
> > > > > Perhaps we should use skb_set_delivery_time to set the timestamp =
as
> > > > > received by the controller? That said I don't know if the unit
> > > > > would
> > > > > be compatible.
> > >
> > > The userspace I think is interested also in the sequence number and
> > > packet status flags (if controller knows data is corrupted, that shou=
ld
> > > be indicated to userspace, similarly for missed packets). Would e.g.
> > > putting all these into some custom cmsg struct be better here?
> > >
> > > This timestamp is also based on controller clock. Not sure if
> > > delivery_time is supposed to be in system clock not some unrelated
> > > hardware clock.
> > >
> > > Userspace may also want to set the packet sequence numbers and
> > > timestamps itself when sending, to indicate in which interval it want=
ed
> > > things to come out.
> > >
> > > On systems where synchronization to Controller ISO clock is not
> > > available (it IIUC cannot really be done via HCI and so this is likel=
y
> > > the situation on desktop/laptop machines), userspace needs some other
> > > tool to keep its SDU timing in sync with the controller, and for e.g.
> > > keeping a fixed number of packets queued to have some buffer for miss=
ed
> > > deadlines, and making sure there is no timing offset between eg. left
> > > and right earpieces of TWS headset.
> >
> > Yeah, btw I will be posting the patches for CSIP soon and I wonder if
> > you could check with this headset of yours, in fact we probably need
> > some changes to the likes of pipewire to detect the presence of
> > DeviceSet object and split the left and right streams.
>
> I'll test the CSIP patchset with the Samsung TWS headset I have. I'm
> also going to make the necessary changes to Pipewire, to see how it
> works from our side.

I just posted an RFC set:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D726293

Make sure you also have the set bellow, apparently this was the cause
of transport not showing up since bap_ready callback was called to
early before we had subscribed for notifications, etc:

https://patchwork.kernel.org/project/bluetooth/list/?series=3D726232

> FWIW, right now, there are issues in getting reliable BAP audio on this
> TWS headset device (with one earbud only currently) --- I'm sending
> unframed LC3 packets to the ISO socket with sub-ms timing accuracy (err
> ~ 0.2ms max, 50us std) and there are still frequent pops in sine wave.
> Stuffing extra 2-4 packets to the socket at the start of playback seems
> to reduce the problem, so maybe the tx sync issue is suspect.

Yeah, Im afraid the headset might be trying to minimize using a jitter
buffer so if we miss any internal it will cause such problem, the
other problem is that the controller may not be reporting the Number
of Packets Complete one by one, which cause us to send packets in
batches which end up removing the timing accuracy of the socket since
we have to wait the controller to acknowledge the packets previously
sent, perhaps we could try detecting this behavior and disable Number
of Packets Complete flow control, so we send based on the configured
interval no matter if we think there is a buffer available in the
controller or not.

> However, no such problem with nrf5430 or ax210+bluez+pipewire as
> receiver, so not really yet clear.
>
> > > This probably means things like information on the timing of the late=
st
> > > Number of Completed Packets event for the handle, the number of
> > > currently queued ISO packets on the controller, and the sequence numb=
er
> > > of the latest packet queued on controller (to know how much is still =
in
> > > socket buffer). Probably also LE Read TX Sync information to know
> > > controller timestamp on a sent packet...
> > >
> > > Does this go via some new ioctls? Or send empty packets with some cms=
g
> > > (so userspace can just poll until it needs to do something)?
> > >
> > > It should also be decided how much the kernel is going to be involved
> > > in getting the SDU timing, sequence numbers, etc. right, or whether
> > > it's just left to the userspace.
> > >
> > > Before trying to propose something here, I think I'd need to first ma=
ke
> > > some prototypes so that it becomes clearer how it would best work.
> >
> > I think we might want to use BT_PKT_STATUS, like is done for SCO, to
> > carry information such as controller timestamp, etc, have a look at
> > it:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git/tree/net/bluetooth/sco.c#n450
>
>
> Yes, for RX that's probably what it should be.
>
> > >
> > > > > > >                         hdr =3D skb_pull_data(skb,
> > > > > > > HCI_ISO_TS_DATA_HDR_SIZE);
> > > > > > >                         if (!hdr) {
> > > > > > > @@ -1650,15 +1651,19 @@ void iso_recv(struct hci_conn *hcon,
> > > > > > > struct sk_buff *skb, u16 flags)
> > > > > > >                                 goto drop;
> > > > > > >                         }
> > > > > > >
> > > > > > > +                       len =3D __le16_to_cpu(hdr->slen);
> > > > > > >                 } else {
> > > > > > > +                       struct hci_iso_data_hdr *hdr;
> > > > > > > +
> > > > > > >                         hdr =3D skb_pull_data(skb,
> > > > > > > HCI_ISO_DATA_HDR_SIZE);
> > > > > > >                         if (!hdr) {
> > > > > > >                                 BT_ERR("Frame is too short (l=
en
> > > > > > > %d)", skb->len);
> > > > > > >                                 goto drop;
> > > > > > >                         }
> > > > > > > +
> > > > > > > +                       len =3D __le16_to_cpu(hdr->slen);
> > > > > > >                 }
> > > > > > >
> > > > > > > -               len    =3D __le16_to_cpu(hdr->slen);
> > > > > > >                 flags  =3D hci_iso_data_flags(len);
> > > > > > >                 len    =3D hci_iso_data_len(len);
> > > > > > >
> > > > > > > --
> > > > > > > 2.39.2
> > > > > > >
> > > > >
> > > > >
> > >
> > >
> >
> >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
