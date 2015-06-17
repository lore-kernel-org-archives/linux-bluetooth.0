Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] BlueZ line discipline baud rate setting update
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434387007-3666-2-git-send-email-ifaenson@broadcom.com>
Date: Wed, 17 Jun 2015 15:16:50 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B95AE695-FE24-4366-86F6-545CC786DFBD@holtmann.org>
References: <1434387007-3666-1-git-send-email-ifaenson@broadcom.com> <1434387007-3666-2-git-send-email-ifaenson@broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> Bring the tty into a known 8 bits, 1 start bit, 1 stop bit,
> hardware flow control state with a given baud rate.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index ac87346..606cc5a 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -271,9 +271,16 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
> 	struct tty_struct *tty = hu->tty;
> 	struct ktermios ktermios;
> 
> +	/* Bring the UART into a known state with a given baud rate */
> 	ktermios = tty->termios;
> 	ktermios.c_cflag &= ~CBAUD;
> -	ktermios.c_cflag |= BOTHER;
> +	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR |
> +			    IGNCR | ICRNL | IXON);
> +	ktermios.c_oflag &= ~OPOST;
> +	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
> +	ktermios.c_cflag &= ~(CSIZE | PARENB | CBAUD);
> +	ktermios.c_cflag |= CS8;
> +	ktermios.c_cflag |= CRTSCTS;
> 	tty_termios_encode_baud_rate(&ktermios, speed, speed);

with the questions raised by the others, I think for now we just want to change the baud rate and leave the rest to a more generic function. I am fine if the kernel side wants to enforce the settings on the UART. That seems fully reasonable. However we need to give drivers a chance to let it come from userspace as well and honor whatever they configured there.

So we need to clear CBAUD and then encode the baud rate. Do we need to bother with BOTHER or is that just not needed at all. I really like to get this detail fixed as soon as possible since we are close to the merge window.

Regards

Marcel

