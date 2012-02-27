Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Feb 2012 11:15:35 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org, marcel@holtmann.org, luiz.dentz@gmail.com
Subject: Re: [RFC 2/2] Bluetooth: L2CAP ERTM state machine replacement
Message-ID: <20120227091528.GB13267@aemeltch-MOBL1>
References: <1330029469-8565-1-git-send-email-mathewm@codeaurora.org>
 <1330029469-8565-3-git-send-email-mathewm@codeaurora.org>
 <CAA37ikYHwKfBV8Ojgqoc8XYQpgv2oHFkzZA6NEZgFkF9nVjBSw@mail.gmail.com>
 <4F483477.2050907@codeaurora.org>
 <CAA37ikbYkfwsCTWGt+dPmEU6CVXfMkfyphfUBxUBJphnd7uB4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikbYkfwsCTWGt+dPmEU6CVXfMkfyphfUBxUBJphnd7uB4Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Sat, Feb 25, 2012 at 12:52:04PM -0300, Ulisses Furquim wrote:
> >> <snip>
> >>
> >> -               if (bt_cb(skb)->retries == 1) {
> >> -                       chan->unacked_frames++;
> >> +               l2cap_chan_hold(chan);
> >> +               sock_hold(chan->sk);
> >> +               tx_skb->sk = chan->sk;
> >>
> >> Do we really need these? Do we always have chan->sk? (We have that in
> >> l2cap_ertm_send() and l2cap_ertm_resend()).
> >
> > The upstream ERTM code still relies on having chan->sk, so I didn't try to
> > finish splitting channels & sockets within this patch.  skb destructors
> > expect to have an sk pointer, so it is critical to modify these reference
> > counts so the socket and chan are around when the skb leaves the hci tx
> > queue.
> 
> If I'm not mistaken the skb destructor relies on sk only to be able to
> access chan, right? It'd be good if we could not rely on sk here.
> Andrei, what do you think?

I believe that ERTM should not use sk. The places where we still use sk
shall be corrected IMO.

> >> -       int ret;
> >> +       struct l2cap_chan *chan =
> >> +               container_of(work, struct l2cap_chan, tx_work);
> >>
> >> -       if (!skb_queue_empty(&chan->tx_q))
> >> -               chan->tx_send_head = chan->tx_q.next;
> >> +       BT_DBG("%p", chan);
> >>
> >> -       chan->next_tx_seq = chan->expected_ack_seq;
> >> -       ret = l2cap_ertm_send(chan);
> >> -       return ret;
> >> +       lock_sock(chan->sk);
> >> +       l2cap_ertm_send(chan);
> >> +       release_sock(chan->sk);
> >>
> >> Can't we just use l2cap_chan_lock()/l2cap_chan_unlock() here? (I'm
> >> assuming you saw the patches creating a lock in l2cap_chan to protect
> >> it) Do we always have sk?
> >
> > l2cap_chan_lock() is pretty new!  Yes, I should use that to guard the ERTM
> > state.
> >
> > Right now, we do still always have sk, but that is changing (as it should).
> 
> Ok. If we could not rely on sk here as well would be good.

Good that we agree here.

Best regards 
Andrei Emeltchenko 
