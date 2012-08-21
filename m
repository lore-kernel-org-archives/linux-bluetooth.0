Return-Path: <cyrus@holtmann.org>
Message-ID: <503322AF.2040000@qca.qualcomm.com>
Date: Tue, 21 Aug 2012 11:24:55 +0530
From: Mohammed Shafi Shajakhan <mohammed@qca.qualcomm.com>
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>, <marcel@holtmann.org>,
	<linux-bluetooth@vger.kernel.org>,
	<yevgeniy.melnichuk@googlemail.com>
Subject: Re: [PATCH v2] Bluetooth: Add support for Sony Vaio T-Series
References: <1344349090-4397-1-git-send-email-mohammed@qca.qualcomm.com> <20120815040856.GC3344@joana>
In-Reply-To: <20120815040856.GC3344@joana>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Gustavo,

On Wednesday 15 August 2012 09:38 AM, Gustavo Padovan wrote:
> Hi Mohammed,
>
> * Mohammed Shafi Shajakhan <mohammed@qca.qualcomm.com> [2012-08-07 19:48:10 +0530]:
>
>> From: Yevgeniy Melnichuk <yevgeniy.melnichuk@googlemail.com>
>>
>> Add Sony Vaio T-Series Bluetooth Module( 0x489:0xE036) to
>> the blacklist of btusb module and add it to the ath3k module.
>>
>> output of cat /sys/kernel/debug/usb/devices
>>
>> T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  5 Spd=12   MxCh= 0
>> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>> P:  Vendor=0489 ProdID=e036 Rev= 0.02
>> S:  Manufacturer=Atheros Communications
>> S:  Product=Bluetooth USB Host Controller
>> S:  SerialNumber=Alaska Day 2006
>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>
>> Signed-off-by: Yevgeniy Melnichuk <yevgeniy.melnichuk@googlemail.com>
>> Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qca.qualcomm.com>
>> ---
>>   drivers/bluetooth/ath3k.c |    2 ++
>>   drivers/bluetooth/btusb.c |    1 +
>>   2 files changed, 3 insertions(+), 0 deletions(-)
>
> Patch has been applied to bluetooth.git. Thanks.

sure, thanks!

>
> 	Gustavo
>


-- 
thanks,
shafi


