Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jul 2014 15:49:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove module parameters for ignoring USB
 devices
Message-ID: <20140706124924.GA6353@t440s.Elisa>
References: <1404649659-47741-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404649659-47741-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 06, 2014, Marcel Holtmann wrote:
> The module parameters to ignore devices based on USB VID/PID are not
> needed at all. So just remove them.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 21 ---------------------
>  1 file changed, 21 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
