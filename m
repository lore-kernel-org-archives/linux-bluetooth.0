Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Use default .cfg file name for RTL8723BS devices with id
 of OBDA8723
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180814064742.14519-1-ianwmorrison@gmail.com>
Date: Tue, 14 Aug 2018 09:00:43 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hdegoede@redhat.com
Message-Id: <B7F47DB8-B3B9-4F20-9DA1-3756B20ED866@holtmann.org>
References: <20180814064742.14519-1-ianwmorrison@gmail.com>
To: Ian W MORRISON <ianwmorrison@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> For RTL8723BS devices the current config file name is a composite of
> both the config name (rtl8723bs) and a postfix of the device-id.
> 
> Given the majority of RTL8723BS devices use a device-id of OBDA8723
> this simplifies the config file name to use "rtl8723bs_config.bin"
> as a default of for these devices.
> 
> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
> ---
> drivers/bluetooth/hci_h5.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..cce422dc1b8d 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -852,7 +852,9 @@ static int h5_btrtl_setup(struct h5 *h5)
> 	bool flow_control;
> 	int err;
> 
> -	btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
> +	btrtl_dev = strcmp("OBDA8723", h5->id) ?
> +		btrtl_initialize(h5->hu->hdev, h5->id) :
> +			btrtl_initialize(h5->hu->hdev, NULL);

I am not letting you duplicate the PNPID here. This needs to be done cleanly with the device table that is already present.

Regards

Marcel
