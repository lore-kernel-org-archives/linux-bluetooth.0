Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with 2.5.6 and D-Link DBT-120
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Svedberg <johan@svedberg.pp.se>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040406125243.GA5de36.johan@svedberg.pp.se>
References: <20040406101704.GA42503.johan@svedberg.pp.se>
	 <1081240989.17215.14.camel@pegasus>
	 <20040406125243.GA5de36.johan@svedberg.pp.se>
Content-Type: text/plain
Message-Id: <1081267161.2879.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 06 Apr 2004 17:59:21 +0200

Hi Johan,

>     root@bettan:~ $ cat /proc/bus/usb/devices
> 
>     T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
>     B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
>     D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
>     P:  Vendor=0000 ProdID=0000 Rev= 2.06
>     S:  Manufacturer=Linux 2.6.5 uhci_hcd
>     S:  Product=Intel Corp. 82371AB/EB/MB PIIX4 USB
>     S:  SerialNumber=0000:00:07.2
>     C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
>     I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
>     E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
>     root@bettan:~ $ lsusb
>     Bus 001 Device 001: ID 0000:0000
> 
> However, if I disable the Bluetooth subsystem and use
> CONFIG_USB_BLUETOOTH_TTY instead, the output is:
> 
>     root@bettan:~ $ cat /proc/bus/usb/devices
> 
>     T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
>     B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
>     D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
>     P:  Vendor=0000 ProdID=0000 Rev= 2.06
>     S:  Manufacturer=Linux 2.6.5 uhci_hcd
>     S:  Product=Intel Corp. 82371AB/EB/MB PIIX4 USB
>     S:  SerialNumber=0000:00:07.2
>     C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
>     I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
>     E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
>     T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
>     D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>     P:  Vendor=0a12 ProdID=0001 Rev= 4.43
>     C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
>     I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=bluetty
>     E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>     E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>     E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>     I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>     I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>     I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>     I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>     I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>     I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
>     E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>     E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>     I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
> 
>     root@bettan:~ $ lsusb
>     Bus 001 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth
>     Dongle
>     Bus 001 Device 001: ID 0000:0000
> 
> But now I can't use the same userspace-tools I used to.

do you see a kernel oops somewhere in your logfiles while using the
hci_usb driver? Otherwise I can't explain why this happens.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
