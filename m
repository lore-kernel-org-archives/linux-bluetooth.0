Return-Path: <cyrus@holtmann.org>
Date: Sun, 13 Jul 2014 21:40:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allocate struct inquiry_entry with GFP_KERNEL
Message-ID: <20140713184021.GA3344@t440s.P-661HNU-F1>
References: <1405264945-15164-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405264945-15164-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jul 13, 2014, Marcel Holtmann wrote:
> The allocation of inquiry cache entries is triggered as a result of
> processing HCI events. Since the processing is done in the context
> of a workqueue, there is no needed to allocate with GFP_ATOMIC in
> that case. Switch it to GFP_KERNEL.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
