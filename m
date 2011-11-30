Return-Path: <cyrus@holtmann.org>
Message-ID: <1322663182.26198.12.camel@aeonflux>
Subject: Re: [PATCHv1 6/6] Bluetooth: Recalculate sched for HCI block flow
 ctrl
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 30 Nov 2011 15:26:22 +0100
In-Reply-To: <1322645765-9519-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322645765-9519-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322645765-9519-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Upstream Code Aurora code with trivial fixes.
> Origin: git://codeaurora.org/kernel/msm.git
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |   25 ++++++++++++++++++++-----
>  1 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 4a0391e..360b44c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2290,10 +2290,12 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
>  
>  	cnt = hdev->acl_cnt;
>  
> -	while (hdev->acl_cnt &&
> +	while (hdev->acl_cnt > 0 &&
>  			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
>  		u32 priority = (skb_peek(&chan->data_q))->priority;
> -		while (quote-- && (skb = skb_peek(&chan->data_q))) {
> +		while (quote > 0 && (skb = skb_peek(&chan->data_q))) {
> +			int blocks = 1;
> +
>  			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
>  					skb->len, skb->priority);
>  
> @@ -2303,15 +2305,28 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
>  
>  			skb = skb_dequeue(&chan->data_q);
>  
> +			if (hdev->flow_ctl_mode ==
> +					HCI_FLOW_CTL_MODE_BLOCK_BASED)
> +				/* Calculate count of blocks used by
> +				 * this packet
> +				 */
> +				blocks = DIV_ROUND_UP(skb->len -
> +					HCI_ACL_HDR_SIZE, hdev->block_len);

would it not be more efficient to have to functions here? One
hci_sched_acl_block and one hci_sched_acl_pkt which implement the
specific details of the flow control mode. And the hci_sched_acl would
just decide which on to call once.

> +
> +			if (blocks > hdev->acl_cnt)
> +				return;
> +
>  			hci_conn_enter_active_mode(chan->conn,
>  						bt_cb(skb)->force_active);

Now an important question that comes up here. The support for the power
save mode (sniff mainly) and AMP controllers is fully pointless. We need
to actually make sure we don't try to put an AMP controller into sniff
mode since that seems like an attempt for failure.

Regards

Marcel


