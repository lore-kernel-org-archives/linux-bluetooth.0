Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: btqcomsmd: Fix module autoload
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1483362596-7843-1-git-send-email-javier@osg.samsung.com>
Date: Thu, 16 Feb 2017 17:19:08 +0100
Cc: linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        linux-bluetooth@vger.kernel.org
Message-Id: <87EA9B62-983A-4520-A221-BF7D5A35C6B9@holtmann.org>
References: <1483362596-7843-1-git-send-email-javier@osg.samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Javier,

> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/bluetooth/btqcomsmd.ko | grep alias
> $
> 
> After this patch:
> 
> $ modinfo drivers/bluetooth/btqcomsmd.ko | grep alias
> alias:          of:N*T*Cqcom,wcnss-btC*
> alias:          of:N*T*Cqcom,wcnss-bt
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
> drivers/bluetooth/btqcomsmd.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
