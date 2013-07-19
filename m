Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <51E8DBFF.4060702@boh.de>
Date: Fri, 19 Jul 2013 06:49:10 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <5BE2601B-7C94-4C24-AB9B-EF187CAD9098@holtmann.org>
References: <51E7ED11.7010103@boh.de> <36A79410-3FA3-408F-BA16-6A30568A7035@holtmann.org> <51E8DBFF.4060702@boh.de>
To: =?iso-8859-1?Q?J=F6rg_Esser?= <jackfritt@boh.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joerg,

>>> don´t know if it is wrong to post under the same topic which is more than one year old.
>>> Ref to it is here.
>>> http://www.spinics.net/lists/linux-bluetooth/msg18763.html
>>> There was never an answer to the latest question from Michael if there will be a solution.
>>> 
>>> I also tried to get this to run with my latest kernel 3.10 under debian 7 without success.
>>> Will there be a solution or should I open my real trashbin?(other sticks are working so far for me) :)
>>> 
>>> Let me know if you need more info´s on that.
>>> 
>>> Thx,
>>> Joerg
>>> 
>>> My syslog says:
>>> Jul 18 15:11:10 debian-capi kernel: [ 64.808373] usb 1-3: new full-speed USB device number 5 using ohci_hcd
>>> Jul 18 15:11:10 debian-capi kernel: [ 65.277828] usb 1-3: New USB device found, idVendor=057c, idProduct=3800
>>> Jul 18 15:11:10 debian-capi kernel: [ 65.277834] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>>> Jul 18 15:11:10 debian-capi kernel: [ 65.277838] usb 1-3: Product: Bluetooth Device
>>> Jul 18 15:11:10 debian-capi kernel: [ 65.277841] usb 1-3: Manufacturer: Bluetooth Device
>>> Jul 18 15:11:10 debian-capi kernel: [ 65.277844] usb 1-3: SerialNumber: CC1C8D0E0400
>>> Jul 18 15:11:10 debian-capi bluetoothd[2199]: HCI dev 0 registered
>>> Jul 18 15:11:10 debian-capi bluetoothd[2199]: Listening for HCI events on hci0
>>> Jul 18 15:11:11 debian-capi bluetoothd[2894]: Can't init device hci0: Invalid request code (56)
>> any chance you can run btmon and see if we have failing HCI commands during the setup phase.
> Sure! Here you are:
> 
> debian-capi:~# btmon
> Bluetooth monitor ver 5.7
> = New Index: 00:00:00:00:00:00 (BR/EDR,USB,hci0) [hci0] 0.025804
> < HCI Command: Reset (0x03|0x0003) plen 0 [hci0] 0.031045
> > HCI Event: Command Complete (0x0e) plen 4 [hci0] 0.037000
>      Reset (0x03|0x0003) ncmd 1
>        Status: Success (0x00)
> < HCI Command: Read Local Supported Feat.. (0x04|0x0003) plen 0 [hci0] 0.037209
> > HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.040740
>      Read Local Supported Features (0x04|0x0003) ncmd 1
>        Status: Success (0x00)
>        Features: 0xff 0xff 0x05 0x00 0x18 0x18 0x00 0x00
>          3 slot packets
>          5 slot packets
>          Encryption
>          Slot offset
>          Timing accuracy
>          Role switch
>          Hold mode
>          Sniff mode
>          Park state
>          Power control requests
>          Channel quality driven data rate (CQDDR)
>          SCO link
>          HV2 packets
>          HV3 packets
>          u-law log synchronous data
>          A-law log synchronous data
>          CVSD synchronous data
>          Power control
>          AFH capable slave
>          AFH classification slave
>          AFH capable master
>          AFH classification master
> < HCI Command: Read Local Version Inform.. (0x04|0x0001) plen 0 [hci0] 0.041025
> > HCI Event: Command Complete (0x0e) plen 12 [hci0] 0.043811
>      Read Local Version Information (0x04|0x0001) ncmd 1
>        Status: Success (0x00)
>        HCI version: 2 - 0x2006
>        LMP version: 2 - 0x1806
>        Manufacturer: AVM Berlin (31)

it declares itself here as Bluetooth 1.2 device. Which means it is the second generation of BlueFritz! USB device.

<snip>

> < HCI Command: Read Local Supported Comm.. (0x04|0x0002) plen 0 [hci0] 0.210014
> > HCI Event: Command Status (0x0f) plen 4 [hci0] 0.217361
>      Read Local Supported Commands (0x04|0x0002) ncmd 1
>        Status: Unknown HCI Command (0x01)

And here is your failing command. Newer kernels have been strict with failing commands and will just abort the setup if anything goes wrong.

Johan, we need to figure out on how to work around this one. Might just match for the manufacturer before sending the command.

>>> debian-capi:~# lsusb -v -d 057c:3800
>> Can you include /sys/kernel/debug/usb/devices from this device.
> 
> After mounting debugfs with
> 
> *mount -t debugfs none /sys/kernel/debug*
> 
> I got this:
> 
> debian-capi:~# cat /sys/kernel/debug/usb/devices

<snip>

> T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=03 Dev#=  8 Spd=12   MxCh= 0
> D:  Ver= 1.10 Cls=ff(vend.) Sub=ff Prot=ff MxPS=64 #Cfgs=  1
> P:  Vendor=057c ProdID=3800 Rev=15.00
> S:  Manufacturer=Bluetooth Device
> S:  Product=Bluetooth Device
> S:  SerialNumber=CC1C8D0E0400
> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=200mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Sorry to make you jump through this hoop, but I needed to know which version of the dongle it is. The first version has its own driver.

> debian-capi:~#
> 
> Oh i forgot to mention that I run this under Virtualbox 4.2.16 with Windows7 64bit host.
> I hope that i still get support?
> If not I also can put this into some real hardware with latest kernel.

I think the issue is pretty clear.

Regards

Marcel

