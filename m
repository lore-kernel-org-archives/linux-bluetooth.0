Return-Path: <cyrus@holtmann.org>
Date: Sun, 2 Nov 2014 10:01:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use HCI_EV_HARDWARE_ERROR define for event
 payload
Message-ID: <20141102080149.GC20526@t440s.P-661HNU-F1>
References: <1414893721-91141-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414893721-91141-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Nov 02, 2014, Marcel Holtmann wrote:
> When constructing the event payload for the HCI_Hardware_Error event
> message, use the HCI_EV_HARDWARE_ERROR define.
> 
> In addition rename the variables from hard_err to hw_err to clearly
> indicate that this is about the hardware error and not a hard error.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_h5.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
