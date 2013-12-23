Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Dec 2013 18:51:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set HCI_QUIRK_RESET_ON_CLOSE for Socket SDIO
 cards
Message-ID: <20131223165124.GA13674@x220.p-661hnu-f1>
References: <1387810352-48383-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387810352-48383-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Dec 23, 2013, Marcel Holtmann wrote:
> The Socket Bluetooth SDIO cards are branded versions of Toshiba SD-BT2
> and they do not support sending HCI_Reset as first command. To make
> this card work the HCI_QUIRK_RESET_ON_CLOSE quirk needs to be set
> before registering the controller.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btsdio.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
