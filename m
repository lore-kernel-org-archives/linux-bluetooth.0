Return-Path: <michel@docomolab-euro.com>
Message-ID: <3F28D21C.7000907@docomolab-euro.com>
Date: Thu, 31 Jul 2003 10:23:56 +0200
From: Maximilian Michel <michel@docomolab-euro.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, max@3max.de
Subject: Re: [Bluez-users] zeevo acer dongle
References: <3F27DED9.3090706@docomolab-euro.com>
	<1059603475.1831.21.camel@pegasus>
In-Reply-To: <1059603475.1831.21.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Maximilian,
> 
> 
>>I got an acer dongle (BT-510) containing a zeevo bluetooth chip.
>>This zeevo-dongle obviously works not so well with bluez as it keeps 
>>crashing with segfault.
>>The system I use should be well-configured, as everything works fine 
>>with csr-based devices (acer BU2 dongle).
>>So, is the zeevo-chip not supported, can it be fixed anyway?
> 
> 
> if I remember correctly, the Zeevo chip is one of these buggy Bluetooth
> devices which have no SCO endpoints. Please send us the output of
> /proc/bus/usb/devices and try one of my latest -mh patches or the latest
> 2.4.22-pre.
> 
> Regards
> 
> Marcel
> 
> 
> 
ok, I'll try the kernel patches, and here the usb-devices:

---
T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.04
S:  Manufacturer=Linux 2.4.21 ehci-hcd
S:  Product=Intel Corp. 82801DB USB EHCI Controller
S:  SerialNumber=00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms
T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=ff40
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0b7a ProdID=07d0 Rev= 1.34
S:  SerialNumber=3EC08003i
C:* #Ifs= 2 Cfg#= 1 Atr=c0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=ff60
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=ff80
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
---

Thanks,

Maximilian
