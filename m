Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Nov 2011 14:24:28 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: use buffer priority to mark URB_ISO_ASAP
 flag
Message-ID: <20111130172428.GA9425@samus>
References: <1320241924-2300-1-git-send-email-luiz.dentz@gmail.com>
 <1320241924-2300-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320241924-2300-4-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 15:52 Wed 02 Nov, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  drivers/bluetooth/btusb.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index abfc4ee..9db2476 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -727,6 +727,9 @@ static int btusb_send_frame(struct sk_buff *skb)
>  		usb_fill_bulk_urb(urb, data->udev, pipe,
>  				skb->data, skb->len, btusb_tx_complete, skb);
>  
> +		if (skb->priority >= HCI_PRIO_MAX - 1)
> +			urb->transfer_flags  = URB_ISO_ASAP;
> +

In case someone is having problems:

With CONFIG_USB_DEBUG enabled the check that the URB_ISO_ASAP flag is
not valid for bulk endpoints is enabled, and that urb is rejected.

>  		hdev->stat.acl_tx++;
>  		break;
>  
> -- 
> 1.7.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
