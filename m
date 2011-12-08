Return-Path: <cyrus@holtmann.org>
Message-ID: <1323333043.1965.20.camel@aeonflux>
Subject: Re: [RFCv2 5/6] Bluetooth: Correct packet len calculation
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 08 Dec 2011 10:30:43 +0200
In-Reply-To: <20111208082645.GA28028@aemeltch-MOBL1>
References: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1323266216-25261-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1323332283.1965.12.camel@aeonflux> <20111208082645.GA28028@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > > Remove unneeded skb_pull and correct packet length calculation
> > > removing magic number.
> > > ---
> > >  net/bluetooth/hci_event.c |    5 ++---
> > >  1 files changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index cfccf7e..21c1bf0 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -2268,8 +2268,6 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
> > >  	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
> > >  	int i;
> > >  
> > > -	skb_pull(skb, sizeof(*ev));
> > > -
> > >  	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
> > >  
> > >  	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
> > > @@ -2277,7 +2275,8 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
> > >  		return;
> > >  	}
> > >  
> > > -	if (skb->len < ev->num_hndl * 4) {
> > > +	if (skb->len < ev->num_hndl * sizeof(struct hci_comp_pkts_info) +
> > > +			sizeof(*ev)) {
> > >  		BT_DBG("%s bad parameters", hdev->name);
> > >  		return;
> > >  	}
> > 
> > actually this check is not enough. You need to make this two-fold.
> > 
> > 	if (skb->len < sizeof(*ev)) {
> 
> maybe:
> 
> if (skb->len < sizeof(*ev) || (...)) 
> 	return;

that will work as well.

Regards

Marcel


