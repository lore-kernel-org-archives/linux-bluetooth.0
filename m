Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Jun 2015 11:07:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Fix memory leak in Intel setup routine
Message-ID: <20150608080742.GB717@t440s.lan>
References: <1433662939-30065-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433662939-30065-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 07, 2015, Marcel Holtmann wrote:
> The SKB returned from the Intel specific version information command is
> missing a kfree_skb.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/bluetooth/btusb.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
