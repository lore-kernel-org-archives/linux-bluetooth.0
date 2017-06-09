Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [Linux-4.9.30] Broadcom BCM20702 bluetooth in ThinkPad-T530 not
 usable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+icZUVT-fJwamHBSUfHW1KOQU6gx3OeKWgbo7B5oTYmK5dm7g@mail.gmail.com>
Date: Fri, 9 Jun 2017 18:18:56 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <984B6D8C-483D-46C7-A746-2BB28B262F87@holtmann.org>
References: <CA+icZUWf1EyPJDOTO-xos=QwQ0DWLOg3goiSX_X2C01QpVqU1w@mail.gmail.com>
 <D83A359C-829A-4DBC-B5CE-1B077CE6B0E4@holtmann.org>
 <CA+icZUUD92VO52MtynBBQFFPxWkj=pvhm0yDkMYNamvVG4ry9Q@mail.gmail.com>
 <1083ECDC-2292-4372-B85D-DA551EB3FB38@holtmann.org>
 <CA+icZUVT-fJwamHBSUfHW1KOQU6gx3OeKWgbo7B5oTYmK5dm7g@mail.gmail.com>
To: sedat.dilek@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sedat,

>>>>> I have some problems using my BCM20702 adapter on my Debian/stretch
>>>>> 9.0 AMD64 system with Linux v4.9.30 on a ThinkPad-T530 notebook.
>>>>> 
>>>> 
>>>> can you run “btmon -w trace.log” and attach that log. I think that I know what is going on, but I want to confirm this.
>>>> 
>>> 
>>> attached is a 2nd hcidump and the requested trace.log.
>> 
>> so here is the problem:
>> 
>> < HCI Command: Set Event Mask Page 2 (0x03|0x0063) plen 8
>>        Mask: 0x0000000000000000
>>> HCI Event: Command Complete (0x0e) plen 4
>>      Set Event Mask Page 2 (0x03|0x0063) ncmd 1
>>        Status: Unknown HCI Command (0x01)
>> 
>> This controller just does not support this command. Problem is that earlier it told us it did.
>> 
>> < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
>>> HCI Event: Command Complete (0x0e) plen 68
>>      Read Local Supported Commands (0x04|0x0002) ncmd 1
>>        Status: Success (0x00)
>>        Commands: 162 entries
>>          ...
>>          Set Event Mask Page 2 (Octet 22 - Bit 2)
>>          ...
>> 
>> Can you provide the output of /sys/kernel/debug/usb/devices that relates to this USB dongle.
>> 
>> I posted a RFC patch that you might want to try. If that works, I just need to include a proper commit message. If it works, please send also the btmon -w trace.log for success part.
>> 
> 
> Hi Marcel,
> 
> [ /sys/kernel/debug/usb/devices ]
> 
> T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=03 Dev#=  9 Spd=12   MxCh= 0
> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a5c ProdID=21e6 Rev= 1.12
> S:  Manufacturer=Broadcom Corp
> S:  Product=BCM20702A0
> S:  SerialNumber=F82FA8E8CFC0
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
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Can you point me to your RFC patch?

I send it to the mailing list already.

Regards

Marcel

