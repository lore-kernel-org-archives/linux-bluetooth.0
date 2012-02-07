Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Subject: Re: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
Date: Tue, 7 Feb 2012 09:08:45 +0100
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com>  <CAA37ikb_RZixK2dYZa2YED=Z942Uu6=W92_xivNEjPAq+w7cqA@mail.gmail.com>
In-Reply-To: <CAA37ikb_RZixK2dYZa2YED=Z942Uu6=W92_xivNEjPAq+w7cqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID: <201202070908.45952.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 09cd860..e969677 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1448,8 +1448,10 @@ static int l2cap_ertm_send(struct l2cap_chan *chan)
> >
> >                chan->next_tx_seq = __next_seq(chan, chan->next_tx_seq);
> >
> > -               if (bt_cb(skb)->retries == 1)
> > +               if (bt_cb(skb)->retries == 1) {
> >                        chan->unacked_frames++;
> > +                       __clear_ack_timer(chan);
> > +               }
> >
> >                chan->frames_sent++;
> 
> Hmm, maybe we can clear ack timer only once if we check nsent in the
> end of l2cap_ertm_send() instead of potentially call it several times?
> Not sure if it's worth it or not, though.

This is what __l2cap_send_ack is doing  i.e. sends RR frame only if
l2cap_ertm_send() returned 0 (or error). Would be good to have this consistent.

So maybe just clear ack timer when incrementing nsent for the 1st time?

if (!nsent++)
	__clear_ack_timer(chan);


-- 
BR
Szymon Janc
