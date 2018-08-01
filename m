Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: btusb: Add HCI reset command on BT shutdown
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1533104622-835-1-git-send-email-amit.k.bag@intel.com>
Date: Wed, 1 Aug 2018 09:16:12 +0200
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com
Message-Id: <FB8FF20C-495C-4F81-93F5-B387F67E2293@holtmann.org>
References: <1533104622-835-1-git-send-email-amit.k.bag@intel.com>
To: Amit K Bag <amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amit,

> In case of BT turn off from UI it is safe to add HCI reset command
> which will maintain the controller state.

this needs to be a bit more details since hdev->shutdown handling is really only for the older Intel controllers.

Also I am failing to see why HCI Reset helps or what it does here. It is going to be called again on hdev->open the next time the controller is activated.

> 
> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> ---
> drivers/bluetooth/btusb.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 572fd75fbcf6..599ec9b12d3f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2369,6 +2369,18 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
> 	struct sk_buff *skb;
> 	long ret;
> 
> +	/* In case of BT off from UI it is safe to do HCI reset.
> +	 * This will maintain the controller state.
> +	 */

I do not care what the UI does here. This is power down operation and so it needs to be explained properly. And with a lot more details since I am failing to understand what state is maintained on HCI Reset. As per specification it will reset all Bluetooth states back to the defaults.

> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +        if (IS_ERR(skb)) {
> +		ret = PTR_ERR(skb);
> +		BT_ERR("%s: BT controller  HCI reset failed (%ld)",
> +		       hdev->name, ret);
> +		return ret;
> +	}
> +	kfree_skb(skb);
> +

There is whitespace damage here. And if this hasn’t been done yet, please first start using bt_dev_err instead of BT_ERR for the Intel parts.

> 	/* Some platforms have an issue with BT LED when the interface is
> 	 * down or BT radio is turned off, which takes 5 seconds to BT LED
> 	 * goes off. This command turns off the BT LED immediately.

Regards

Marcel

