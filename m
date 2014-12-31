Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: PROBLEM: 0489:e062 [Sony VAIO SVF1531C5E] Bluetooth adapter does not see BT devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54A3F213.20106@gmail.com>
Date: Wed, 31 Dec 2014 14:51:38 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6DA7C965-5DC7-4A67-81FA-6182DF3A12F5@holtmann.org>
References: <54A2D333.7090607@gmail.com> <FB8B7DF3-D835-4270-8932-BAED0DA050BE@holtmann.org> <54A3DD1B.4040100@gmail.com> <F1981414-E281-4925-9C71-7310F538219F@holtmann.org> <54A3F213.20106@gmail.com>
To: Miguel Barrio Orsikowsky <megamik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Miguel,

>>>>> [1.] One line summary of the problem:
>>>>> 
>>>>> 0489:e062 [Sony VAIO SVF1531C5E] Bluetooth adapter does not see BT devices
>>>>> 
>>>>> [2.] Full description of the problem/report:
>>>>> 
>>>>> The Bluetooth adapter is detected and apparently working but, when executing "hcitool scan", the device list is always empty: it cannot see any BT device around.
>>>>> 
>>>>> But, if I boot into Windows just before booting into Linux, the adapter works perfectly and it sees all BT devices. It seems Windows driver is performing some activation to the BT adapter.
>>>>> 
>>>>> Test case:
>>>>> Step 1: power on the Sony VAIO SVF1531C5E and boot into Linux.
>>>>> Step 2: while having around one or more devices with BT enabled and visible, type "hcitool scan" and wait for a few seconds just to see that nothing gets listed.
>>>>> Step 4: reboot the laptop and boot into a Windows partition (mine is Windows 8.1 x64).
>>>>> Step 5: wait until it is completely booted, then just reboot into Linux again.
>>>>> Step 6: while having around one or more devices with BT enabled and visible, type "hcitool scan" and wait for a few seconds just to see all of your devices correctly listed this time. You will be able to pair and use them later without any issue.
>>>>> 
>>>>> [3.] Keywords (i.e., modules, networking, kernel):
>>>>> 
>>>>> [4.] Kernel version (from /proc/version):
>>>>> 
>>>>> Linux version 3.19.0-031900rc2-generic (apw@tangerine) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201412290135 SMP Mon Dec 29 01:36:54 UTC 2014
>>>> just include the content of /sys/kernel/debug/usb/devices for this adapter. I assume it is connected via USB.
>>> Yes, it is integrated and connected via USB:
>>> 
>>> T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
>>> D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>>> P:  Vendor=0489 ProdID=e062 Rev= 1.12
>>> S:  Manufacturer=Broadcom Corp
>>> S:  Product=BCM43142A0
>>> S:  SerialNumber=3C77E6DC7494
>>> C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
>>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>>> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>>> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
>>> I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
>> this one is listed as loading firmware patches if they are provided.
>> 
>>         /* Foxconn - Hon Hai */
>>         { USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xff, 0x01, 0x01),
>>           .driver_info = BTUSB_BCM_PATCHRAM },
>> 
>> The only thing you have to do find the right *.hcd file and put under /lib/firmware/brcm/ so it can be loaded. I bet if you call dmesg and look at the log of the driver it will even mention something about the firmware file.
>> 
>> Some of the Broadcom dongles are pretty much broken. They will not work when you do not patch the firmware to fix their bugs.
>> 
> I have done the following:
> 
> 1. dmesg | grep Bluetooth. This reveals the name of the firmware patch needed:
> 
> [   15.825275] Bluetooth: hci0: BCM: patch brcm/BCM43142A0-0489-e062.hcd not found
> 
> 2. Mounted the Windows 8.1 x64 partition into /mnt
> 
> 3. find /mnt -iname '*brcm.inf'. This leads to '/mnt/Program Files/WIDCOMM/Bluetooth Software/bin/bcbtums-win8x64-brcm.inf', viewed it and located the E062 string which leads to the file BCM43142A0_001.001.011.0161.0182.hex:
> 
> ...
> %BRCM43142BtAdapter.DeviceDesc%=BlueRAMUSBE062, USB\VID_0489&PID_E062       ; Sony 43142A0 combo
> ...
> ;;;;;;;;;;;;;RAMUSBE062;;;;;;;;;;;;;;;;;
> 
> [RAMUSBE062.CopyList]
> bcbtums.sys
> btwampfl.sys
> BCM43142A0_001.001.011.0161.0182.hex
> ...
> 
> 4. find /mnt -name 'BCM43142A0_001.001.011.0161.0182.hex'. Copied the '/mnt/Program Files/WIDCOMM/Bluetooth Software/bin/BCM43142A0_001.001.011.0161.0182.hex' file into my home dir.
> 
> 5. Downloaded and compiled hex2hcd (https://github.com/jessesung/hex2hcd<https://github.com/jessesung/hex2hcd>). Executed it against the BCM43142A0_001.001.011.0161.0182.hex file to get the BCM43142A0-0489-e062.hcd as requested by the dmesg message, and put it in /lib/firmare/brcm.
> 
> 6. Reboot.
> 
> 7. Now dmesg does not show the error "patch brcm/BCM43142A0-0489-e062.hcd not found", but the BT adapter is not even recognized ("hcitool scan" shows No such device), and dmesg shows this error in addition to the "hci0 command 0x1001 tx timeout" one:
> 
> [   26.265214] Bluetooth: hci0: HCI_OP_READ_LOCAL_VERSION failed (-110)

can you show us btmon output for this. And it might be really hard to capture it since it is a physical present adapter. Might need to see if rfkill {block,unblock} bluetooth would kick if off the USB bus.

This could be just a timing issue between some of the commands, but I would need to figure out when that happens and why such command takes longer. One other option is to increase the HCI_INIT_TIMEOUT in the kernel and see if that does help.

> 8. I rebooted into Linux again (no Windows this time), and the BT adapter is now recognized and fully working ("hcitool scan" shows all the BT devices around). Dmesg shows no errors this time but this two new messages:
> 
> [   15.107318] Bluetooth: hci0: BCM: patching hci_ver=06 hci_rev=00b6 lmp_ver=06 lmp_subver=210b
> [   15.567138] Bluetooth: hci0: BCM: firmware hci_ver=06 hci_rev=00b6 lmp_ver=06 lmp_subver=210b
> 
> Thus, there is no need to boot Windows before Linux if the .hcd file is present, but you still need to boot Linux twice in order for the BT adapter to work properly:

You should also see these two lines for the first time when booting into Linux. The hci_rev should change after loading the firmware.

Regards

Marcel

