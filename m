Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: h5: Fix missing dependency on
 BT_HCIUART_SERDEV
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180804204026.9746-1-johan.hedberg@gmail.com>
Date: Sat, 4 Aug 2018 23:23:43 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <23B9A036-D3BF-4FA8-9C36-292AFD14BC75@holtmann.org>
References: <20180804204026.9746-1-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This driver was recently updated to use serdev, so add the appropriate
> dependency. Without this one can get compiler warnings like this if
> CONFIG_SERIAL_DEV_BUS is not enabled:
> 
>  CC [M]  drivers/bluetooth/hci_h5.o
> drivers/bluetooth/hci_h5.c:934:36: warning: ‘h5_serdev_driver’ defined but not used [-Wunused-variable]
> static struct serdev_device_driver h5_serdev_driver = {
>                                    ^~~~~~~~~~~~~~~~
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> drivers/bluetooth/Kconfig | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

