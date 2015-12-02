Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 5/5] bluetooth: hci_intel: Add LhP support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448650563-9075-5-git-send-email-loic.poulain@intel.com>
Date: Tue, 1 Dec 2015 21:59:00 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <205F31A4-4BE0-43F5-8526-07194FB4D44E@holtmann.org>
References: <1448650563-9075-1-git-send-email-loic.poulain@intel.com> <1448650563-9075-5-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add Support for LhP(IBT-2.1) Intel controller.
> This controller requests bddata configuration before being able to
> work properly. The setup is done in manufacturing mode.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 70 +++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 95bc57c..7314d37 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -888,6 +888,64 @@ no_lpm:
> 	return 0;
> }
> 
> +static int intel_setup_lhp(struct hci_uart *hu, struct intel_version *ver)
> +{
> +	static const u8 mfg_enable[] = { 0x01, 0x00 };
> +	static const u8 mfg_reset_deactivate[] = { 0x00, 0x01 };
> +	const struct firmware *fw;
> +	char fwname[32];
> +	const u8 *fw_ptr;
> +	struct hci_dev *hdev = hu->hdev;
> +	struct sk_buff *skb;
> +	int err;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_enable), mfg_enable,
> +			     HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Enabling manufacturer mode failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	bt_dev_info(hdev, "Applying bddata");
> +
> +	snprintf(fwname, sizeof(fwname), "intel/ibt-10-%u.bddata",
> +		 ver->hw_revision);

I think we need to use a more detailed versioning name. It is a ROM chip and depending on its version, this might differ. This simple firmware names only work for LnP which are RAM chips.

> +
> +	err = request_firmware(&fw, fwname, &hdev->dev);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to load Intel bddata file %s (%d)",
> +			   fwname, err);
> +		return PTR_ERR(skb);
> +	}
> +
> +	fw_ptr = fw->data;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc2f, fw->size, fw->data, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Applying bddata failed (%ld)", PTR_ERR(skb));
> +		release_firmware(fw);
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	release_firmware(fw);
> +
> +	/* Disable the manufacturer mode, reset, deactivate fw patched version.
> +	 */
> +	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_reset_deactivate),
> +			     mfg_reset_deactivate, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
> +		       hdev->name, PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> static int intel_setup(struct hci_uart *hu)
> {
> 	static const u8 mfg_enable[] = { 0x01, 0x00 };
> @@ -975,6 +1033,9 @@ setup:
> 	case 0x0b:
> 		err = intel_setup_lnp(hu, ver);
> 		break;
> +	case 0x0a:
> +		err = intel_setup_lhp(hu, ver);
> +		break;
> 	default:
> 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
> 			   ver->hw_variant);
> @@ -1040,6 +1101,15 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> 		bt_dev_err(hdev, "Controller requests manufacturing");
> 		set_bit(STATE_REQ_MANUFACTURING, &intel->flags);
> 		inject_cmd_complete(hdev, 0xfc05, 0x01);
> +
> +	/* Instead of responding to bddata command with a command complete event
> +	 * LhP controller returns a command status event. In order to complete
> +	 * the ongoing bddata command generate a command complete event from
> +	 * the command status one.
> +	 */

What is wrong with using __hci_cmd_sync_ev for these cases?


> +	} else if (skb->len >= 6 && hdr->evt == 0x0f && skb->data[4] == 0x2f &&
> +		   skb->data[5] == 0xfc) {
> +		inject_cmd_complete(hdev, 0xfc2f, skb->data[2]);
> 	}
> recv:
> 	return hci_recv_frame(hdev, skb);

Regards

Marcel

