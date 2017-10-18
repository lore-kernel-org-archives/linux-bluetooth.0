Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Libor Peltan <lpeltan@insys-tec.de>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: UART baud rate to 3M within btattach
Date: Wed, 18 Oct 2017 11:36:54 +0000
Message-ID: <6AEB9243C1923B41A52689D49F0E099ED2F6AC@insys-exchange.INSYS-GROUP.LAN>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

my setup: Linux 4.14rc2, bluez 5.47. SoC + Qualcomm BT chip, connected via UART.
The default speed of the UART is 115200 bps, which is obviously slow, need 3M bps.

I already found out, how to do it: send a HCI command
0x01 0x48 0xFC 0x01 0x0E
In other words: OGF=0x3F, OCF=0x0048, plen=1, pdata=0xE
...and reset the UART after 300 millis with new speed.

This is possible via 'hcitool', but it breaks running instances of btattach...

I would like to make btattach to do it for me at startup. Is there a way to configure it?

It seems that hciattach had this possibility, but dunno if not already deprecated in bluez 5.47 and how to use it.

Thanks for any suggestions!!

Libor

