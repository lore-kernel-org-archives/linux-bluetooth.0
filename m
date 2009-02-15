Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 15 Feb 2009 15:49:04 +0530
Message-ID: <43bd633d0902150219q402b335fma2d5564faf449199@mail.gmail.com>
Subject: How can I find out if my USB Bluetooth dongle is Class I or Class II
	using Bluez
From: Bhavin Shah <bhavinpshah@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We want to use Class I dongle to increase the range of the content we
want to push within our Bluetooth Zone. For this we have ordered some
of Bluetooth Dongles. All the suppliers have claimed that they are
Class I dongles. But to our surprise, when we tested it we figured out
that only one type out of three types is having good range. The other
dongles does not have good range. They are all having CSR chipset and
shows me same set of firmware.I am using Bluez 4.26.

I surfed on net and find out that the 'Transmit Power' is the value
that I should look for. When I did "#hciconfig hci0 inqtpl" it gave me
IO error!

With "bccmd" I found out that one of the dongle which does not have
good range has 0x0004 value on address 0x0017 and the one which has
good range has 0x000f value on the address 0x0017. Can someone please
help me how can I check what values should belong to Class I and Class
II dongles? Also is there a way to change these values using "bccmd".
I have already tried "#bccmd psset" but it did not set the values
correctly.

Your help is much appreciated, I am totally new to Bluetooth subject on Linux.

Regards,
Bhavin
