Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Nov 2012 14:23:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hid2hci: change subsystem in udev rule from usb to usb*
Message-ID: <20121120122345.GA14255@x220.ger.corp.intel.com>
References: <50AB6B96.20209@ahsoftware.de>
 <1353412028-5677-1-git-send-email-holler@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353412028-5677-1-git-send-email-holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

On Tue, Nov 20, 2012, Alexander Holler wrote:
> With kernel 3.6 (commit 7e97243c2080ecae7129e83635227fdebd4feef6) the class for some
> devices (e.g. dongles from Logitech) were changed from usb to usbmisc. As consequence
> the udev rule for hid2hci didn't work anymore with kernels >= 3.6.
> 
> Changing the subsystem from "usb" to "usb*" matches both "usb" and "usbmisc" and works
> with all kernels.
> 
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>  scripts/bluetooth-hid2hci.rules | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks. The patch has been applied (after fixing up the commit message
to not include the signed-off-by and to have sensible line widths).

Johan
