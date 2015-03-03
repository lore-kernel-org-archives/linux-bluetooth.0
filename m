Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Rich Rath <rath@way.net>
Date: Mon, 2 Mar 2015 22:12:53 -1000
Message-ID: <CAPygXWLHcbw_qYA2bk9T9hSCABN-kwPQyPZeH_sedWo+-e50DA@mail.gmail.com>
Subject: unable to get bluez to recognize apple magic trackpad by name
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Blueman manager formerly recognized apple magic trackpad as such.

A bug in the 3.10 (kernel caused the system to hang because of
buffer-overflow in HID
core when the Apple magic trackpad was used after recognizing it via bluetooth.

the bug is here, along with the fix for it:
http://marc.info/?l=linux-bluetooth&m=138901091912674&w=2

Once the problem was fixed somewhere in 3.14, blueman  would pair
successfully but not provide the name, only identifying it by  MAC
address.

dmesg shows the correct name:

[Tue Jan 27 12:10:46 2015] magicmouse 0005:05AC:030E.0007: unknown
main item tag 0x0
[Tue Jan 27 12:10:46 2015] input: Apple Wireless Trackpad as
/devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.0/bluetooth/hci0/hci0:11/0005:05AC:030E.0007/input/input14
[Tue Jan 27 12:10:46 2015] magicmouse 0005:05AC:030E.0007:
input,hidraw4: BLUETOOTH HID v1.60 Mouse [Apple Wireless Trackpad] on
00:0a:3a:7c:b4:d8


and It also shows up in cat /proc/bus/input/devices

I: Bus=0005 Vendor=05ac Product=030e Version=0160
N: Name="Apple Wireless Trackpad"
P: Phys=00:0a:3a:7c:b4:d8
S: Sysfs=/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/bluetooth/hci0/hci0:11/0005:05AC:030E.0009/input/input16
U: Uniq=60:c5:47:89:91:a9
H: Handlers=event9 mouse2
B: PROP=5
B: EV=10001b
B: KEY=e520 10000 0 0 0 0
B: ABS=273800000000003
B: MSC=10

the dev at blueman who worked with me on another problem suggested
this particular problem might be in bluez and the kernel rather than
blueman:
https://github.com/blueman-project/blueman/issues/117#issuecomment-75496826

This makes sense since the problem appeared for the first time when
the 3.14 update restored the ability to use the apple magic trackpad.

The issue does not effect operation of the trackpad, just the name in
the blueman device manager, etc.  The only reason I report it is that
it used to show up properly before the 3.10 bug and the 3.14 fix noted
in the link above.

Any help would be greatly appreciated, especially if  if I am just
missing something.  Plz let me know if any more commands need to be
run/output provided.  Please be thorough if you want me to run
something as I am not a dev or a coder but can follow cli instructions
and such.

Temp workaround is to alias the device:
$ python2 ./test-device alias 60:C5:47:89:91:A9 'Apple Touchpad'

Thanks,
Rich
