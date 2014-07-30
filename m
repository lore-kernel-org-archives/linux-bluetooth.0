Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jul 2014 09:26:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix sparse warning from HID new leds handling
Message-ID: <20140730062632.GA23949@t440s.P-661HNU-F1>
References: <1406700525-18066-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406700525-18066-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 30, 2014, Marcel Holtmann wrote:
> The new leds bit handling produces this spares warning.
> 
>   CHECK   net/bluetooth/hidp/core.c
> net/bluetooth/hidp/core.c:156:60: warning: dubious: x | !y
> 
> Just fix it by doing an explicit x << 0 shift operation.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hidp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
