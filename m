Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1360767045-26958-3-git-send-email-johan.hedberg@gmail.com>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
	<1360767045-26958-3-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 14 Feb 2013 14:48:33 -0300
Message-ID: <CACJA=fWD8mvxvY-WRq-j2c284-SkezbS05KVp_bGwcdKN6yn9g@mail.gmail.com>
Subject: Re: [PATCH 02/12] Bluetooth: Add basic start/complete HCI transaction functions
From: Andre Guedes <andre.guedes@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Feb 13, 2013 at 11:50 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
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
>  net/bluetooth/hci_core.c         |   81 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0e53032..5cd58f5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1058,6 +1058,11 @@ int hci_unregister_cb(struct hci_cb *hcb);
>  #define hci_transaction_lock(d)                mutex_lock(&d->transaction_lock)
>  #define hci_transaction_unlock(d)      mutex_unlock(&d->transaction_lock)
>
> +int hci_start_transaction(struct hci_dev *hdev);
> +int hci_complete_transaction(struct hci_dev *hdev,
> +                            void (*complete)(struct hci_dev *hdev,
> +                                             __u16 last_cmd, int status));
> +
>  int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
>  void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
>  void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 05e2e8b..13c064e 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2196,6 +2196,87 @@ static int hci_send_frame(struct sk_buff *skb)
>         return hdev->send(skb);
>  }
>
> +int hci_start_transaction(struct hci_dev *hdev)
> +{
> +       struct hci_transaction *transaction;
> +       int err;
> +
> +       hci_transaction_lock(hdev);
> +
> +       /* We can't start a new transaction if there's another one in
> +        * progress of being built.
> +        */
> +       if (hdev->build_transaction) {
> +               err = -EBUSY;
> +               goto unlock;
> +       }
> +
> +       transaction = kmalloc(sizeof(*transaction), GFP_ATOMIC);

I've failed to see why we need GFP_ATOMIC here. As this code is not
running in any atomic section, we can allocate memory using
GFP_KERNEL.

> +       if (!transaction) {
> +               err = -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       memset(transaction, 0, sizeof(*transaction));

We can also use kzalloc instead of kmalloc, making this memset unnecessary.

Regards,

Andre
