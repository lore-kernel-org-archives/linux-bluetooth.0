Return-Path: <cyrus@holtmann.org>
Message-ID: <1352382227.16204.6.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix memory leak when removing a UUID
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 08 Nov 2012 14:43:47 +0100
In-Reply-To: <1352366726-4308-1-git-send-email-johan.hedberg@gmail.com>
References: <1352366726-4308-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When removing a UUID from the list in the remove_uuid() function we must
> also kfree the entry in addition to removing it from the list.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


