Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 1/2] Bluetooth: Add setup callback for chip init on USB path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f185108a5a8f4f9fa420a17a35d8225d@nalasexr02e.na.qualcomm.com>
Date: Sat, 14 Feb 2015 15:34:12 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <A896D6D4-D811-4CAE-A460-CE0599ABD3B5@holtmann.org>
References: <f185108a5a8f4f9fa420a17a35d8225d@nalasexr02e.na.qualcomm.com>
To: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> This callback is for initialization of BT chipset through USB channel
> Some of chipset does not allow sending a patch or config files through
> HCI VS channel at early stage as well as they don't support to send
> USB patch files to other channel except USB bulk path.
> 
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
> drivers/bluetooth/btusb.c        | 9 +++++++++
> include/net/bluetooth/hci_core.h | 1 +
> 2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b876888..102020d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -887,6 +887,15 @@ static int btusb_open(struct hci_dev *hdev)
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	/* Patching USB firmware files prior to starting any URBs of HCI path
> +	 * It is more safe to use USB bulk channel for downloading USB patch
> +	 */
> +	if (hdev->setup_on_usb) {
> +		err = hdev->setup_on_usb(hdev);
> +		if (err <0)
> +			return err;
> +	}
> +

this is a blunt layer violation. You should not be calling callbacks from the hci_dev struct. That is none of the drivers business.

> 	err = usb_autopm_get_interface(data->intf);
> 	if (err < 0)
> 		return err;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 52863c3..1938582 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -373,6 +373,7 @@ struct hci_dev {
> 	int (*close)(struct hci_dev *hdev);
> 	int (*flush)(struct hci_dev *hdev);
> 	int (*setup)(struct hci_dev *hdev);
> +	int (*setup_on_usb)(struct hci_dev *hdev);

We can not do it this way. The core is transport and vendor agnostic. There is no business in the core for dealing with USB or vendor specific details.

Regards

Marcel

