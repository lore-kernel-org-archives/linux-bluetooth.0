Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Sep 2013 00:21:14 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use devname:vhci module alias for virtual HCI
 driver
Message-ID: <20130901232114.GN7440@joana>
References: <1377579758-10105-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377579758-10105-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-08-26 Marcel Holtmann <marcel@holtmann.org>:

> To allow creating /dev/vhci device node, add the proper module alias for
> this driver.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_vhci.c | 1 +
>  1 file changed, 1 insertion(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
