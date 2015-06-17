Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v4 2/4] hci_uart: line discipline enhancements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434576658-20730-3-git-send-email-ifaenson@broadcom.com>
Date: Wed, 17 Jun 2015 23:50:31 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Arend van Spriel <arend@broadcom.com>
Message-Id: <EC2420F4-9F0F-47DB-A5E5-713E763E3E26@holtmann.org>
References: <1434576658-20730-1-git-send-email-ifaenson@broadcom.com> <1434576658-20730-3-git-send-email-ifaenson@broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> Added the ability to flow control the UART, improved the UART baud
> rate setting, transferred the speeds into line discipline from the
> protocol and introduced the tty init function.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 106 +++++++++++++++++++++++++++++++++++++++---
> drivers/bluetooth/hci_uart.h  |   7 +++
> 2 files changed, 106 insertions(+), 7 deletions(-)

I applied this patch to bluetooth-next tree, but I had to amend it a little bit.

Please make sure the subject is prefixed with Bluetooth: all the time.

> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index ac87346..959dd64 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -266,6 +266,85 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
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

I moved these into this

			status ? "failed" : "success"

so that the conditional statement is on the same line.

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
> +void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
> +			 unsigned int oper_speed)
> +{
> +	hu->init_speed = init_speed;
> +	hu->oper_speed = oper_speed;
> +}
> +
> +void hci_uart_init_tty(struct hci_uart *hu)
> +{
> +	struct tty_struct *tty = hu->tty;
> +	struct ktermios ktermios;
> +
> +	/* Bring the UART into a known 8 bits no parity hw fc state */
> +	ktermios = tty->termios;
> +	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
> +			    | INLCR | IGNCR | ICRNL | IXON);

I fixed this up to have the | on the previous line and then INCLR line up with IGNBRK.

> +	ktermios.c_oflag &= ~OPOST;
> +	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
> +	ktermios.c_cflag &= ~(CSIZE | PARENB);
> +	ktermios.c_cflag |= CS8;
> +	ktermios.c_cflag |= CRTSCTS;
> +
> +	/* tty_set_termios() return not checked as it is always 0 */
> +	tty_set_termios(tty, &ktermios);
> +}
> +
> void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
> {
> 	struct tty_struct *tty = hu->tty;
> @@ -273,13 +352,13 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
> 
> 	ktermios = tty->termios;
> 	ktermios.c_cflag &= ~CBAUD;
> -	ktermios.c_cflag |= BOTHER;
> 	tty_termios_encode_baud_rate(&ktermios, speed, speed);
> 
> 	/* tty_set_termios() return not checked as it is always 0 */
> 	tty_set_termios(tty, &ktermios);
> 
> -	BT_DBG("%s: New tty speed: %d", hu->hdev->name, tty->termios.c_ispeed);
> +	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev->name,
> +	       tty->termios.c_ispeed, tty->termios.c_ospeed);
> }
> 
> static int hci_uart_setup(struct hci_dev *hdev)
> @@ -287,15 +366,28 @@ static int hci_uart_setup(struct hci_dev *hdev)
> 	struct hci_uart *hu = hci_get_drvdata(hdev);
> 	struct hci_rp_read_local_version *ver;
> 	struct sk_buff *skb;
> +	unsigned int speed;
> 	int err;
> 
> +	/* Init speed if any */
> +	speed = 0;
> 	if (hu->proto->init_speed)
> -		hci_uart_set_baudrate(hu, hu->proto->init_speed);
> -
> -	if (hu->proto->set_baudrate && hu->proto->oper_speed) {
> -		err = hu->proto->set_baudrate(hu, hu->proto->oper_speed);
> +		speed = hu->proto->init_speed;
> +	else if (hu->init_speed)
> +		speed = hu->init_speed;

I added the speed assignment as else statement

	else
		speed = 0;

> +	if (speed)
> +		hci_uart_set_baudrate(hu, speed);
> +
> +	/* Operational speed if any */
> +	speed = 0;
> +	if (hu->proto->oper_speed)
> +		speed = hu->proto->oper_speed;
> +	else if (hu->oper_speed)
> +		speed = hu->oper_speed;
> +	if (hu->proto->set_baudrate && speed) {
> +		err = hu->proto->set_baudrate(hu, speed);
> 		if (!err)
> -			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
> +			hci_uart_set_baudrate(hu, speed);
> 	}
> 
> 	if (hu->proto->setup)
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index e9f970c..ce9c670 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -85,6 +85,9 @@ struct hci_uart {
> 	struct sk_buff		*tx_skb;
> 	unsigned long		tx_state;
> 	spinlock_t		rx_lock;
> +
> +	unsigned int init_speed;
> +	unsigned int oper_speed;
> };
> 

Regards

Marcel

