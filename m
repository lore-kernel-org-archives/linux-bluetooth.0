Return-Path: <cyrus@holtmann.org>
Message-ID: <1323331911.1965.6.camel@aeonflux>
Subject: Re: [PATCH 1/2] Process Read Local AMP Info in hciemu
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 08 Dec 2011 10:11:51 +0200
In-Reply-To: <1323263005-20552-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323263005-20552-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Add processing of Read Local AMP Info in hciemu, the values returned are
> used to emulate AMP HCI.
> ---
>  test/hciemu.c |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)
> 
> diff --git a/test/hciemu.c b/test/hciemu.c
> index 38918f5..1022eb5 100644
> --- a/test/hciemu.c
> +++ b/test/hciemu.c
> @@ -44,6 +44,7 @@
>  #include <bluetooth/bluetooth.h>
>  #include <bluetooth/hci.h>
>  #include <bluetooth/hci_lib.h>
> +#include <bluetooth/l2cap.h>
>  
>  #define VHCI_DEV		"/dev/vhci"
>  
> @@ -777,6 +778,35 @@ static void hci_info_param(uint16_t ocf, int plen, uint8_t *data)
>  		break;
>  	}
>  }
> +static void hci_status_param(uint16_t ocf, int plen, uint8_t *data)
> +{
> +	read_local_amp_info_rp ai;
> +	uint8_t status;
> +
> +	const uint16_t ogf = OGF_STATUS_PARAM;
> +
> +	switch (ocf) {
> +		case OCF_READ_LOCAL_AMP_INFO:

one too many indentation here.

Regards

Marcel


