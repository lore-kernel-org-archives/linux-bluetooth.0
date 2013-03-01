Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v3 03/16] Bluetooth: Add initial skeleton for HCI transaction framework
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130301070425.GB14811@x220.P-661HNU-F1>
Date: Thu, 28 Feb 2013 23:30:53 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <01E8737B-3E6B-4FF5-B281-C262E85442B7@holtmann.org>
References: <1361951844-13719-1-git-send-email-johan.hedberg@gmail.com> <1361951844-13719-4-git-send-email-johan.hedberg@gmail.com> <4FF31B76-4E16-4481-9158-4874B3D67349@holtmann.org> <20130301070425.GB14811@x220.P-661HNU-F1>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,


>>> +typedef void (*transaction_complete_t)(struct hci_dev *hdev, u16 last_cmd,
>>> +				       int status);
>> 
>> why is status an int and not __u8?
>> 
>> We might want to prefix this with hci_ here. Just in case someone
>> includes this header.
> 
> The int came from the old hci_req_complete() API, but you're right it
> doesn't really make sense to have anything else than u8. I'll fix both
> issues for the next iteration of the set.
> 
>>> +struct transaction_ctrl {
>> 
>> Same here. hci_ prefix seems like a good idea.
> 
> Sure.
> 
>>> +	__u8			start;
>> 
>> Why is not a bool and we are using true/false. Magic numbers like 1 in
>> the code seem like a bad idea.
> 
> The main reason is that I wanted to control the amount of data we
> consume from the control buffer (which is limited to 40 bytes) and the
> size of bool is architecture dependent (could be 1 byte or 4 or
> something else). E.g. all other existing variables part of the buffer
> are either u8 or u16. We still have plenty of space left though and the
> complete callback pointer is anyway not a fixed size, so if you're not
> too worried that we'll continue extending the buffer in the future I'll
> just change this to bool.

since we are not short on space right now, lets use bool to clearly indicate the range we are expecting.

At some point, we might consider having separate control buffer between L2CAP and HCI, but lets not worry too much about that now.

> 
>>> +int hci_transaction_run(struct hci_transaction *transaction)
>>> +{
>>> +	struct hci_dev *hdev = transaction->hdev;
>>> +
>>> +	BT_DBG("length %u", skb_queue_len(&transaction->cmd_q));
>>> +
>>> +	/* Do not allow empty transactions */
>>> +	if (skb_queue_empty(&transaction->cmd_q))
>>> +		return -EINVAL;
>>> +
>>> +	spin_lock(&hdev->cmd_q.lock);
>>> +	skb_queue_splice_tail(&transaction->cmd_q, &hdev->cmd_q);
>>> +	spin_unlock(&hdev->cmd_q.lock);
>>> +
>>> +	queue_work(hdev->workqueue, &hdev->cmd_work);
>>> +
>>> +	return 0;
>>> +}
>> 
>> I am wondering why we are not giving the complete handler when
>> finishing the transaction. Having a copy of the handler in hci_dev
>> structure seems a bit pointless. What is the reason here?
> 
> The hdev->transaction_complete is not related to building transactions
> but for running them. I can move giving the callback to the
> transaction_run function and thereby remove the need to store it in
> struct hci_transaction, but the fact remains that it still needs to be
> copied to the first skb of the transaction (since the moment we start
> processing the transaction the callback needs to be copied to
> hdev->transaction_complete). Storing the callback in struct
> hci_transaction made it easy to copy it to the first skb when
> hci_transaction_cmd() gets called for the first time on the transaction.
> 
> So let me repeat, we need the hdev->complete_transaction since the
> callback could be needed for any individual HCI command that's part of
> the transaction in case that command fails (since then we stop
> processing the transaction and call the callback). Because of this the
> callback needs to be part of the first skb of the transaction.

The way I see this is that if one command of the transaction fails, we need to not continue and just discard the rest of the transaction. Why not just go through the queue and find the complete callback attached with the last skb of transaction. Either that is the last successful command, or we had to go and remove the rest of the queue.

This reminds me. Have you tested this with random commands in the transaction failing?

Regards

Marcel

