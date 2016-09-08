Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/3] Bluetooth: Add support for appearance in scan rsp
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1473280837-4093-2-git-send-email-szymon.janc@codecoup.pl>
Date: Thu, 8 Sep 2016 06:45:48 +0100
Cc: linux-bluetooth@vger.kernel.org,
        =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Message-Id: <8C3FD17A-3F2A-4F61-ADFE-55C0AD8F4C1A@holtmann.org>
References: <1473280837-4093-1-git-send-email-szymon.janc@codecoup.pl> <1473280837-4093-2-git-send-email-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This patch enables prepending appearance value to scan response data.
> It also adds support for setting appearance value through mgmt command.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> include/net/bluetooth/mgmt.h     |  6 ++++++
> net/bluetooth/hci_request.c      |  9 +++++++++
> net/bluetooth/mgmt.c             | 40 ++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 56 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a48f71d..f00bf66 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -211,6 +211,7 @@ struct hci_dev {
> 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
> 	__u8		short_name[HCI_MAX_SHORT_NAME_LENGTH];
> 	__u8		eir[HCI_MAX_EIR_LENGTH];
> +	__u16		appearance;
> 	__u8		dev_class[3];
> 	__u8		major_class;
> 	__u8		minor_class;
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 611b243..72a456b 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -598,6 +598,12 @@ struct mgmt_rp_read_ext_info {
> 	__u8     eir[0];
> } __packed;
> 
> +#define MGMT_OP_SET_APPEARANCE		0x0043
> +struct mgmt_cp_set_appearance {
> +	__u16	appearance;
> +} __packed;
> +#define MGMT_SET_APPEARANCE_SIZE	2
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index d1839d2..ac683d1 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1015,6 +1015,15 @@ static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
> 
> 	instance_flags = adv_instance->flags;
> 
> +	if (instance_flags & MGMT_ADV_FLAG_APPEARANCE &&
> +	    hdev->appearance != 0x0000) {
> +		ptr[0] = 3;
> +		ptr[1] = 2;

Lets use the proper constant for this.

> +		memcpy(ptr + 2, &hdev->appearance, 2);

And this is broken. put_unaligned_le16.

> +		scan_rsp_len += 4;
> +		ptr += 4;
> +	}
> +
> 	memcpy(ptr, adv_instance->scan_rsp_data,
> 	       adv_instance->scan_rsp_len);
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5f6942d..5eb8716 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -105,6 +105,7 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_GET_ADV_SIZE_INFO,
> 	MGMT_OP_START_LIMITED_DISCOVERY,
> 	MGMT_OP_READ_EXT_INFO,
> +	MGMT_OP_SET_APPEARANCE,
> };
> 
> static const u16 mgmt_events[] = {
> @@ -3112,6 +3113,40 @@ failed:
> 	return err;
> }
> 
> +static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
> +			  u16 len)
> +{
> +	struct mgmt_cp_set_appearance *cp = data;
> +	int err;
> +
> +	BT_DBG("");
> +
> +	hci_dev_lock(hdev);
> +
> +	/* If the old values are the same as the new ones just return a
> +	 * direct command complete event.
> +	 */
> +	if (hdev->appearance == cp->appearance) {
> +		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_APPEARANCE, 0,
> +					data, len);
> +		goto failed;
> +	}
> +
> +	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
> +		mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_APPEARANCE,
> +				MGMT_STATUS_BUSY);
> +		goto failed;

Why? Lets expire the advertising instance right away and not introduce broken code in the first place.

> +	}
> +
> +	hdev->appearance = cp->appearance;
> +
> +	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_APPEARANCE, 0,
> +				data, len);
> +failed:

Use unlock: or done: as label name here.

> +	hci_dev_unlock(hdev);
> +	return err;
> +}
> +
> static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
> 				         u16 opcode, struct sk_buff *skb)
> {
> @@ -5887,6 +5922,7 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
> 	flags |= MGMT_ADV_FLAG_DISCOV;
> 	flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
> 	flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
> +	flags |= MGMT_ADV_FLAG_APPEARANCE;
> 	flags |= MGMT_ADV_FLAG_LOCAL_NAME;
> 
> 	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID)
> @@ -5964,6 +6000,9 @@ static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
> 			tx_power_managed = true;
> 			max_len -= 3;
> 		}
> +	} else {
> +		if (adv_flags & MGMT_ADV_FLAG_APPEARANCE)
> +			max_len -= 4;
> 	}

And I am missing the update to tlv_data_max_len function. Feel free to unify it if you can.

> 
> 	if (len > max_len)
> @@ -6431,6 +6470,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
> 	{ start_limited_discovery, MGMT_START_DISCOVERY_SIZE },
> 	{ read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
> 						HCI_MGMT_UNTRUSTED },
> +	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
> };

Regards

Marcel

