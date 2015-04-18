Return-Path: <cyrus@holtmann.org>
Date: Sat, 18 Apr 2015 09:32:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Fix two coding style issues
Message-ID: <20150418063244.GA19881@t440s.P-661HNU-F1>
References: <1429218950-21313-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429218950-21313-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 16, 2015, Marcel Holtmann wrote:
> ERROR: spaces required around that '<' (ctx:WxV)
> +		if (err <0)
>  		        ^
> 
> ERROR: code indent should use tabs where possible
> +^I^I^I^I        sizeof(ver));$
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
