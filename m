Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Jul 2014 13:28:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use bool for smp_ltk_encrypt return value
Message-ID: <20140701102834.GA4781@t440s.lan>
References: <1404205164-46988-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404205164-46988-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jul 01, 2014, Marcel Holtmann wrote:
> The return value of smp_ltk_encrypt is simple boolean, so just use
> bool and make the code a bit more readable.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/smp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
