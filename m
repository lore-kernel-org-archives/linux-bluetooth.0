Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Arend Van Spriel" <arend@broadcom.com>
Subject: RE: [PATCH v2 2/5] H4 line discipline enhancements
Date: Fri, 12 Jun 2015 15:36:22 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E9426154C@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
 <1433966720-17482-3-git-send-email-ifaenson@broadcom.com>
 <25BD16D3-E014-4C70-AE58-0742CD2A3DF6@holtmann.org>
In-Reply-To: <25BD16D3-E014-4C70-AE58-0742CD2A3DF6@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Thursday, June 11, 2015 6:05 AM
To: Ilya Faenson
Cc: linux-bluetooth@vger.kernel.org; Arend Van Spriel
Subject: Re: [PATCH v2 2/5] H4 line discipline enhancements

Hi Ilya,

> Added the ability to flow control the UART and improved the
> UART baud rate setting.
>=20
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 66 ++++++++++++++++++++++++++++++++++++++=
+++--
> drivers/bluetooth/hci_uart.h  |  1 +
> 2 files changed, 65 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index ac87346..f86e973 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -266,20 +266,82 @@ static int hci_uart_send_frame(struct hci_dev *hdev=
, struct sk_buff *skb)
> 	return 0;
> }
>=20
> +/* Flow control or un-flow control the device */
> +void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
> +{
> +	struct tty_struct *tty =3D hu->tty;
> +	struct ktermios ktermios;
> +	int status;
> +	unsigned int set =3D 0;
> +	unsigned int clear =3D 0;
> +
> +	if (enable) {
> +		/* Disable hardware flow control */
> +		ktermios =3D tty->termios;
> +		ktermios.c_cflag &=3D ~CRTSCTS;
> +		status =3D tty_set_termios(tty, &ktermios);
> +		BT_DBG("Disabling hardware flow control: %s", status ?
> +		       "failed" : "success");
> +
> +		/* Clear RTS to prevent the device from sending */
> +		/* Most UARTs need OUT2 to enable interrupts */
> +		status =3D tty->driver->ops->tiocmget(tty);
> +		BT_DBG("Current tiocm 0x%x", status);
> +
> +		set &=3D ~(TIOCM_OUT2 | TIOCM_RTS);
> +		clear =3D ~set;
> +		set &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +		       TIOCM_OUT2 | TIOCM_LOOP;
> +		clear &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +			 TIOCM_OUT2 | TIOCM_LOOP;
> +		status =3D tty->driver->ops->tiocmset(tty, set, clear);
> +		BT_DBG("Clearing RTS: %s", status ? "failed" : "success");
> +	} else {
> +		/* Set RTS to allow the device to send again */
> +		status =3D tty->driver->ops->tiocmget(tty);
> +		BT_DBG("Current tiocm 0x%x", status);
> +
> +		set |=3D (TIOCM_OUT2 | TIOCM_RTS);
> +		clear =3D ~set;
> +		set &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +		       TIOCM_OUT2 | TIOCM_LOOP;
> +		clear &=3D TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
> +			 TIOCM_OUT2 | TIOCM_LOOP;
> +		status =3D tty->driver->ops->tiocmset(tty, set, clear);
> +		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
> +
> +		/* Re-enable hardware flow control */
> +		ktermios =3D tty->termios;
> +		ktermios.c_cflag |=3D CRTSCTS;
> +		status =3D tty_set_termios(tty, &ktermios);
> +		BT_DBG("Enabling hardware flow control: %s", status ?
> +		       "failed" : "success");
> +	}
> +}
> +
> void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
> {
> 	struct tty_struct *tty =3D hu->tty;
> 	struct ktermios ktermios;
>=20
> +	/* Bring the UART into a known state with a given baud rate */
> 	ktermios =3D tty->termios;
> 	ktermios.c_cflag &=3D ~CBAUD;
> -	ktermios.c_cflag |=3D BOTHER;
> +	ktermios.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP
> +			    | INLCR | IGNCR | ICRNL | IXON);

can we put the | at the end of the previous line and keep IGNBRK and INLCR =
aligned.

Honestly I have no idea what the absolute 100% correct coding style rules a=
re here, but at least lets try to be consistent. So referring to the code a=
bove, the | should be at the end.

IF: Okay, will do.

> +	ktermios.c_oflag &=3D ~OPOST;
> +	ktermios.c_lflag &=3D ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
> +	ktermios.c_cflag &=3D ~(CSIZE | PARENB | CBAUD);
> +	ktermios.c_cflag |=3D CS8;
> +	ktermios.c_cflag |=3D CRTSCTS;
> 	tty_termios_encode_baud_rate(&ktermios, speed, speed);
>=20
> 	/* tty_set_termios() return not checked as it is always 0 */
> 	tty_set_termios(tty, &ktermios);
>=20
> -	BT_DBG("%s: New tty speed: %d", hu->hdev->name, tty->termios.c_ispeed);
> +	BT_DBG("%s: New tty speeds: %d/%d, cflag: 0x%x", hu->hdev->name,
> +	       tty->termios.c_ispeed, tty->termios.c_ospeed,
> +	       tty->termios.c_cflag);
> }
>=20
> static int hci_uart_setup(struct hci_dev *hdev)
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index e9f970c..8ef1881 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -100,6 +100,7 @@ int hci_uart_unregister_proto(const struct hci_uart_p=
roto *p);
> int hci_uart_tx_wakeup(struct hci_uart *hu);
> int hci_uart_init_ready(struct hci_uart *hu);
> void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
> +void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);

The rest looks good.

Regards

Marcel
