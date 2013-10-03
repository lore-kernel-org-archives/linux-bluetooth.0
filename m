Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Oct 2013 10:06:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow changing device class when BR/EDR is
 disabled
Message-ID: <20131003070623.GA23775@x220.p-661hnu-f1>
References: <1380782249-29597-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380782249-29597-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Oct 02, 2013, Marcel Holtmann wrote:
> Changing the device class when BR/EDR is disabled has no visible
> effect for remote devices. However to simplify the logic allow it
> as long as the controller supports BR/EDR operations.
> 
> If it is not allowed, then the overall logic becomes rather
> complicated since the class of device values would need clearing
> or restoring when BR/EDR setting changes.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
