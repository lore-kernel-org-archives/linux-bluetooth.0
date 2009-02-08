Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb compatibility issues
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Rogers <brian@xyzw.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <498EB082.7040708@xyzw.org>
References: <498EB082.7040708@xyzw.org>
Content-Type: text/plain
Date: Sun, 08 Feb 2009 18:10:19 +0100
Message-Id: <1234113019.5355.18.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> It appears that the btusb driver has never worked for at least the 
> following dongles:
> 
> 1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth Adapter
> 1131:1004 Integrated System Solution Corp. Bluetooth Device
> 2001:f111 D-Link Corp. [hex] DBT-122 Bluetooth adapter
> 0a5c:200a Broadcom Corp. Bluetooth dongle
> 
> And so when this became the default driver in 2.6.27, some users could 
> no longer use Bluetooth. They can generally scan for devices, but no 
> connections can be established in either direction.
> 
> See the bug report here: 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/268502

just a warning here. Everything that is buried in Ubuntu bugs is nothing
I care about. The Ubuntu kernel maintainers have to learn to get these
things solved upstream.

> I have the KY-BT100 listed above, and was hoping this would be an 
> ordinary regression where I could just bisect and find the bad commit. 
> But I soon realized what made Bluetooth work or not work was whether 
> hci_usb or btusb was being used. One thing I noticed is that either way, 
> I got this in dmesg:
> 
> hci_cmd_task: hci0 command tx timeout
> 
> This seems to be common to everyone experiencing this issue. Since the 
> message is still produced with the hci_usb driver, even though that 
> driver works, a (perhaps naive) guess of mine is that the problem has 
> something to do with the two drivers handling this error differently.
> 
> I'm attaching the output of 'hciconfig -a' and logs of 'bluetoothd -nd'. 
> I got different results depending on whether I plugged in the dongle 
> before or after starting bluetoothd, so I'm supplying both log files. In 
> the hotplugging case, I got these two messages:
> 
> bluetoothd[6745]: Adapter /org/bluez/6745/hci0 without an address
> bluetoothd[6745]: Can't read version info for /org/bluez/6745/hci0: 
> Unknown error 18446744073709551506 (-110)
> 
> after plugging in the device, and the applet didn't show a list of 
> paired devices to try to connect to, so I just unplugged the device.

Don't try with bluetoothd at all. Make sure it is not running. Plug in
the dongle and start hcidump -X -V and then do hciconfig hci0 up. This
way I see what is going on.

Also please run a kernel built from bluetooth-testing.git so I can
properly debug this. There is one change in it that affects the bulk
URBs and maybe these dongles just don't like it if we only submit them
when needed.

Next step is to check on these devices ISOC interface. So I need the
content of /proc/bus/usb/devices for this dongle. And then you need to
try to mark them with BTUSB_BROKEN_ISOC.

Regards

Marcel


