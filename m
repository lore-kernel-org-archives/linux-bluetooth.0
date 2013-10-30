Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: Intel 7260 bluetooth malfunction when it is connected to EHCI bus
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <52707428.9070908@canonical.com>
Date: Wed, 30 Oct 2013 20:44:35 +0100
Cc: Tedd An <tedd.an@intel.com>,
	Johan Hedberg <johan.hedberg@intel.com>,
	xiong.y.zhang@intel.com,
	"Gustavo F. Padovan" <gustavo.padovan@collabora.co.uk>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <6091DDC7-7B00-4457-82A0-F8CC9B4EE9DD@holtmann.org>
References: <526F8804.9060906@canonical.com> <A07820C9-C272-4AD4-AE16-49F81956C2D7@holtmann.org> <52707428.9070908@canonical.com>
To: Hui Wang <hui.wang@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hui,

>>> The problem is:
>>> On the machine which has Intel 7260 BT module, i use it to connect a bluetooth headset,
>>> it can successfully scan and connect to the headset, when i play sound to the bt headset,
>>> the problem comes, if the bt module is connected to the XHCI, it can work very well.
>>> 
>>> u@u-Lenovo-B4400:~$ lsusb -t
>>> 1-7:1.0: No such file or directory
>>> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>>> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>>>    |__ Port 6: Dev 8, If 0, Class=HID, Driver=usbhid, 1.5M
>>>    |__ Port 7: Dev 2, If 0, Class=vend., Driver=, 12M
>>>    |__ Port 11: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>    |__ Port 11: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>> 
>>> But if the bt module is connected to the EHCI, it always fails to play sound.
>>> 
>>> u@u-Lenovo-B4400:~$ lsusb -t
>>> /: Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
>>> /: Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
>>> /: Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>>>    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
>>> /: Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci_hcd/3p, 480M
>>>    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>>>        |__ Port 5: Dev 3, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>        |__ Port 5: Dev 3, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>>>        |__ Port 6: Dev 4, If 0, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M
>>>        |__ Port 6: Dev 4, If 1, Class='bInterfaceClass 0x0e not yet handled', Driver=uvcvideo, 480M
>> can you paste /sys/kernel/debug/usb/devices here.
>> 
>> If the uvcvideo driver is also using ISOC URBs, we might have just exhausted the bandwidth of the USB bus here or these two devices just do not play nice with each other.
>> 
>> Try to unload the uvcvideo driver and try it again.
> Thanks for your reply, follow your instruction, i totally disabled the camera from the BIOS, then the usb tree like this,
> u@u-Lenovo-B4400:~$ lsusb -t
> 1-1.3:1.0: No such file or directory
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 5000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/14p, 480M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
>    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/8p, 480M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-pci/3p, 480M
>    |__ Port 1: Dev 2, If 0, Class=hub, Driver=hub/6p, 480M
>        |__ Port 2: Dev 3, If 0, Class=HID, Driver=usbhid, 1.5M
>        |__ Port 3: Dev 4, If 0, Class=vend., Driver=, 12M
>        |__ Port 5: Dev 5, If 0, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
>        |__ Port 5: Dev 5, If 1, Class='bInterfaceClass 0xe0 not yet handled', Driver=btusb, 12M
> u@u-Lenovo-B4400:~$ uname -a
> Linux u-Lenovo-B4400 3.12.0-031200rc6-generic #201310191635 SMP Sat Oct 19 20:36:43 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
> 
> I re-did the test, the result is same as before, after the headset is connected and i play audio, no sound is heard from the headset.
> And hciconfig output shows still no SCO packets received by BT driver.
> u@u-Lenovo-B4400:~$ hciconfig
> hci0:    Type: BR/EDR  Bus: USB
>    BD Address: 00:15:00:CC:2D:D2  ACL MTU: 1021:5  SCO MTU: 96:5
>    UP RUNNING PSCAN
>    RX bytes:5853 acl:61 sco:0 events:298 errors:0
>    TX bytes:19212 acl:68 sco:1 commands:179 errors:0

this is strange. The only reason I can think of is that you do not have the firmware installed and or it is not loaded correctly. Does dmesg give any indication that something failed here.

Since this is a 3.12 kernel it should have native support for Intel specific setup routing. Any chance you can run btmon -w <file> before plugging the device into the bus. Maybe something goes wrong with the setup routine on EHCI.

Regards

Marcel

