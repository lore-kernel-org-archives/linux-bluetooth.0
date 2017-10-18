Return-Path: <lpeltan@insys-tec.de>
From: Libor Peltan <lpeltan@insys-tec.de>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: UART baud rate to 3M within btattach
Date: Wed, 18 Oct 2017 14:16:05 +0000
Message-ID: <6AEB9243C1923B41A52689D49F0E099ED2F713@insys-exchange.INSYS-GROUP.LAN>
References: <6AEB9243C1923B41A52689D49F0E099ED2F6AC@insys-exchange.INSYS-GROUP.LAN>
 <B688E807-F368-4359-AE46-85CF3931198F@holtmann.org>
 <6AEB9243C1923B41A52689D49F0E099ED2F6DE@insys-exchange.INSYS-GROUP.LAN>
 <91F67C0D-356B-4CBB-BA32-899B0BB30DC4@holtmann.org>
In-Reply-To: <91F67C0D-356B-4CBB-BA32-899B0BB30DC4@holtmann.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you Marcel, your suggestion solved my issue:

I had to compile the kernel with CONFIG_BT_HCIUART_QCA.
I must also call following at the bootup:

btattach -S 3000000 -P qca
sleep 1
killall btattach
sleep 1
btattach -S 3000000 -P h4
bluetoothd

...otherwise bluetoothd doesn't work (=3Dfinds 0 adapters).
But I'm glad to have this workaround :)

Libor

-----Urspr=FCngliche Nachricht-----
Von: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Gesendet: Mittwoch, 18. Oktober 2017 14:14
An: Libor Peltan <lpeltan@insys-tec.de>
Cc: linux-bluetooth@vger.kernel.org
Betreff: Re: UART baud rate to 3M within btattach

Hi Libor,

> I call 'btattach -P h4', because ath3k and qca options would simply reply=
 'protocol not supported'.
>=20
> My point is how to send the HCI command inside, or before btattach launch=
.

that is done by the different protocols drivers. Use a kernel that has supp=
ort for ath3k or qca. Otherwise you can not do it. It designed that the ker=
nel does the UART handling and the setup (including firmware loading etc.).

Regards

Marcel
