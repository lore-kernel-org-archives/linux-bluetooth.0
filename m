Return-Path: <cyrus@holtmann.org>
Message-ID: <1322745223.26198.35.camel@aeonflux>
Subject: Re: [PATCHv2 5/8] Bluetooth: Add HCI Read Data Block Size function
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Dec 2011 14:13:43 +0100
In-Reply-To: <1322743335-8671-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322743335-8671-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Upstream Code Aurora function with minor trivial fixes.
> Origin: git://codeaurora.org/kernel/msm.git
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    8 ++++++++
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_event.c        |   31 +++++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index a6a2509..c5de256 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -741,6 +741,14 @@ struct hci_rp_read_bd_addr {
>  	bdaddr_t bdaddr;
>  } __packed;
>  
> +#define HCI_OP_READ_DATA_BLOCK_SIZE	0x100a
> +struct hci_rp_read_data_block_size {
> +	__u8     status;
> +	__le16   max_acl_len;
> +	__le16   block_len;
> +	__le16   num_blocks;
> +} __packed;
> +
>  #define HCI_OP_WRITE_PAGE_SCAN_ACTIVITY	0x0c1c
>  struct hci_cp_write_page_scan_activity {
>  	__le16   interval;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a7fd63a..869ab72 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -172,6 +172,8 @@ struct hci_dev {
>  
>  	__u8		flow_ctl_mode;
>  
> +	__u16		block_len;
> +
>  	unsigned int	auto_accept_delay;
>  
>  	unsigned long	quirks;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index efad012..a646310 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -774,6 +774,33 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
>  	hci_req_complete(hdev, HCI_OP_READ_BD_ADDR, rp->status);
>  }
>  
> +static void hci_cc_read_data_block_size(struct hci_dev *hdev,
> +							struct sk_buff *skb)
> +{
> +	struct hci_rp_read_data_block_size *rp = (void *) skb->data;
> +
> +	BT_DBG("%s status 0x%x", hdev->name, rp->status);
> +
> +	if (rp->status)
> +		return;
> +
> +	if (hdev->flow_ctl_mode == HCI_FLOW_CTL_MODE_BLOCK_BASED) {
> +		hdev->acl_mtu  = __le16_to_cpu(rp->max_acl_len);
> +		hdev->sco_mtu = 0;
> +		hdev->block_len = __le16_to_cpu(rp->block_len);
> +		/* acl_pkts indicates the number of blocks */
> +		hdev->acl_pkts = __le16_to_cpu(rp->num_blocks);
> +		hdev->sco_pkts = 0;
> +		hdev->acl_cnt = hdev->acl_pkts;
> +		hdev->sco_cnt = 0;
> +	}

I am still not convinced that overloading the variables is a good idea.
And so far nobody has me convinced that this is the best way.

Regards

Marcel


