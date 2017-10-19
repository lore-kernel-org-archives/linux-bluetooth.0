Return-Path: <lpeltan@insys-tec.de>
From: Libor Peltan <lpeltan@insys-tec.de>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: UART baud rate to 3M within btattach
Date: Thu, 19 Oct 2017 07:54:32 +0000
Message-ID: <6AEB9243C1923B41A52689D49F0E099ED2F775@insys-exchange.INSYS-GROUP.LAN>
References: <6AEB9243C1923B41A52689D49F0E099ED2F6AC@insys-exchange.INSYS-GROUP.LAN>
 <B688E807-F368-4359-AE46-85CF3931198F@holtmann.org>
 <6AEB9243C1923B41A52689D49F0E099ED2F6DE@insys-exchange.INSYS-GROUP.LAN>
 <91F67C0D-356B-4CBB-BA32-899B0BB30DC4@holtmann.org>
 <6AEB9243C1923B41A52689D49F0E099ED2F713@insys-exchange.INSYS-GROUP.LAN>
 <E66B264E-BFE6-485C-A756-50DA72931AF8@holtmann.org>
In-Reply-To: <E66B264E-BFE6-485C-A756-50DA72931AF8@holtmann.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
I tried to log what's going on both in case of my btattach-kill-btattach wo=
rkaround case, and in case i run only 'btattach -P qca' and bluetoothd is n=
ot working afterwards. You can find the logs at
http://stuff.krakonos.org/files/btmonSee.tar.bz2
I'm not really able to understand the output myself :(
Thank you for further comments,
Libor

-----Urspr=FCngliche Nachricht-----
Von: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Gesendet: Mittwoch, 18. Oktober 2017 16:31
An: Libor Peltan <lpeltan@insys-tec.de>
Cc: linux-bluetooth@vger.kernel.org
Betreff: Re: UART baud rate to 3M within btattach

Hi Libor,

> Thank you Marcel, your suggestion solved my issue:
>=20
> I had to compile the kernel with CONFIG_BT_HCIUART_QCA.
> I must also call following at the bootup:
>=20
> btattach -S 3000000 -P qca
> sleep 1
> killall btattach
> sleep 1
> btattach -S 3000000 -P h4
> bluetoothd
>=20
> ...otherwise bluetoothd doesn't work (=3Dfinds 0 adapters).
> But I'm glad to have this workaround :)

actually only one btattach command should be needed. If this doesn't work, =
we should fix hci_qca.c to support it. Since after loading the firmware and=
 configuring the UART speed, the QCA protocol will automatically run H4. No=
 need to kill btattach and restart it with a different protocol.

Can you share "btmon -w trace.log" traces?

Regards

Marcel
