Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: headset - sco times out after 1 minute
Date: Mon, 6 Apr 2009 18:26:49 -0500
Message-ID: <79DD16001F75DB4EB7DE37CDD687BB2001AA78BE@dalamsexb02.AMERICAS.ROOT.PRI>
From: "Brock Denson" <Brock.Denson@csr.com>
To: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,
I am having some trouble with SCO.  I can connect to a headset and start
SCO, but after about 1 minute the SCO stops, but remains connected.

Disclaimers:
I know very little about Dbus or the inner workings of Bluetooth.

Some hopefully useful information:
BlueZ versions tried 4.30 and 4.34 with ./configure as per README,
latest version from git using bootstrap-configure
Linux Distribution Fedora Core 10
Kernel version 2.6.27.21-170.2.56.fc10.i686

Steps to recreate:
1.  Attach USB Bluetooth device
2.  Download pskeys
	Bccmd psload -r pskeys.psr
3.  Get default adapter
	Dbus-send --system --print-reply --type=method_call
--dest=org.bluez / org.bluez.Manager.DefaultAdapter
4.  Create a device
	Dbus-send --system --print-reply --type=method_call
--dest=org.bluez /org/bluez/2030/hci0 org.bluez.Adapter.CreateDevice
string:"11:11:11:11:11:11"
5.  Connect to device
	Dbus-send --system --print-reply --type=method_call
--dest=org.bluez /org/bluez/2030/hci0/dev_11_11_11_11_11_11
org.bluez.Headset.Connect
6.  Start SCO
	Dbus-send --system --print-reply --type=method_call
--dest=org.bluez /org/bluez/2030/hci0/dev_11_11_11_11_11_11
org.bluez.Headset.Play

The final dbus-send command returns an error after about 30
(suspiciously close to DEFAULT_DEFER_TIMEOUT in common/btio.c:48)
seconds of org.freedesktop.DBus.Error.NoReply and the SCO stops about 30
seconds later.  I have looked around a good bit, but have had trouble
finding documentation on the bluez 4.x branch.
The error from bluetoothd -n -d indicates a G_IO_ERR at the time the SCO
stops (~1 minute) from connect_cb() in common/btio.c:124 which then
calls sco_connect_cb() in audio/headset.c:544 
I do not see any errors in the kernel log, and have tried to capture the
dbus traffic with dbus-monitor (which is also a bit short on docs as
well) with little luck.  I have tried things like:
Dbus-monitor --system
Dbus-monitor --system "type='method_call'"
Dbus-monitor --system "type='method_call',interface='org.bluez.Headset'"

I would love to figure that out as well, by the way.

I would appreciate any help here,

Brock Denson | Sr. Applications Engineer | m. 972 900-6806 | o. 214
540-3838 

