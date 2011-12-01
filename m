Return-Path: <cyrus@holtmann.org>
Message-ID: <1322738114.26198.21.camel@aeonflux>
Subject: Re: [PATCHv1 6/6] Bluetooth: Recalculate sched for HCI block flow
 ctrl
From: Marcel Holtmann <marcel@holtmann.org>
To: 'Emeltchenko Andrei' <Andrei.Emeltchenko.news@gmail.com>
Cc: Peter Krystad <pkrystad@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 01 Dec 2011 12:15:14 +0100
In-Reply-To: <20111201094607.GB2216@aemeltch-MOBL1>
References: <1322645765-9519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322645765-9519-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322663182.26198.12.camel@aeonflux> <000301ccaff1$e59d6b60$b0d84220$@org>
	 <20111201094607.GB2216@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > index 4a0391e..360b44c 100644
> > > > --- a/net/bluetooth/hci_core.c
> > > > +++ b/net/bluetooth/hci_core.c
> > > > @@ -2303,15 +2305,28 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
> > > >
> > > >  			skb = skb_dequeue(&chan->data_q);
> > > >
> > > > +			if (hdev->flow_ctl_mode ==
> > > > +					HCI_FLOW_CTL_MODE_BLOCK_BASED)
> > > > +				/* Calculate count of blocks used by
> > > > +				 * this packet
> > > > +				 */
> > > > +				blocks = DIV_ROUND_UP(skb->len -
> > > > +					HCI_ACL_HDR_SIZE, hdev->block_len);
> > > 
> > > would it not be more efficient to have to functions here? One
> > > hci_sched_acl_block and one hci_sched_acl_pkt which implement the
> > > specific details of the flow control mode. And the hci_sched_acl would
> > > just decide which on to call once.
> > 
> > There has to be a check for which flow control mode is used by the device somewhere, and
> > this fragment is really the only difference between the two modes, in separate functions
> > the rest would be duplicate code.
> 
> I feel the same, we can still make a function like:

are we really sure here. If we have more than one SKB in the queue, I
still feel that the check here is pointless. Especially since we do
certain code changes already.

> blocks = __get_blocks(hdev, skb);
> 
> would this be better?

Lets give it a try. Can you whip up a patch for it.

> > > > +
> > > > +			if (blocks > hdev->acl_cnt)
> > > > +				return;
> > > > +
> > > >  			hci_conn_enter_active_mode(chan->conn,
> > > >  						bt_cb(skb)->force_active);
> > > 
> > > Now an important question that comes up here. The support for the power
> > > save mode (sniff mainly) and AMP controllers is fully pointless. We need
> > > to actually make sure we don't try to put an AMP controller into sniff
> > > mode since that seems like an attempt for failure.
> 
> We can test for BREDR controller in hci_conn_enter_active_mode function.
> This function is already too big.

That is what I am saying, we are running code that we know already is
only required for BR/EDR controllers. And now we have two checks here.

Actually maybe just flipping a bit and entering active before or after
might be a way here.

This is a fundamental hot path in our data processing. We need to be
smarter here.

Regards

Marcel


