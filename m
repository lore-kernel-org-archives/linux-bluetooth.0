Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Jan 2015 08:25:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Sort USB_DEVICE entries for
 Marvell by vendor id
Message-ID: <20150129062506.GA11335@t440s.P-661HNU-F1>
References: <1422502903-12203-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422502903-12203-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 28, 2015, Marcel Holtmann wrote:
> New entries to the USB blacklist/quirk device table should be sorted
> by USB vendor id. Fix the recent entry fro Marvell devices.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
