Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [RFC 9/9] Bluetooth: Implement secondary advertising on different
 PHYs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512374873-1956-10-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Fri, 8 Dec 2017 10:00:07 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <33D18E80-05B4-45B6-936D-F292AFC00850@holtmann.org>
References: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1512374873-1956-10-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> This patch adds support for advertising in primary and secondary
> channel on different PHYs. User can add the phy preference in
> the flag based on which phy type will be added in extended
> advertising parameter would be set.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> include/net/bluetooth/hci.h  |  6 +++++-
> include/net/bluetooth/mgmt.h |  6 ++++++
> net/bluetooth/hci_request.c  | 18 +++++++++++++++---
> net/bluetooth/mgmt.c         | 18 ++++++++++++++++--
> 4 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1337fbf..40a22e2 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -398,6 +398,8 @@ enum {
> #define HCI_LE_SLAVE_FEATURES		0x08
> #define HCI_LE_PING			0x10
> #define HCI_LE_DATA_LEN_EXT		0x20
> +#define HCI_LE_PHY_2M			0x01
> +#define HCI_LE_PHY_CODED		0x08
> #define HCI_LE_EXT_ADV			0x10
> #define HCI_LE_EXT_SCAN_POLICY		0x80
> 
> @@ -1507,7 +1509,9 @@ struct hci_cp_le_set_ext_scan_params {
>         __u8	data[0];
> } __packed;
> 
> -#define LE_PHY_1M 0x01
> +#define LE_PHY_1M 	0x01
> +#define LE_PHY_2M 	0x02
> +#define LE_PHY_CODED	0x03
> 
> struct hci_cp_le_scan_phy_params {
>         __u8	type;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 72a456b..f1055dd 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -561,6 +561,12 @@ struct mgmt_rp_add_advertising {
> #define MGMT_ADV_FLAG_TX_POWER		BIT(4)
> #define MGMT_ADV_FLAG_APPEARANCE	BIT(5)
> #define MGMT_ADV_FLAG_LOCAL_NAME	BIT(6)
> +#define MGMT_ADV_FLAG_SEC_1M 		BIT(7)
> +#define MGMT_ADV_FLAG_SEC_2M 		BIT(8)
> +#define MGMT_ADV_FLAG_SEC_CODED 	BIT(9)
> +
> +#define MGMT_ADV_FLAG_SEC_MASK	(MGMT_ADV_FLAG_SEC_1M | MGMT_ADV_FLAG_SEC_2M | \
> +				 MGMT_ADV_FLAG_SEC_CODED)
> 
> #define MGMT_OP_REMOVE_ADVERTISING	0x003F
> struct mgmt_cp_remove_advertising {
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 9d0a940..68c2f18 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1590,7 +1590,8 @@ static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
> 		return;
> 
> 	secondary_adv = (adv_inst->adv_data_len > HCI_MAX_AD_LENGTH ||
> -			 adv_inst->scan_rsp_len > HCI_MAX_AD_LENGTH);
> +			 adv_inst->scan_rsp_len > HCI_MAX_AD_LENGTH ||
> +			 flags & MGMT_ADV_FLAG_SEC_MASK);
> 
> 	if (connectable) {
> 		if (secondary_adv)
> @@ -1612,8 +1613,19 @@ static void __hci_req_setup_ext_adv_instance(struct hci_request *req,
> 	cp.own_addr_type = own_addr_type;
> 	cp.channel_map = hdev->le_adv_channel_map;
> 	cp.tx_power = 127;
> -	cp.primary_phy = LE_PHY_1M;
> -	cp.secondary_phy = LE_PHY_1M;
> +
> +	if (flags & MGMT_ADV_FLAG_SEC_2M){
> +		cp.primary_phy = LE_PHY_1M;
> +		cp.secondary_phy = LE_PHY_2M;
> +	} else if (flags & MGMT_ADV_FLAG_SEC_CODED) {
> +		cp.primary_phy = LE_PHY_CODED;
> +		cp.secondary_phy = LE_PHY_CODED;
> +	} else {
> +		/* In all other cases use 1M */
> +		cp.primary_phy = LE_PHY_1M;
> +		cp.secondary_phy = LE_PHY_1M;
> +	}
> +
> 	cp.handle = instance;
> 
> 	hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp), &cp);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 120da46..68cf080 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5996,6 +5996,16 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
> 	flags |= MGMT_ADV_FLAG_APPEARANCE;
> 	flags |= MGMT_ADV_FLAG_LOCAL_NAME;
> 
> +	if (ext_adv_capable(hdev)) {
> +		flags |= MGMT_ADV_FLAG_SEC_1M;
> +
> +		if (hdev->le_features[1] & HCI_LE_PHY_2M)
> +			flags |= MGMT_ADV_FLAG_SEC_2M;
> +
> +		if (hdev->le_features[1] & HCI_LE_PHY_CODED)
> +			flags |= MGMT_ADV_FLAG_SEC_CODED;
> +	}
> +
> 	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID)
> 		flags |= MGMT_ADV_FLAG_TX_POWER;
> 
> @@ -6246,10 +6256,14 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
> 	duration = __le16_to_cpu(cp->duration);
> 
> 	/* The current implementation only supports a subset of the specified
> -	 * flags.
> +	 * flags. Also need to check mutual exclusiveness of sec flags.
> 	 */
> 	supported_flags = get_supported_adv_flags(hdev);
> -	if (flags & ~supported_flags)
> +	if (flags & ~supported_flags ||
> +	    ((flags & MGMT_ADV_FLAG_SEC_MASK) != 0 &&
> +	     (flags & MGMT_ADV_FLAG_SEC_MASK) != MGMT_ADV_FLAG_SEC_1M &&
> +	     (flags & MGMT_ADV_FLAG_SEC_MASK) != MGMT_ADV_FLAG_SEC_2M &&
> +	     (flags & MGMT_ADV_FLAG_SEC_MASK) != MGMT_ADV_FLAG_SEC_CODED))

define a mask value for this and do some bit trickery. I think there are even CPU macros for bit counting in the worst case. However a simple XOR and then AND with the mask value checked against 0 should do the trick.

Regards

Marcel

