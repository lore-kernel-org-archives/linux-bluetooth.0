Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2013 09:48:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 05/12 v3] Bluetooth: Switch from hdev->cmd_q to using
 transactions
Message-ID: <20130218074825.GC17232@x220>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
 <1360921920-14080-6-git-send-email-johan.hedberg@gmail.com>
 <1361053337.1583.7.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361053337.1583.7.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 16, 2013, Marcel Holtmann wrote:
> >  static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
> >  {
> > +	struct hci_transaction *transaction;
> >  	struct sk_buff *skb;
> >  
> >  	BT_DBG("%s %ld", hdev->name, opt);
> >  
> >  	/* Driver initialization */
> >  
> > +	if (hci_start_transaction(hdev) < 0)
> > +		return;
> > +
> > +	hci_transaction_lock(hdev);
> > +
> > +	transaction = hdev->build_transaction;
> > +
> >  	/* Special commands */
> >  	while ((skb = skb_dequeue(&hdev->driver_init))) {
> >  		bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
> >  		skb->dev = (void *) hdev;
> > -
> > -		skb_queue_tail(&hdev->cmd_q, skb);
> > -		queue_work(hdev->workqueue, &hdev->cmd_work);
> > +		skb_queue_tail(&transaction->cmd_q, skb);
> >  	}
> >  	skb_queue_purge(&hdev->driver_init);
> 
> if we have to touch this one, then please look at my hdev->setup()
> patches I send a while back. We should get these merged so that drivers
> can use a transaction within the driver and remove the driver_init queue
> actually.

Alright. I'll look into it.

Johan
