Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH] Bluetooth: btusb: Use USB_INTERFACE_INFO to do device
 matching
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 16 Nov 2011 18:14:31 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF39DB@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEEEF58@nasanexd02b.na.qualcomm.com>
	 <1321263144.15441.465.camel@aeonflux>
	 <07BBB2AAB1A10A488A2AD166C7CB8B0DEF39DB@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321434874.15441.524.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> I have gone through commits about the adding of USB_DEVICE entry, and found as follow:
> 
> For Broadcom SoftSailing reporting vendor specific entry, no detailed commit description.

I think that this got posted to the mailing list at least.

> For Apple MacBookPro7,1 entry, its interface class is 0xff, so cannot be removed.
> 
> For Apple iMac11,1 entry, its interface class is 0xff, so cannot be removed.
> 
> For Apple MacBookPro6,2 entry, its interface class is 0xff, so cannot be removed.
> 
> For Apple MacBookAir3,1, MacBookAir3,2 entry, its interface class is 0xff, so cannot be removed.
> 
> For Apple MacBookAir4,1 entry, no detailed commit description.
> 
> For Apple MacBookPro8,2 entry, no detailed commit description.
> 
> For Apple MacMini5,1, no detailed commit description.

for all the MacBook its seems we can use USB_DEVICE_AND_INTERFACE_INFO
with 0xff, 0x01, 0x01. So at least we would just match the first
interface and not all interfaces of these chips.

    T:  Bus=03 Lev=02 Prnt=03 Port=02 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
    D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=05ac ProdID=821b Rev= 0.34
    S:  Manufacturer=Apple Inc.
    S:  Product=Bluetooth USB Host Controller
    C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
    I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
    E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
    E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
    E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
    I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
    I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
    I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
    I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
    I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
    E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
    E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
    I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
    E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
    E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
    I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Especially since the SCO endpoints have a proper 0xe0, 0x01, 0x01
descriptor our check here becomes simpler and can be made generic.

> For Ericsson entry, no commit description.
> 
> For Canyon CN-BTU1 entry, no detailed commit description.

These two are really just old and messed up devices. We have no chance
to do anything here.

> For BCM20702A0 entry, its interface class is 0xff, so it cannot be removed.

Maybe it is similar as the Apple dongles. It uses 0xff, 0x01, 0x01 and
then we just should USB_DEVICE_AND_INTERFACE_INFO as well here.

> For "AVM BlueFRITZ", "Bluetooth Ulttraport Module from IBM", and "ALPS Modules with non-standard id" entries, no related commit description.

I do have the BlueFritz at home and can check up on it, but if we trust
the Internet, then it is like this:

I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  1
P:  Vendor=057c ProdID=3800 Rev=15.00
S:  Manufacturer=Bluetooth Device
S:  Product=Bluetooth Device
S:  SerialNumber=2C1F880***
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=200mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

So an USB_DEVICE_AND_INTERFACE_INFO with 0xff, 0xff, 0xff would be fine.

And for the old Ultraport and ALPS, we most likely will not easily find
these devices.

Regards

Marcel


