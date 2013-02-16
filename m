Return-Path: <cyrus@holtmann.org>
Message-ID: <1361053148.1583.5.camel@aeonflux>
Subject: Re: [PATCH 03/12 v3] Bluetooth: Add hci_transaction_cmd_complete
 function
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 16 Feb 2013 23:19:08 +0100
In-Reply-To: <1360921920-14080-4-git-send-email-johan.hedberg@gmail.com>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
	 <1360921920-14080-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This function is used to process the HCI transaction state, including
> things like picking the next command to send, calling the complete
> callback for the current transaction and moving the next transaction
> from the queue (if any) to hdev->current_transaction.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |   65 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 5cd58f5..54efaa2 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1062,6 +1062,7 @@ int hci_start_transaction(struct hci_dev *hdev);
>  int hci_complete_transaction(struct hci_dev *hdev,
>  			     void (*complete)(struct hci_dev *hdev,
>  					      __u16 last_cmd, int status));
> +bool hci_transaction_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
>  
>  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
>  void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 0b289f3..8923a1f 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2976,6 +2976,71 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  	kfree_skb(skb);
>  }
>  
> +static void __transaction_next(struct hci_dev *hdev, u16 opcode, int status)
> +{
> +	struct hci_transaction *transaction;
> +
> +	transaction = hdev->current_transaction;
> +	if (!transaction)
> +		goto next_in_queue;
> +
> +	if (status || skb_queue_empty(&transaction->cmd_q)) {
> +		hdev->current_transaction = NULL;
> +
> +		/* We need to give up the transaction lock temporarily
> +		 * since the complete callback might trigger a deadlock
> +		 */
> +		hci_transaction_unlock(hdev);
> +		if (transaction->complete)
> +			transaction->complete(hdev, opcode, status);
> +		__transaction_free(transaction);
> +		hci_transaction_lock(hdev);
> +
> +		transaction = hdev->current_transaction;
> +	}

why do we need current_transaction again. Can we not just always use the
head of the list?

Regards

Marcel


