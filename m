Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Libor Peltan <lpeltan@insys-tec.de>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: bt "server" how to configure requiring passkey from connecting
 clients
Date: Tue, 7 Aug 2018 09:43:33 +0000
Message-ID: <VI1PR0601MB21287F56810A923C8881893C9A270@VI1PR0601MB2128.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I'm preparing a bluetooth "access point" using BlueZ 5.47, so that for exam=
ple mobile phones can connect to it, and further use PAN profile (which is =
not part of this question). So far it works well, just using the JustWorks =
pairing method.

I'd like to secure this a little bit, not allowing anyone to pair, rather t=
o request passkey (let's say hardcoded string) before accepting pairing req=
uested by a client mobile phone.

After searching through documentation and much googling, I don't see any hi=
nts how to achieve this.

I found some information about pairing agents in BlueZ5, both in bluetoothc=
tl and custom (programming them seems complicated but viable and I cannot u=
se simple-agent since I don't have python on my machine), but all the useca=
ses seem to target on BlueZ being the client, who initiates pairing, and th=
e agent takes care of inputting passkey required by the other side - which =
is the opposite of what I need.

How to configure BlueZ5 to require passkey from any incomming pairing reque=
sts?

Thanks very much for your answers!

Libor
