Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Nov 2010 15:47:45 -0800
From: Greg KH <gregkh@suse.de>
To: stefan.seyfried@googlemail.com
Cc: linux-bluetooth@vger.kernel.org,
	Stefan Seyfried <seife+kernel@b1-systems.com>,
	Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] btusb: Fix log spamming due to autosuspend
Message-ID: <20101130234745.GC6926@suse.de>
References: <1291150148-14376-1-git-send-email-stefan.seyfried@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291150148-14376-1-git-send-email-stefan.seyfried@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 30, 2010 at 09:49:08PM +0100, stefan.seyfried@googlemail.com wrote:
> From: Stefan Seyfried <seife+kernel@b1-systems.com>
> 
> If a device is autosuspended an inability to resubmit URBs is
> to be expected. Check the error code and only log real errors.
> (Now that autosuspend is default enabled for btusb, those log
> messages were happening all the time e.g. with a BT mouse)
> 
> Signed-off-by: Stefan Seyfried <seife+kernel@b1-systems.com>
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> ---
>  drivers/bluetooth/btusb.c |    9 ++++++---

This one doesn't go through me, sorry:

	> ./scripts/get_maintainer.pl --file --roles drivers/bluetooth/btusb.c
	Marcel Holtmann <marcel@holtmann.org> (maintainer:BLUETOOTH DRIVERS)
	"Gustavo F. Padovan" <padovan@profusion.mobi> (maintainer:BLUETOOTH DRIVERS)
	linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS)
	linux-kernel@vger.kernel.org (open list)

Marcel and Gustavo are the ones that need to handle it.

thanks,

greg k-h
