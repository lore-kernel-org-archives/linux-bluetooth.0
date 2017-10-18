Return-Path: <lpeltan@insys-tec.de>
From: Libor Peltan <lpeltan@insys-tec.de>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: UART baud rate to 3M within btattach
Date: Wed, 18 Oct 2017 12:09:17 +0000
Message-ID: <6AEB9243C1923B41A52689D49F0E099ED2F6DE@insys-exchange.INSYS-GROUP.LAN>
References: <6AEB9243C1923B41A52689D49F0E099ED2F6AC@insys-exchange.INSYS-GROUP.LAN>
 <B688E807-F368-4359-AE46-85CF3931198F@holtmann.org>
In-Reply-To: <B688E807-F368-4359-AE46-85CF3931198F@holtmann.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Marcel for your answer.

I call 'btattach -P h4', because ath3k and qca options would simply reply '=
protocol not supported'.

My point is how to send the HCI command inside, or before btattach launch.

Thanks :)

-----Urspr=FCngliche Nachricht-----
Von: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Gesendet: Mittwoch, 18. Oktober 2017 14:05
An: Libor Peltan <lpeltan@insys-tec.de>
Cc: linux-bluetooth@vger.kernel.org
Betreff: Re: UART baud rate to 3M within btattach

Hi Libor,

> my setup: Linux 4.14rc2, bluez 5.47. SoC + Qualcomm BT chip, connected vi=
a UART.
> The default speed of the UART is 115200 bps, which is obviously slow, nee=
d 3M bps.
>=20
> I already found out, how to do it: send a HCI command
> 0x01 0x48 0xFC 0x01 0x0E
> In other words: OGF=3D0x3F, OCF=3D0x0048, plen=3D1, pdata=3D0xE ...and re=
set=20
> the UART after 300 millis with new speed.
>=20
> This is possible via 'hcitool', but it breaks running instances of btatta=
ch...
>=20
> I would like to make btattach to do it for me at startup. Is there a way =
to configure it?
>=20
> It seems that hciattach had this possibility, but dunno if not already de=
precated in bluez 5.47 and how to use it.

so it depends on your hardware. Is the QCA or ATH hardware? Try btattach -P=
 qca or btattach -P ath3k and see if it will change the baudrate and do the=
 correct setup.

Regards

Marcel
