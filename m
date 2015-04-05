Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2015 09:19:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: hci_uart: Add support for vendor
 detection flag
Message-ID: <20150405061923.GA11977@t440s.P-661HNU-F1>
References: <1428189183-12932-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428189183-12932-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Apr 04, 2015, Marcel Holtmann wrote:
> This adds a new HCI_UART_VND_DETECT flag to allow automatic vendor
> detection. This allows to enable known vendor commands (for example
> for setting the public device address) when using a standard H:4
> UART protocol or when running in virtual machines.
> 
> When this new flag is configured and no vendor specific setup
> routine is provided, then the local version information are read
> and the provided manufacturer information can be evaluated to
> configure extra vendor callbacks.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ldisc.c | 29 ++++++++++++++++++++++++++++-
>  drivers/bluetooth/hci_uart.h  |  1 +
>  2 files changed, 29 insertions(+), 1 deletion(-)

All three patches in this set have been applied to bluetooth-next.
Thanks.

Johan
