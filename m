Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: UART baud rate to 3M within btattach
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6AEB9243C1923B41A52689D49F0E099ED2F6DE@insys-exchange.INSYS-GROUP.LAN>
Date: Wed, 18 Oct 2017 14:13:38 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <91F67C0D-356B-4CBB-BA32-899B0BB30DC4@holtmann.org>
References: <6AEB9243C1923B41A52689D49F0E099ED2F6AC@insys-exchange.INSYS-GROUP.LAN>
 <B688E807-F368-4359-AE46-85CF3931198F@holtmann.org>
 <6AEB9243C1923B41A52689D49F0E099ED2F6DE@insys-exchange.INSYS-GROUP.LAN>
To: Libor Peltan <lpeltan@insys-tec.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Libor,

> I call 'btattach -P h4', because ath3k and qca options would simply reply 'protocol not supported'.
> 
> My point is how to send the HCI command inside, or before btattach launch.

that is done by the different protocols drivers. Use a kernel that has support for ath3k or qca. Otherwise you can not do it. It designed that the kernel does the UART handling and the setup (including firmware loading etc.).

Regards

Marcel

