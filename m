Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] bluetooth: hidp+hidraw write support
From: Marcel Holtmann <marcel@holtmann.org>
To: SephirXV <sephirxv@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <21b895620909101040qeb5973axbba6c5a44f6e5b6a@mail.gmail.com>
References: <21b895620909101040qeb5973axbba6c5a44f6e5b6a@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Sep 2009 19:50:26 +0200
Message-Id: <1252605026.8931.46.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christopher,

> somewhere before .28, non-compliant HIDP devices would connect, and
> could be read from, but writing to the device had no effect.

this is not a proper commit message. Don't care about "somewhere", just
explain what this patch is fixing or what feature it adds.

> Signed-off-by: Christopher Olson <sephirxv@gmail.com>
> 
> ---
> 
> --- net/bluetooth/hidp/core.c   2009-09-10 09:32:20.000000000 -0500
> +++ net/bluetooth/hidp/core.c.2 2009-09-10 09:41:37.000000000 -0500
> @@ -40,6 +40,7 @@
> 
>  #include <linux/input.h>
>  #include <linux/hid.h>
> +#include <linux/hidraw.h>
> 
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -513,6 +514,11 @@ static void hidp_process_transmit(struct
>                 kfree_skb(skb);
>         }
>  }
> +
> +static int hidp_output_raw_report(struct hid_device *hid, __u8 *buf,
> size_t count)
> +{
> +        return hidp_send_ctrl_message(hid->driver_data, buf[0], buf +
> 1, count - 1);
> +}

Please just create the SKB, copy the data, queue it and schedule it.
This buf[0] and buf + 1. Is pointless and just confusing.

And while at it change the send_ctrl_message to only accept the header
parameter since we are not even using data and size at all.

Regards

Marcel


