Return-Path: <cyrus@holtmann.org>
Message-ID: <1328959509.28848.42.camel@aeonflux>
Subject: Re: [RFC BlueZ 01/22] lib: Add functions to deal with unaligned
 access without conversion
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 11 Feb 2012 12:25:09 +0100
In-Reply-To: <1328910007-25604-2-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1328910007-25604-2-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> In various places we need to do access unaligned memory, but we don't
> want to do any type of conversions, i.e. the values are already in the
> host order.
> ---
>  lib/bluetooth.h |   40 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index 1dee6df..e9ced19 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -126,6 +126,46 @@ do {						\
>  	__p->__v = (val);			\
>  } while(0)
>  
> +static inline uint64_t bt_get_h64(void *ptr)
> +{
> +	return bt_get_unaligned((uint64_t *) ptr);
> +}

this is a bad idea. Rather change the code to always clearly use the le
vs be versions. There is no need for a host copy. You only do this on
wire protocols and you know the endian.

Regards

Marcel


