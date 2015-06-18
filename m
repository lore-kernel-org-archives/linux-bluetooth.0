Return-Path: <cyrus@holtmann.org>
From: "Huang, Rick" <rickh@qti.qualcomm.com>
To: Sumit's Mailing Lists <lists@battlepenguin.com>,
	"Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: ath3k Bluetooth adapter not loading: [0cf3:3004] Atheros
 Communications, Inc. AR3012 Bluetooth 4.0
Date: Thu, 18 Jun 2015 10:09:21 +0000
Message-ID: <64d5c541c81f4f4fa80304c7517b135f@nalasexr02e.na.qualcomm.com>
References: <556486B0.1020104@battlepenguin.com>
 <EEAFDBFC-C252-4843-A9E0-3E74EA21B665@holtmann.org>
 <557EBF98.2000701@battlepenguin.com>
 <A93AF220-83E9-4FC3-BC07-18B285E5FA3D@holtmann.org>
 <557EDE40.7070006@battlepenguin.com> <557F03E2.3000001@qca.qualcomm.com>
 <557F0FD2.7000000@battlepenguin.com> <55808CAB.3020205@qca.qualcomm.com>
 <55816C31.3050008@battlepenguin.com> <55816F6D.3030706@battlepenguin.com>
 <5581C269.5020401@qca.qualcomm.com>,<55822E92.60609@battlepenguin.com>
 <53369F14-1B95-40B4-AAB1-3181ED18CFD7@qca.qualcomm.com>,<558234DF.7080103@battlepenguin.com>
 <C280E19E-C4F3-400F-8C2B-F1208B137E62@qca.qualcomm.com>
 <5582852A.2070805@battlepenguin.com>
In-Reply-To: <5582852A.2070805@battlepenguin.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

>>Is there any other way to detect AR/ROME chips sharing with same VID/PID except sending command to controller even though they're reporting same PID?

I compared the AR and ROME chip's USB descriptions but no difference between them. 
So, I think if they use the same VID/PIV, we have to send VSC command to know the chip is AR or ROME chip.

Thanks
Rick

-----Original Message-----
From: Sumit's Mailing Lists [mailto:lists@battlepenguin.com] 
Sent: Thursday, June 18, 2015 4:46 PM
To: Kim, Ben Young Tae
Cc: Marcel Holtmann; Huang, Rick; linux-bluetooth@vger.kernel.org
Subject: Re: ath3k Bluetooth adapter not loading: [0cf3:3004] Atheros Communications, Inc. AR3012 Bluetooth 4.0

