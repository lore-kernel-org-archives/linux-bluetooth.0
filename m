Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Disconnect hidraw device when an input device is
 disconnected
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Rogers <brian@xyzw.org>
Cc: linux-bluetooth@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <4A64254F.5080504@xyzw.org>
References: <4A64254F.5080504@xyzw.org>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 10:13:41 +0200
Message-Id: <1248077621.4549.99.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> hidraw didn't exist when Bluetooth code was adapted to use the HID
> subsystem.
> Now that it does exist, hidp is responsible for disconnecting it.
> Without
> doing this, old hidraw devices stick around forever.
> 
> Signed-off-by: Brian Rogers <brian@xyzw.org>
> ---
>  net/bluetooth/hidp/core.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index a9f7afb..5def2db 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -40,6 +40,7 @@
>  
>  #include <linux/input.h>
>  #include <linux/hid.h>
> +#include <linux/hidraw.h>
>  
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -574,6 +575,8 @@ static int hidp_session(void *arg)
>         if (session->hid) {
>                 if (session->hid->claimed & HID_CLAIMED_INPUT)
>                         hidinput_disconnect(session->hid);
> +               if (session->hid->claimed & HID_CONNECT_HIDRAW)
> +                       hidraw_disconnect(session->hid);
>                 hid_destroy_device(session->hid);
>         }

patch looks good. However I don't understand why the HID core can't do
that for us. This seems wrong for both cases.

Jiri, why does the HID core register input device and HIDRAW device for
us, but not disconnect it?

Regards

Marcel


