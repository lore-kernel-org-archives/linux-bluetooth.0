Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [RFC 3/9] Bluetooth: Use Set ext adv/scan rsp data if controller
 supports
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512374873-1956-4-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Fri, 8 Dec 2017 09:46:07 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <077918E2-E423-4518-ABC9-54DD956FCC2C@holtmann.org>
References: <1512374873-1956-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1512374873-1956-4-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> This patch implements Set Ext Adv data and Set Ext Scan rsp data
> if controller support extended advertising.
> 
> Currently the operation is set as Complete data and fragment
> preference is set as no fragment
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> include/net/bluetooth/hci.h      |  29 +++++++
> include/net/bluetooth/hci_core.h |   6 +-
> net/bluetooth/hci_core.c         |   8 +-
> net/bluetooth/hci_request.c      | 177 ++++++++++++++++++++++++++++++++-------
> net/bluetooth/mgmt.c             |  18 +++-
> 5 files changed, 201 insertions(+), 37 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index dd6b9cb..997995d 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1587,6 +1587,30 @@ struct hci_cp_ext_adv_set {
> 	__u8  max_events;
> } __packed;
> 
> +#define HCI_MAX_EXT_AD_LENGTH		251
> +
> +#define HCI_OP_LE_SET_EXT_ADV_DATA		0x2037
> +struct hci_cp_le_set_ext_adv_data {
> +	__u8  handle;
> +	__u8  operation;
> +	__u8  fragment_preference;
> +	__u8  length;
> +	__u8  data[HCI_MAX_EXT_AD_LENGTH];
> +} __packed;
> +
> +#define HCI_OP_LE_SET_EXT_SCAN_RSP_DATA		0x2038
> +struct hci_cp_le_set_ext_scan_rsp_data {
> +	__u8  handle;
> +	__u8  operation;
> +	__u8  fragment_preference;
> +	__u8  length;
> +	__u8  data[HCI_MAX_EXT_AD_LENGTH];
> +} __packed;
> +
> +#define LE_SET_ADV_DATA_OP_COMPLETE	0x03
> +
> +#define LE_SET_ADV_DATA_NO_FRAG		0x01
> +
> /* ---- HCI Events ---- */
> #define HCI_EV_INQUIRY_COMPLETE		0x01
> 
> @@ -1984,6 +2008,11 @@ struct hci_ev_le_conn_complete {
> #define LE_LEGACY_SCAN_RSP_ADV		0x001b
> #define LE_LEGACY_SCAN_RSP_ADV_SCAN	0x001a
> 
> +/* Extended Advertising event types */
> +#define LE_EXT_ADV_NON_CONN_IND		0x0000
> +#define LE_EXT_ADV_CONN_IND		0x0001
> +#define LE_EXT_ADV_SCAN_IND		0x0002
> +
> #define ADDR_LE_DEV_PUBLIC	0x00
> #define ADDR_LE_DEV_RANDOM	0x01
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 2abeabb..610172a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -166,9 +166,9 @@ struct adv_info {
> 	__u16	remaining_time;
> 	__u16	duration;
> 	__u16	adv_data_len;
> -	__u8	adv_data[HCI_MAX_AD_LENGTH];
> +	__u8	adv_data[HCI_MAX_EXT_AD_LENGTH];
> 	__u16	scan_rsp_len;
> -	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
> +	__u8	scan_rsp_data[HCI_MAX_EXT_AD_LENGTH];

I don’t think you can do it this way. The legacy advertising is its own instance. So you need extra adv_data_ext[] field here since you need to track both. I would need to double check if some ext adv set number is magically matched to the legacy advertising, but I do not remember that.

Even if you use the new HCI commands to set up legacy advertising, the length does not magically increase.

Frankly I would like to see first that we use the new HCI commands to set up legacy advertising. That way we improve using multiple legacy advertising instances at the same time via controller offload and avoid rotation. That part should be figured out first and implemented before adding the extra length of PHY details.

And btw. we need mgmt-tester patches to test the correct behavior. The advertising API is rather complex and powerful.

Regards

Marcel

