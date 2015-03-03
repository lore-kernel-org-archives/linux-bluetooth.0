Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: Add setup callback for chip init on USB
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <ed9be4d986c749d7a0b35a335184a932@nalasexr02e.na.qualcomm.com>
Date: Mon, 2 Mar 2015 17:10:15 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <432FC4CE-3058-4C15-A8E5-523CE34C170E@holtmann.org>
References: <ed9be4d986c749d7a0b35a335184a932@nalasexr02e.na.qualcomm.com>
To: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> Some of chipset does not allow to send a patch or config files through
> HCI VS channel at early stage as well as they don't support to send
> USB patch files to other channel except USB bulk path.
> 
> New callback added is for initialization of BT controller through USB
> 
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
> drivers/bluetooth/btusb.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3ca2e1b..73e1066 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -337,6 +337,8 @@ struct btusb_data {
> 
> 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
> +
> +	int (*setup_on_usb)(struct hci_dev *hdev);
> };

I am still not really comfortable with the name setup_on_usb, but I also failed to come up with anything better in the last two weeks. So I decided to merge this to give the patch larger exposure. My failure to figure out a better consistent naming should not stand in the way of supporting your devices.

Patch has been applied to bluetooth-next tree.

Regards

Marcel

