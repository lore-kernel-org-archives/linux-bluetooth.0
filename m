Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Fix sparse warning with btmrvl driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404308739-26797-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Jul 2014 16:45:34 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0B87CEA0-AC47-40C8-934D-941D89D2020A@holtmann.org>
References: <1404308739-26797-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch fixes the following sparse warning caused by a missing
> declaration in the header file:
> 
> drivers/bluetooth/btmrvl_main.c:218:5: warning: symbol 'btmrvl_pscan_window_reporting' was not declared. Should it be static?
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> drivers/bluetooth/btmrvl_drv.h | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

