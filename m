Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2015 09:22:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Remove unused h4->rx_skb field
Message-ID: <20150405062208.GC11977@t440s.P-661HNU-F1>
References: <1428204350-31714-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428204350-31714-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 04, 2015, Marcel Holtmann wrote:
> The h4->rx_skb is not used anymore and with that just remove it. Seems
> this was a leftover and even the kfree_skb call freeing it is rather
> pointless since it got never allocated.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_h4.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
