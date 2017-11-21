Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1511261624.16347.29.camel@hadess.net>
Subject: Bluetooth LE mouse staying "connected"
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 21 Nov 2017 11:53:44 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

I re-tested the battery support for Bluetooth LE, and I still have my
mouse staying "connected" because the PropertiesChanged signal is never
sent for it.

I believe the reason is that a btd_device reference is staying around.

Reproducer:
1. Launch bluetoothd
2. Turn mouse on
3. "disconnect" the device from the computer side
4. Notice that the "Connected" property didn't change but the device
will now appear disconnected in a properties dump

When connecting, the flow is:
- batt_probe() is called, I ref() the device
- batt_accept() is called

When disconnecting, the flow is:
- batt_disconnect() is called

Shouldn't batt_remove also be called in this case, so the refing is
symmetrical? If not, should I move the btd_device ref to batt_accept()
and add a removal for batt_disconnect()? Or is the problem in the core?

Cheers
