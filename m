Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] BlueZ line discipline baud rate setting update
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434387007-3666-2-git-send-email-ifaenson@broadcom.com>
Date: Mon, 15 Jun 2015 19:35:42 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5A718AB3-958E-415A-B60E-4BC4827DB583@holtmann.org>
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

I think this one needs to align like this:

			&= ~(IGNBRK | .. |
			     IGNCR | ..);

However I can fix that one easily inline. So no worries.

Fred, can you test this patch so I can add a Tested-by line.

Regards

Marcel

