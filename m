Return-Path: <cyrus@holtmann.org>
Message-ID: <52707428.9070908@canonical.com>
Date: Wed, 30 Oct 2013 10:51:20 +0800
From: Hui Wang <hui.wang@canonical.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Tedd An <tedd.an@intel.com>, Johan Hedberg <johan.hedberg@intel.com>,
 xiong.y.zhang@intel.com,
 "Gustavo F. Padovan" <gustavo.padovan@collabora.co.uk>,
 "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: Intel 7260 bluetooth malfunction when it is connected to EHCI
 bus
References: <526F8804.9060906@canonical.com> <A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org>
In-Reply-To: <A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/29/2013 07:16 PM, Marcel Holtmann wrote:
> Hi Hui,
>
>> The problem is:
>> On the machine which has Intel 7260 BT module, i use it to connect a bluetooth headset,
>> it can successfully scan and connect to the headset, when i play sound to the bt headset,
>> the problem comes, if the bt module is connected to the XHCI, it can work very well.
>>
>> u@u-Lenovo-B4400:~$ lsusb -t
>> 1-7:1.0: No such file or directory
>> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>>     |__ Port 6: Dev 8, If 0, Class=HID, Driver=usbhid, 1.5M
>>     |__ Port 7: Dev 2, If 0, Class=vend., Driver=, 12M
>>     |__ Port 11: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>     |__ Port 11: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>
>> But if the bt module is connected to the EHCI, it always fails to play sound.
>>
>> u@u-Lenovo-B4400:~$ lsusb -t
>> /: Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>> /: Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
>> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>>         |__ Port 5: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>         |__ Port 5: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>         |__ Port 6: Dev 4, If 0, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M
>>         |__ Port 6: Dev 4, If 1, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M
> can you paste /sys/kernel/debug/usb/devices here.
>
> If the uvcvideo driver is also using ISOC URBs, we might have just exhausted the bandwidth of the USB bus here or these two devices just do not play nice with each other.
>
> Try to unload the uvcvideo driver and try it again.
Thanks for your reply, follow your instruction, i totally disabled the 
camera from the BIOS, then the usb tree like this,
  u@u-Lenovo-B4400:~$ lsusb -t
1-1.3:1.0: No such file or directory
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
         |__ Port 2: Dev 3, If 0, Class=HID, Driver=usbhid, 1.5M
         |__ Port 3: Dev 4, If 0, Class=vend., Driver=, 12M
         |__ Port 5: Dev 5, If 0, Class='bInterfaceClass 0xe0 not yet 
handled', Driver=btusb, 12M
         |__ Port 5: Dev 5, If 1, Class='bInterfaceClass 0xe0 not yet 
handled', Driver=btusb, 12M
u@u-Lenovo-B4400:~$ uname -a
Linux u-Lenovo-B4400 3.12.0-031200rc6-generic #201310191635 SMP Sat Oct 
19 20:36:43 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

I re-did the test, the result is same as before, after the headset is 
connected and i play audio, no sound is heard from the headset.
And hciconfig output shows still no SCO packets received by BT driver.
u@u-Lenovo-B4400:~$ hciconfig
hci0:    Type: BR/EDR  Bus: USB
     BD Address: 00:15:00:CC:2D:D2  ACL MTU: 1021:5  SCO MTU: 96:5
     UP RUNNING PSCAN
     RX bytes:5853 acl:61 sco:0 events:298 errors:0
     TX bytes:19212 acl:68 sco:1 commands:179 errors:0

This is the debug output of "sudo cat /sys/kernel/debug/usb/devices" 
after those operations,
u@u-Lenovo-B4400:~$ sudo cat /sys/kernel/debug/usb/devices

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=5000 MxCh= 4
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 3.00 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
P:  Vendor=1d6b ProdID=0003 Rev= 3.05
S:  Manufacturer=Linux 3.12.0-rc6-WR5.0.1.4_standard+ xhci_hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh=14
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 3.05
S:  Manufacturer=Linux 3.12.0-rc6-WR5.0.1.4_standard+ xhci_hcd
S:  Product=xHCI Host Controller
S:  SerialNumber=0000:00:14.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 3
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 3.05
S:  Manufacturer=Linux 3.12.0-rc6-WR5.0.1.4_standard+ ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 8
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=8000 Rev= 0.05
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh= 3
B:  Alloc=  4/800 us ( 1%), #Int=  3, #Iso=  1
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0002 Rev= 3.05
S:  Manufacturer=Linux 3.12.0-rc6-WR5.0.1.4_standard+ ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1a.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 6
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=8008 Rev= 0.05
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms

T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=1.5  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0461 ProdID=4d22 Rev= 2.00
S:  Product=USB Optical Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=11 Prot=ff MxPS= 8 #Cfgs=  1
P:  Vendor=138a ProdID=0011 Rev= 0.78
S:  SerialNumber=7ffcdfda8afe
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 4 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=4ms

T:  Bus=01 Lev=02 Prnt=02 Port=04 Cnt=03 Dev#=  5 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=07dc Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:* If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms


Thanks,
Hui.

>
> Regards
>
> Marcel
>
>
>
