Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 May 2016 21:58:06 -0400
Message-ID: <CAO52t7=F9j4M=XdLVpVsbN81QoAUoWgYNDZAr_oLsdZUZXepwg@mail.gmail.com>
Subject: Unable to use Microsoft Bluetooth Mobile Mouse 3600
From: Rick Ueno <rick.ueno@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm trying to connect a microsoft bluetooth mobile mouse 3600 (the
bluetooth card is Intel AC 3160
(http://www.intel.com/content/www/us/en/wireless-products/dual-band-wireless-ac-3160-bluetooth.html).
Using bluetoothctl, I was able to pair and connect ("Pairing
successful" and "Connection successful").

---
> bluetoothctl
[NEW] Controller 34:E6:AD:A1:44:6E ChromeLinux_0EB6 [default]
[NEW] Device 00:1E:52:CB:01:34 rueno’s mouse
[NEW] Device 0C:FC:85:00:44:D9 JETech 2155
[JETech 2155]# agent on
Agent registered
[JETech 2155]# default-agent
Default agent request successful
[JETech 2155]# scan on
Discovery started
[CHG] Controller 34:E6:AD:A1:44:6E Discovering: yes
[NEW] Device F4:F9:51:D4:8E:77 F4-F9-51-D4-8E-77
[NEW] Device C2:DD:27:45:BD:4E BluetoothMouse3600
[JETech 2155]# trust C2:DD:27:45:BD:4E
[CHG] Device C2:DD:27:45:BD:4E Trusted: yes
Changing C2:DD:27:45:BD:4E trust succeeded
[CHG] Device C2:DD:27:45:BD:4E RSSI: -55
[JETech 2155]# pair C2:DD:27:45:BD:4E
Attempting to pair with C2:DD:27:45:BD:4E
[CHG] Device C2:DD:27:45:BD:4E Connected: yes
[CHG] Device C2:DD:27:45:BD:4E UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device C2:DD:27:45:BD:4E UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device C2:DD:27:45:BD:4E UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
[CHG] Device C2:DD:27:45:BD:4E UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
[CHG] Device C2:DD:27:45:BD:4E UUIDs: 00001812-0000-1000-8000-00805f9b34fb
[CHG] Device C2:DD:27:45:BD:4E Paired: yes
Pairing successful
[CHG] Device C2:DD:27:45:BD:4E Modalias: usb:v045Ep0916d0100
[JETech 2155]# connect C2:DD:27:45:BD:4E
Attempting to connect to C2:DD:27:45:BD:4E
Connection successful
[BluetoothMouse3600]# info C2:DD:27:45:BD:4E
Device C2:DD:27:45:BD:4E
Name: BluetoothMouse3600
Alias: BluetoothMouse3600
Appearance: 0x03c2
Icon: input-mouse
Paired: yes
Trusted: yes
Blocked: no
Connected: yes
LegacyPairing: no
UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
UUID: Device Information        (0000180a-0000-1000-8000-00805f9b34fb)
UUID: Battery Service           (0000180f-0000-1000-8000-00805f9b34fb)
UUID: Human Interface Device    (00001812-0000-1000-8000-00805f9b34fb)
Modalias: usb:v045Ep0916d0100
RSSI: -55
---

However, the mouse does not seem to be responsive (Moving the mouse
doesn't move the cursor, or clicks are not registering). As you can
see above, I have a BT keyboard (JETech 2155) and another mouse
(rueno's mouse) that is working perfectly, so I believe the issue is
with the microsoft mouse.

When I look at the bluetoothd log, I see the following errors:

---
May 17 14:47:49 valkyrie bluetoothd[279]: Bluetooth daemon 5.39
May 17 14:47:49 valkyrie systemd[1]: Started Bluetooth service.
May 17 14:47:49 valkyrie bluetoothd[279]: Starting SDP server
May 17 14:47:49 valkyrie bluetoothd[279]: Bluetooth management
interface 1.10 initialized
May 17 14:47:49 valkyrie bluetoothd[279]: Failed to obtain handles for
"Service Changed" characteristic
May 17 14:47:49 valkyrie bluetoothd[279]: Sap driver initialization failed.
May 17 14:47:49 valkyrie bluetoothd[279]: sap-server: Operation not
permitted (1)
May 17 21:35:49 valkyrie bluetoothd[279]: No cache for C2:DD:27:45:BD:4E
May 17 21:35:53 valkyrie bluetoothd[279]: input-hog profile probe
failed for C2:DD:27:45:BD:4E
May 17 21:35:53 valkyrie bluetoothd[279]: GATT service objects disabled
---

>From what I understand, the error about sap-server can be ignored, but
I'm worried about the input-hog profile error (The device ID is of the
mouse in question). Am I missing a step somewhere?

I am wondering if the mouse is not yet supported by the kernel? If it
is not, is there a plan to add support for this mouse?

Thank you,
