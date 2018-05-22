Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] btmrvl: support sysfs initiated firmware coredump
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1526595312-1371-1-git-send-email-arend.vanspriel@broadcom.com>
Date: Tue, 22 May 2018 09:04:44 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <57FC7035-839E-48E9-AA93-B3966860012D@holtmann.org>
References: <1526595312-1371-1-git-send-email-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arend,

> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
> it is possible to initiate a device coredump from user-space. This
> patch adds support for it in btmrvl_sdio adding the .coredump()
> driver callback. This makes dump through debugfs obsolete so removing
> it.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> This patch depends upon a patch that is in Linus' tree since 4.17-rc3:
> 
> 
>  commit ed4564babeeee4fb19fe4ec0beabe29754e380f9
>  Author: Arend van Spriel <aspriel@gmail.com>
>  Date:   Sun Apr 8 23:57:07 2018 +0200
> 
>     drivers: change struct device_driver::coredump() return type to void
> 
> However, bt-next is still at 4.17-rc1.
> 
> Regards,
> Arend
> ---
> drivers/bluetooth/btmrvl_debugfs.c | 31 -------------------------------
> drivers/bluetooth/btmrvl_drv.h     |  2 --
> drivers/bluetooth/btmrvl_main.c    |  6 ------
> drivers/bluetooth/btmrvl_sdio.c    | 11 ++++++++---
> 4 files changed, 8 insertions(+), 42 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

