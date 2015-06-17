Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Arend Van Spriel <arend@broadcom.com>
Subject: RE: [PATCH v3 2/5] H4 line discipline enhancements
Date: Wed, 17 Jun 2015 19:48:42 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E9426330A@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com>
 <1434555767-18234-3-git-send-email-ifaenson@broadcom.com>
 <1A0E495D-EC40-4509-9ACD-EF9761C24811@holtmann.org>
In-Reply-To: <1A0E495D-EC40-4509-9ACD-EF9761C24811@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Marcel Holtmann
Sent: Wednesday, June 17, 2015 12:55 PM
To: Ilya Faenson
Cc: BlueZ development; Arend Van Spriel
Subject: Re: [PATCH v3 2/5] H4 line discipline enhancements

Hi Ilya,

> Added the ability to flow control the UART, improved the UART baud
> rate setting, transferred the speeds into line discipline from the
> protocol and introduced the tty init function.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 93 +++++++++++++++++++++++++++++++++++++++----
> drivers/bluetooth/hci_uart.h  |  9 ++++-
> 2 files changed, 93 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index ac87346..7159cd0 100644
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
> @@ -289,13 +368,13 @@ static int hci_uart_setup(struct hci_dev *hdev)
> 	struct sk_buff *skb;
> 	int err;
> 
> -	if (hu->proto->init_speed)
> -		hci_uart_set_baudrate(hu, hu->proto->init_speed);
> +	if (hu->init_speed)
> +		hci_uart_set_baudrate(hu, hu->init_speed);
> 
> -	if (hu->proto->set_baudrate && hu->proto->oper_speed) {
> -		err = hu->proto->set_baudrate(hu, hu->proto->oper_speed);
> +	if (hu->proto->set_baudrate && hu->oper_speed) {
> +		err = hu->proto->set_baudrate(hu, hu->oper_speed);
> 		if (!err)
> -			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
> +			hci_uart_set_baudrate(hu, hu->oper_speed);
> 	}
> 
> 	if (hu->proto->setup)
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index e9f970c..4781636 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -58,8 +58,6 @@ struct hci_uart;
> struct hci_uart_proto {
> 	unsigned int id;
> 	const char *name;
> -	unsigned int init_speed;
> -	unsigned int oper_speed;

I would leave these in. I mean they are really useful for simple drivers that just want to set one these. What I would do is also just copy the values from here into hu->init_speed and hu->oper_speed as their default values. Then vendor drivers can overwrite them later on or they stay zero.

In addition, removing the fields here will break git bisect and that is not what we can do. Meaning if we really wanted to remove the values completely. You needed to leave them in here and then send a follow up patch that uses the new hci_uart_set_speeds function and remove the fields here and its usage in hci_bcm.c.

IF: Okay, I will restore the speed fields in the protocol.

> 	int (*open)(struct hci_uart *hu);
> 	int (*close)(struct hci_uart *hu);
> 	int (*flush)(struct hci_uart *hu);
> @@ -85,6 +83,9 @@ struct hci_uart {
> 	struct sk_buff		*tx_skb;
> 	unsigned long		tx_state;
> 	spinlock_t		rx_lock;
> +
> +	unsigned int init_speed;
> +	unsigned int oper_speed;
> };
> 
> /* HCI_UART proto flag bits */
> @@ -99,7 +100,11 @@ int hci_uart_register_proto(const struct hci_uart_proto *p);
> int hci_uart_unregister_proto(const struct hci_uart_proto *p);
> int hci_uart_tx_wakeup(struct hci_uart *hu);
> int hci_uart_init_ready(struct hci_uart *hu);
> +void hci_uart_init_tty(struct hci_uart *hu);
> void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
> +void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
> +void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
> +			 unsigned int oper_speed);

The rest looks good to me.

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
