Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: UART baud rate to 3M within btattach
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6AEB9243C1923B41A52689D49F0E099ED2F6AC@insys-exchange.INSYS-GROUP.LAN>
Date: Wed, 18 Oct 2017 14:05:10 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <B688E807-F368-4359-AE46-85CF3931198F@holtmann.org>
References: <6AEB9243C1923B41A52689D49F0E099ED2F6AC@insys-exchange.INSYS-GROUP.LAN>
To: Libor Peltan <lpeltan@insys-tec.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Libor,

> my setup: Linux 4.14rc2, bluez 5.47. SoC + Qualcomm BT chip, connected via UART.
> The default speed of the UART is 115200 bps, which is obviously slow, need 3M bps.
> 
> I already found out, how to do it: send a HCI command
> 0x01 0x48 0xFC 0x01 0x0E
> In other words: OGF=0x3F, OCF=0x0048, plen=1, pdata=0xE
> ...and reset the UART after 300 millis with new speed.
> 
> This is possible via 'hcitool', but it breaks running instances of btattach...
> 
> I would like to make btattach to do it for me at startup. Is there a way to configure it?
> 
> It seems that hciattach had this possibility, but dunno if not already deprecated in bluez 5.47 and how to use it.

so it depends on your hardware. Is the QCA or ATH hardware? Try btattach -P qca or btattach -P ath3k and see if it will change the baudrate and do the correct setup.

Regards

Marcel

