Return-Path: <SRS0=iDKf=PH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E11C43387
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Dec 2018 14:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CE02075D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Dec 2018 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYdBlZ5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeL3OCD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Dec 2018 09:02:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46679 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeL3OCD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Dec 2018 09:02:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so12323249pfe.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Dec 2018 06:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yxG7m/436Tbtkr3w6GYV0MQgrbWL2UZyGeZ/5qQBnZU=;
        b=XYdBlZ5LNoHbsQ/csSm4opsAAl/UZKv/7PMqG8jce9/7MjKiPkFQ6QG5djFnFC+bYj
         276VCDZMgh5ujmQg+IE3q4YtUEiiGO3JfrAD1cXa2lBQSO2PrG6ZuhXS90ZdNgWe0LX/
         1VQrRerGOJnH40sXO7BD+YeUaQDRfN19NHTxMkU2NVpaEP4MDUhT1PvsQQxXhmr4pTwm
         w/FiQah0LBbAqb3b6Wr1vxFfgWX9/yrwypSBmbb8fWyB7KamooVy2LIoZB1tgOu+FbmH
         zJoBfBRg+7pTc5WH1em4Woqs4Hlkr3yLtFMXiA8reSCQ3PNUGz3jeqCO0uViRCmyxUkz
         4BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=yxG7m/436Tbtkr3w6GYV0MQgrbWL2UZyGeZ/5qQBnZU=;
        b=eYxp5zaloo897tzY1bBgA3TURHGPcae4E5ro1vy0EAckedEGDwDgEWeF0QMjgMymAW
         aGGi+Rqq7UEWG6UICIzGs3F5aniQQsOUGGIJM4KCTF+q9xfdP0SECGYb6erbW7+2rrPX
         1jjkkyej4POGs9xJdccnko+fFIaPfsRsQx2FwybpR0YKSGjcliu/thX13LMDv4CNPX3V
         cmjb52FhQsQ8RPvKVu8pKgeC6/k0Mu81Wib8S4YWSUBzPH6bmrhVMm12Ys8yr/EVA3ib
         ZVY+vKpiD5Y+xsHuYT1EGS+lxsIWKAupEwOCJXMgBm7O3g+8ciEIfh5vO+2qRnJ9Hcc1
         coMQ==
X-Gm-Message-State: AA+aEWYqu7gdifU77P/EQHssL5yOSWynJwmfwm96rkVv48KrYvcFJHIc
        yOxGDvbwrNezZH8YJb7+XjDrWiU/is5oG8fDwBr0SEYz
X-Google-Smtp-Source: AFSGD/VtgN+7//thwQZtAh2Z7jzzo65SCTWZFrZ2egWbRxh0broySyP3LoeXKsB+iLjFFWuG9fzf688Vehylc8tci1M=
X-Received: by 2002:a62:938f:: with SMTP id r15mr34684979pfk.27.1546178522081;
 Sun, 30 Dec 2018 06:02:02 -0800 (PST)
MIME-Version: 1.0
References: <1527256763-13474-1-git-send-email-emil.lenngren@gmail.com> <A73D99C8-7E66-49CF-8B85-E8879308A5F8@holtmann.org>
In-Reply-To: <A73D99C8-7E66-49CF-8B85-E8879308A5F8@holtmann.org>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Sun, 30 Dec 2018 15:01:51 +0100
Message-ID: <CAO1O6sf8G8VPJLoctB4mNC842NUE4FA0KKi8Hb-cVQq+rfuTag@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix flow bugs in H5 so the protocol doesn't stall
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

S=C3=B6n den 30 dec. 2018 11:29 skrev Marcel Holtmann <marcel@holtmann.org>=
:
>
> Hi Emil,
>
> > 1. If more than tx_win packets are enqueued, so that the unack queue
> > gets full, then when packets are later acked, uart tx is not woken up,
> > meaning that the flow will be stalled unless uart tx is not later
> > woken up for some other reason (e.g. packet is received so an ack
> > needs to be sent).
> >
> > 2. If remote peer sends tx_win packets to us and our ack(s) are
> > incorrectly received by the remote device, it will first resend the
> > tx_win packets and wait for their ack before it can send the next
> > packets. However, we only send ack if a NEW packet (not a resent packet=
)
> > is arrived. Therefore, we will never send ack and the remote device
> > will keep resend the packets (and wait for the acks) forever, until
> > we send a new tx packet.
>
> do you have interest in working on the bt3wire.c driver that is a pure se=
rdev driver and make it fully H:5 compliant. I think it would be good to mo=
ve away from hci_h5.c since it is too much entangled with the line discipli=
ne.

I can take a look at it but can't promise anything. I found the email
from 2018-03-18. Is that the latest version? Are there any known
issues with it expect that it misses important features?

Anyway, the current hci_h5.c driver should still be fixed since it's
still in use and probably will for some time...
Yeah the protocol gets pretty complicated in practice and there are
quite many "edge" cases that can be a bit tricky to cover. I'm not
sure if a few comments spread out at different places would make
someone follow the code. I would rather see them as a compliment to a
bigger description at the top of the file or so, discussing various
flows and cases. What do you think?

