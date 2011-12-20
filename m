Return-Path: <cyrus@holtmann.org>
Message-ID: <1324414977.1965.135.camel@aeonflux>
Subject: Re: [PATCHv3 5/5] Bluetooth: Correct packet len calculation
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 20 Dec 2011 13:02:57 -0800
In-Reply-To: <20111220190504.GA24612@joana>
References: <1324305091-19393-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1324305091-19393-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <20111220190504.GA24612@joana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Remove unneeded skb_pull and correct packet length calculation
> > removing magic number. Move BT_DBG after len check otherwise
> > it could possibly access wrong memory.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/hci_event.c |    9 ++++-----
> >  1 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 919e3c0..47e1476 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2266,20 +2266,19 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
> >  	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
> >  	int i;
> >  
> > -	skb_pull(skb, sizeof(*ev));
> > -
> > -	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
> > -
> >  	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
> >  		BT_ERR("Wrong event for mode %d", hdev->flow_ctl_mode);
> >  		return;
> >  	}
> >  
> > -	if (skb->len < ev->num_hndl * 4) {
> > +	if (skb->len < sizeof(*ev) || skb->len < sizeof(*ev) +
> > +			ev->num_hndl * sizeof(struct hci_comp_pkts_info)) {
> 
> I think you can remove the first part of this check.

you are accessing ev->num_handl, so you need to ensure that you have at
least ev->num_handl size of data in your SKB. So this code is correct.

Regards

Marcel


