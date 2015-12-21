Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 21 Dec 2015 15:46:07 +0100
From: Martin =?utf-8?Q?Kj=C3=A6r_J=C3=B8rgensen?= <mkj@gotu.dk>
To: linux-bluetooth@vger.kernel.org
Subject: DS4 issues
Message-ID: <20151221144607.GA18773@mkjlap.gotu.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is there any "full" support for a Sony DualShock 4 in the bluez/kernel
stack?

The one I own works perfectly when using USB cable.

When using bluetooth it gets recognized as a somewhat generic
Bluetooth Wireless Controller. Pairing it up with my system seems to
work as it creates a joystick device (/dev/input/js0) but when testing
it with jstest, only the touchpad on the DS4 triggers two of the
axis. None of the buttons or sticks reacts in jstest.
Pairing it with the usual bluetoothctl makes the DS4 LED dimmed blue
light.

I know of the ds4drv project and have used it to connect my DS4, but
it seems a big buggy and I was hoping it was or will be merged into
bluez/kernel, making it superfluous.

Using the DS4 makes the LED brighter than using ordinary bluetoothctl,
perhaps because ds4drv knows how to intruct the LED.
Even if my DS4 is almost next to my bluetooth radio device, the ds4drv
reports "Signal strength low (29/40/38) reports"
Testing with jstest seems to trigger all buttons and axises. The
touchpad itself as a button triggers, but touching the pad doesnt trigger
anything.
In some games the digital keys on the left doesnt get recognized, even
if they get triggered by jstest and other programs like Steam
recognizes them.



