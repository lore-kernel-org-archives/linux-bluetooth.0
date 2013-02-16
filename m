Return-Path: <cyrus@holtmann.org>
Message-ID: <1361053056.1583.4.camel@aeonflux>
Subject: Re: [PATCH 02/12 v3] Bluetooth: Add basic start/complete HCI
 transaction functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 16 Feb 2013 23:17:36 +0100
In-Reply-To: <1360921920-14080-3-git-send-email-johan.hedberg@gmail.com>
References: <1360921920-14080-1-git-send-email-johan.hedberg@gmail.com>
	 <1360921920-14080-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> With these functions it will be possible to declare the start and end of
> a transaction. hci_start_transaction() creates hdev->build_transaction
> which will be used by hci_send_command() to construct a transaction.
> hci_complete_transaction() indicates the end of a transaction with an
> optional complete callback to be called once the transaction is
> complete. The transaction is either moved to hdev->current_transaction
> (if no other transaction is in progress) or appended to
> hdev->transaction_q.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    5 +++
>  net/bluetooth/hci_core.c         |   80 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0e53032..5cd58f5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1058,6 +1058,11 @@ int hci_unregister_cb(struct hci_cb *hcb);
>  #define hci_transaction_lock(d)		mutex_lock(&d->transaction_lock)
>  #define hci_transaction_unlock(d)	mutex_unlock(&d->transaction_lock)
>  
> +int hci_start_transaction(struct hci_dev *hdev);
> +int hci_complete_transaction(struct hci_dev *hdev,
> +			     void (*complete)(struct hci_dev *hdev,
> +					      __u16 last_cmd, int status));
> +
>  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
>  void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
>  void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 05e2e8b..0b289f3 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2196,6 +2196,86 @@ static int hci_send_frame(struct sk_buff *skb)
>  	return hdev->send(skb);
>  }
>  
> +int hci_start_transaction(struct hci_dev *hdev)
> +{
> +	struct hci_transaction *transaction;
> +	int err;
> +
> +	hci_transaction_lock(hdev);
> +
> +	/* We can't start a new transaction if there's another one in
> +	 * progress of being built.
> +	 */
> +	if (hdev->build_transaction) {
> +		err = -EBUSY;
> +		goto unlock;
> +	}

I do not get this part. Why not use a common mutex on
hci_start_transaction and have it close with hci_complete_transaction.

This sounds more like a double protection.

> +
> +	transaction = kzalloc(sizeof(*transaction), GFP_KERNEL);
> +	if (!transaction) {
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	skb_queue_head_init(&transaction->cmd_q);
> +
> +	hdev->build_transaction = transaction;
> +

I am bit confused with this build_transaction concept. So we are
expecting to build transaction inside the same function. Meaning that
start and complete functions will be called in the same context.

Maybe some concept of DECLARE_TRANSACTION declaring a local variable and
then start and complete transaction would be better.

On that topic using begin_transaction and finish_transaction sounds a
bit more appealing. Or even run_transaction instead of finish.

Regards

Marcel


