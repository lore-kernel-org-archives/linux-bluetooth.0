Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/4] bluetooth: add bt_mrvl driver to support Marvell
 bluetooth devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1242866141-22325-1-git-send-email-bzhao@marvell.com>
References: <1242866141-22325-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain
Date: Wed, 20 May 2009 17:45:54 -0700
Message-Id: <1242866754.3147.81.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> This driver, bt_mrvl, provides basic definitions and library functions
> to support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
> combo chip.
> 
> This patch incorporates a lot of comments given by
> Nicolas Pitre <nico@marvell.com>. Many thanks to Nicolas Pitre.
> 
> Signed-off-by: Rahul Tank <rahult@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
>  drivers/bluetooth/Kconfig            |    2 +
>  drivers/bluetooth/Makefile           |    2 +
>  drivers/bluetooth/bt_mrvl/Kconfig    |   12 +
>  drivers/bluetooth/bt_mrvl/Makefile   |    7 +
>  drivers/bluetooth/bt_mrvl/btm_drv.h  |  223 +++++++++++
>  drivers/bluetooth/bt_mrvl/btm_main.c |  728 ++++++++++++++++++++++++++++++++++
>  6 files changed, 974 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/bluetooth/bt_mrvl/Kconfig
>  create mode 100644 drivers/bluetooth/bt_mrvl/Makefile
>  create mode 100644 drivers/bluetooth/bt_mrvl/btm_drv.h
>  create mode 100644 drivers/bluetooth/bt_mrvl/btm_main.c

the first thing that I need from you is to remove this vendor specific
debug mess. You can use dynamic debug and hex dump infrastructure
already present in the upstream kernel.

For the driver name please do btmrvl.ko and btmrvl_sdio.ko or use the
chipset specific code number. And I prefer not to have it in a
subdirectory. So just prefix all your files with btmrvl_

Then please resend them and I do a detailed review.

Regards

Marcel


