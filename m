Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Mar 2013 12:03:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 03/16] Bluetooth: Add initial skeleton for HCI
 transaction framework
Message-ID: <20130301100320.GA20590@x220.P-661HNU-F1>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com>
 <1361951844-13719-4-git-send-email-johan.hedberg@gmail.com>
 <4FF31B76-4E16-4481-9158-4874B3D67349@holtmann.org>
 <20130301070425.GB14811@x220.P-661HNU-F1>
 <01E8737B-3E6B-4FF5-B281-C262E85442B7@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01E8737B-3E6B-4FF5-B281-C262E85442B7@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Feb 28, 2013, Marcel Holtmann wrote:
> >>> +int hci_transaction_run(struct hci_transaction *transaction)
> >>> +{
> >>> +	struct hci_dev *hdev = transaction->hdev;
> >>> +
> >>> +	BT_DBG("length %u", skb_queue_len(&transaction->cmd_q));
> >>> +
> >>> +	/* Do not allow empty transactions */
> >>> +	if (skb_queue_empty(&transaction->cmd_q))
> >>> +		return -EINVAL;
> >>> +
> >>> +	spin_lock(&hdev->cmd_q.lock);
> >>> +	skb_queue_splice_tail(&transaction->cmd_q, &hdev->cmd_q);
> >>> +	spin_unlock(&hdev->cmd_q.lock);
> >>> +
> >>> +	queue_work(hdev->workqueue, &hdev->cmd_work);
> >>> +
> >>> +	return 0;
> >>> +}
> >> 
> >> I am wondering why we are not giving the complete handler when
> >> finishing the transaction. Having a copy of the handler in hci_dev
> >> structure seems a bit pointless. What is the reason here?
> > 
> > The hdev->transaction_complete is not related to building transactions
> > but for running them. I can move giving the callback to the
> > transaction_run function and thereby remove the need to store it in
> > struct hci_transaction, but the fact remains that it still needs to be
> > copied to the first skb of the transaction (since the moment we start
> > processing the transaction the callback needs to be copied to
> > hdev->transaction_complete). Storing the callback in struct
> > hci_transaction made it easy to copy it to the first skb when
> > hci_transaction_cmd() gets called for the first time on the transaction.
> > 
> > So let me repeat, we need the hdev->complete_transaction since the
> > callback could be needed for any individual HCI command that's part of
> > the transaction in case that command fails (since then we stop
> > processing the transaction and call the callback). Because of this the
> > callback needs to be part of the first skb of the transaction.
> 
> The way I see this is that if one command of the transaction fails, we
> need to not continue and just discard the rest of the transaction. Why
> not just go through the queue and find the complete callback attached
> with the last skb of transaction. Either that is the last successful
> command, or we had to go and remove the rest of the queue.

A command that completes it not part of hdev->cmd_q anymore but can be
found in hdev->sent_cmd instead. This means that to find the complete
callback we first need to check for
bt_cb(hdev->sent_cmd)->transaction.complete and if it's NULL start going
through hdev->cmd_q. This is more complicated than just checking for
hdev->transaction_complete, but if you think it's worth not having to
add another hdev member then I'll go with it.

Another problem is that the control buffer gets lost when doing
skb_clone. This means we have to add a memcpy of the skb->cb after doing
the hdev->sent_cmd = skb_clone(skb) in hci_cmd_work.

> This reminds me. Have you tested this with random commands in the
> transaction failing?

I *think* I tested it, but I'll make sure to do it at least before
sending the next patch set iteration.

Johan
