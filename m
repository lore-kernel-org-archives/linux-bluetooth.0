Return-Path: <cyrus@holtmann.org>
Message-ID: <1361053337.1583.7.camel@aeonflux>
Subject: Re: [PATCH 05/12 v3] Bluetooth: Switch from hdev->cmd_q to using
 transactions
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 16 Feb 2013 23:22:17 +0100
In-Reply-To: <1360921920-14080-6-git-send-email-johan.hedberg@gmail.com>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
	 <1360921920-14080-6-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch converts the code from using a single hdev->cmd_q HCI command
> queue to use the HCI transaction infrastructure.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c  |   87 ++++++++++++++++++++++++++++++++++++++-------
>  net/bluetooth/hci_event.c |   12 +++++--
>  net/bluetooth/hci_sock.c  |    5 +--
>  3 files changed, 88 insertions(+), 16 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 6569248..4f55225 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -80,10 +80,18 @@ void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
>  			return;
>  
>  		skb = skb_clone(hdev->sent_cmd, GFP_ATOMIC);
> +		hci_transaction_lock(hdev);
>  		if (skb) {
> -			skb_queue_head(&hdev->cmd_q, skb);
> -			queue_work(hdev->workqueue, &hdev->cmd_work);
> +			struct hci_transaction *transaction =
> +						hdev->current_transaction;
> +			if (transaction) {
> +				skb_queue_head(&transaction->cmd_q, skb);
> +				queue_work(hdev->workqueue, &hdev->cmd_work);
> +			} else {
> +				kfree_skb(skb);
> +			}
>  		}
> +		hci_transaction_unlock(hdev);
>  
>  		return;
>  	}
> @@ -203,22 +211,30 @@ static void amp_init(struct hci_dev *hdev)
>  
>  static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
>  {
> +	struct hci_transaction *transaction;
>  	struct sk_buff *skb;
>  
>  	BT_DBG("%s %ld", hdev->name, opt);
>  
>  	/* Driver initialization */
>  
> +	if (hci_start_transaction(hdev) < 0)
> +		return;
> +
> +	hci_transaction_lock(hdev);
> +
> +	transaction = hdev->build_transaction;
> +
>  	/* Special commands */
>  	while ((skb = skb_dequeue(&hdev->driver_init))) {
>  		bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
>  		skb->dev = (void *) hdev;
> -
> -		skb_queue_tail(&hdev->cmd_q, skb);
> -		queue_work(hdev->workqueue, &hdev->cmd_work);
> +		skb_queue_tail(&transaction->cmd_q, skb);
>  	}
>  	skb_queue_purge(&hdev->driver_init);

if we have to touch this one, then please look at my hdev->setup()
patches I send a while back. We should get these merged so that drivers
can use a transaction within the driver and remove the driver_init queue
actually.

Regards

Marcel


