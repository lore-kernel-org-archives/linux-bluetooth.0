Return-Path: <cyrus@holtmann.org>
Message-ID: <1323093294.26198.52.camel@aeonflux>
Subject: Re: [RFCv1 3/3] Bluetooth: Process num completed data blocks event
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 05 Dec 2011 14:54:54 +0100
In-Reply-To: <1323089704-1005-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323089704-1005-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1323089704-1005-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Adds support for Number Of Completed Data Blocks Event. Highly
> modified version of Code Aurora code.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h |    7 +++++
>  net/bluetooth/hci_event.c   |   61 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 9490c2c..0a6193e 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1149,6 +1149,13 @@ struct hci_ev_le_meta {
>  	__u8     subevent;
>  } __packed;
>  
> +#define HCI_EV_NUM_COMP_BLOCKS		0x48
> +struct hci_ev_num_comp_blocks {
> +	__le16   num_blocks;
> +	__u8     num_hndl;
> +	/* variable length part */
> +} __packed;
> +
>  /* Low energy meta events */
>  #define HCI_EV_LE_CONN_COMPLETE		0x01
>  struct hci_ev_le_conn_complete {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index fd7e6b5..26e4d38 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2325,6 +2325,63 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
>  	tasklet_enable(&hdev->tx_task);
>  }
>  
> +static inline void hci_num_comp_blocks_evt(struct hci_dev *hdev,
> +							struct sk_buff *skb)
> +{
> +	struct hci_ev_num_comp_blocks *ev = (void *) skb->data;
> +	__le16 *ptr;
> +	int i;
> +
> +	skb_pull(skb, sizeof(*ev));
> +
> +	BT_DBG("%s num_blocks %d num_hndl %d", hdev->name, ev->num_blocks,
> +								ev->num_hndl);
> +
> +	if (skb->len < ev->num_hndl * 6) {
> +		BT_DBG("%s bad parameters", hdev->name);
> +		return;
> +	}
> +
> +	if (hdev->dev_type != HCI_BREDR)
> +		return;

This check is bogus. Check for current flow control mode and not the
controller type.

> +	tasklet_disable(&hdev->tx_task);
> +
> +	for (i = 0, ptr = (__le16 *) skb->data; i < ev->num_hndl; i++) {
> +		struct hci_conn *conn;
> +		__u16  handle, block_count;
> +
> +		handle = get_unaligned_le16(ptr++);
> +
> +		/* Skip packet count*/
> +		ptr++;
> +
> +		block_count = get_unaligned_le16(ptr++);

I think the info struct here would also make this part a lot easier to
read.

> +
> +		conn = hci_conn_hash_lookup_handle(hdev, handle);
> +		if (!conn)
> +			continue;
> +
> +		conn->sent -= block_count;
> +
> +		switch (conn->type) {
> +		case ACL_LINK:
> +			hdev->block_cnt += block_count;
> +			if (hdev->block_cnt > hdev->num_blocks)
> +				hdev->block_cnt = hdev->num_blocks;
> +			break;
> +
> +		default:
> +			BT_ERR("Not implemented for type %d", conn->type);
> +			break;
> +		}
> +	}
> +
> +	tasklet_schedule(&hdev->tx_task);
> +
> +	tasklet_enable(&hdev->tx_task);
> +}

The sooner we move everything over to processing within a workqueue, the
better. I am not even sure why just disabling the tx_task tasklet is
enough to not lock hci_dev. It is too long ago. The last time I touched
this code was in 2007.

Regards

Marcel



