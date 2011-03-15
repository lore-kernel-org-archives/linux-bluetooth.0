Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Mar 2011 12:38:09 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth-next] Bluetooth: fix sending LE data over USB
Message-ID: <20110315103809.GF4369@null>
References: <1300137633-24495-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300137633-24495-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Mar 14, 2011 at 06:20:33PM -0300, ext Vinicius Costa Gomes wrote:
> Now that we have support for LE connections, before discarding a
> frame we must check if there's a LE connection over that transport.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Looks ok.

Acked-by: Ville Tervo <ville.tervo@nokia.com>


> ---
>  drivers/bluetooth/btusb.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 411ae9c..59dd4ae 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -690,7 +690,8 @@ static int btusb_send_frame(struct sk_buff *skb)
>  		break;
>  
>  	case HCI_ACLDATA_PKT:
> -		if (!data->bulk_tx_ep || hdev->conn_hash.acl_num < 1)
> +		if (!data->bulk_tx_ep || (hdev->conn_hash.acl_num < 1 &&
> +						hdev->conn_hash.le_num < 1))
>  			return -ENODEV;
>  
>  		urb = usb_alloc_urb(0, GFP_ATOMIC);
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
