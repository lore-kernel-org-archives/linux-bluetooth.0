Return-Path: <cyrus@holtmann.org>
Subject: Re: [bluetooth-next 1/1] bluetooth: handle device reset event
From: Marcel Holtmann <marcel@holtmann.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: linux-bluetooth@vger.kernel.org, guy.cohen@intel.com,
	ron.rindjunsky@intel.com, Gregory Paskar <greogry.paskar@intel.com>
In-Reply-To: <1266486007-25015-1-git-send-email-tomas.winkler@intel.com>
References: <1266486007-25015-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 21 Feb 2010 11:27:29 +0100
Message-ID: <1266748049.18491.16.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

> From: Gregory Paskar <greogry.paskar@intel.com>
> 
> A bluetooth device experiencing hardware failure may issue
> a HARDWARE_ERROR hci event. The reaction to this event is device
> reset flow implemented in following sequence.

since Bluetooth is a brand name, I prefer you write it properly inside
the commit message or comments. The B is uppercase, everything else is
lowercase.

> 1. Notify: HCI_DEV_DOWN
> 2. Reinitialize internal structures.
> 3. Call driver flush function
> 4. Send HCI reset request to the device.
> 5. Send HCI init sequence reset to the device.
> 6. Notify HCI_DEV_UP.
> 
> Signed-off-by: Gregory Paskar <greogry.paskar@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Ron Rindjunsky <ron.rindjunsky@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    5 ++++
>  include/net/bluetooth/hci_core.h |    2 +
>  net/bluetooth/hci_core.c         |   40 +++++++++++++++++++++++++++++++++++++-
>  net/bluetooth/hci_event.c        |    3 ++
>  4 files changed, 49 insertions(+), 1 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ed3aea1..cd23eb4 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -691,6 +691,11 @@ struct hci_ev_cmd_status {
>  	__le16   opcode;
>  } __attribute__ ((packed));
>  
> +#define HCI_EV_HARDWARE_ERROR 0x10
> +struct hci_ev_hw_error {
> +	__u8     hw_code;
> +} __attribute__ ((packed));
> +
>  #define HCI_EV_ROLE_CHANGE		0x12
>  struct hci_ev_role_change {
>  	__u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 7b86094..d2b1cba 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -110,6 +110,8 @@ struct hci_dev {
>  	struct tasklet_struct	rx_task;
>  	struct tasklet_struct	tx_task;
>  
> +	struct work_struct 	hw_err_work;
> +
>  	struct sk_buff_head	rx_q;
>  	struct sk_buff_head	raw_q;
>  	struct sk_buff_head	cmd_q;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 94ba349..6002439 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -834,6 +834,44 @@ static int hci_rfkill_set_block(void *data, bool blocked)
>  	return 0;
>  }
>  
> +static void hci_device_hw_error(struct hci_dev *hdev)
> +{
> +	hci_req_lock(hdev);
> +	clear_bit(HCI_UP, &hdev->flags);
> +	hci_notify(hdev, HCI_DEV_DOWN);
> +	tasklet_disable(&hdev->tx_task);
> +	skb_queue_purge(&hdev->rx_q);
> +	skb_queue_purge(&hdev->cmd_q);
> +	hci_dev_lock_bh(hdev);
> +	inquiry_cache_flush(hdev);
> +	hci_conn_hash_flush(hdev);
> +	hci_dev_unlock_bh(hdev);
> +	if (hdev->flush)
> +		hdev->flush(hdev);
> +	atomic_set(&hdev->cmd_cnt, 1);
> +	hdev->acl_cnt = 0;
> +	hdev->sco_cnt = 0;
> +	hci_reset_req(hdev, 0);
> +	atomic_set(&hdev->cmd_cnt, 1);
> +	hci_init_req(hdev, 0);
> +	tasklet_enable(&hdev->tx_task);
> +	set_bit(HCI_UP, &hdev->flags);
> +	hci_notify(hdev, HCI_DEV_UP);
> +	hci_req_unlock(hdev);
> +}

This is a big block of commands. Almost impossible for anybody to follow
easily. You need to split them into small logical chunks and separate
them by empty lines.

Also I think there could be more unification with other init and reset
code inside hci_core.c.

> +
> +

I don't know where you get the double empty lines between functions
from, but I don't remember anything inside net/bluetooth/ doing it. And
even if, then that is an oversight.

> +static void hci_hw_err_work(struct work_struct *ws)
> +{
> +	struct hci_dev *hdev;
> +	hdev = container_of(ws, struct hci_dev, hw_err_work);

You could assign it directly at variable declaration.

> +	if (!hdev) {
> +		BT_DBG("%s: hci_hw_error_worker: hdev = NULL ", hdev->name);
> +		return;
> +	}

Can it really happen that hdev is NULL? Even if hdev goes away in
between, the pointer should be not NULL, it should be actually invalid
and cause more harm.

> +	hci_device_hw_error(hdev);
> +}
> +
>  static const struct rfkill_ops hci_rfkill_ops = {
>  	.set_block = hci_rfkill_set_block,
>  };
> @@ -903,7 +941,7 @@ int hci_register_dev(struct hci_dev *hdev)
>  	tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
>  	tasklet_init(&hdev->rx_task, hci_rx_task, (unsigned long) hdev);
>  	tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);
> -
> +	INIT_WORK(&hdev->hw_err_work, hci_hw_err_work);
>  	skb_queue_head_init(&hdev->rx_q);
>  	skb_queue_head_init(&hdev->cmd_q);
>  	skb_queue_head_init(&hdev->raw_q);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 28517ba..e8f48cc 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1953,6 +1953,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
>  	case HCI_EV_REMOTE_HOST_FEATURES:
>  		hci_remote_host_features_evt(hdev, skb);
>  		break;
> +	case HCI_EV_HARDWARE_ERROR:
> +		schedule_work(&hdev->hw_err_work);
> +		break;

The more I think about this, the more I feel like we should be
processing the HCI event in a work queue anyway. The sysfs integration
needs it and it is not a performance critical path anyway. The ACL and
SCO/eSCO packets are the only ones where processing in a tasklet really
matters.

Regards

Marcel


