Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] BlueZ line discipline baud rate setting update
Date: Mon, 15 Jun 2015 21:45:59 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E942626AC@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1434387007-3666-1-git-send-email-ifaenson@broadcom.com>
 <1434387007-3666-2-git-send-email-ifaenson@broadcom.com>
 <3176FE9D-3C12-4448-B7FB-D876F9DE3911@holtmann.org>
In-Reply-To: <3176FE9D-3C12-4448-B7FB-D876F9DE3911@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Monday, June 15, 2015 5:41 PM
To: Ilya Faenson
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] BlueZ line discipline baud rate setting update

Hi Ilya,

> Bring the tty into a known 8 bits, 1 start bit, 1 stop bit,
> hardware flow control state with a given baud rate.
>=20
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index ac87346..606cc5a 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -271,9 +271,16 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsi=
gned int speed)
> 	struct tty_struct *tty =3D hu->tty;
> 	struct ktermios ktermios;
>=20
> +	/* Bring the UART into a known state with a given baud rate */
> 	ktermios =3D tty->termios;
> 	ktermios.c_cflag &=3D ~CBAUD;
> -	ktermios.c_cflag |=3D BOTHER;
> +	ktermios.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR |
> +			    IGNCR | ICRNL | IXON);
> +	ktermios.c_oflag &=3D ~OPOST;
> +	ktermios.c_lflag &=3D ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
> +	ktermios.c_cflag &=3D ~(CSIZE | PARENB | CBAUD);

I just realize that we are clearing CBAUD twice here. I think the one above=
 BOTHER should also be removed.

IF: Agreed, good catch.

> +	ktermios.c_cflag |=3D CS8;
> +	ktermios.c_cflag |=3D CRTSCTS;
> 	tty_termios_encode_baud_rate(&ktermios, speed, speed);

Regards

Marcel
