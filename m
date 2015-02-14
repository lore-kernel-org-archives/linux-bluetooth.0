Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Add device shutdown routine for Intel Bluetooth device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150213092052.7d392608@tedd-test>
Date: Sat, 14 Feb 2015 15:41:57 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <0CA53D87-8632-4D53-9F08-282FB7CDC8BF@holtmann.org>
References: <20150213092052.7d392608@tedd-test>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds the device shutdown routine for Intel Bluetooth device.
> 
> Some platforms have BT LED issue with Intel Bluetooth device that BT LED goes
> off 5 seconds after BT is turned off
> 
> For Intel Bluetooth device, the BT LED is turned off when:
> - there is no active connection or radio activity
> - USB is suspend
> 
> So, when the BT is turned off, it takes 5 seconds because USB suspend timeone
> is 5 seconds by default. And if the USB suspend is not enabled, BT LED won't be
> turned off.
> 
> To fix this issue, recently Intel Bluetooth firmware patch had been submitted
> to turn off the BT LED immediately by the vendor specific command(0xFC3F). And
> this patch sends this command to the device before closing the device.
> 
> For backward compatibility of this command  with old firmware, this command was
> supported before, but it behaves same as HCI_RESET internally. So, it won't be
> the problem even if the system doesn't have the latest firmware patch.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b876888..b2c099a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2331,6 +2331,27 @@ static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> 	return 0;
> }
> 
> +static int btusb_shutdown_intel(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	long ret;
> +
> +	/* Some platforms have an issue with BT LED when hci interface is down or
> +	 * BT radio is turned off, which takes 5 seconds to BT LED goes off.
> +	 * This command turns off the BT LED immediately.
> +	 */

you need to make sure that you are not exceeding the 78 chars limit with your comment. I fixed that up before applying the patch.

> +	skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		ret = PTR_ERR(skb);
> +		BT_ERR("%s: turning off Intel device LED failed (%ld)",
> +		       hdev->name, ret);
> +		return ret;
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +

Patch has been applied to bluetooth-next tree.

Regards

Marcel

