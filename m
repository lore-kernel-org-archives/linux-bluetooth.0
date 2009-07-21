Return-Path: <cyrus@holtmann.org>
Subject: bluetooth SPP link to Nokia phone
From: Henry Gomersall <whg21@cam.ac.uk>
Reply-To: heng@cantab.net
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Tue, 21 Jul 2009 10:45:40 +0100
Message-Id: <1248169540.7048.52.camel@whg21-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've been attempting to do some hacking on the Bluez stack. The starting
point was to initiate an SPP link to my Nokia 6300 mobile phone. I can
establish the link, but when I attempt to send characters to it (through
several different methods), the phone will announce it is disconnecting.
The python I use is at the bottom of this email.

I have already set up a serial connection using a UART to bluetooth
module (a module based on the LMX9830) in conjunction with a
USB->serial->UART piece of hardware. In this configuration, I can
initiate a connection to the phone and write and receive bytes from it
no problem.

My questions are as follows:

1) Am I missing something important with how I am using the Bluez stack?
2) Is this a known issue or is it a previous known issue? I am still
using the version of Bluez that comes with shipped with Ubuntu 9.04
which is 4.39.
3) Are there any caveats with how devices implement the serial port
profile?

I'm keen to sort this problem out and would appreciate any assistance.

Many thanks,

Henry Gomersall

The code used:

import dbus

bus = dbus.SystemBus();
manager = dbus.Interface(bus.get_object('org.bluez', '/'),
'org.bluez.Manager')
obj = bus.get_object('org.bluez', manager.DefaultAdapter())
adapter = dbus.Interface(obj, 'org.bluez.Adapter')

phone = dbus.Interface(bus.get_object('org.bluez',
adapter.ListDevices()[0]), 'org.bluez.Device')

phone_serial = dbus.Interface(phone, 'org.bluez.Serial')
phone_serial.Connect('spp')

At this stage, I have the device /dev/rfcomm0, but I cannot write data
to it without breaking the link.

