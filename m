Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 2/2] Bluletooth: Add hardware reset callback to reset
 intel bluetooth chip
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1534844080-31240-2-git-send-email-raghuram.hegde@intel.com>
Date: Tue, 21 Aug 2018 16:14:14 +0200
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
        sukumar.ghorai@intel.com, amit.k.bag@intel.com
Message-Id: <45FE6D00-AF3A-4110-A0A6-B021590A8AAF@holtmann.org>
References: <1534844080-31240-1-git-send-email-raghuram.hegde@intel.com>
 <1534844080-31240-2-git-send-email-raghuram.hegde@intel.com>
To: Raghuram Hegde <raghuram.hegde@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raghuram,

having no commit message is not acceptable. You need to explain what the patch is doing.

> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> ---
> drivers/bluetooth/btusb.c        | 2 ++
> include/net/bluetooth/hci_core.h | 1 +
> 2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index cd2e5cf14ea5..908f8105b3af 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3083,6 +3083,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->shutdown = btusb_shutdown_intel;
> 		hdev->set_diag = btintel_set_diag_mfg;
> 		hdev->set_bdaddr = btintel_set_bdaddr;
> +		hdev->hw_reset = btintel_reset_bt;
> 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> @@ -3095,6 +3096,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->hw_error = btintel_hw_error;
> 		hdev->set_diag = btintel_set_diag;
> 		hdev->set_bdaddr = btintel_set_bdaddr;
> +		hdev->hw_reset = btintel_reset_bt;
> 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> 	}
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0db1b9b428b7..9765ba78be2c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -427,6 +427,7 @@ struct hci_dev {
> 	int (*post_init)(struct hci_dev *hdev);
> 	int (*set_diag)(struct hci_dev *hdev, bool enable);
> 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> +	void (*hw_reset)(struct hci_dev *hdev, unsigned char code);
> };

So where is this callback used?

Regards

Marcel
