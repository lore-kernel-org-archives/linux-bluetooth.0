Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 12:24:33 -0800
From: Greg KH <greg@kroah.com>
To: pavan_savoy@ti.com
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers:staging: ti-st: remove bt_drv
Message-ID: <20101216202433.GA25948@kroah.com>
References: <1292328400-7649-1-git-send-email-pavan_savoy@ti.com>
 <1292328400-7649-2-git-send-email-pavan_savoy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292328400-7649-2-git-send-email-pavan_savoy@ti.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 14, 2010 at 06:06:39AM -0600, pavan_savoy@ti.com wrote:
> From: Pavan Savoy <pavan_savoy@ti.com>
> 
> Remove the BT driver from the staging folder.
> This is to update the staging folder with the
> latest BT driver.
> 
> Signed-off-by: Pavan Savoy <pavan_savoy@ti.com>
> ---
>  drivers/staging/ti-st/Kconfig   |   14 -

Deleting this file will break the build at this patch, right?  Care to
just make it empty instead and then add the needed data to it in the
next patch?

thanks,

greg k-h
