Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 2/2] Bluetooth: Add device shutdown routine for Intel Bluetooth device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150205114408.7c50ab05@tedd-test>
Date: Thu, 12 Feb 2015 11:49:31 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <B6C686CB-66CB-4EE7-9085-61DFF90C2471@holtmann.org>
References: <20150205114408.7c50ab05@tedd-test>
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
> to turn off the BT LED explicitly by the vendor specific command(0xFC3F). And
> this patch sends this command to the device before closing the device.
> 
> For backward compatibility of this command  with old firmware, this command was
> supported before, but it behaves same as HCI_RESET internally. So, it won't be
> the problem even if the system doesn't have the latest firmware patch.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b876888..e0f8a15 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2331,6 +2331,23 @@ static int btusb_set_bdaddr_intel(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> 	return 0;
> }
> 
> +static int btusb_shutdown_intel(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	long ret;
> +

please add a comment on why we are doing this and what it does. I know you have it in the commit message, but I think an extra one would be helpful here.

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
> static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
> 				    const bdaddr_t *bdaddr)
> {
> @@ -2709,6 +2726,7 @@ static int btusb_probe(struct usb_interface *intf,
> 	if (id->driver_info & BTUSB_INTEL) {
> 		hdev->setup = btusb_setup_intel;
> 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
> +		hdev->shutdown = btusb_shutdown_intel;

Please sort it after setup().

Regards

Marcel

