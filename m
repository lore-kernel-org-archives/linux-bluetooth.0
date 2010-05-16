Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Sun, 16 May 2010 01:53:31 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Julia Lawall <julia@diku.dk>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 20/37] drivers/bluetooth: Use kmemdup
Message-ID: <20100516045331.GA25105@vigoh>
References: <Pine.LNX.4.64.1005152318590.21345@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.1005152318590.21345@ask.diku.dk>
List-ID: <linux-bluetooth.vger.kernel.org>

* Julia Lawall <julia@diku.dk> [2010-05-15 23:19:15 +0200]:

> From: Julia Lawall <julia@diku.dk>
> 
> Use kmemdup when some other buffer is immediately copied into the
> allocated region.
> 
> A simplified version of the semantic patch that makes this change is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression from,to,size,flag;
> statement S;
> @@
> 
> -  to = \(kmalloc\|kzalloc\)(size,flag);
> +  to = kmemdup(from,size,flag);
>    if (to==NULL || ...) S
> -  memcpy(to, from, size);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  drivers/bluetooth/bcm203x.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff -u -p a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
> --- a/drivers/bluetooth/bcm203x.c
> +++ b/drivers/bluetooth/bcm203x.c
> @@ -224,7 +224,7 @@ static int bcm203x_probe(struct usb_inte
>  
>  	BT_DBG("firmware data %p size %zu", firmware->data, firmware->size);
>  
> -	data->fw_data = kmalloc(firmware->size, GFP_KERNEL);
> +	data->fw_data = kmemdup(firmware->data, firmware->size, GFP_KERNEL);
>  	if (!data->fw_data) {
>  		BT_ERR("Can't allocate memory for firmware image");
>  		release_firmware(firmware);
> @@ -234,7 +234,6 @@ static int bcm203x_probe(struct usb_inte
>  		return -ENOMEM;
>  	}
>  
> -	memcpy(data->fw_data, firmware->data, firmware->size);
>  	data->fw_size = firmware->size;
>  	data->fw_sent = 0;


Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
http://padovan.org