On 18/06/15 13:53, Kim, Ben Young Tae wrote:
> Hi Sumit,
>
>> On Jun 17, 2015, at 8:03 PM, Sumit's Mailing Lists <lists@battlepenguin.com> wrote:
>>
>>> On 18/06/15 10:53, Kim, Ben Young Tae wrote:
>>> Hi Sumit,
>>>
>>> On Jun 17, 2015, at 7:36 PM, Sumit's Mailing Lists 
>>> <lists@battlepenguin.com <mailto:lists@battlepenguin.com>> wrote:
>>>
>>>>> On 18/06/15 02:54, Ben Young Tae Kim wrote:
>>>>> Hi Sumit,
>>>>>
>>>>>> On 06/17/15 06:00, Sumit Khanna wrote:
>>>>>>> On 17/06/15 20:46, Sumit's Mailing Lists wrote:
>>>>>>>> On 17/06/15 04:52, Ben Young Tae Kim wrote:
>>>>>>>> Hi Sumit,
>>>>>>>>
>>>>>>>>> On 06/15/15 10:48, Sumit's Mailing Lists wrote:
>>>>>>>>>> On 16/06/15 00:57, Ben Young Tae Kim wrote:
>>>>>>>>>> Hi Sumit,
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> On 06/15/15 07:16, Sumit's Mailing Lists wrote:
>>>>>>>>>>>> On 15/06/15 21:55, Marcel Holtmann wrote:
>>>>>>>>>>>> Hi Smuit,
>>>>>>>>>>>>
>>>>>>>>>>>>>>> I'm currently using an MSI WS60 laptop which contains 
>>>>>>>>>>>>>>> the following Bluetooth controller (from lsusb):
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Bus 003 Device 003: ID 0cf3:3004 Atheros Communications, 
>>>>>>>>>>>>>>> Inc. AR3012 Bluetooth 4.0
>>>>>>>>>>>>>> assuming that the firmware is present, this is most 
>>>>>>>>>>>>>> likely just missing the right VID/PID additions in the drivers.
>>>>>>>>>>>>>> Please prepare a patch for that.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> and the more detailed version:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Bus 003 Device 003: ID 0cf3:3004 Atheros Communications, 
>>>>>>>>>>>>>>> Inc. AR3012 Bluetooth 4.0 Device Descriptor:
>>>>>>>>>>>>>>> bLength                18
>>>>>>>>>>>>>>> bDescriptorType         1
>>>>>>>>>>>>>>> bcdUSB               1.10
>>>>>>>>>>>>>>> bDeviceClass          224 Wireless
>>>>>>>>>>>>>>> bDeviceSubClass         1 Radio Frequency
>>>>>>>>>>>>>>> bDeviceProtocol         1 Bluetooth
>>>>>>>>>>>>>>> bMaxPacketSize0        64
>>>>>>>>>>>>>>> idVendor           0x0cf3 Atheros Communications, Inc.
>>>>>>>>>>>>>>> idProduct          0x3004 AR3012 Bluetooth 4.0
>>>>>>>>>>>>>>> bcdDevice            0.01
>>>>>>>>>>>>>>> iManufacturer           0
>>>>>>>>>>>>>>> iProduct                0
>>>>>>>>>>>>>>> iSerial                 0
>>>>>>>>>>>>>>> bNumConfigurations      1
>>>>>>>>>>>>>>> Configuration Descriptor:
>>>>>>>>>>>>>> I actually prefer /sys/kernel/debug/usb/devices output 
>>>>>>>>>>>>>> for the devices.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Regards
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Marcel
>>>>>>>>>>>>> Here is the output from /sys/kernel/debug/usb/devices for 
>>>>>>>>>>>>> my ath3k (also added it to the kernel bugzilla):
>>>>>>>>>>>>>
>>>>>>>>>>>>> T:  Bus=03 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  3 Spd=12  
>>>>>>>>>>>>> MxCh= 0
>>>>>>>>>>>>> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  
>>>>>>>>>>>>> 1
>>>>>>>>>>>>> P:  Vendor=0cf3 ProdID=3004 Rev= 0.01
>>>>>>>>>>>>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
>>>>>>>>>>>>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>>>> Driver=(none)
>>>>>>>>>>>>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>>>>>>>>>>>>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>>>>>>>>>>>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>>>>>>>>>>>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>>>> Driver=(none)
>>>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>>>>>>>>>>>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>>>> Driver=(none)
>>>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>>>>>>>>>>>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>>>> Driver=(none)
>>>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>>>>>>>>>>>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>>>> Driver=(none)
>>>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>>>>>>>>>>>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>>>> Driver=(none)
>>>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>>>>>>>>>>>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01
>>>>>>>>>>>>> Driver=(none)
>>>>>>>>>>>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>>>>>>>>>>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>>>>>>>>>>>>
>>>>>>>>>>>>> and the firmware the kernel is trying to load:
>>>>>>>>>>>>>
>>>>>>>>>>>>> [  762.729370] usb 3-1.3: Direct firmware load for 
>>>>>>>>>>>>> ar3k/AthrBT_0x00000200.dfu failed with error -2 [  
>>>>>>>>>>>>> 762.729373] Bluetooth: Patch file not found 
>>>>>>>>>>>>> ar3k/AthrBT_0x00000200.dfu [  762.729374] Bluetooth: 
>>>>>>>>>>>>> Loading patch file failed [  762.729381] ath3k: probe of 
>>>>>>>>>>>>> 3-1.3:1.0 failed with error -2 [  762.729411] usbcore: 
>>>>>>>>>>>>> registered new interface driver ath3k
>>>>>>>>>>>> I fail to see that firmware in linux-firmware tree. However 
>>>>>>>>>>>> this up to Atheros / Qualcomm to submit there. I can not do 
>>>>>>>>>>>> much about this.
>>>>>>>>>>>>
>>>>>>>>>>>> Regards
>>>>>>>>>>>>
>>>>>>>>>>>> Marcel
>>>>>>>>>>> Marcel,
>>>>>>>>>>>
>>>>>>>>>>> So it's pulling the right firmware file for my device, but 
>>>>>>>>>>> It just hasn't been released yet?
>>>>>>>>>>>
>>>>>>>>>>> I know with the Wi-Fi firmware, the ath10k devs had python 
>>>>>>>>>>> scripts to extract the firmware binaries from the Windows 
>>>>>>>>>>> drivers (mentioned in here 
>>>>>>>>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1383184
>>>>>>>>>>> ). Has anyone done that before with the bluetooth firmware, 
>>>>>>>>>>> or do you typically just wait for atheros/qualcom to release 
>>>>>>>>>>> official ones?
>>>>>>>>>> Where did you get your atheros board/card since I couldn't 
>>>>>>>>>> find that board here. Is it a laptop? The BT firmware driver 
>>>>>>>>>> was trying to load AthrBT_0x00000200.dfu file and it got 
>>>>>>>>>> failed because no firmware file was present. But 0x00000200 
>>>>>>>>>> means fw_version.rom_version which coming from controller 
>>>>>>>>>> chip, however, I haven't seen this version on Atheros chipset.
>>>>>>>>>>
>>>>>>>>>> I'm adding my friend - Rick Huang here. He may help you out
>>>>>>>>>>
>>>>>>>>>> Hi Rick,
>>>>>>>>>>
>>>>>>>>>> Have you seen rom_version as 0x00000200?
>>>>>>>>>>
>>>>>>>>>>> Sumit
>>>>>>>>>>> --
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>>>>>>>>> linux-bluetooth" in the body of a message to 
>>>>>>>>>>> majordomo@vger.kernel.org <mailto:majordomo@vger.kernel.org>
>>>>>>>>>>> More majordomo info at  
>>>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>>>> Thanks
>>>>>>>>>> -- Ben Kim
>>>>>>>>> Yes, It's an MSI WS-60 Laptop, purchased two months ago in 
>>>>>>>>> Australia. Is there any other debugging information I need to 
>>>>>>>>> pull for you?
>>>>>>>>>
>>>>>>>>> Sumit
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>>>>>>> linux-bluetooth" in the body of a message to 
>>>>>>>>> majordomo@vger.kernel.org <mailto:majordomo@vger.kernel.org>
>>>>>>>>> More majordomo info at  
>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>>>> According to my colleague, it is not AR chip but QCA ROME core 
>>>>>>>> inside even though they're sharing same VID/PID with AR/QCA 
>>>>>>>> ROME(version 2). That's why you cannot bring up your card with 
>>>>>>>> ath3k driver. I knew it was not a good idea as it was early 
>>>>>>>> stage to develop the card so that next version of ROME USB 
>>>>>>>> card(v3.0 or
>>>>>>>> v3.2) will use different PID/VID as you can see below.
>>>>>>>>
>>>>>>>> Can you follow up these instructions to see whether or not it 
>>>>>>>> can be addressed on your setup?
>>>>>>>>
>>>>>>>> --
>>>>>>>> 1. put this code in drivers/bluetooth/btusb.c
>>>>>>>>
>>>>>>>> static const struct usb_device_id blacklist_table[] = { ...
>>>>>>>>   /* QCA ROME chipset */
>>>>>>>>   { USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
>>>>>>>>   { USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
>>>>>>>>   { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME 
>>>>>>>> }, // <-- add new VID/PID here ...
>>>>>>>>
>>>>>>>> 2. Copy firmware files into /lib/firmware/qca
>>>>>>>> - nvm_usb_00000200.bin
>>>>>>>> - rampatch_usb_00000200.bin
>>>>>>>> Those FW files won't be available on linux-firmware.git til 
>>>>>>>> today but it it will be available soon I believe.
>>>>>>>> --
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>> -- Ben Kim
>>>>>>> Hi Ben,
>>>>>>>
>>>>>>> I added that line to my btusb.c; did a mrpropery, copied my 
>>>>>>> .config back into the source tree, disabled ATH3K in menucofnig, 
>>>>>>> made the bzImage and rebooted. The firmware you attached is in 
>>>>>>> /lib/firmware/qca.
>>>>>>>
>>>>>>> I enabled debugging (FLAGS_btusb.o := -DDEBUG in the Makefile) 
>>>>>>> so I could get some more info, and discovered I also have to 
>>>>>>> delete this line or it will match the ath first:
>>>>>>>
>>>>>>> { USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 }
>>>>>>>
>>>>>>> So then I saw
>>>>>>>
>>>>>>> [    1.263991] usb 3-1.3: new full-speed USB device number 3 using
>>>>>>> ehci-pci
>>>>>>> [    1.277022] usb 4-1.8: new full-speed USB device number 3 using
>>>>>>> ehci-pci
>>>>>>> [    1.350050] usb 3-1.3: New USB device found, idVendor=0cf3,
>>>>>>> idProduct=3004
>>>>>>> [    1.350051] usb 3-1.3: New USB device strings: Mfr=0, Product=0,
>>>>>>> SerialNumber=0
>>>>>>> [    1.350461] intf ffff88041bf62400 id ffffffff81d83bc0
>>>>>>> [    1.350462] BT Device Info 0
>>>>>>> [    1.350463] BT Device Info (after matching) 32768
>>>>>>> [    1.350466] In Rome Block
>>>>>>> [    1.350546] input: ETPS/2 Elantech Touchpad as
>>>>>>> /devices/platform/i8042/serio1/input/input10
>>>>>>> [    1.350671] hci0
>>>>>>> [    1.350879] Bluetooth: hci0: don't support firmware rome 0x200
>>>>>>> [    1.364795] usb 4-1.8: New USB device found, idVendor=1770,
>>>>>>> idProduct=ff00
>>>>>>> [    1.364797] usb 4-1.8: New USB device strings: Mfr=1, Product=1,
>>>>>>> SerialNumber=1
>>>>>>> [    1.364798] usb 4-1.8: Product: MSI EPF USB
>>>>>>> [    1.364799] usb 4-1.8: Manufacturer: MSI EPF USB
>>>>>>> [    1.364800] usb 4-1.8: SerialNumber: MSI EPF USB
>>>>>>>
>>>>>>> So those BT Device Info statements I added in the probe 
>>>>>>> function. "In Rome Block" I added right after "if 
>>>>>>> (id->driver_info &
>>>>>>> BTUSB_QCA_ROME) "
>>>>>>> and you can see where that error comes from.
>>>>>>>
>>>>>>> And that comes from...oh it checks another table...okay so I 
>>>>>>> added the following to qca_device_info
>>>>>>>
>>>>>>>       { 0x00000200, 28, 4, 18 },
>>>>>>>
>>>>>>> and now I get;
>>>>>>>
>>>>>>> [    1.357942] intf ffff88041ba5bc00 id ffffffff81d83bc0
>>>>>>> [    1.357943] BT Device Info 0
>>>>>>> [    1.357944] BT Device Info (after matching) 32768
>>>>>>> [    1.357946] In Rome Block
>>>>>>> [    1.358113] hci0
>>>>>>> [    1.358516] bluetooth hci0: Direct firmware load for
>>>>>>> qca/rampatch_usb_00000200.bin failed with error -2
>>>>>>> [    1.358517] Bluetooth: hci0: failed to request rampatch file:
>>>>>>> qca/rampatch_usb_00000200.bin (-2)
>>>>>>>
>>>>>>> So progress. It's attempting to load the firmware and failing. 
>>>>>>> Are those the right numbers for the device_info block?
>>>>>>>
>>>>>>> Sumit
>>>>>> Just remembered -2 is when it can't even find the firmware. But I 
>>>>>> think I have it installed right. Is this correct:
>>>>>>
>>>>>> catelyn linux # ls /lib/firmware/qca/ -l total 60
>>>>>> -rw-r--r-- 1 root root  1859 Jun 17 18:07 nvm_usb_00000200.bin
>>>>>> -rw-r--r-- 1 root root 54432 Jun 17 18:07 
>>>>>> rampatch_usb_00000200.bin
>>>>>>
>>>>>> catelyn linux # sha256sum /lib/firmware/qca/*
>>>>>> 50cddc73c1a7c90bb3338941785d46088374b2aebf5dd1679c23145e39ad5087
>>>>>> /lib/firmware/qca/nvm_usb_00000200.bin
>>>>>> 7551fc3a01fe46514d4da265095aabf07371cf17418a9f238e51b0fc4e83cfc5
>>>>>> /lib/firmware/qca/rampatch_usb_00000200.bin
>>>>> You did right thing. I cannot understand why driver couldn't 
>>>>> access firmware file which is in /lib/firmware/qca. Did you check 
>>>>> each folder has right permission to access?
>>>>>
>>>>> Thanks
>>>>> -- Ben Kim
>>>> Ah I'm dumb. I'm using an initrd. :) So I've recompiled btusb as a 
>>>> module and it loads the firmware! :)
>>>>
>>>> [  108.599370] intf ffff8800c9d2b800 id ffffffffa0005f50 [  
>>>> 108.599733] usbcore: registered new interface driver btusb [  
>>>> 108.599769] hci0 [  108.602907] Bluetooth: hci0: using rampatch 
>>>> file:
>>>> qca/rampatch_usb_00000200.bin
>>>> [  108.602909] Bluetooth: hci0: QCA: patch rome 0x200 build 0x299, 
>>>> firmware rome 0x200 build 0x111 [  108.658716] Bluetooth: hci0: 
>>>> using NVM file: qca/nvm_usb_00000200.bin
>>>>
>>>> and I checked rfkill to make sure I wasn't soft/hard blocked:
>>>>
>>>> sudo rfkill list
>>>> 0: msi-bluetooth: Bluetooth
>>>>   Soft blocked: no
>>>>   Hard blocked: no
>>>> 1: msi-wlan: Wireless LAN
>>>>   Soft blocked: no
>>>>   Hard blocked: no
>>>> 2: hci0: Bluetooth
>>>>   Soft blocked: no
>>>>   Hard blocked: no
>>>> 3: phy0: Wireless LAN
>>>>   Soft blocked: no
>>>>   Hard blocked: no
>>>>
>>>> Sumit
>>>>
>>>>
>>>>
>>>> However, upon attempting to turn on bluetooth, either via the 
>>>> blueman applet or the bluetoothctl command line like so:
>>>>
>>>> bluetoothctl
>>>> [NEW] Controller 2C:33:7A:00:05:DA BlueZ 5.25 [default] 
>>>> [bluetooth]# select 2C:33:7A:00:05:DA [bluetooth]# power on Failed 
>>>> to set power on: org.bluez.Error.Failed [bluetooth]#
>>>>
>>>> I get the following kernel error:
>>>>
>>>> [ 1172.484075] hci0
>>>> [ 1172.484097] Bluetooth: hci0: Failed to access otp area (-108)
>>> Why does it try to load firmware again since it is already done on 
>>> previous logs. I haven't used bluetoothctrl command. Can you follow 
>>> up this step?
>>>
>>> 1. Make sure to load firmware files on the kernel message
>>>> Bluetooth: hci0: QCA: patch rome 0x200 build 0x299, firmware rome 
>>>> 0x200 build 0x111
>>> 2. # hciattach hci0 up
>>> 3. # hcitool inq
>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>> linux-bluetooth" in the body of a message to 
>>>> majordomo@vger.kernel.org <mailto:majordomo@vger.kernel.org>
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Thanks
>>> --Ben Kim
>> Oh I rebooted; so this is a fresh log. As far as I can tell, it only 
>> tries to load the firmware once.
>>
>> Huh, odd. When I try to use hcitool, it can't find hci0:
>>
>> # hciattach hci0 up
>> Unknown device type or id
>> # hcitool inq
>> Inquiring ...
>> Inquiry failed.: No such device
>> # hcitool dev
>> Devices:
>>
>> Here's a pastbin or my current dmesg:
>> https://bpaste.net/show/76b3ab48f222 (towards the bottom is where I 
>> modprobe btusb)
>>
>> Sumit
> Did you load btusb module on manual? Looks like kernel was going to detect the card and loaded on boot step and you did to load driver again then it failed.
>
> Can you just reboot the PC and see fw is downloaded on the boot and run my sequences on root permission?
>
> Thanks
> -- Ben Kim

Ah yes; not sure what happened last time. On a fresh reboot it autoloads btusb. But I still get this:

[root] # hciattach hci0 up
Unknown device type or id
[root] # hcitool inq
Inquiring ...
Inquiry failed.: No such device
[root] #

Nothing in my dmesg when I run those commands either. But once again, if I try using "power on" in bluetoothctl, I see the following:

[  244.655087] hci0
[  244.655096] Bluetooth: hci0: Failed to access otp area (-108)

Latest dmesg: https://bpaste.net/show/8204c1f5e384

Sumit
