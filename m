Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [RFC 4/5] tty: Re-add external interface for tty_set_termios()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427985456-31536-5-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 2 Apr 2015 08:08:59 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5D684794-B7FF-4A1A-A2F4-54BA4EA5F501@holtmann.org>
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-5-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This is needed by Bluetooth hci_uart module to be able to change speed
> of Bluetooth controller and local UART.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/tty/tty_ioctl.c | 3 ++-
> include/linux/tty.h     | 1 +
> 2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 632fc81..8e53fe4 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -536,7 +536,7 @@ EXPORT_SYMBOL(tty_termios_hw_change);
>  *	Locking: termios_rwsem
>  */
> 
> -static int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
> +int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
> {
> 	struct ktermios old_termios;
> 	struct tty_ldisc *ld;
> @@ -569,6 +569,7 @@ static int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
> 	up_write(&tty->termios_rwsem);
> 	return 0;
> }
> +EXPORT_SYMBOL_GPL(tty_set_termios);

can you send this one to the Linux TTY mailing list first to get at least an Ack from Greg KH on this.

Regards

Marcel

