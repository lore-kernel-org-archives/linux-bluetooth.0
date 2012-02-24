Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Feb 2012 22:12:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow HCI UART reset parameter via flags ioctl
Message-ID: <20120224201252.GA21313@x220.P-661HNU-F1>
References: <1330099944-9371-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330099944-9371-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Feb 24, 2012, Marcel Holtmann wrote:
> The flags ioctl for HCI UART drivers already allows setting of certain
> Bluetooth core quirks. The reset parameter fits right in here. So allow
> this as well.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/hci_ldisc.c |   11 +++--------
>  drivers/bluetooth/hci_uart.h  |    1 +
>  2 files changed, 4 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
