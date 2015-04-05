Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2015 09:29:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Update version number driver
Message-ID: <20150405062908.GI11977@t440s.P-661HNU-F1>
References: <1428212164-19437-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428212164-19437-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 04, 2015, Marcel Holtmann wrote:
> This version number is more cosmetic and for debugging purposes, but
> since there has been a few changes lately, increase it now.
> 
> Two left-over and not used version constants that were never exposed
> anywhere are removed since they have no actual value.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_bcsp.c  | 2 --
>  drivers/bluetooth/hci_h4.c    | 2 --
>  drivers/bluetooth/hci_ldisc.c | 2 +-
>  3 files changed, 1 insertion(+), 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
