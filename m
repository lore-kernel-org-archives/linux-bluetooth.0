Return-Path: <cyrus@holtmann.org>
Message-ID: <5271EAA2.1030705@canonical.com>
Date: Thu, 31 Oct 2013 13:29:06 +0800
From: Hui Wang <hui.wang@canonical.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Tedd An <tedd.an@intel.com>, Johan Hedberg <johan.hedberg@intel.com>,
 xiong.y.zhang@intel.com,
 "Gustavo F. Padovan" <gustavo.padovan@collabora.co.uk>,
 "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: Intel 7260 bluetooth malfunction when it is connected to EHCI
 bus
References: <526F8804.9060906@canonical.com> <A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org> <52707428.9070908@canonical.com> <6091DDC7-7B00-4457-82A0-F8CC9B4EE9DD@holtmann.org>
In-Reply-To: <6091DDC7-7B00-4457-82A0-F8CC9B4EE9DD@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/31/2013 03:44 AM, Marcel Holtmann wrote:
> Hi Hui,
>
>>>> The problem is:
>>>> On the machine which has Intel 7260 BT module, i use it to connect a bluetooth headset,
>>>> it can successfully scan and connect to the headset, when i play sound to the bt headset,
>>>> the problem comes, if the bt module is connected to the XHCI, it can work very well.
>>>>
>>>> u@u-Lenovo-B4400:~$ lsusb -t
>>>> 1-7:1.0: No such file or directory
>>>> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>>>> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>>>>     |__ Port 6: Dev 8, If 0, Class=HID, Driver=usbhid, 1.5M
>>>>     |__ Port 7: Dev 2, If 0, Class=vend., Driver=, 12M
>>>>     |__ Port 11: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>>     |__ Port 11: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>>
>>>> But if the bt module is connected to the EHCI, it always fails to play sound.
>>>>
>>>> u@u-Lenovo-B4400:~$ lsusb -t
>>>> /: Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>>>> /: Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>>>> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>>>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
>>>> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>>>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>>>>         |__ Port 5: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>>         |__ Port 5: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>>         |__ Port 6: Dev 4, If 0, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M
>>>>         |__ Port 6: Dev 4, If 1, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M
>>> can you paste /sys/kernel/debug/usb/devices here.
>>>
>>> If the uvcvideo driver is also using ISOC URBs, we might have just exhausted the bandwidth of the USB bus here or these two devices just do not play nice with each other.
>>>
>>> Try to unload the uvcvideo driver and try it again.
>> Thanks for your reply, follow your instruction, i totally disabled the camera from the BIOS, then the usb tree like this,
>> u@u-Lenovo-B4400:~$ lsusb -t
>> 1-1.3:1.0: No such file or directory
>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
>> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
>>     |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>>         |__ Port 2: Dev 3, If 0, Class=HID, Driver=usbhid, 1.5M
>>         |__ Port 3: Dev 4, If 0, Class=vend., Driver=, 12M
>>         |__ Port 5: Dev 5, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>         |__ Port 5: Dev 5, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>> u@u-Lenovo-B4400:~$ uname -a
>> Linux u-Lenovo-B4400 3.12.0-031200rc6-generic #201310191635 SMP Sat Oct 19 20:36:43 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
>>
>> I re-did the test, the result is same as before, after the headset is connected and i play audio, no sound is heard from the headset.
>> And hciconfig output shows still no SCO packets received by BT driver.
>> u@u-Lenovo-B4400:~$ hciconfig
>> hci0:    Type: BR/EDR  Bus: USB
>>     BD Address: 00:15:00:CC:2D:D2  ACL MTU: 1021:5  SCO MTU: 96:5
>>     UP RUNNING PSCAN
>>     RX bytes:5853 acl:61 sco:0 events:298 errors:0
>>     TX bytes:19212 acl:68 sco:1 commands:179 errors:0
> this is strange. The only reason I can think of is that you do not have the firmware installed and or it is not loaded correctly. Does dmesg give any indication that something failed here.
I can confirm the firmware file is the 
/lib/firmware/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq, and it is in the 
filesystem. And from the dmesg, the firmware was successfully loaded.

