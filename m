Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Semih Hazar <shazar@gmail.com>
Date: Thu, 6 Oct 2016 17:26:14 -0500
Message-ID: <CAH3xFdZjm+YS+3N8=_v=jMhRPsBb5PzcqLe=vQDRDKKae6U1_Q@mail.gmail.com>
Subject: BLE Connection Problem with iPhone 7
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I'm using the latest kernel (master) and latest Bluez release. Our
Python app is using D-Bus API to create a BLE peripheral.

When connecting from an iPhone 7, it doesn't work with our embedded
WiFi/Bluetooth module, but works with a USB BT dongle. In [1] you can
see the packet dump when using the embedded chip and in [2] when using
the USB dongle.

Can you help me understand the difference between these two? Initially
it looks like both the phone and our device is setting new MTU sizes.
But in the non-working case only our device (i.e. Bluez) is asking for
a new MTU size. Is that correct?

Also in non-working scenario, iPhone doesn't seem to be querying
services on our device.

What could be the reason for this? What else can I check?

Another point is, embedded module works with other smartphones
including other iPhones such as 6 and 6S.

Both embedded module and the USB dongle use Broadcom chips. Module:
BCM43438A0, USB: BCM20702A1

[1] http://imgur.com/8uoXnVw
[2] http://imgur.com/JnSlIKK

Thanks in advance,
Semih Hazar
