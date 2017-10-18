Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: UART baud rate to 3M within btattach
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6AEB9243C1923B41A52689D49F0E099ED2F713@insys-exchange.INSYS-GROUP.LAN>
Date: Wed, 18 Oct 2017 16:31:20 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E66B264E-BFE6-485C-A756-50DA72931AF8@holtmann.org>
References: <6AEB9243C1923B41A52689D49F0E099ED2F6AC@insys-exchange.INSYS-GROUP.LAN>
 <B688E807-F368-4359-AE46-85CF3931198F@holtmann.org>
 <6AEB9243C1923B41A52689D49F0E099ED2F6DE@insys-exchange.INSYS-GROUP.LAN>
 <91F67C0D-356B-4CBB-BA32-899B0BB30DC4@holtmann.org>
 <6AEB9243C1923B41A52689D49F0E099ED2F713@insys-exchange.INSYS-GROUP.LAN>
To: Libor Peltan <lpeltan@insys-tec.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Libor,

> Thank you Marcel, your suggestion solved my issue:
> 
> I had to compile the kernel with CONFIG_BT_HCIUART_QCA.
> I must also call following at the bootup:
> 
> btattach -S 3000000 -P qca
> sleep 1
> killall btattach
> sleep 1
> btattach -S 3000000 -P h4
> bluetoothd
> 
> ...otherwise bluetoothd doesn't work (=finds 0 adapters).
> But I'm glad to have this workaround :)

actually only one btattach command should be needed. If this doesn't work, we should fix hci_qca.c to support it. Since after loading the firmware and configuring the UART speed, the QCA protocol will automatically run H4. No need to kill btattach and restart it with a different protocol.

Can you share "btmon -w trace.log" traces?

Regards

Marcel

