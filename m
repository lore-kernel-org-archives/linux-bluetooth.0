Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Reply-To: jose.bollo@iot.bzh
From: =?UTF-8?Q?Jos=C3=A9_Bollo?= <jose.bollo@iot.bzh>
Date: Thu, 8 Dec 2016 15:40:24 +0100
Message-ID: <CA+LDafA2A4Jy8s4aYi8DiwZ=L6dNsQm5g6es5jXMu0pqB9fprA@mail.gmail.com>
Subject: How BLE services could be remembered?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I observe a strange behaviour of bluez dbus interface.

I'm using Cinolink BT 4.0 USB Adapter (CSR BC8510 chipset), Bluez 5.43
on debian and/or on fedora.

When I first pair a BLE device, the services are correctly discovered
and the GATT endpoints are created (a lot).

Then I can use it as expected and it is nice. But when I turn off the
computer and restart it, things become different.

Because the devices are paired with LT key, they are still paired but
the GATT services are not availables. I can connect to the device but
it doesn't declares the GATT properties/attributes that I need. Also,
the service advertises itself without effect.

To be able to restore the attributes, I need to first remove the
device using bluetoothctl (CancelPair doesn't seems to work) and to
pair a new time.

Can you reproduce it? Is it the intended behaviour? How can I setup
the system to have GATT properties+attributes present after an
advertising? What dbus method should I call (ConnectService doesn't
works)?

Best regards

Jos=C3=A9 Bollo - Senior Software Engineer
www.iot.bzh
