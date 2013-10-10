Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Oct 2013 22:15:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Remove unused bfusb_ioctl() callback
Message-ID: <20131010201539.GC9414@x220.p-661hnu-f1>
References: <1381427406-26472-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381427406-26472-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 10, 2013, Marcel Holtmann wrote:
> The bfusb_ioctl() function is not used and thus remove it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/bfusb.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

All seven patches have been applied to bluetooth-next. Thanks.

Johan
