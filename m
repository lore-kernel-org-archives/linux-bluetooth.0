Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200909110832.16244.oliver@neukum.org>
References: <6887eb5d0909102327u2ca531d1q35d027839495a978@mail.gmail.com>
	 <200909110832.16244.oliver@neukum.org>
Date: Fri, 11 Sep 2009 17:44:21 +0530
Message-ID: <6887eb5d0909110514l14350045q5978f0eabbde2eb1@mail.gmail.com>
Subject: Re: problem in btusb driver for linux-2.6.30
From: Kartikey Parmar <kartikey2781@gmail.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear Oliver / Marcel

kindly find /proc/bus/usb/devices output below:

*****************************************************************************************

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1d6b ProdID=0001 Rev= 2.06
S:  Manufacturer=Linux 2.6.30 ohci_hcd
S:  Product=AT91 OHCI
S:  SerialNumber=at91
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=16 #Cfgs=  1
P:  Vendor=1131 ProdID=1001 Rev= 3.73
S:  Manufacturer=ISSC
S:  Product=ISSCEDRBTA
C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
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

*********************************************************************************************

On Fri, Sep 11, 2009 at 12:02 PM, Oliver Neukum <oliver@neukum.org> wrote:
> Am Freitag, 11. September 2009 08:27:33 schrieb Kartikey Parmar:
>> Dear friends,
>>
>> I have configured linux-2.6.30 for AT91SAM9263 with Bluetooth support
>> of RFCOMM, SCO, L2CAP and HCI USB driver for bluetooth usb dongle.
>
> Did it work with 2.6.29?
>
>> When I insert bluetooth dongle in usb port it calls btusb_probe twice,
>> and then I m receiving error like "No such device".
>>
>> I have checked with the debug log, it gives me an error "interface
>> numbers are hardcoded in the spec" and returns ENODEV.
>
> Please post the log and "lsusb -v" for your device.
>
>        Regards
>                Oliver
>
>

-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
