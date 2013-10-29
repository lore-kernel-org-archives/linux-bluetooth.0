Return-Path: <cyrus@holtmann.org>
Message-ID: <526F8804.9060906@canonical.com>
Date: Tue, 29 Oct 2013 18:03:48 +0800
From: Hui Wang <hui.wang@canonical.com>
MIME-Version: 1.0
To: tedd.an@intel.com, johan.hedberg@intel.com, marcel@holtmann.org,
 xiong.y.zhang@intel.com, gustavo.padovan@collabora.co.uk
CC: linux-bluetooth@vger.kernel.org
Subject: Intel 7260 bluetooth malfunction when it is connected to EHCI bus
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

The problem is:
On the machine which has Intel 7260 BT module, i use it to connect a 
bluetooth headset,
it can successfully scan and connect to the headset, when i play sound 
to the bt headset,
the problem comes, if the bt module is connected to the XHCI, it can 
work very well.

u@u-Lenovo-B4400:~$ lsusb -t
1-7:1.0: No such file or directory
/: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
/: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
     |__ Port 6: Dev 8, If 0, Class=HID, Driver=usbhid, 1.5M
     |__ Port 7: Dev 2, If 0, Class=vend., Driver=, 12M
     |__ Port 11: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet 
handled', Driver=btusb, 12M
     |__ Port 11: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet 
handled', Driver=btusb, 12M

But if the bt module is connected to the EHCI, it always fails to play 
sound.

u@u-Lenovo-B4400:~$ lsusb -t
/: Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
/: Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
/: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
/: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
         |__ Port 5: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet 
handled', Driver=btusb, 12M
         |__ Port 5: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet 
handled', Driver=btusb, 12M
         |__ Port 6: Dev 4, If 0, Class='bInterfaceClass 0x0e not yet 
handled', Driver=uvcvideo, 480M
         |__ Port 6: Dev 4, If 1, Class='bInterfaceClass 0x0e not yet 
handled', Driver=uvcvideo, 480M

---------------------------------------------------------------------------------------------------------
The BT moudle version, firmware version and linux kernel version:
dmesg snippet,
[    2.164386] Bluetooth: hci0: read Intel version: 370710018002030d00
[    2.200701] Bluetooth: hci0: Intel Bluetooth firmware file: 
intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq

And the firmware was got from 
http://permalink.gmane.org/gmane.linux.bluez.kernel/37580.

To verify the firmware is the latest, i execute following commands,
u@u-Lenovo-B4400:~$ sudo hcitool cmd 0x3f 0x005 0x00
< HCI Command: ogf 0x3f, ocf 0x0005, plen 1
   00
 > HCI Event: 0x0e plen 13
   01 05 FC 00 37 07 10 01 80 02 03 0D 2E

On the machine, i installed ubuntu-12.04 (kernel is 3.5), then i 
replaced the kernel to the linux-3.8 and
the latest upstream kernel linux-3.12.0-rc6, the situation had no 
difference, the problem still can be
reproduced on very linux kernel version.

----------------------------------------------------------------------------------------------------------
My investigation:

I did the test on dozens of laptops on which all installed intel 7260 
wifi+bt combo, in case the bt module
is connected to EHCI bus, it will 100% fail to play sound to the bt 
headset. If the bt module is connected
to the XHCI bus, it will work very well, including play audio to a bt 
headset.

And more investigation show, if the bt module is on the EHCI bus, it 
can't receive any SCO packet like this,
u@u-Lenovo-B4400:~$ hciconfig
hci0: Type: BR/EDR Bus: USB
  BD Address: 00:15:00:CC:2D:D2 ACL MTU: 1021:5 SCO MTU: 96:5
  UP RUNNING PSCAN
  RX bytes:6687 acl:61 sco:0 events:308 errors:0
  TX bytes:19367 acl:70 sco:3 commands:179 errors:0

if the bt module is on the XHCI bus, it can transmit and receive SCO 
packets very well,
u@u-Lenovo-B4400:~$ hciconfig
hci0: Type: BR/EDR Bus: USB
  BD Address: 00:15:00:CC:2D:D2 ACL MTU: 1021:5 SCO MTU: 96:5
  UP RUNNING PSCAN
  RX bytes:572756 acl:47 sco:11173 events:221 errors:0
  TX bytes:586261 acl:55 sco:11137 commands:137 errors:0

----------------------------------------------------------------------------------------------------------
So could anybody be kindly help to confirm this problem,  and could the 
maintainer of intel 7260 bt driver/firmware
be kindly to solve this problem?

Thanks in advance.

Hui.
