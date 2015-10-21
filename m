Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 Oct 2015 07:34:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Set manufacturer for Intel bootloader
 devices
Message-ID: <20151021043405.GC12268@t440s.P-661HNU-F1>
References: <1445383905-18051-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445383905-18051-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 21, 2015, Marcel Holtmann wrote:
> For Intel bootloader devices, set the manufacturer information so that
> it becomes possible to decode the boot process.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
