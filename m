Return-Path: <cyrus@holtmann.org>
Message-ID: <4D2FC458.9010307@lundman.net>
Date: Fri, 14 Jan 2011 12:34:48 +0900
From: Jorgen Lundman <lundman@lundman.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Linux 2.6.22-19 bluetoothd on mediaplayer, works AND hangs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello list,


I am trying out the bluetooth drivers on an embedded MIPS media player. The 
Linux kenrel version is locked at 2.6.22-19-sigma. Not much I can do there.

As it happens, I did get it all to work, but the "bluetoothd" process, hangs. It 
hangs in a strange way where you can not kill it, and "ps" will also hang when 
it inspects /proc/$pid-of-bluetoothd/ etc.

If I ignore that bluetoothd process hangs, the bluetooth device does actually 
work. The device is made active before the process hangs.

For example:

sh-3.00# ./dbus-daemon --system

sh-3.00# insmod bluetooth.ko
<6>Bluetooth: Core ver 2.11
<6>NET: Registered protocol family 31
<6>Bluetooth: HCI device and connection manager initialized
<6>Bluetooth: HCI socket layer initialized

sh-3.00# insmod l2cap.ko
<6>Bluetooth: L2CAP ver 2.8
<6>Bluetooth: L2CAP socket layer initialized

sh-3.00# insmod hci_usb.ko
<6>Bluetooth: HCI USB driver ver 2.9
<6>usbcore: registered new interface driver hci_usb

sh-3.00# ./bluetoothd

(Not hung yet [1])

sh-3.00# ./usr/sbin/hciconfig -a
hci0:   Type: USB
         BD Address: 00:1B:DC:00:41:91 ACL MTU: 310:10 SCO MTU: 64:8
         UP RUNNING
         RX bytes:95 acl:0 sco:0 events:10 errors:0
         TX bytes:45 acl:0 sco:0 commands:10 errors:0
         Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy:
         Link mode: SLAVE ACCEPT
         Name: 'PCH-C200-0'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 2.1 (0x4) HCI Rev: 0x12e7 LMP Ver: 2.1 (0x4) LMP Subver: 0x12e7
         Manufacturer: Cambridge Silicon Radio (10)

Now the 'bluetoothd' process is hung - unkillable etc. What is amusing is that 
the bluetooth device keeps working:

sh-3.00# ./wminput
Put Wiimote in discoverable mode now (press 1+2)...
Ready.
<6>input: Nintendo Wiimote as /class/input/input1


I have not yet found anyway to kill bluetoothd, apart from reboot. It is 
annoying that is hangs like this, even though I can still use the device.  If I 
strace the process, I get:


writev(2, [{"bluetoothd[1813]: plugins/hciops."..., 71}, {"\n"...,
1}], 2bluetoothd[1813]: plugins/hciops.c:update_ext_inquiry_response()) 
                                      = 72

[snip]

open("/var/lib/bluetooth/00:1B:DC:00:41:91/config", O_RDWR) = 17
flock(17, LOCK_EX) = 0
fstat(17, {st_mode=S_IFREG|0644, st_size=13, ...}) = 0
old_mmap(NULL, 13, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_LOCKED, 17, 0

Note the missing return value for old_mmap(). It never comes back. If I take out 
update_ext_inquiry_response() entirely, it just dies in another old_mmap(). This 
makes me think that the process is locked against itself somewhere earlier, and 
dying in mmap() is just a symptom of that.

Are there any known issues with the version of bluetooth module that comes with 
2.6.22-19 which could be my issue? Anything know relating to -sigma's kernel 
patches even? Although it is peculiar the device keeps working if the problem is 
in the kernel module. Debug mode I can turn on?

sh-3.00# lsmod
Module                  Size  Used by    Tainted: P
hci_usb                15872  2
l2cap                  26576  6
bluetooth              66176  6 hci_usb,l2cap

If I "hciconfig hci0 down" the device, hci_usb module decreases to 1, but I can 
never get it to 0 (I would guess bluetoothd holds the other one).

[1] Actually, I tried to kill bluetoothd before I run hciconfig, and even though 
it is not yet stuck in mmap, the process does not die even here.

-- 
Jorgen Lundman       | <lundman@lundman.net>
Unix Administrator   | +81 (0)3 -5456-2687 ext 1017 (work)
Shibuya-ku, Tokyo    | +81 (0)90-5578-8500          (cell)
Japan                | +81 (0)3 -3375-1767          (home)