[    8.600217] Bluetooth: hci0: Intel Bluetooth firmware file: 
intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
[    8.653635] kvm: disabled by bios
[    8.672981] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, 
id: 0x1e2b1, caps: 0xd00123/0x840300/0x126c00
[    8.707034] input: SynPS/2 Synaptics TouchPad as 
/devices/platform/i8042/serio1/input/input13
[    8.717725] Registered led device: phy0-led
[    8.722730] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    8.752626] Bluetooth: hci0: Intel Bluetooth firmware patch completed 
and activated

> Since this is a 3.12 kernel it should have native support for Intel specific setup routing. Any chance you can run btmon -w <file> before plugging the device into the bus. Maybe something goes wrong with the setup routine on EHCI.
Do you mean the hcidump file i just sent in my previous email.

In case some of you can't receive the attachment, i decode the log file 
here:

u@u-Lenovo-K4450:~$ hcidump -r lenovo-k4450-bt-ascii-hex.log
HCI sniffer - Bluetooth packet analyzer ver 2.2
btsnoop version: 1 datalink type: 1002
 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 78:F7:BE:08:5E:DF class 0x240404 type ACL
 > HCI Event: Command Status (0x0f) plen 4
     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 256 bdaddr 78:F7:BE:08:5E:DF type ACL encrypt 0x00
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 256
     Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x87
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
 > HCI Event: Read Remote Extended Features (0x23) plen 13
     status 0x00 handle 256 page 1 max 0
     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 78:F7:BE:08:5E:DF name 'HM1700'
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
     status 0x00 bdaddr 78:F7:BE:08:5E:DF
 > HCI Event: Command Complete (0x0e) plen 10
     IO Capability Request Reply (0x01|0x002b) ncmd 1
     status 0x00 bdaddr 78:F7:BE:08:5E:DF
 > HCI Event: Command Complete (0x0e) plen 10
     User Confirmation Request Negative Reply (0x01|0x002d) ncmd 1
     status 0x00 bdaddr 78:F7:BE:08:5E:DF
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 256 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Inquiry (0x01|0x0001) status 0x00 ncmd 2
 > HCI Event: Extended Inquiry Result (0x2f) plen 255
     bdaddr 78:F7:BE:08:5E:DF mode 1 clkoffset 0x0391 class 0x240404 
rssi -52
     Unknown type 0x48 with 8 bytes data
     Shortened local name: '..'
 > HCI Event: Command Complete (0x0e) plen 4
     Inquiry Cancel (0x01|0x0002) ncmd 2
     status 0x00
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 256 bdaddr 78:F7:BE:08:5E:DF type ACL encrypt 0x00
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 256
     Features: 0xbf 0xfe 0x8f 0xfe 0x9b 0xff 0x79 0x87
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
 > HCI Event: Read Remote Extended Features (0x23) plen 13
     status 0x00 handle 256 page 1 max 0
     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 78:F7:BE:08:5E:DF name 'HM1700'
 > HCI Event: Command Status (0x0f) plen 4
     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
     status 0x00 bdaddr 78:F7:BE:08:5E:DF
 > HCI Event: Command Complete (0x0e) plen 10
     IO Capability Request Reply (0x01|0x002b) ncmd 1
     status 0x00 bdaddr 78:F7:BE:08:5E:DF
 > HCI Event: Command Complete (0x0e) plen 10
     User Confirmation Request Reply (0x01|0x002c) ncmd 1
     status 0x00 bdaddr 78:F7:BE:08:5E:DF
 > HCI Event: Auth Complete (0x06) plen 3
     status 0x00 handle 256
 > HCI Event: Command Status (0x0f) plen 4
     Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 256 encrypt 0x01
 > HCI Event: Command Status (0x0f) plen 4
     Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
 > HCI Event: Synchronous Connect Complete (0x2c) plen 17
     status 0x00 handle 257 bdaddr 78:F7:BE:08:5E:DF type eSCO
     Air mode: CVSD
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 257 reason 0x16
     Reason: Connection Terminated by Local Host
 > HCI Event: Command Status (0x0f) plen 4
     Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
 > HCI Event: Synchronous Connect Complete (0x2c) plen 17
     status 0x00 handle 257 bdaddr 78:F7:BE:08:5E:DF type eSCO
     Air mode: CVSD
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1


Regards,
Hui.

>
> Regards
>
> Marcel
>
>
