Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Dec 2014 22:26:23 -0800
From: Tristan Lelong <tristan@lelong.xyz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] hci_bcsp: Add LE protocol on kernel side
Message-ID: <20141213062623.GA3058@localhost.localdomain>
References: <1418368478-13956-1-git-send-email-tristan@lelong.xyz>
 <1418368478-13956-2-git-send-email-tristan@lelong.xyz>
 <0E818206-73C3-476C-BB9D-7CC686ED7FEC@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0E818206-73C3-476C-BB9D-7CC686ED7FEC@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 12, 2014 at 02:58:33PM +0100, Marcel Holtmann wrote:
> > ---
> > drivers/bluetooth/hci_bcsp.c     | 202 +++++++++++++++++++++++++++++++--------
> > include/net/bluetooth/hci_core.h |   2 +
> > net/bluetooth/hci_core.c         |   6 +-
> > 3 files changed, 171 insertions(+), 39 deletions(-)
> 
> patch for drivers and net should always be separate. You need to split this.

Ok, I didn't know this one, I'll fix this.

> 
> > 
> > diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> > index 21cc45b..142b42b 100644
> > --- a/drivers/bluetooth/hci_bcsp.c
> > +++ b/drivers/bluetooth/hci_bcsp.c
> > @@ -1,6 +1,5 @@
> > /*
> >  *
> > - *  Bluetooth HCI UART driver
> 
> No idea why you are removing this line.

I'll fix this one.

> > 
> > +static u8 conf_pkt[4]     = { 0xad, 0xef, 0xac, 0xed };
> > +static u8 conf_rsp_pkt[4] = { 0xde, 0xad, 0xd0, 0xd0 };
> > +static u8 sync_pkt[4]     = { 0xda, 0xdc, 0xed, 0xed };
> > +static u8 sync_rsp_pkt[4] = { 0xac, 0xaf, 0xef, 0xee };
> 
> This should be const actually.

Agreed, I'll change this.

> 
> > +
> > +
> 
> And we do not do double empty lines. If that is in the code, then it is a leftover.

I missed this one, I'll fix it.

> > +
> > +	/* tell upper layer about the reset */
> > +	hci_dev_reset_stat(hu->hdev->id);
> > +
> 
> We introduced hci_reset_dev for the H:5 protocol. And I think that is the same that should be used here. The core only injects are hardware error event at the moment, but that is a core bug and we should fix that to handle proper stack reset when that happens. The driver should not hack around this.
> 

I initially wrote the code for a 3.10 kernel, I must have missed this in the new version. I'll change this.

> > +
> > +	if (BCSP_PKT_LEN(bcsp->rx_skb->data) == BCSP_LE_PKT_LEN) {
> > +		/* spot "conf" pkts and reply with a "conf rsp" pkt */
> > +		if (!memcmp(&bcsp->rx_skb->data[4], conf_pkt, 4)) {
> > +			if (bcsp->le_state == BCSP_SHY)
> > +				return;
> > +
> > +			BT_DBG("Found a LE conf pkt");
> > +			nskb = alloc_skb(4, GFP_ATOMIC);
> > +			if (!nskb)
> > +				return;
> > +			memcpy(skb_put(nskb, 4), conf_rsp_pkt, 4);
> > +			bt_cb(nskb)->pkt_type = BCSP_LE_PKT;
> > +
> > +			skb_queue_head(&bcsp->unrel, nskb);
> > +			hci_uart_tx_wakeup(hu);
> > +		}
> > +		/* Spot "sync" pkts and reply with a "sync rsp" pkt */
> > +		else if (!memcmp(&bcsp->rx_skb->data[4], sync_pkt, 4)) {
> > +			if (bcsp->le_state == BCSP_GARULOUS)
> > +				/* we force the connection state to reset */
> > +				bcsp_internal_reset(hu);
> 
> These needs { }. If you end up having a comment include it in { } even if the compiler does not care. That is for our reading sake.
> 

Just tried to follow how it was done initially, but I did not really like it either, I'll fix this.

> > +
> > +			BT_INFO("BCSP: hci%d LE sync pkt, performing reset",
> > +					hu->hdev->id);
> 
> Align the second line properly according to the coding style. Even if previous code might actually violate it.
> 

Will do, as well as all the following coding style issues.

> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index f001856..2c5130a 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -65,10 +65,12 @@ static DEFINE_IDA(hci_index_ida);
> > 
> > /* ---- HCI notifications ---- */
> > 
> > -static void hci_notify(struct hci_dev *hdev, int event)
> > +void hci_notify(struct hci_dev *hdev, int event)
> > {
> > 	hci_sock_dev_event(hdev, event);
> > }
> > +EXPORT_SYMBOL(hci_notify);
> > +
> 
> We will never export this internal detail to drivers. Use hci_reset_dev and lets get a proper stack reset handling implemented.

Understood, I'll ignore the notification to upper layer for now.

> 
> > 
> > /* ---- HCI debugfs entries ---- */
> > 
> > @@ -2783,6 +2785,8 @@ done:
> > 	hci_dev_put(hdev);
> > 	return ret;
> > }
> > +EXPORT_SYMBOL(hci_dev_reset_stat);
> > +
> 
> I have no idea why I would ever allow a driver to reset these. Even in case of errors it is fine to keep counting.

Ok, I can see the point here.

I will fix all this and do some testing, then resubmit early next week.
Thank you very much for your comments.

Regards
