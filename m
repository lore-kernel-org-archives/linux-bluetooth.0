Return-Path: <cyrus@holtmann.org>
Message-ID: <1322221373.29909.15.camel@aeonflux>
Subject: Re: [RFC 2/2] Bluetooth: Add HCI Read Data Block Size function
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 25 Nov 2011 12:42:53 +0100
In-Reply-To: <1322062515-8475-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322062515-8475-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322062515-8475-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
>  include/net/bluetooth/hci.h      |   11 +++++++++++
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_event.c        |   31 +++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ee83c36..324883a 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -271,6 +271,9 @@ enum {
>  #define HCI_ERROR_LOCAL_HOST_TERM	0x16
>  #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
>  
> +/* Flow control modes */
> +#define HCI_BLOCK_BASED_FLOW_CTL_MODE	0x01
> +

isn't this better HCI_FLOW_CTL_MODE_BLOCK_BASED. Especially if you also
wanna define the packet based one.

>  /* -----  HCI Commands ---- */
>  #define HCI_OP_NOP			0x0000
>  
> @@ -737,6 +740,14 @@ struct hci_rp_read_bd_addr {
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
> index 23ccb61..8413b29 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -771,6 +771,33 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
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
> +	if (hdev->flow_ctl_mode == HCI_BLOCK_BASED_FLOW_CTL_MODE) {
> +		hdev->acl_mtu  = __le16_to_cpu(rp->max_acl_len);
> +		hdev->sco_mtu = 0;
> +		hdev->block_len = __le16_to_cpu(rp->block_len);
> +		/* acl_pkts indicates the number of blocks */
> +		hdev->acl_pkts = __le16_to_cpu(rp->num_blocks);
> +		hdev->sco_pkts = 0;
> +		hdev->acl_cnt = hdev->acl_pkts;
> +		hdev->sco_cnt = 0;
> +	}

Do we just wanna use use previous packet based flow variables. Is that
really a good idea? Shouldn't we separate it?

> +
> +	BT_DBG("%s acl mtu %d:%d, block len %d", hdev->name, hdev->acl_mtu,
> +					hdev->acl_cnt, hdev->block_len);
> +
> +	hci_req_complete(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, rp->status);
> +}
> +
>  static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	__u8 status = *((__u8 *) skb->data);
> @@ -1978,6 +2005,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
>  		hci_cc_read_bd_addr(hdev, skb);
>  		break;
>  
> +	case HCI_OP_READ_DATA_BLOCK_SIZE:
> +		hci_cc_read_data_block_size(hdev, skb);
> +		break;
> +
>  	case HCI_OP_WRITE_CA_TIMEOUT:
>  		hci_cc_write_ca_timeout(hdev, skb);
>  		break;

Regards

Marcel


