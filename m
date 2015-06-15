Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] BlueZ line discipline baud rate setting update
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434387007-3666-2-git-send-email-ifaenson@broadcom.com>
Date: Mon, 15 Jun 2015 23:40:46 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3176FE9D-3C12-4448-B7FB-D876F9DE3911@holtmann.org>
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

I just realize that we are clearing CBAUD twice here. I think the one above BOTHER should also be removed.

> +	ktermios.c_cflag |= CS8;
> +	ktermios.c_cflag |= CRTSCTS;
> 	tty_termios_encode_baud_rate(&ktermios, speed, speed);

Regards

Marcel

