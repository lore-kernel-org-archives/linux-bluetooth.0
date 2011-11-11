Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 2/2] Bluetooth: Do not set HCI_RAW when HS enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 11 Nov 2011 23:29:57 +0900
In-Reply-To: <1321020867-8938-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321020867-8938-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321020867-8938-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321021801.15441.397.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>  net/bluetooth/hci_core.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 189bada..1b08e4b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -51,6 +51,7 @@
>  
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> +#include <net/bluetooth/l2cap.h>
>  
>  #define AUTO_OFF_TIMEOUT 2000
>  
> @@ -570,8 +571,9 @@ int hci_dev_open(__u16 dev)
>  	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
>  		set_bit(HCI_RAW, &hdev->flags);
>  
> -	/* Treat all non BR/EDR controllers as raw devices for now */
> -	if (hdev->dev_type != HCI_BREDR)
> +	/* Treat all non BR/EDR controllers as raw devices if
> +	   enable_hs is not set */
> +	if (hdev->dev_type != HCI_BREDR && !enable_hs)
>  		set_bit(HCI_RAW, &hdev->flags);

this is fine with me. Even while the include of l2cap.h is kinda nasty.
Maybe the enable_hs variable actually needs to be moved into hci_*.c
files and not stay inside L2CAP.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


