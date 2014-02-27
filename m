Return-Path: <cyrus@holtmann.org>
Message-ID: <530FBB6B.8080300@gmx.net>
Date: Thu, 27 Feb 2014 23:25:47 +0100
From: Tobias Jakobi <liquid.acid@gmx.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [bluez-5.14] connect fails with 'org.bluez.Error.NotAvailable'
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm trying to establish a BT connection between two systems. The client
is running bluez-5.14 and I'm using bluetoothctl to interface with the
daemon.

The server system provides a NAP, plus dnsmasq, so that connecting
clients receive an IP. For reference, this works perfectly on an Android
smartphone. When connecting to the server system, the bnep device is
created on the server and added to the bridge. The Android bluetooth
stack then gets an IP via dnsmasq and voila... TCP/IP connection.

On this client however, this doesn't work at all. Plus, I'm not getting
any kind of meaningful error message.

That's the server:
[bluetooth]# info 00:02:72:C6:43:11
Device 00:02:72:C6:43:11
	Name: chidori-bt
	Alias: chidori-bt
	Class: 0x020000
	Paired: yes
	Trusted: yes
	Blocked: no
	Connected: no
	LegacyPairing: no
	UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
	UUID: NAP                       (00001116-0000-1000-8000-00805f9b34fb)
	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v1D6Bp0246d0509


And here's how connecting goes:
[bluetooth]# connect 00:02:72:C6:43:11
Attempting to connect to 00:02:72:C6:43:11
[CHG] Device 00:02:72:C6:43:11 Connected: yes
[CHG] Device 00:02:72:C6:43:11 Modalias: usb:v1D6Bp0246d0509
Failed to connect: org.bluez.Error.NotAvailable
[CHG] Device 00:02:72:C6:43:11 Connected: no

So, it looks like that it briefly connect, but then drops the connection
again. I haven't been able to figure out what exaclty is 'NotAvailable'
at this moment. The server at least is.


This is something from the bt daemon (client):
leena bluetoothd[26910]: Bluetooth daemon 5.14
leena bluetoothd[26910]: Starting SDP server
leena bluetoothd[26910]: Bluetooth management interface 1.3 initialized
leena bluetoothd[26910]: Sap driver initialization failed.
leena bluetoothd[26910]: sap-server: Operation not permitted (1)
leena bluetoothd[26910]: Can't add /org/bluez/hci0/dev_00_02_72_C6_43_11
to non-LE capable adapter connect list

I'm not sure if the 'non-LE' message has something to do with the issue.

Any idea on how to proceed here?

Greets,
Tobias

PS: More info:
[bluetooth]# show
Controller B4:82:FE:65:22:8E
	Name: leena-bt
	Alias: leena-bt
	Class: 0x00010c
	Powered: yes
	Discoverable: no
	Pairable: yes
	UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
	UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
	UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
	UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
	Modalias: usb:v1D6Bp0246d050E
	Discovering: no
