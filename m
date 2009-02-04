Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Feb 2009 21:18:06 +0000 (GMT)
From: Jamie Lentin <jm@lentin.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] hci_usb: Add support for OQO Model 01+
In-Reply-To: <1233772222.12562.1.camel@californication>
Message-ID: <alpine.DEB.2.00.0902042117170.20425@localhost.localdomain>
References: <alpine.DEB.2.00.0902041341380.16577@localhost.localdomain> <1233772222.12562.1.camel@californication>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Hi Jamie,
>
>> Add USB device ID for OQO 01+'s internal USB bluetooth
>
> please proof that you really need this by sending in the content
> of /proc/bus/usb/devices. Normally Bluetooth devices get identified by
> its class descriptor.

So they do.  And it works fine without the patch.  How embarrasing. 
Apologies, I should have re-checked this.  Ignore the patch.

For completeness' sake, here is the relevant chunk of 
/proc/bus/usb/devices.

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1557 ProdID=0003 Rev= 9.32
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

> Also the hci_usb driver has been replaced by btusb. So please send
> patches against that kernel.

Again, thanks.  Switched to using this module without problems.

> Regards
>
> Marcel
