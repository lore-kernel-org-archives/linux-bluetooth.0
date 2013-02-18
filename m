Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2013 09:46:55 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/12 v3] Bluetooth: Add hci_transaction_cmd_complete
 function
Message-ID: <20130218074655.GB17232@x220>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
 <1360921920-14080-4-git-send-email-johan.hedberg@gmail.com>
 <1361053148.1583.5.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361053148.1583.5.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 16, 2013, Marcel Holtmann wrote:
> > This function is used to process the HCI transaction state, including
> > things like picking the next command to send, calling the complete
> > callback for the current transaction and moving the next transaction
> > from the queue (if any) to hdev->current_transaction.
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> >  include/net/bluetooth/hci_core.h |    1 +
> >  net/bluetooth/hci_core.c         |   65 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 66 insertions(+)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 5cd58f5..54efaa2 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1062,6 +1062,7 @@ int hci_start_transaction(struct hci_dev *hdev);
> >  int hci_complete_transaction(struct hci_dev *hdev,
> >  			     void (*complete)(struct hci_dev *hdev,
> >  					      __u16 last_cmd, int status));
> > +bool hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
> >  
> >  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
> >  void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 0b289f3..8923a1f 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2976,6 +2976,71 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
> >  	kfree_skb(skb);
> >  }
> >  
> > +static void __transaction_next(struct hci_dev *hdev, u16 opcode, int status)
> > +{
> > +	struct hci_transaction *transaction;
> > +
> > +	transaction = hdev->current_transaction;
> > +	if (!transaction)
> > +		goto next_in_queue;
> > +
> > +	if (status || skb_queue_empty(&transaction->cmd_q)) {
> > +		hdev->current_transaction = NULL;
> > +
> > +		/* We need to give up the transaction lock temporarily
> > +		 * since the complete callback might trigger a deadlock
> > +		 */
> > +		hci_transaction_unlock(hdev);
> > +		if (transaction->complete)
> > +			transaction->complete(hdev, opcode, status);
> > +		__transaction_free(transaction);
> > +		hci_transaction_lock(hdev);
> > +
> > +		transaction = hdev->current_transaction;
> > +	}
> 
> why do we need current_transaction again. Can we not just always use the
> head of the list?

Since we give up and re-acquire the lock when calling
transaction->complete() it is possible that a new transaction has
already been moved to current_transaction and started running when
complete() returns. If this is the case the __transaction_next() should
just return (like it does).

Johan
