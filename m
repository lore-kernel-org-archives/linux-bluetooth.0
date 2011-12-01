Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
	"'Emeltchenko Andrei'" <Andrei.Emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1322645765-9519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>	 <1322645765-9519-7-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1322663182.26198.12.camel@aeonflux>
In-Reply-To: <1322663182.26198.12.camel@aeonflux>
Subject: RE: [PATCHv1 6/6] Bluetooth: Recalculate sched for HCI block flow ctrl
Date: Wed, 30 Nov 2011 22:24:33 -0800
Message-ID: <000301ccaff1$e59d6b60$b0d84220$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel, Andrei,

> Hi Andrei,
> > >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 4a0391e..360b44c 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2303,15 +2305,28 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
> >
> >  			skb = skb_dequeue(&chan->data_q);
> >
> > +			if (hdev->flow_ctl_mode ==
> > +					HCI_FLOW_CTL_MODE_BLOCK_BASED)
> > +				/* Calculate count of blocks used by
> > +				 * this packet
> > +				 */
> > +				blocks = DIV_ROUND_UP(skb->len -
> > +					HCI_ACL_HDR_SIZE, hdev->block_len);
> 
> would it not be more efficient to have to functions here? One
> hci_sched_acl_block and one hci_sched_acl_pkt which implement the
> specific details of the flow control mode. And the hci_sched_acl would
> just decide which on to call once.

There has to be a check for which flow control mode is used by the device somewhere, and
this fragment is really the only difference between the two modes, in separate functions
the rest would be duplicate code.

> > +
> > +			if (blocks > hdev->acl_cnt)
> > +				return;
> > +
> >  			hci_conn_enter_active_mode(chan->conn,
> >  						bt_cb(skb)->force_active);
> 
> Now an important question that comes up here. The support for the power
> save mode (sniff mainly) and AMP controllers is fully pointless. We need
> to actually make sure we don't try to put an AMP controller into sniff
> mode since that seems like an attempt for failure.
> 
> Regards
> 
> Marcel
> 
> 

Regards,

Peter.

--Peter Krystad
  Employee of Qualcomm Innovation Center, Inc.
  Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum



