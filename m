Return-Path: <cyrus@holtmann.org>
Subject: Re: Can't bring bluetooth controller up
To: Marcel Holtmann <marcel@holtmann.org>
References: <56222AC0.4090302@gmail.com>
 <53E5ADDA-1988-4404-8E37-DBBA99A69CB9@holtmann.org>
 <56223B1A.9050204@gmail.com>
 <C0D62687-5C0A-4D64-A91A-0949EAAD48E8@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
From: =?UTF-8?Q?Julio_Gonz=c3=a1lez_Mej=c3=adas?= <juliolokooo@gmail.com>
Message-ID: <5624CC53.7080507@gmail.com>
Date: Mon, 19 Oct 2015 12:56:19 +0200
MIME-Version: 1.0
In-Reply-To: <C0D62687-5C0A-4D64-A91A-0949EAAD48E8@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Hi Julio,
>
>>>> I have a card reader with bluetooth controller built-in (Broadcom BCM2045A) and it stopped working suddenly some days ago as it appears down and I can't bring it up with hciconfig, this is what happens:
>>>>
>>>> sudo hciconfig hci0 up
>>>> Can't init device hci0: Operation not supported (95)
>>>>
>>>> This is the output of hcidump when running this command:
>>>>
>>>> hcidump
>>>> HCI sniffer - Bluetooth packet analyzer ver 5.35
>>>> device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>      Reset (0x03|0x0003) ncmd 1
>>>>      status 0x00
>>>>> HCI Event: Command Complete (0x0e) plen 12
>>>>      Read Local Supported Features (0x04|0x0003) ncmd 1
>>>>      status 0x00
>>>>      Features: 0xff 0xff 0x8d 0xfe 0x8f 0xf9 0x00 0x80
>>>>> HCI Event: Command Complete (0x0e) plen 12
>>>>      Read Local Version Information (0x04|0x0001) ncmd 1
>>>>      status 0x00
>>>>      HCI Version: 2.0 (0x3) HCI Revision: 0x2000
>>>>      LMP Version: 2.0 (0x3) LMP Subversion: 0x410d
>>>>      Manufacturer: Broadcom Corporation (15)
>>>>> HCI Event: Command Complete (0x0e) plen 10
>>>>      Read BD ADDR (0x04|0x0009) ncmd 1
>>>>      status 0x00 bdaddr 25:7B:43:51:08:D3
>>>>> HCI Event: Command Complete (0x0e) plen 11
>>>>      Read Buffer Size (0x04|0x0005) ncmd 1
>>>>      status 0x00
>>>>      ACL MTU 1017:8 SCO MTU 64:0
>>>>> HCI Event: Command Complete (0x0e) plen 7
>>>>      Read Class of Device (0x03|0x0023) ncmd 1
>>>>      status 0x00 class 0x000000
>>>>> HCI Event: Command Complete (0x0e) plen 252
>>>>      Read Local Name (0x03|0x0014) ncmd 1
>>>>      status 0x00 name 'BCM2045'
>>>>> HCI Event: Command Complete (0x0e) plen 6
>>>>      Read Voice Setting (0x03|0x0025) ncmd 1
>>>>      status 0x00 voice setting 0x0060
>>>>> HCI Event: Command Complete (0x0e) plen 5
>>>>      Read Number of Supported IAC (0x03|0x0038) ncmd 1
>>>>> HCI Event: Command Complete (0x0e) plen 8
>>>>      Read Current IAC LAP (0x03|0x0039) ncmd 1
>>>>      IAC 0x9e8b33 (General Inquiry Access Code)
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>      Set Event Filter (0x03|0x0005) ncmd 1
>>>>      status 0x00
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>      Write Connection Accept Timeout (0x03|0x0016) ncmd 1
>>>>      status 0x00
>>>>> HCI Event: Command Complete (0x0e) plen 68
>>>>      Read Local Supported Commands (0x04|0x0002) ncmd 1
>>>>      status 0x00
>>>>      Commands: ffffff03feffcfffffffffff0300f8ff07
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>      Write Inquiry Mode (0x03|0x0045) ncmd 1
>>>>      status 0x00
>>>>> HCI Event: Command Complete (0x0e) plen 14
>>>>      Read Local Extended Features (0x04|0x0004) ncmd 1
>>>>      status 0x00 page 1 max 0
>>>>      Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>      Set Event Mask (0x03|0x0001) ncmd 1
>>>>      status 0x00
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>      Write Default Link Policy Settings (0x02|0x000f) ncmd 1
>>>>      status 0x00
>>>>> HCI Event: Command Complete (0x0e) plen 8
>>>>      Read Page Scan Activity (0x03|0x001b) ncmd 1
>>>>      status 0x00 interval 2048 window 18
>>>>> HCI Event: Command Complete (0x0e) plen 4
>>>>      Delete Stored Link Key (0x03|0x0012) ncmd 1
>>>>      status 0x11 deleted 2048
>>>>      Error: Unsupported Feature or Parameter Value
>>>
>>> for some reason this command is failing. That should not happen actually. What is the content of /sys/kernel/debug/usb/devices for this device.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>>
>> This is the content of /sys/kernel/debug/usb:
>>
>> T: Bus=04 Lev=02 Prnt=02 Port=02 Cnt=02 Dev#= 3 Spd=12 MxCh= 0
>> D: Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
>> P: Vendor=0a5c ProdID=2045 Rev= 1.12
>> S: Manufacturer=Broadcom Corp
>> S: Product=BCM2045A
>> S: SerialNumber=000000000000
>> C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=1ms
>> E: Ad=82(I) Atr=02(Bulk) MxPS= 64 Ivl=0ms
>> E: Ad=02(O) Atr=02(Bulk) MxPS= 64 Ivl=0ms
>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E: Ad=83(I) Atr=01(Isoc) MxPS= 0 Ivl=1ms
>> E: Ad=03(O) Atr=01(Isoc) MxPS= 0 Ivl=1ms
>> I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E: Ad=83(I) Atr=01(Isoc) MxPS= 9 Ivl=1ms
>> E: Ad=03(O) Atr=01(Isoc) MxPS= 9 Ivl=1ms
>> I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E: Ad=83(I) Atr=01(Isoc) MxPS= 17 Ivl=1ms
>> E: Ad=03(O) Atr=01(Isoc) MxPS= 17 Ivl=1ms
>> I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E: Ad=83(I) Atr=01(Isoc) MxPS= 25 Ivl=1ms
>> E: Ad=03(O) Atr=01(Isoc) MxPS= 25 Ivl=1ms
>> I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E: Ad=83(I) Atr=01(Isoc) MxPS= 33 Ivl=1ms
>> E: Ad=03(O) Atr=01(Isoc) MxPS= 33 Ivl=1ms
>> I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>> E: Ad=83(I) Atr=01(Isoc) MxPS= 49 Ivl=1ms
>> E: Ad=03(O) Atr=01(Isoc) MxPS= 49 Ivl=1ms
>> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>> E: Ad=84(I) Atr=02(Bulk) MxPS= 32 Ivl=0ms
>> E: Ad=04(O) Atr=02(Bulk) MxPS= 32 Ivl=0ms
>> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
>
> I sent a patch to the mailing list that might fix this. Please try it out.
>
> Regards
>
> Marcel
>

Thank you! I have tried the patch and my bluetooth controller works fine 
now.

Regards
