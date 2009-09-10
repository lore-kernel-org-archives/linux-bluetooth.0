Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] bluetooth: hidp+hidraw disconnect
From: Marcel Holtmann <marcel@holtmann.org>
To: SephirXV <sephirxv@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <21b895620909101040r6887d4c3w511ff975c0e6aca@mail.gmail.com>
References: <21b895620909101040r6887d4c3w511ff975c0e6aca@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Sep 2009 19:44:11 +0200
Message-Id: <1252604651.8931.40.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christopher,

> Somewhere between 2.6.26 and 2.6.28, hidraw began connecting to HIDP
> devices which don't strictly define their behavior in the HID usage
> table, and without any patching on my part. These non-compliant
> devices wouldn't automatically disconnect, leaving hidraw files which
> did nothing.
> 
> Signed-off-by: Christopher Olson <sephirxv@gmail.com>
> 
> ---
> 
> --- net/bluetooth/hidp/core.c   2009-09-10 09:32:20.000000000 -0500
> +++ net/bluetooth/hidp/core.c.1 2009-09-10 09:31:37.000000000 -0500
> @@ -40,6 +40,7 @@
> 
>  #include <linux/input.h>
>  #include <linux/hid.h>
> +#include <linux/hidraw.h>
> 
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -736,6 +737,8 @@ static void hidp_stop(struct hid_device
> 
>         if (hid->claimed & HID_CLAIMED_INPUT)
>                 hidinput_disconnect(hid);
> +       if (hid->claimed & HID_CLAIMED_HIDRAW)
> +               hidraw_disconnect(hid);
>         hid->claimed = 0;
>  }

I am pretty sure such a patch or similar is in net-next-2.6 already.

Regards

Marcel


