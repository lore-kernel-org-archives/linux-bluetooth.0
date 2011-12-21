Return-Path: <cyrus@holtmann.org>
Message-ID: <1324434516.1965.159.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: btusb: fix bInterval for high/super speed
 isochronous endpoints
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
	Gustavo Padovan <padovan@profusion.mobi>
Date: Tue, 20 Dec 2011 18:28:36 -0800
In-Reply-To: <1324433940-16838-1-git-send-email-bzhao@marvell.com>
References: <1324433940-16838-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> For high-speed/super-speed isochronous endpoints, the bInterval
> value is used as exponent, 2^(bInterval-1). Luckily we have
> usb_fill_int_urb() function that handles it correctly. So we just
> call this function to fill in the RX URB.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
>  drivers/bluetooth/btusb.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ea5ad1c..a67c6db 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -508,15 +508,10 @@ static int btusb_submit_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
>  
>  	pipe = usb_rcvisocpipe(data->udev, data->isoc_rx_ep->bEndpointAddress);
>  
> -	urb->dev      = data->udev;
> -	urb->pipe     = pipe;
> -	urb->context  = hdev;
> -	urb->complete = btusb_isoc_complete;
> -	urb->interval = data->isoc_rx_ep->bInterval;
> +	usb_fill_int_urb(urb, data->udev, pipe, buf, size, btusb_isoc_complete,
> +				hdev, data->isoc_rx_ep->bInterval);
>  
>  	urb->transfer_flags  = URB_FREE_BUFFER | URB_ISO_ASAP;
> -	urb->transfer_buffer = buf;
> -	urb->transfer_buffer_length = size;

this looks better. And don't ask me why I did not do that from the
beginning ;)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


