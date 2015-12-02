Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v2] Bluetooth: btintel: Add manufacturing enter/exit helpers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449067068-9707-1-git-send-email-loic.poulain@intel.com>
Date: Wed, 2 Dec 2015 07:52:05 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <733BD25D-9053-44CD-8A96-2BE381BFD807@holtmann.org>
References: <1449067068-9707-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Older Intel controllers need to enter manufacturing mode to perform
> some vendor specific operations (patching, configuration...).
> Add enter/exit manufaturing methods and refactor existing
> manufacturing code.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: add static definition if !CONFIG_BT_INTEL
> 
> drivers/bluetooth/btintel.c | 109 ++++++++++++++++++++++----------------------
> drivers/bluetooth/btintel.h |  12 +++++
> drivers/bluetooth/btusb.c   |  54 ++++++----------------
> 3 files changed, 81 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 1f13e61..e9f26eb 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -73,6 +73,43 @@ int btintel_check_bdaddr(struct hci_dev *hdev)
> }
> EXPORT_SYMBOL_GPL(btintel_check_bdaddr);
> 
> +int btintel_enter_mfg(struct hci_dev *hdev)
> +{
> +	const u8 param[] = { 0x01, 0x00 };
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc11, 2, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Entering manufacturer mode failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_enter_mfg);
> +
> +int btintel_exit_mfg(struct hci_dev *hdev, bool reset, bool patched)
> +{
> +	u8 param[] = { 0x00, 0x00 };
> +	struct sk_buff *skb;
> +

please add a comment above this that talks about activating / deactivating patches. From the original code this was obvious since it was in the command buffer name.

The 0x02 means reset and activate patches while 0x01 means reset and deactivate patches. So a comment spelling this out in plain English would help here to understand what the patched parameter means.

And of course reset == false means that we just disable manufacturer mode. So mentioning that would be useful as well.

> +	if (reset)
> +		param[1] |= patched ? 0x02 : 0x01;
> +
> +	skb = __hci_cmd_sync(hdev, 0xfc11, 2, param, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		bt_dev_err(hdev, "Exiting manufacturer mode failed (%ld)",
> +			   PTR_ERR(skb));
> +		return PTR_ERR(skb);
> +	}
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btintel_exit_mfg);

Regards

Marcel

