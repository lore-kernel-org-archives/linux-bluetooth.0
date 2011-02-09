Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 9 Feb 2011 11:47:40 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: pavan_savoy@ti.com
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v10] Bluetooth: btwilink driver
Message-ID: <20110209134740.GA2597@joana>
References: <1297253680-4412-1-git-send-email-pavan_savoy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297253680-4412-1-git-send-email-pavan_savoy@ti.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

* pavan_savoy@ti.com <pavan_savoy@ti.com> [2011-02-09 06:14:40 -0600]:

> From: Pavan Savoy <pavan_savoy@ti.com>
> 
> Gustavo,
> 
> reposting v10,
> fixing the really long goto label.
> (from Ville) moving the reg_status before register.
> 
> Find below the patch version v9.
> Have taken care of Ville's comments.
> In addition fixed the issue seen when built as module, with
> repeated probe/remove of the platform driver.
> 
> patch v8 comments taken care,
> 
> As suggested, the modifications to TI ST driver to remove the bluetooth
> references have been made and the changes have been merged to the
> linux-next tree.
> 
> Find below the patch for the btwilink driver,
> I have taken care of your following comments,
> 1. channel IDs and the offsets are now being taken from the
> header file hci.h.
> 2. removed the un-necessary BT_ERR.
> 3. changed the order during return from st_register.
> 4. continue to unregister even if 1st unregister fails.
> 
> Please review and provide comments,
> 
> Thanks & Regards,
> Pavan Savoy
> 
> -- patch description --
> 
> This is the bluetooth protocol driver for the TI WiLink7 chipsets.
> Texas Instrument's WiLink chipsets combine wireless technologies
> like BT, FM, GPS and WLAN onto a single chip.
> 
> This Bluetooth driver works on top of the TI_ST shared transport
> line discipline driver which also allows other drivers like
> FM V4L2 and GPS character driver to make use of the same UART interface.
> 
> Kconfig and Makefile modifications to enable the Bluetooth
> driver for Texas Instrument's WiLink 7 chipset.
> 
> Signed-off-by: Pavan Savoy <pavan_savoy@ti.com>
> ---
>  drivers/bluetooth/Kconfig    |   10 +
>  drivers/bluetooth/Makefile   |    1 +
>  drivers/bluetooth/btwilink.c |  395 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 406 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/bluetooth/btwilink.c

Look good to me now. ;)

The patch need to go through Greg's tree, together with the modifications in
the core driver. Then,

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
http://profusion.mobi
