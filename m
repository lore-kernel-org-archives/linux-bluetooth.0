Return-Path: <cyrus@holtmann.org>
Message-ID: <1332930313.1870.164.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: vhci: Ignore return code of
 nonseekable_open()
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	johan.hedberg@gmail.com
Date: Wed, 28 Mar 2012 12:25:13 +0200
In-Reply-To: <1332928122-10919-1-git-send-email-dh.herrmann@googlemail.com>
References: <1332928122-10919-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> The comment in ./fs/open.c clearly states that nonseekable_open() will
> never fail. Therefore, we can safely ignore the return code. This is the
> recommended way to deal with nonseekable_open().
> Our current code looks like nonseekable_open() is checked for the return
> code. However, if we check the return code, we must also kfree() our
> private data if the open fails. To avoid this overhead and to avoid
> confusion, we simply drop the return code and return 0.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> See the UHID discussion for more information. Marcel suggested to also fix vhci
> so here is the patch ;)
> 
>  drivers/bluetooth/hci_vhci.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


