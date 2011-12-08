Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 10:26:51 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 5/6] Bluetooth: Correct packet len calculation
Message-ID: <20111208082645.GA28028@aemeltch-MOBL1>
References: <1323266216-25261-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1323266216-25261-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1323332283.1965.12.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323332283.1965.12.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 08, 2011 at 10:18:03AM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Remove unneeded skb_pull and correct packet length calculation
> > removing magic number.
> > ---
> >  net/bluetooth/hci_event.c |    5 ++---
> >  1 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index cfccf7e..21c1bf0 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2268,8 +2268,6 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
> >  	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
> >  	int i;
> >  
> > -	skb_pull(skb, sizeof(*ev));
> > -
> >  	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
> >  
> >  	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
> > @@ -2277,7 +2275,8 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
> >  		return;
> >  	}
> >  
> > -	if (skb->len < ev->num_hndl * 4) {
> > +	if (skb->len < ev->num_hndl * sizeof(struct hci_comp_pkts_info) +
> > +			sizeof(*ev)) {
> >  		BT_DBG("%s bad parameters", hdev->name);
> >  		return;
> >  	}
> 
> actually this check is not enough. You need to make this two-fold.
> 
> 	if (skb->len < sizeof(*ev)) {

maybe:

if (skb->len < sizeof(*ev) || (...)) 
	return;

> This needs to be checked first. Otherwise you are accessing ev->num_hndl
> before even knowing that it is valid. A malicious device could otherwise
> sneak in some weird behavior.

Agree.
Best regards 
Andrei Emeltchenko 
