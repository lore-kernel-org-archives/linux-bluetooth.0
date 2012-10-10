Return-Path: <cyrus@holtmann.org>
Message-ID: <1349882925.27233.130.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: btmrv: Use %*ph specifier instead of
 print_hex_dump_bytes
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, bzhao@marvell.com
Date: Wed, 10 Oct 2012 17:28:45 +0200
In-Reply-To: <1349880093-23728-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1349880093-23728-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use standard print specifier and remove print_hex_dump_bytes call.
> Makes output more sensible:
> 
> ...
> [18809.401218] 00000000: 0b 00 00 fe 5b fc 01 f2 00 00 00    ....[......
> ...
> 
> would be changed to
> 
> ...
> [18809.401218] Bluetooth: hex: 0b 00 00 fe 5b fc 01 f2 00 00 00
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


