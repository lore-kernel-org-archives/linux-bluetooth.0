Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 2 Dec 2013 19:03:31 +0100
Message-ID: <CALzzRXk2F_3DKysS2SphGw-2WPqK-karYv+YqRiOC75=UJCHhw@mail.gmail.com>
Subject: Help for USB Dongle Asus USB-BT400 with Raspberry Pi and Bluez
From: Alessandro Nicolosi <alenico84@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I hope this can be the right place where to find help for my problems.

I need to use the dongle Asus USB-BT400 to provide Bluetooth support
for my Raspberry Pi in which I installed the Raspbian distribution.
I have to work with Raspberry Pi and a BLE device called SensorTag
from Texas Instruments. So I have to use the gatttool command from
Bluez.
I followed the instructions from this site to set up Bluez in my
Raspberry Pi with Raspbian.

 http://mike.saunby.net/2013/04/raspberry-pi-and-ti-cc2541-sensortag.html

I downloaded and installed the last version of Bluez 5.11.
I plugged in my BLE USB dongle in my Raspberry Pi but I think there
are some problems.
When I type in the command "hciconfig" I have no output results.
And also when I type in "hcitool dev" no devices is listed.
But when I type in "lsusb" the output is:

Bus 001 Device 002: ID 0424:9512 Standard Microsystems Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp.
Bus 001 Device 004: ID 0b05:17cb ASUSTek Computer, Inc.

The last one is my USB dongle, so I think the hardware is correctly recognized.
Which could be my problem?

I also tried the dongle Asus USB-BT400 in my notebook with Xubuntu
13.10 and it worked very well (hciconfig sees the bluetooth
interface).

I also read something about my dongle by googling and I found the
message linked below from this mailing list, so I thought you can help
me or give me a way forward.

http://marc.info/?l=linux-bluetooth&m=137812308709357&w=2

Maybe I can edit some source files to add the device ID? If yes, which
changes I have to do?

Thanks in advance for your help
Regards

-- 
Alessandro Nicolosi
