Return-Path: <cyrus@holtmann.org>
Message-ID: <1325180758.1965.291.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Remove HCI_PRIO_MAX from ctrl cdm in
 RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 29 Dec 2011 09:45:58 -0800
In-Reply-To: <CABBYNZ+w0hqxHW2j4JrY_LQ8tG_aEy+Jk1TEXpixKo4aMbCQRA@mail.gmail.com>
References: <1324408558-24653-1-git-send-email-padovan@profusion.mobi>
	 <1324408558-24653-2-git-send-email-padovan@profusion.mobi>
	 <1324414866.1965.133.camel@aeonflux>
	 <CABBYNZ+w0hqxHW2j4JrY_LQ8tG_aEy+Jk1TEXpixKo4aMbCQRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> >> RFCOMM needs a proper priority mechanism inside itself and not try to use
> >> l2cap priority to fix its own problem.
> >
> > <snip>
> >
> >>  static void rfcomm_make_uih(struct sk_buff *skb, u8 addr)
> >> @@ -1786,8 +1776,15 @@ static inline int rfcomm_process_tx(struct rfcomm_dlc *d)
> >>               return skb_queue_len(&d->tx_queue);
> >>
> >>       while (d->tx_credits && (skb = skb_dequeue(&d->tx_queue))) {
> >> -             err = rfcomm_send_frame(d->session, skb->data, skb->len,
> >> -                                                     skb->priority);
> >> +             struct socket *sock = d->session->sock;
> >> +             struct sock *sk = sock->sk;
> >> +
> >> +             if (sk->sk_priority != skb->priority) {
> >> +                     lock_sock(sk);
> >> +                     sk->sk_priority = skb->priority;
> >> +                     release_sock(sk);
> >> +             }
> >> +             err = rfcomm_send_frame(d->session, skb->data, skb->len);
> >>               if (err < 0) {
> >>                       skb_queue_head(&d->tx_queue, skb);
> >>                       break;
> >
> > coming to think about this, we might not even bother setting the
> > sk->sk_priority at all here. Lets just forget about RFCOMM.
> 
> I guess you guys don't remember, but I tried to explain why the
> priority has to be set even for RFCOMM, any frame sent by the kernel
> with a timeout needs to be scheduled as soon as possible otherwise it
> may timeout due to quote being consumed by other channels with higher
> priority, so in this case if an A2DP stream in ongoing you will never
> be able to complete a RFCOMM connection because there wont be enough
> quote to schedule them before they timeout (usually 10 out 10 attempt
> end up like that in my setup).
> 
> Perhaps if we assign a dedicated queue/hci_chan per RFCOMM socket that
> should get rid of this resetting sk_priority on every frame, but that
> means not depending on socket API at all to pass frames from RFCOMM to
> L2CAP, so we need an API to create L2CAP frames directly in RFCOMM
> modules and queue them in its hci_chan.

yes, we need exactly this. Not using the L2CAP socket and interfacing
with L2CAP directly is a good idea. Same came up with A2MP as well.

Regards

Marcel


