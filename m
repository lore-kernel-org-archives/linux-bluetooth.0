Return-Path: <javier@osg.samsung.com>
Subject: Re: [PATCH] Bluetooth: btqcomsmd: Fix module autoload
To: linux-kernel@vger.kernel.org
References: <1483362596-7843-1-git-send-email-javier@osg.samsung.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
 <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <85286a63-27b9-a410-d642-430bf3fb2444@osg.samsung.com>
Date: Fri, 3 Feb 2017 18:34:09 -0300
MIME-Version: 1.0
In-Reply-To: <1483362596-7843-1-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On 01/02/2017 10:09 AM, Javier Martinez Canillas wrote:
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

Any comments about this patch?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
