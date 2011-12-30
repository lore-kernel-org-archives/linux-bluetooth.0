Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Dec 2011 12:11:41 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 5/5] Bluetooth: Correct packet len calculation
Message-ID: <20111230101139.GA7282@aemeltch-MOBL1>
References: <1324305091-19393-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1324305091-19393-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111220190504.GA24612@joana>
 <1324414977.1965.135.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324414977.1965.135.camel@aeonflux>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Dec 20, 2011 at 01:02:57PM -0800, Marcel Holtmann wrote:
> > > Remove unneeded skb_pull and correct packet length calculation
> > > removing magic number. Move BT_DBG after len check otherwise
> > > it could possibly access wrong memory.
> > > 
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > ---
> > >  net/bluetooth/hci_event.c |    9 ++++-----
> > >  1 files changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 919e3c0..47e1476 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -2266,20 +2266,19 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
> > >  	struct hci_ev_num_comp_pkts *ev = (void *) skb->data;
> > >  	int i;
> > >  
> > > -	skb_pull(skb, sizeof(*ev));
> > > -
> > > -	BT_DBG("%s num_hndl %d", hdev->name, ev->num_hndl);
> > > -
> > >  	if (hdev->flow_ctl_mode != HCI_FLOW_CTL_MODE_PACKET_BASED) {
> > >  		BT_ERR("Wrong event for mode %d", hdev->flow_ctl_mode);
> > >  		return;
> > >  	}
> > >  
> > > -	if (skb->len < ev->num_hndl * 4) {
> > > +	if (skb->len < sizeof(*ev) || skb->len < sizeof(*ev) +
> > > +			ev->num_hndl * sizeof(struct hci_comp_pkts_info)) {
> > 
> > I think you can remove the first part of this check.
> 
> you are accessing ev->num_handl, so you need to ensure that you have at
> least ev->num_handl size of data in your SKB. So this code is correct.

BTW: I resent the remaining patch from this series. Cannot add more to
Marcel's comment above.

Best regards 
Andrei Emeltchenko 
