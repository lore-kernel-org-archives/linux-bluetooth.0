Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Libor Peltan <lpeltan@insys-tec.de>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: question: auto-trust after pairing
Date: Wed, 16 May 2018 10:58:07 +0000
Message-ID: <AM3PR06MB083875B8578B90DE59B104F69A920@AM3PR06MB0838.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone,

I'd like to ask about specific configuration of bluetooth daemon.

1. How it works for me:
I'm running BlueZ 5.47 on an ARMv7-powered board with a Qualcomm chip.
When a device (mostly a phone) connects via bluetooth, it is paired automat=
ically without any PIN exchange.
In order to use PAN protocol over bluetooth, the connected device needs to =
be trusted.
To achieve this, I created an external program, that communicates with blue=
toothd via DBus. When a DBus message arrives informing about new paired dev=
ice, the program responds (if some policy conditions are fulfilled) with DB=
us message requesting trusting this device. Overall, this makes an approx 0=
.5 secs delay between pairing and trusting of the device.

2. My problem
When testing an iPhone in the role of the connecting device, after the pair=
ing I can see an error message on the iPhone. After trying to connect again=
, it already works. It's not nice, for the future users, to always receive =
an error message on first attempt - I need to avoid this.
I observed that after pairing, the iPhone immediately (in 10 millis) tries =
to connect to PAN. This is not yet possible, since it's not yet trusted. Th=
is causes the error message.

3. My question
Is there a way to change bluetoothd, so that he automatically trusts a devi=
ce when it pairs?
Is it possible to turn this "auto-trust" mode on and off without restarting=
 bluetoothd?

Thanks much for the answers or any other usefult tips!

Libor Peltan

