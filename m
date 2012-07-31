Return-Path: <cyrus@holtmann.org>
Message-ID: <501805E8.2080505@shealevy.com>
Date: Tue, 31 Jul 2012 12:20:56 -0400
From: Shea Levy <shea@shealevy.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Unable to Detect Bluetooth Device on Macbook Pro 9,2 (Mid-2012
 13")
References: <5017E234.2000207@shealevy.com>  <1343749923.1803.68.camel@aeonflux> <50180209.1090002@shealevy.com> <1343751179.1803.73.camel@aeonflux>
In-Reply-To: <1343751179.1803.73.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/31/2012 12:12 PM, Marcel Holtmann wrote:
> Hi Shea,
>
>>> include /sys/kernel/debug/usb/devices details for this device.
>> Not sure, which device it is, so here's all of bus 4:
> <snip>
>
>> T:  Bus=04 Lev=04 Prnt=04 Port=02 Cnt=03 Dev#=  9 Spd=12   MxCh= 0
>> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=05ac ProdID=821d Rev= 0.86
>> S:  Manufacturer=Apple Inc.
>> S:  Product=Bluetooth USB Host Controller
>> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> lets take the one that says Bluetooth USB Host Controller ;)

Sorry, braindead moment. Thanks.

> Regards
>
> Marcel
>
>

~Shea
