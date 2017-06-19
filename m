Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Koginov  Gleb" <gkoginov@student.ethz.ch>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: BLE propagation delay of 50ms for devices next to each other - is
 this normal?
Date: Mon, 19 Jun 2017 13:40:49 +0000
Message-ID: <CE225A6C8248A541A98682EC87ACADD3025B7E0A@MBX111.d.ethz.ch>
References: <CE225A6C8248A541A98682EC87ACADD3025B7D53@MBX111.d.ethz.ch>
In-Reply-To: <CE225A6C8248A541A98682EC87ACADD3025B7D53@MBX111.d.ethz.ch>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a BLE sensor (TI CC2650STK) that I connect to my raspberry pi 3b via Bluetooth low-energy. The device is set up to run at 7.5ms connection interval with notifications. The pi side uses BlueZ stack.

When comparing the signal received from this device to a similar sensor, but wired through I2C, I am seeing an identical signal shape but a propagation delay of roughly 50ms. This is considerably more than what I would expect to see for a regular BLE propagation delay (considering the two devices lie right next to each other). The following stackoverflow post contains a plot showing exactly what the two signals look like:

https://stackoverflow.com/questions/44136728/bluez-is-propagation-delay-of-50ms-normal-for-ble/44164015#44164015
Unfortunately nobody was able to help with this matter so far.

So far I've re-checked the firmware on the sensor side and everything should be correct - no buffering happens.
Is there, perhaps, some level of buffering happening on the BlueZ side? Otherwise would anyone be able to suggest the possible source of these issues?

Thank you!

Regards,
Gleb
