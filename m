Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2 2/5] H4 line discipline enhancements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1433966720-17482-3-git-send-email-ifaenson@broadcom.com>
Date: Thu, 11 Jun 2015 12:05:29 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Arend van Spriel <arend@broadcom.com>
Message-Id: <25BD16D3-E014-4C70-AE58-0742CD2A3DF6@holtmann.org>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com> <1433966720-17482-3-git-send-email-ifaenson@broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> Added the ability to flow control the UART and improved the
> UART baud rate setting.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 66 +++++++++++++++++++++++++++++++++++++++++--
> drivers/bluetooth/hci_uart.h  |  1 +
> 2 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index ac87346..f86e973 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -266,20 +266,82 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	return 0;
> }
> 
> +/* Flow control or un-flow control the device */
> +void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> +{
> +	struct tty_struct *tty = hu->tty;
> +	struct ktermios ktermios;
> +	int status;
> +	unsigned int set = 0;
> +	unsigned int clear = 0;
> +
> +	if (enable) {
> +		/* Disable hardware flow control */
> +		ktermios = tty->termios;
> +		ktermios.c_cflag &= ~CRTSCTS;
> +		status = tty_set_termios(tty, &ktermios);
> +		BT_DBG("Disabling hardware flow control: %s", status ?
> +		       "failed" : "success");
> +
> +		/* Clear RTS to prevent the device from sending */
> +		/* Most UARTs need OUT2 to enable interrupts */
> +		status = tty->driver->ops->tiocmget(tty);
> +		BT_DBG("Current tiocm 0x%x", status);
> +
> +		set &= ~(TIOCM_OUT2 | TIOCM_RTS);
> +		clear = ~set;
> +		set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +		       TIOCM_OUT2 | TIOCM_LOOP;
> +		clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +			 TIOCM_OUT2 | TIOCM_LOOP;
> +		status = tty->driver->ops->tiocmset(tty, set, clear);
> +		BT_DBG("Clearing RTS: %s", status ? "failed" : "success");
> +	} else {
> +		/* Set RTS to allow the device to send again */
> +		status = tty->driver->ops->tiocmget(tty);
> +		BT_DBG("Current tiocm 0x%x", status);
> +
> +		set |= (TIOCM_OUT2 | TIOCM_RTS);
> +		clear = ~set;
> +		set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +		       TIOCM_OUT2 | TIOCM_LOOP;
> +		clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +			 TIOCM_OUT2 | TIOCM_LOOP;
> +		status = tty->driver->ops->tiocmset(tty, set, clear);
> +		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
> +
> +		/* Re-enable hardware flow control */
> +		ktermios = tty->termios;
> +		ktermios.c_cflag |= CRTSCTS;
> +		status = tty_set_termios(tty, &ktermios);
> +		BT_DBG("Enabling hardware flow control: %s", status ?
> +		       "failed" : "success");
> +	}
> +}
> +
> void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
> {
> 	struct tty_struct *tty = hu->tty;
> 	struct ktermios ktermios;
> 
> +	/* Bring the UART into a known state with a given baud rate */
> 	ktermios = tty->termios;
> 	ktermios.c_cflag &= ~CBAUD;
> -	ktermios.c_cflag |= BOTHER;
> +	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
> +			    | INLCR | IGNCR | ICRNL | IXON);

can we put the | at the end of the previous line and keep IGNBRK and INLCR aligned.

Honestly I have no idea what the absolute 100% correct coding style rules are here, but at least lets try to be consistent. So referring to the code above, the | should be at the end.

> +	ktermios.c_oflag &= ~OPOST;
> +	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
> +	ktermios.c_cflag &= ~(CSIZE | PARENB | CBAUD);
> +	ktermios.c_cflag |= CS8;
> +	ktermios.c_cflag |= CRTSCTS;
> 	tty_termios_encode_baud_rate(&ktermios, speed, speed);
> 
> 	/* tty_set_termios() return not checked as it is always 0 */
> 	tty_set_termios(tty, &ktermios);
> 
> -	BT_DBG("%s: New tty speed: %d", hu->hdev->name, tty->termios.c_ispeed);
> +	BT_DBG("%s: New tty speeds: %d/%d, cflag: 0x%x", hu->hdev->name,
> +	       tty->termios.c_ispeed, tty->termios.c_ospeed,
> +	       tty->termios.c_cflag);
> }
> 
> static int hci_uart_setup(struct hci_dev *hdev)
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index e9f970c..8ef1881 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -100,6 +100,7 @@ int hci_uart_unregister_proto(const struct hci_uart_proto *p);
> int hci_uart_tx_wakeup(struct hci_uart *hu);
> int hci_uart_init_ready(struct hci_uart *hu);
> void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
> +void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);

The rest looks good.

Regards

Marcel

