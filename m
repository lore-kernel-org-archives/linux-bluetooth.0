Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2015 09:22:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Remove unused h4->rx_state and
 h4->rx_count field
Message-ID: <20150405062254.GD11977@t440s.P-661HNU-F1>
References: <1428204567-4467-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428204567-4467-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 04, 2015, Marcel Holtmann wrote:
> The fields h4->rx_state and h4->rx_count are not used at all and with
> that they can be just removed.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_h4.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
