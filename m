Return-Path: <cyrus@holtmann.org>
From: James Cloos <cloos@jhcloos.com>
To: linux-bluetooth@vger.kernel.org
Subject: Keeping hci interface powered
Date: Sat, 03 Jan 2015 19:27:40 -0500
Message-ID: <m3oaqfl79f.fsf@carbon.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I recently assembled a box for htpc duties, including a bluetooth
keyboard.

It mostly works, except that the hci interface continually powers down.

I suspect every time the keyboard powers down,the hci does, too.

How can I prevent that?

I want the hci always to be powered, so that the keyboard can reconnect
every time I hit a key.

As it is, whenever I want to use it, I have to ssh in from another
system, run bluetoothctl and therein run power on and connect $MAC.

You can imagine how frustrating that is.

The box has a Gigabyte F2A88XN-WIFI board, which came with a laptop-
style mini-pcie card with an intel 7260 802.11n on the pcie and an
8087:07dc bluetooth on the usb.

bluetoothctl show says:

Controller 80:86:xx:xx:xx:xx
	Name: BlueZ 5.27
	Alias: BlueZ 5.27
	Class: 0x000104
	Powered: yes
	Discoverable: no
	Pairable: yes
	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v1D6Bp0246d051B
	Discovering: no

Thanks,

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 0x997A9F17ED7DAEA6
