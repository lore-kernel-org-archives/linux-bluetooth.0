Return-Path: <cyrus@holtmann.org>
Message-ID: <1339127037.1817.137.camel@aeonflux>
Subject: Re: [PATCH hcidump] Correct HCI version according to assign numbers
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Jun 2012 12:43:57 +0900
In-Reply-To: <1339069794-25843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1339069794-25843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Bluetooth specifies assigned number for 0x05 as following:
> 5 - Bluetooth Core Specification 3.0 + HS
> http://www.bluetooth.org/Technical/AssignedNumbers/hci.htm
> ---
>  lib/hci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/hci.c b/lib/hci.c
> index 269c021..0c1ef5e 100644
> --- a/lib/hci.c
> +++ b/lib/hci.c
> @@ -647,7 +647,7 @@ static hci_map ver_map[] = {
>  	{ "1.2",	0x02 },
>  	{ "2.0",	0x03 },
>  	{ "2.1",	0x04 },
> -	{ "3.0",	0x05 },
> +	{ "3.0 + HS",	0x05 },
>  	{ "4.0",	0x06 },

this is not correct. Please read the Bluetooth logo requirements. There
are BT controllers that are just 3.0 (without HS) and that is valid. The
addition of + HS is only valid if you have at least on AMP controller in
the system.

Regards

Marcel


