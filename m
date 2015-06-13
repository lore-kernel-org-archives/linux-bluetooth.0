Return-Path: <cyrus@holtmann.org>
Message-ID: <557C1E7B.1020800@peakwork.de>
Date: Sat, 13 Jun 2015 14:13:47 +0200
From: Markus Pfau <markus.pfau@peakwork.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: High CPU load when turning off BT keyboard
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

google searches regarding CPU load after switching off an bluetooth 
input device can be found a lot.
Unfortunately they usually finish with "not reproducable"

I have now such an device:

Jun 13 01:06:11 odroid kernel: [ 2496.403746] [c6] input: BT 
Touchpad_keyboard as 
/devices/12110000.usb/usb1/1-1/1-1.5/1-1.5:1.0/bluetooth/hci0/hci0:71/input1
Jun 13 01:06:11 odroid kernel: [ 2496.407206] [c6] hid-generic 
0005:099A:0500.0001: input,hidraw0: BLUETOOTH HID v1.1b Mouse [BT 
Touchpad_keyboard] on 00:1a:7d:da:71:12

and it was very good reproducable.

- Linux Ubuntu 15.05
- Odroid XU3 Board
- Latest Bluez version (5.30) compiled from source

What I did:
- Start bluetoothd
- Power On
- Switch On BT Keyboard, wait for connect
- Switch BT keyboard off
- bluetoothd runs with 100% CPU and stays there regardless what I do

The cause is, that one eventhandler in device is not freed and the 
System eventloop seems to call this event without sync.
For any reason the BT device is not detected as "reconnectable", after 
disconnection void input_device_enter_reconnect_mode is called but there 
is nothing to do:

diff --git a/profiles/input/device.c b/profiles/input/device.c
index a494ea2..aacf3a7 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1204,7 +1204,12 @@ static void 
input_device_enter_reconnect_mode(struct input_device *idev)
          */
         if (idev->reconnect_mode != RECONNECT_ANY &&
                                 idev->reconnect_mode != RECONNECT_HOST)
-               return;
+       {
+          if (idev->sec_watch > 0)
+                g_source_remove(idev->sec_watch);
+         idev->sec_watch=0;
+         return;
+       }

Freeing idev->sec_watch in this case results to an clean disconnect and 
no CPU load appears.

I have noticed the CPU load issue also with older Bluez versions (e.g. 
4.101), I think this problem has never fixed.

Can you pls verify / apply  this patch?

Thanks, Markus
