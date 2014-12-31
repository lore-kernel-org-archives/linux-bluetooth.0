Return-Path: <cyrus@holtmann.org>
Message-ID: <54A3DD1B.4040100@gmail.com>
Date: Wed, 31 Dec 2014 12:25:15 +0100
From: Miguel Barrio Orsikowsky <megamik@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: PROBLEM: 0489:e062 [Sony VAIO SVF1531C5E] Bluetooth adapter does
 not see BT devices
References: <54A2D333.7090607@gmail.com> <FB8B7DF3-D835-4270-8932-BAED0DA050BE@holtmann.org>
In-Reply-To: <FB8B7DF3-D835-4270-8932-BAED0DA050BE@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

El 30/12/14 a las 20:09, Marcel Holtmann escribió:
> Hi Miguel,
>
>> [1.] One line summary of the problem:
>>
>> 0489:e062 [Sony VAIO SVF1531C5E] Bluetooth adapter does not see BT devices
>>
>> [2.] Full description of the problem/report:
>>
>> The Bluetooth adapter is detected and apparently working but, when executing "hcitool scan", the device list is always empty: it cannot see any BT device around.
>>
>> But, if I boot into Windows just before booting into Linux, the adapter works perfectly and it sees all BT devices. It seems Windows driver is performing some activation to the BT adapter.
>>
>> Test case:
>> Step 1: power on the Sony VAIO SVF1531C5E and boot into Linux.
>> Step 2: while having around one or more devices with BT enabled and visible, type "hcitool scan" and wait for a few seconds just to see that nothing gets listed.
>> Step 4: reboot the laptop and boot into a Windows partition (mine is Windows 8.1 x64).
>> Step 5: wait until it is completely booted, then just reboot into Linux again.
>> Step 6: while having around one or more devices with BT enabled and visible, type "hcitool scan" and wait for a few seconds just to see all of your devices correctly listed this time. You will be able to pair and use them later without any issue.
>>
>> [3.] Keywords (i.e., modules, networking, kernel):
>>
>> [4.] Kernel version (from /proc/version):
>>
>> Linux version 3.19.0-031900rc2-generic (apw@tangerine) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201412290135 SMP Mon Dec 29 01:36:54 UTC 2014
> just include the content of /sys/kernel/debug/usb/devices for this adapter. I assume it is connected via USB.

Yes, it is integrated and connected via USB:

T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e062 Rev= 1.12
S:  Manufacturer=Broadcom Corp
S:  Product=BCM43142A0
S:  SerialNumber=3C77E6DC7494
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

Regards,
Miguel.
