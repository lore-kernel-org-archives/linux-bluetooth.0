Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAFd36BgPbm9a6Cw9sgJdrbqJb_8SvEOjhhDhTqsy8jv7qTp8sw@mail.gmail.com>
References: <CAFd36Bj_SiUoeeu0h7kbEZnUx=6iXExCSTCvht_NLh4MY2-zSw@mail.gmail.com>
 <6DC4CADB-8928-48F8-82F7-662425143FB7@holtmann.org> <CAFd36BgPbm9a6Cw9sgJdrbqJb_8SvEOjhhDhTqsy8jv7qTp8sw@mail.gmail.com>
From: Jerome Leclanche <adys.wh@gmail.com>
Date: Fri, 15 Aug 2014 04:40:36 +0100
Message-ID: <CAFd36BhcZjywFqZPc2NhY15Mzgui-mT0jcA3=uU+wzO3x5CX2Q@mail.gmail.com>
Subject: Re: Missing vendor-specific ID for BCM20702A0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 21, 2014 at 12:12 PM, Jerome Leclanche <jerome@leclan.ch> wrote:
> On Mon, Jul 21, 2014 at 12:03 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Jerome,
>
> Hi,
>
>>
>>> I have a Z97-DELUXE motherboard. This includes a BCM20702A0 bluetooth chip.
>>> In order to be able to use it, I have to do 'echo "0b05 17cf" >>
>>> /sys/bus/usb/drivers/btusb/new_id' every reboot, otherwise I don't
>>> have an hci0 available. Was told this would be the best place to
>>> report this to.
>>>
>>> lsusb:
>>> Bus 001 Device 003: ID 0b05:17cf ASUSTek Computer, Inc.
>>> Device Descriptor:
>>>  bLength                18
>>>  bDescriptorType         1
>>>  bcdUSB               2.00
>>>  bDeviceClass          255 Vendor Specific Class
>>>  bDeviceSubClass         1
>>>  bDeviceProtocol         1
>>>  bMaxPacketSize0        64
>>>  idVendor           0x0b05 ASUSTek Computer, Inc.
>>>  idProduct          0x17cf
>>>  bcdDevice            1.12
>>>  iManufacturer           1 Broadcom Corp
>>>  iProduct                2 BCM20702A0
>>>  iSerial                 3 54271E910064
>>>  bNumConfigurations      1
>>>
>>> Note: Not subscribed, please CC.
>>
>> actually the content of /sys/kernel/debug/usb/devices is a bit more helpful in determine what kind of entry needs to be added to the module list of btusb driver.
>>
>
> Here you go.

Hi,

Checking in if this was enough or anything else was needed? I can post
a patch if it helps (but I'll need some docs wrt. patch guidelines for
these types of feature requests).

>
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0b05 ProdID=17cf Rev= 1.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=54271E910064
> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
>
>
>> Regards
>>
>> Marcel
>>
>
> J. Leclanche
