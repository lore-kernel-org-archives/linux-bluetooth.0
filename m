Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] BlueZ line discipline baud rate setting update
Date: Wed, 17 Jun 2015 13:26:32 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E94262F69@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1434387007-3666-1-git-send-email-ifaenson@broadcom.com>
 <1434387007-3666-2-git-send-email-ifaenson@broadcom.com>,<B95AE695-FE24-4366-86F6-545CC786DFBD@holtmann.org>
In-Reply-To: <B95AE695-FE24-4366-86F6-545CC786DFBD@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

________________________________________
From: Marcel Holtmann [marcel@holtmann.org]
Sent: Wednesday, June 17, 2015 9:16 AM
To: Ilya Faenson
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] BlueZ line discipline baud rate setting update

Hi Ilya,

> Bring the tty into a known 8 bits, 1 start bit, 1 stop bit,
> hardware flow control state with a given baud rate.
>
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index ac87346..606cc5a 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -271,9 +271,16 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsi=
gned int speed)
>       struct tty_struct *tty =3D hu->tty;
>       struct ktermios ktermios;
>
> +     /* Bring the UART into a known state with a given baud rate */
>       ktermios =3D tty->termios;
>       ktermios.c_cflag &=3D ~CBAUD;
> -     ktermios.c_cflag |=3D BOTHER;
> +     ktermios.c_iflag &=3D ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR |
> +                         IGNCR | ICRNL | IXON);
> +     ktermios.c_oflag &=3D ~OPOST;
> +     ktermios.c_lflag &=3D ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
> +     ktermios.c_cflag &=3D ~(CSIZE | PARENB | CBAUD);
> +     ktermios.c_cflag |=3D CS8;
> +     ktermios.c_cflag |=3D CRTSCTS;
>       tty_termios_encode_baud_rate(&ktermios, speed, speed);

with the questions raised by the others, I think for now we just want to ch=
ange the baud rate and leave the rest to a more generic function. I am fine=
 if the kernel side wants to enforce the settings on the UART. That seems f=
ully reasonable. However we need to give drivers a chance to let it come fr=
om userspace as well and honor whatever they configured there.

So we need to clear CBAUD and then encode the baud rate. Do we need to both=
er with BOTHER or is that just not needed at all. I really like to get this=
 detail fixed as soon as possible since we are close to the merge window.

IF: The BOTHER is not needed. Okay: if this function deals with the baud ra=
te only, I will then introduce a separate function to bring the UART into a=
 reasonable default state for Bluetooth as part of the next Broadcom patch =
set. I'll try publishing them today if my other duties do not interfere.

Regards

Marcel=
