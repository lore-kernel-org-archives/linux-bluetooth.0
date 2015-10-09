Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Oct 2015 09:22:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: bpa10x: Fix missing BT_HCIUART dependency
Message-ID: <20151009062205.GA5184@t440s.lan>
References: <1444325405-112323-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444325405-112323-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 08, 2015, Marcel Holtmann wrote:
> Selecting just BT_HCIUART_H4 is not enough and it also needs to select
> BT_HCIUART to avoid this warning:
> 
> warning: (BT_HCIBPA10X) selects BT_HCIUART_H4 which has unmet direct
> dependencies (NET && BT && BT_HCIUART)
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to bluetooth-next. Thanks.

Johan
