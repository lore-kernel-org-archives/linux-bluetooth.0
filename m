Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <51E7ED11.7010103@boh.de>
Date: Thu, 18 Jul 2013 07:13:33 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <36A79410-3FA3-408F-BA16-6A30568A7035@holtmann.org>
References: <51E7ED11.7010103@boh.de>
To: =?iso-8859-1?Q?J=F6rg_Esser?= <jackfritt@boh.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joerg,

> don´t know if it is wrong to post under the same topic which is more than one year old.
> Ref to it is here.
> http://www.spinics.net/lists/linux-bluetooth/msg18763.html
> There was never an answer to the latest question from Michael if there will be a solution.
> 
> I also tried to get this to run with my latest kernel 3.10 under debian 7 without success.
> Will there be a solution or should I open my real trashbin?(other sticks are working so far for me) :)
> 
> Let me know if you need more info´s on that.
> 
> Thx,
> Joerg
> 
> My syslog says:
> Jul 18 15:11:10 debian-capi kernel: [ 64.808373] usb 1-3: new full-speed USB device number 5 using ohci_hcd
> Jul 18 15:11:10 debian-capi kernel: [ 65.277828] usb 1-3: New USB device found, idVendor=057c, idProduct=3800
> Jul 18 15:11:10 debian-capi kernel: [ 65.277834] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> Jul 18 15:11:10 debian-capi kernel: [ 65.277838] usb 1-3: Product: Bluetooth Device
> Jul 18 15:11:10 debian-capi kernel: [ 65.277841] usb 1-3: Manufacturer: Bluetooth Device
> Jul 18 15:11:10 debian-capi kernel: [ 65.277844] usb 1-3: SerialNumber: CC1C8D0E0400
> Jul 18 15:11:10 debian-capi bluetoothd[2199]: HCI dev 0 registered
> Jul 18 15:11:10 debian-capi bluetoothd[2199]: Listening for HCI events on hci0
> Jul 18 15:11:11 debian-capi bluetoothd[2894]: Can't init device hci0: Invalid request code (56)

any chance you can run btmon and see if we have failing HCI commands during the setup phase.

> debian-capi:~# lsusb -v -d 057c:3800

Can you include /sys/kernel/debug/usb/devices from this device.

Regards

Marcel

