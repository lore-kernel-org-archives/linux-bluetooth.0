Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHkwNTk-wiy3=ZkdeyceLm9NuJauyqs1391QfcAWTxfPmU13sQ@mail.gmail.com>
References: <CAHkwNT=sQQz11YWsxivxb20mW7rh1U=CXTN7uyBqTzkXvNbXgA@mail.gmail.com>
	<37D1ED5D-6FF5-4ABA-BD2A-222261BE1EAA@holtmann.org>
	<CAHkwNT=3m4nU5M_Kk5htfDonqPrKZO5vRR0q_8Mn2O=umGMK5Q@mail.gmail.com>
	<B4AA2825-8C58-46FB-A529-7CC910920500@holtmann.org>
	<CAHkwNT=Hoc4xibrtg2zk7K1vwcutcWgUHAN58XpWH0jnqfLXbg@mail.gmail.com>
	<1C9C7F69-AFBA-4B69-9185-656881389B87@holtmann.org>
	<CAHkwNTk-wiy3=ZkdeyceLm9NuJauyqs1391QfcAWTxfPmU13sQ@mail.gmail.com>
Date: Mon, 5 Oct 2015 20:33:50 +0530
Message-ID: <CAHkwNTk6Zu_z3iOJTzTsTD+msYiuTj=F77CjbuToD3ndbKgMnQ@mail.gmail.com>
Subject: Re: Issues With USB Bluetooth Dongle
From: Anil Nair <anilcoll90@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>>>> use hcidump. You are stuck with BlueZ 4 since Ubuntu refuses to upgrade to BlueZ 5.
>>>>
>>>
>>> The  USB Dongle isnt being discovered nor Can I send or recieve any
>>> file, I used "hcicump" the only output that i am able to get is,
>>>
>>> HCI sniffer - Bluetooth packet analyzer ver 2.5
>>> device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
>>
>> you need to run this as root. And then try hciconfig hci0 up and see if anything goes wrong.
>>
>> If you had btmon, then this would be a lot simpler to test. You just start btmon and then plug in the USB dongle and it would trace every single event.
>
> Generally btmon should be included in the Ubuntu distribution right? I
> tried compiling BlueZ5 from source but its showing me the I have a
> older DBus version. Anyways I will try with "hcidump" and will let you
> know.
>

HCI Event: Command Complete (0x0e) plen 4
    Reset (0x03|0x0003) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Supported Features (0x04|0x0003) ncmd 1
    status 0x00
    Features: 0xff 0xff 0x8d 0xfe 0x8f 0xf9 0x00 0x80
> HCI Event: Command Complete (0x0e) plen 12
    Read Local Version Information (0x04|0x0001) ncmd 1
    status 0x00
    HCI Version: 2.0 (0x3) HCI Revision: 0x2000
    LMP Version: 2.0 (0x3) LMP Subversion: 0x410d
    Manufacturer: Broadcom Corporation (15)
> HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 1
    status 0x00 bdaddr 00:1B:10:00:2A:EC
> HCI Event: Command Complete (0x0e) plen 11
    Read Buffer Size (0x04|0x0005) ncmd 1
    status 0x00
    ACL MTU 1017:8 SCO MTU 64:0
> HCI Event: Command Complete (0x0e) plen 7
    Read Class of Device (0x03|0x0023) ncmd 1
    status 0x00 class 0x000000
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'BCM2045B'
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
> HCI Event: Command Complete (0x0e) plen 5
    Read Number of Supported IAC (0x03|0x0038) ncmd 1
> HCI Event: Command Complete (0x0e) plen 8
    Read Current IAC LAP (0x03|0x0039) ncmd 1
    IAC 0x9e8b33 (General Inquiry Access Code)
> HCI Event: Command Complete (0x0e) plen 4
    Set Event Filter (0x03|0x0005) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Write Connection Accept Timeout (0x03|0x0016) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 68
    Read Local Supported Commands (0x04|0x0002) ncmd 1
    status 0x00
    Commands: ffffff03feffcfffffffffff0300f8ff07
> HCI Event: Command Complete (0x0e) plen 4
    Write Inquiry Mode (0x03|0x0045) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 14
    Read Local Extended Features (0x04|0x0004) ncmd 1
    status 0x00 page 1 max 0
    Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Set Event Mask (0x03|0x0001) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Write Default Link Policy Settings (0x02|0x000f) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 8
    Read Page Scan Activity (0x03|0x001b) ncmd 1
    status 0x00 interval 2048 window 18
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Write Class of Device (0x03|0x0024) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Write Local Name (0x03|0x0013) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Write Current IAC LAP (0x03|0x003a) ncmd 1
    status 0x00
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00

>>>>>> include /sys/kernel/debug/usb/devices from this device.
>>>>>
>>>>> Did you mean the contents in the file? I did not understand.
>>>>
>>>> Yes, there will be section for your controller.
>>>>
>>>
>>> T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
>>> D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>>> P:  Vendor=0a12 ProdID=0001 Rev= 1.00
>>> S:  Manufacturer=Bluetooth v2.0
>>> S:  Product=Bluetooth V2.0 Dongle
>>> C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
>>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>>> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>>> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>>> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
>>
>> I highly doubt that this is a genuine CSR based dongle. The Rev= 1.00 is pretty much a dead give away that this is wrong and also the If#= 2 is not something you normally find on CSR dongles.
>
> Oh that was the only dongle available and its specifically written in
> the package works only with Windows.Generally its the other way round
> all my devices works in Linux and does not work properly in Windows. I
> was curious as to why its not working in Linux.
>
>> So my wild guess is that one of the HCI commands is actually failing in the init sequence. Now you just need to figure out which one. That happens if you get sold essentially a fake dongle.
>
> Okay they fooled Windows but could not fool Linux. :D.

rfkill had blocked my device. When I enabled it, the device started
working.:). It is working with latest stable kernel 4.2.2.
How can you come to know wheather the device is fake or no?

Thanks for the help Marcel. :).
I hope I can trouble you guys when I require any help. :).

--
Regards,
Anil Nair
