Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Apr 2015 08:41:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: hci_uart: Reorder Atheros specific driver
 callbacks
Message-ID: <20150413054121.GB5614@t440s.P-661HNU-F1>
References: <1428755738-22030-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428755738-22030-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 11, 2015, Marcel Holtmann wrote:
> The driver callbacks in the Atheros support were all in a random order
> and did not help readability of this driver. So reorder them to make
> them aligned with what other Bluetooth UART drivers do. This patch is
> not changing any actual code.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ath.c | 66 +++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 36 deletions(-)

Both patches have been applied to bluetooth-next. Thanks.

Johan
