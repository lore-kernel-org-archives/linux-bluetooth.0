Return-Path: <cyrus@holtmann.org>
From: gene heskett <gheskett@wdtv.com>
To: linux-bluetooth@vger.kernel.org
Subject: Poor connection retention
Date: Sun, 3 Jul 2011 10:08:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201107031008.15248.gheskett@wdtv.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greetings;

I have a BT dongle on my usb tree here, which when connected after a 
reboot, throws this in the log:

Jul  2 17:29:21 coyote bluetoothd[30502]: Bluetooth deamon 4.93
Jul  2 17:29:21 coyote bluetoothd[30502]: Starting SDP server
Jul  2 17:29:22 coyote klogd: Bluetooth: L2CAP ver 2.15
Jul  2 17:29:22 coyote klogd: Bluetooth: L2CAP socket layer initialized
Jul  2 17:29:22 coyote klogd: Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Jul  2 17:29:22 coyote klogd: Bluetooth: BNEP filters: protocol multicast
Jul  2 17:29:22 coyote bluetoothd[30502]: Listening for HCI events on hci0
Jul  2 17:29:22 coyote klogd: Bluetooth: SCO (Voice Link) ver 0.6
Jul  2 17:29:22 coyote klogd: Bluetooth: SCO socket layer initialized
Jul  2 17:29:22 coyote bluetoothd[30502]: HCI dev 0 up
Jul  2 17:29:22 coyote klogd: Bluetooth: RFCOMM TTY layer initialized
Jul  2 17:29:22 coyote klogd: Bluetooth: RFCOMM socket layer initialized
Jul  2 17:29:22 coyote klogd: Bluetooth: RFCOMM ver 1.11
Jul  2 17:29:22 coyote bluetoothd[30502]: Adapter /org/bluez/30502/hci0 has 
been enabled

Which to my untrained eye, looks normal.

The circuit does not have a lot of traffic as its an rs-232 terminal 
emulation.

However, a few hours later the connection is lost, and an attempt to re-
establish it with blueman-manager fails, logging this when it fails:

Jul  3 09:50:58 coyote klogd: hci_acl_tx_to: hci0 ACL tx timeout
Jul  3 09:50:58 coyote klogd: hci_acl_tx_to: hci0 killing stalled ACL 
connection 00:0C:84:00:86:F8

rfcomm0 exists until I try to reconnect, and is then removed.

Blueman-manager seems to be reporting stale data because even when the 
terminal proggy is DOA, it is reporting a poor signal when I hover over the 
bar graph that is identical to when it was working.  Occasionally the green 
bar will go to nearly full height, but generally its just a small bar.  The 
circuit length is about 17 feet, thru a wall and a floor in a stick built 
house.

I can reconnect only by rebooting this machine.

Is this a known problem?  If so, what can I do about it?

The kernel running is a pclos built 2.6.38.8, on a quad core phenom.
pclos is a rolling release and is kept up to date daily.

Cheers, gene
-- 
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Some people need a good imaginary cure for their painful imaginary ailment.
