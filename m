Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Jul 2013 20:40:09 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ath3k: don't use stack memory for DMA
Message-ID: <20130707194009.GB3966@joana>
References: <20130627094837.GA2288@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130627094837.GA2288@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stanislaw,

* Stanislaw Gruszka <sgruszka@redhat.com> [2013-06-27 11:48:41 +0200]:

> Memory allocated by vmalloc (including stack) can not be used for DMA,
> i.e. data pointer on usb_control_msg() should not point to stack memory.
> 
> Resolves:
> https://bugzilla.redhat.com/show_bug.cgi?id=977558
> 
> Reported-and-tested-by: Andy Lawrence <dr.diesel@gmail.com>
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
>  drivers/bluetooth/ath3k.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index 11f467c..81b636c 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -193,24 +193,44 @@ error:
>  
>  static int ath3k_get_state(struct usb_device *udev, unsigned char *state)
>  {
> -	int pipe = 0;
> +	int ret, pipe = 0;
> +	char *buf;
> +
> +	buf = kmalloc(1, GFP_KERNEL);

Can we make this:

	buf = kmalloc(sizeof(*buf), GFP_KERNEL);

> +	if (!buf)
> +		return -ENOMEM;
>  
>  	pipe = usb_rcvctrlpipe(udev, 0);
> -	return usb_control_msg(udev, pipe, ATH3K_GETSTATE,
> -			USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
> -			state, 0x01, USB_CTRL_SET_TIMEOUT);
> +	ret = usb_control_msg(udev, pipe, ATH3K_GETSTATE,
> +			      USB_TYPE_VENDOR | USB_DIR_IN, 0, 0,
> +			      buf, 1, USB_CTRL_SET_TIMEOUT);

sizeof(*buf) instead of "1"

> +
> +	*state = *buf;
> +	kfree(buf);
> +
> +	return ret;
>  }
>  
>  static int ath3k_get_version(struct usb_device *udev,
>  			struct ath3k_version *version)
>  {
> -	int pipe = 0;
> +	int ret, pipe = 0;
> +	char *buf;

this should be struct ath3k_version *buf;

> +	const int size = sizeof(struct ath3k_version);

and here sizeof(*buf);

	Gustavo
