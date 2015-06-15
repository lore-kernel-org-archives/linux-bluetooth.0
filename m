Return-Path: <cyrus@holtmann.org>
Message-ID: <557F0FD2.7000000@battlepenguin.com>
Date: Tue, 16 Jun 2015 01:48:02 +0800
From: Sumit's Mailing Lists <lists@battlepenguin.com>
MIME-Version: 1.0
To: Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 "Huang, Rick" <rickh@qti.qualcomm.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: ath3k Bluetooth adapter not loading: [0cf3:3004] Atheros Communications,
 Inc. AR3012 Bluetooth 4.0
References: <556486B0.1020104@battlepenguin.com> <EEAFDBFC-C252-4843-A9E0-3E74EA21B665@holtmann.org> <557EBF98.2000701@battlepenguin.com> <A93AF220-83E9-4FC3-BC07-18B285E5FA3D@holtmann.org> <557EDE40.7070006@battlepenguin.com> <557F03E2.3000001@qca.qualcomm.com>
In-Reply-To: <557F03E2.3000001@qca.qualcomm.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

On 16/06/15 00:57, Ben Young Tae Kim wrote:
> Hi Sumit,
>
>
> On 06/15/15 07:16, Sumit's Mailing Lists wrote:
>> On 15/06/15 21:55, Marcel Holtmann wrote:
>>> Hi Smuit,
>>>
>>>>>> I'm currently using an MSI WS60 laptop which contains the following
>>>>>> Bluetooth controller (from lsusb):
>>>>>>
>>>>>> Bus 003 Device 003: ID 0cf3:3004 Atheros Communications, Inc. AR3012
>>>>>> Bluetooth 4.0
>>>>> assuming that the firmware is present, this is most likely just missing the right VID/PID additions in the drivers. Please prepare a patch for that.
>>>>>
>>>>>> and the more detailed version:
>>>>>>
>>>>>> Bus 003 Device 003: ID 0cf3:3004 Atheros Communications, Inc. AR3012
>>>>>> Bluetooth 4.0
>>>>>> Device Descriptor:
>>>>>> bLength                18
>>>>>> bDescriptorType         1
>>>>>> bcdUSB               1.10
>>>>>> bDeviceClass          224 Wireless
>>>>>> bDeviceSubClass         1 Radio Frequency
>>>>>> bDeviceProtocol         1 Bluetooth
>>>>>> bMaxPacketSize0        64
>>>>>> idVendor           0x0cf3 Atheros Communications, Inc.
>>>>>> idProduct          0x3004 AR3012 Bluetooth 4.0
>>>>>> bcdDevice            0.01
>>>>>> iManufacturer           0
>>>>>> iProduct                0
>>>>>> iSerial                 0
>>>>>> bNumConfigurations      1
>>>>>> Configuration Descriptor:
>>>>> I actually prefer /sys/kernel/debug/usb/devices output for the devices.
>>>>>
>>>>> Regards
>>>>>
>>>>> Marcel
>>>>>
>>>> Here is the output from /sys/kernel/debug/usb/devices for my ath3k (also
>>>> added it to the kernel bugzilla):
>>>>
>>>> T:  Bus=03 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
>>>> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>>>> P:  Vendor=0cf3 ProdID=3004 Rev= 0.01
>>>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>>>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>>>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>>>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>>>
>>>> and the firmware the kernel is trying to load:
>>>>
>>>> [  762.729370] usb 3-1.3: Direct firmware load for
>>>> ar3k/AthrBT_0x00000200.dfu failed with error -2
>>>> [  762.729373] Bluetooth: Patch file not found ar3k/AthrBT_0x00000200.dfu
>>>> [  762.729374] Bluetooth: Loading patch file failed
>>>> [  762.729381] ath3k: probe of 3-1.3:1.0 failed with error -2
>>>> [  762.729411] usbcore: registered new interface driver ath3k
>>> I fail to see that firmware in linux-firmware tree. However this up to Atheros / Qualcomm to submit there. I can not do much about this.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>> Marcel,
>>
>> So it's pulling the right firmware file for my device, but It just
>> hasn't been released yet?
>>
>> I know with the Wi-Fi firmware, the ath10k devs had python scripts to
>> extract the firmware binaries from the Windows drivers (mentioned in
>> here https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1383184). Has
>> anyone done that before with the bluetooth firmware, or do you typically
>> just wait for atheros/qualcom to release official ones?
> Where did you get your atheros board/card since I couldn't find that board here. Is it a laptop? The BT firmware driver was trying to load AthrBT_0x00000200.dfu file and it got failed because no firmware file was present. But 0x00000200 means fw_version.rom_version which coming from controller chip, however, I haven't seen this version on Atheros chipset.
>
> I'm adding my friend - Rick Huang here. He may help you out
>
> Hi Rick,
>
> Have you seen rom_version as 0x00000200?
>
>> Sumit
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Thanks
> -- Ben Kim
>

Yes, It's an MSI WS-60 Laptop, purchased two months ago in Australia. Is
there any other debugging information I need to pull for you?

Sumit