> > }
> >
> > static void h5_handle_internal_rx(struct hci_uart *hu)
> > @@ -354,7 +359,7 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
> >
> >       h5->rx_ack =3D H5_HDR_ACK(hdr);
> >
> > -     h5_pkt_cull(h5);
> > +     h5_pkt_cull(hu);
> >
> >       switch (H5_HDR_PKT_TYPE(hdr)) {
> >       case HCI_EVENT_PKT:
> > @@ -419,6 +424,8 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, uns=
igned char c)
> >       if (H5_HDR_RELIABLE(hdr) && H5_HDR_SEQ(hdr) !=3D h5->tx_ack) {
> >               BT_ERR("Out-of-order packet arrived (%u !=3D %u)",
> >                      H5_HDR_SEQ(hdr), h5->tx_ack);
> > +             set_bit(H5_TX_ACK_REQ, &h5->flags);
> > +             hci_uart_tx_wakeup(hu);
> >               h5_reset_rx(h5);
>
> I really wonder if these are actually two independent patches fixing two =
independent things.

You're right, they could be separated.

>
> Regards
>
> Marcel


/Emil

Den s=C3=B6n 30 dec. 2018 kl 11:29 skrev Marcel Holtmann <marcel@holtmann.o=
rg>:
>
> Hi Emil,
>
> > 1. If more than tx_win packets are enqueued, so that the unack queue
> > gets full, then when packets are later acked, uart tx is not woken up,
> > meaning that the flow will be stalled unless uart tx is not later
> > woken up for some other reason (e.g. packet is received so an ack
> > needs to be sent).
> >
> > 2. If remote peer sends tx_win packets to us and our ack(s) are
> > incorrectly received by the remote device, it will first resend the
> > tx_win packets and wait for their ack before it can send the next
> > packets. However, we only send ack if a NEW packet (not a resent packet=
)
> > is arrived. Therefore, we will never send ack and the remote device
> > will keep resend the packets (and wait for the acks) forever, until
> > we send a new tx packet.
>
> do you have interest in working on the bt3wire.c driver that is a pure se=
rdev driver and make it fully H:5 compliant. I think it would be good to mo=
ve away from hci_h5.c since it is too much entangled with the line discipli=
ne.
>
> > ---
> > drivers/bluetooth/hci_h5.c | 11 +++++++++--
> > 1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> > index abee221..6fca22c 100644
> > --- a/drivers/bluetooth/hci_h5.c
> > +++ b/drivers/bluetooth/hci_h5.c
> > @@ -238,16 +238,19 @@ static int h5_close(struct hci_uart *hu)
> >       return 0;
> > }
> >
> > -static void h5_pkt_cull(struct h5 *h5)
> > +static void h5_pkt_cull(struct hci_uart *hu)
> > {
> > +     struct h5 *h5 =3D hu->priv;
> >       struct sk_buff *skb, *tmp;
> >       unsigned long flags;
> >       int i, to_remove;
> > +     bool was_full;
> >       u8 seq;
> >
> >       spin_lock_irqsave(&h5->unack.lock, flags);
> >
> >       to_remove =3D skb_queue_len(&h5->unack);
> > +     was_full =3D to_remove =3D=3D h5->tx_win;
>
> I would really add a comment here.
>
> >       if (to_remove =3D=3D 0)
> >               goto unlock;
> >
> > @@ -278,6 +281,8 @@ static void h5_pkt_cull(struct h5 *h5)
> >
> > unlock:
> >       spin_unlock_irqrestore(&h5->unack.lock, flags);
> > +     if (was_full && to_remove > 0 && !skb_queue_empty(&h5->rel))
> > +             hci_uart_tx_wakeup(hu);
>
> And here as well. it should be commented on why this is the right express=
ion. Especially since it is rather complex. Can we not check all the condit=
ions up-front?
>
> > }
> >
> > static void h5_handle_internal_rx(struct hci_uart *hu)
> > @@ -354,7 +359,7 @@ static void h5_complete_rx_pkt(struct hci_uart *hu)
> >
> >       h5->rx_ack =3D H5_HDR_ACK(hdr);
> >
> > -     h5_pkt_cull(h5);
> > +     h5_pkt_cull(hu);
> >
> >       switch (H5_HDR_PKT_TYPE(hdr)) {
> >       case HCI_EVENT_PKT:
> > @@ -419,6 +424,8 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, uns=
igned char c)
> >       if (H5_HDR_RELIABLE(hdr) && H5_HDR_SEQ(hdr) !=3D h5->tx_ack) {
> >               BT_ERR("Out-of-order packet arrived (%u !=3D %u)",
> >                      H5_HDR_SEQ(hdr), h5->tx_ack);
> > +             set_bit(H5_TX_ACK_REQ, &h5->flags);
> > +             hci_uart_tx_wakeup(hu);
> >               h5_reset_rx(h5);
>
> I really wonder if these are actually two independent patches fixing two =
independent things.
>
> Regards
>
> Marcel
>
