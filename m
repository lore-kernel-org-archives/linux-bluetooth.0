Return-Path: <cyrus@holtmann.org>
Message-ID: <1361191652.1583.28.camel@aeonflux>
Subject: Re: [PATCH 02/12 v3] Bluetooth: Add basic start/complete HCI
 transaction functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 18 Feb 2013 13:47:32 +0100
In-Reply-To: <20130218074329.GA17232@x220>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
	 <1360921920-14080-3-git-send-email-johan.hedberg@gmail.com>
	 <1361053056.1583.4.camel@aeonflux> <20130218074329.GA17232@x220>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > +int hci_start_transaction(struct hci_dev *hdev)
> > > +{
> > > +	struct hci_transaction *transaction;
> > > +	int err;
> > > +
> > > +	hci_transaction_lock(hdev);
> > > +
> > > +	/* We can't start a new transaction if there's another one in
> > > +	 * progress of being built.
> > > +	 */
> > > +	if (hdev->build_transaction) {
> > > +		err = -EBUSY;
> > > +		goto unlock;
> > > +	}
> > 
> > I do not get this part. Why not use a common mutex on
> > hci_start_transaction and have it close with hci_complete_transaction.
> > 
> > This sounds more like a double protection.
> > 
> > > +
> > > +	transaction = kzalloc(sizeof(*transaction), GFP_KERNEL);
> > > +	if (!transaction) {
> > > +		err = -ENOMEM;
> > > +		goto unlock;
> > > +	}
> > > +
> > > +	skb_queue_head_init(&transaction->cmd_q);
> > > +
> > > +	hdev->build_transaction = transaction;
> > > +
> > 
> > I am bit confused with this build_transaction concept. So we are
> > expecting to build transaction inside the same function. Meaning that
> > start and complete functions will be called in the same context.
> > 
> > Maybe some concept of DECLARE_TRANSACTION declaring a local variable and
> > then start and complete transaction would be better.
> 
> Both of the above two issues are related to the desire to not have to
> introduce a new function next to hci_send_cmd() (that would take this
> local variable "context") and to be able to keep all current
> hci_send_cmd() calls as they are.

not having to modify hci_send_cmd seems fine. I was more thinking of
tracking this stuff. Since it only requires to know start and end of the
transaction. So that tracking could be localized.

I do like the idea of replacing cmd_q with a more advanced queue that
also has the ability for callbacks when a command finished. That is
pretty neat. The API itself seems also fine, but the actual
implementation feels rather hackish to have this all in hdev struct
while in reality it should be localized to the calling functions (except
for the queue itself of course).

The way I see this, we just need to take a proper lock protecting the
queue. And then mark the begin of a transaction and when it finishes.
When you call finish the markers get supplied to the queue.

Of course the queue can not be processed at the same time you create a
transaction, but that should be just fine.

> In my initial iteration of the patch set I did have the kind of locking
> you describe, but keeping the requirement for hci_send_cmd() like I
> stated means that you'll then either end up having a potential race
> or a deadlock inside the function since sometimes you're entering with
> the transaction lock held (when using begin/finish transaction) and
> sometimes without the lock held (all existing calls to hci_send_cmd().

I think we need to protect the access the queue against the queue
processing and that should be enough. I can see the desire to make
hci_send_cmd essentially a single transaction without callback. That is
a nice idea and should be most likely kept. However I am not sure if not
better use new command to add commands to a transaction. It does not
feel right to overload hci_send_cmd with two semantics.

The kernel historically makes the caller being aware of what it is doing
and what context it is in. See GFP_KERNEL and alike and locked vs
unlocked functions. If we are trying to be super smart now seems going
against that.

Regards

Marcel


