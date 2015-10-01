Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B4AA2825-8C58-46FB-A529-7CC910920500@holtmann.org>
References: <CAHkwNT=sQQz11YWsxivxb20mW7rh1U=CXTN7uyBqTzkXvNbXgA@mail.gmail.com>
	<37D1ED5D-6FF5-4ABA-BD2A-222261BE1EAA@holtmann.org>
	<CAHkwNT=3m4nU5M_Kk5htfDonqPrKZO5vRR0q_8Mn2O=umGMK5Q@mail.gmail.com>
	<B4AA2825-8C58-46FB-A529-7CC910920500@holtmann.org>
Date: Fri, 2 Oct 2015 00:21:47 +0530
Message-ID: <CAHkwNT=Hoc4xibrtg2zk7K1vwcutcWgUHAN58XpWH0jnqfLXbg@mail.gmail.com>
Subject: Re: Issues With USB Bluetooth Dongle
From: Anil Nair <anilcoll90@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> use hcidump. You are stuck with BlueZ 4 since Ubuntu refuses to upgrade to BlueZ 5.
>

The  USB Dongle isnt being discovered nor Can I send or recieve any
file, I used "hcicump" the only output that i am able to get is,

HCI sniffer - Bluetooth packet analyzer ver 2.5
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff

>>> include /sys/kernel/debug/usb/devices from this device.
>>
>> Did you mean the contents in the file? I did not understand.
>
> Yes, there will be section for your controller.
>

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a12 ProdID=0001 Rev= 1.00
S:  Manufacturer=Bluetooth v2.0
S:  Product=Bluetooth V2.0 Dongle
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

>>> Then again, you are running a 3.13 kernel, that is a pretty old kernel.
>>
>> You want me to try it with the latest stable release?
>
> That might actually help. Try to run a 4.2 kernel.

I will have to compile the kernel from source and attach the kernel
image to Ubuntu right?
Is there any documentation avaliable?

--
Regards,
Anil Nair
