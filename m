Return-Path: <cyrus@holtmann.org>
Message-ID: <1328284991.2062.35.camel@aeonflux>
Subject: Re: [PATCHv1 2/2] Bluetooth: Helper removes duplicated code
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 08:03:11 -0800
In-Reply-To: <1328279275-10303-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279275-10303-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1328279275-10303-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use __check_timout helper to remove duplicated code
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c |   31 +++++++++++++------------------
>  1 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9a56a40..95eeae5 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2390,22 +2390,25 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
>  	return DIV_ROUND_UP(skb->len - HCI_ACL_HDR_SIZE, hdev->block_len);
>  }
>  
> -static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
> +static inline void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
>  {
> -	struct hci_chan *chan;
> -	struct sk_buff *skb;
> -	int quote;
> -	unsigned int cnt;
> -
>  	if (!test_bit(HCI_RAW, &hdev->flags)) {
>  		/* ACL tx timeout must be longer than maximum
>  		 * link supervision timeout (40.9 seconds) */
> -		if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx +
> +		if (!cnt && time_after(jiffies, hdev->acl_last_tx +
>  					msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
>  			hci_link_tx_to(hdev, ACL_LINK);
>  	}
> +}
>  
> -	cnt = hdev->acl_cnt;
> +static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
> +{
> +	unsigned int cnt = hdev->acl_cnt;
> +	struct hci_chan *chan;
> +	struct sk_buff *skb;
> +	int quote;
> +
> +	__check_timeout(hdev, cnt);
>  
>  	while (hdev->acl_cnt &&
>  			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
> @@ -2438,20 +2441,12 @@ static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
>  
>  static inline void hci_sched_acl_blk(struct hci_dev *hdev)
>  {
> +	unsigned int cnt = hdev->block_cnt;
>  	struct hci_chan *chan;
>  	struct sk_buff *skb;
>  	int quote;
> -	unsigned int cnt;
> -
> -	if (!test_bit(HCI_RAW, &hdev->flags)) {
> -		/* ACL tx timeout must be longer than maximum
> -		 * link supervision timeout (40.9 seconds) */
> -		if (!hdev->block_cnt && time_after(jiffies, hdev->acl_last_tx +
> -					msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
> -			hci_link_tx_to(hdev, ACL_LINK);
> -	}
>  
> -	cnt = hdev->block_cnt;

maybe the patch is just funnily trying to be too smart, but I am missing
the cnt init here.

> +	__check_timeout(hdev, cnt);
>  
>  	while (hdev->block_cnt > 0 &&
>  			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {

Regards

Marcel


