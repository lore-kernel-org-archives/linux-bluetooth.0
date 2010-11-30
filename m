Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 29 Nov 2010 23:52:00 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Alexander Holler <holler@ahsoftware.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Alicke Xu <sxu@atheros.com>,
	"Luis R. Rodriguez" <lrodriguez@atheros.com>,
	Vikram Kandukuri <vikram.kandukuri@atheros.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: reduce memory usage
Message-ID: <20101130015200.GD5919@vigoh>
References: <1290456541-3812-1-git-send-email-holler@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290456541-3812-1-git-send-email-holler@ahsoftware.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

* Alexander Holler <holler@ahsoftware.de> [2010-11-22 21:09:01 +0100]:

> There is no need to hold the firmware in memory.
> 
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>  drivers/bluetooth/ath3k.c |   75 ++++++++++++---------------------------------
>  1 files changed, 20 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 128cae4..81cd1ed 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -43,46 +43,40 @@ MODULE_DEVICE_TABLE(usb, ath3k_table);
>  #define USB_REQ_DFU_DNLOAD	1
>  #define BULK_SIZE		4096
>  
> -struct ath3k_data {
> -	struct usb_device *udev;
> -	u8 *fw_data;
> -	u32 fw_size;
> -	u32 fw_sent;
> -};
> -
> -static int ath3k_load_firmware(struct ath3k_data *data,
> -				unsigned char *firmware,
> -				int count)
> +static int ath3k_load_firmware(struct usb_device *udev,
> +				const struct firmware *firmware)
>  {
>  	u8 *send_buf;
>  	int err, pipe, len, size, sent = 0;
> +	int count = firmware->size;
>  
> -	BT_DBG("ath3k %p udev %p", data, data->udev);
> +	BT_DBG("udev %p", udev);
>  
> -	pipe = usb_sndctrlpipe(data->udev, 0);
> +	pipe = usb_sndctrlpipe(udev, 0);
>  
> -	if ((usb_control_msg(data->udev, pipe,
> +	send_buf = kmalloc(BULK_SIZE, GFP_ATOMIC);
> +	if (!send_buf) {
> +		BT_ERR("Can't allocate memory chunk for firmware");
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(send_buf, firmware->data, 20);
> +	if ((err = usb_control_msg(udev, pipe,
>  				USB_REQ_DFU_DNLOAD,
>  				USB_TYPE_VENDOR, 0, 0,
> -				firmware, 20, USB_CTRL_SET_TIMEOUT)) < 0) {
> +				send_buf, 20, USB_CTRL_SET_TIMEOUT)) < 0) {
>  		BT_ERR("Can't change to loading configuration err");
> -		return -EBUSY;
> +		goto error;
>  	}
>  	sent += 20;
>  	count -= 20;

Patch looks good to me,  but I have a question here: what's 20 here? I
didn't figured out.

Vikram, what's your opinion on this patch? Can you ack/nack it?

-- 
Gustavo F. Padovan
http://profusion.mobi
