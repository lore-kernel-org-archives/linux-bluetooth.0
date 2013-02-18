Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Feb 2013 09:43:29 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 02/12 v3] Bluetooth: Add basic start/complete HCI
 transaction functions
Message-ID: <20130218074329.GA17232@x220>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
 <1360921920-14080-3-git-send-email-johan.hedberg@gmail.com>
 <1361053056.1583.4.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361053056.1583.4.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 16, 2013, Marcel Holtmann wrote:
> > +int hci_start_transaction(struct hci_dev *hdev)
> > +{
> > +	struct hci_transaction *transaction;
> > +	int err;
> > +
> > +	hci_transaction_lock(hdev);
> > +
> > +	/* We can't start a new transaction if there's another one in
> > +	 * progress of being built.
> > +	 */
> > +	if (hdev->build_transaction) {
> > +		err = -EBUSY;
> > +		goto unlock;
> > +	}
> 
> I do not get this part. Why not use a common mutex on
> hci_start_transaction and have it close with hci_complete_transaction.
> 
> This sounds more like a double protection.
> 
> > +
> > +	transaction = kzalloc(sizeof(*transaction), GFP_KERNEL);
> > +	if (!transaction) {
> > +		err = -ENOMEM;
> > +		goto unlock;
> > +	}
> > +
> > +	skb_queue_head_init(&transaction->cmd_q);
> > +
> > +	hdev->build_transaction = transaction;
> > +
> 
> I am bit confused with this build_transaction concept. So we are
> expecting to build transaction inside the same function. Meaning that
> start and complete functions will be called in the same context.
> 
> Maybe some concept of DECLARE_TRANSACTION declaring a local variable and
> then start and complete transaction would be better.

Both of the above two issues are related to the desire to not have to
introduce a new function next to hci_send_cmd() (that would take this
local variable "context") and to be able to keep all current
hci_send_cmd() calls as they are.

In my initial iteration of the patch set I did have the kind of locking
you describe, but keeping the requirement for hci_send_cmd() like I
stated means that you'll then either end up having a potential race
or a deadlock inside the function since sometimes you're entering with
the transaction lock held (when using begin/finish transaction) and
sometimes without the lock held (all existing calls to hci_send_cmd().

So what we're dealing with here is trading less complexity in all our
hci_send_cmd() callers (not having to pass around this extra context)
for slightly more complexity inside the hci_send_cmd() function, which I
maintain is less complexity than removing it would introduce elsewhere,
basically this:

       hci_transaction_lock(hdev);

        /* If this is part of a multi-command transaction (i.e.
         * hci_start_transaction() has been called) just add the skb to
         * the end of the transaction being built.
         */
        if (hdev->build_transaction) {
                skb_queue_tail(&hdev->build_transaction->cmd_q, skb);
                goto unlock;
        }

        /* If we're in the middle of a hci_request the req lock will be
         * held and our only choice is to append to the request
         * transaction.
         */
        if (hdev->req_status && hdev->current_transaction) {
                skb_queue_tail(&hdev->current_transaction->cmd_q, skb);
                goto unlock;
        }

        /* This is neither a multi-command transaction nor a hci_request
         * situation, but simply hci_send_cmd being called without any
         * existing context. Create a simple one-command transaction out
         * of the skb
         */
        err = __transaction_from_skb(hdev, skb);
        if (err < 0)
                kfree_skb(skb);

unlock:
        hci_transaction_unlock(hdev);


> On that topic using begin_transaction and finish_transaction sounds a
> bit more appealing. Or even run_transaction instead of finish.

begin/run sounds fine to me.

Johan
