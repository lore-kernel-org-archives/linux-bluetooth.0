Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: MacbookPro12,1 Bluetooth not found by Bluez
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441775933.3223.2@mail.quuxo.net>
Date: Tue, 8 Sep 2015 22:57:20 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8B052FF6-9EF3-4A9D-9ECA-773B40DC807E@holtmann.org>
References: <1441775933.3223.2@mail.quuxo.net>
To: Michael Gratton <mike@vee.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michael,

> No Bluetooth adapter is being found by Bluez on my MacbookPro12,1 when running Ubuntu 15.10, Linux 4.2rc8 and Bluez 5.33. After normal boot, the output of `hcitool dev` contains no devices.
> 
> Relevant kernel logs are below, but since it finds the BT adaptor but also reports it as both hid-generic and input devices, I imagine I need to switch it out of HID mode and into HCI mode. However, when I try manually running hid2hci as root, the command silently fails and no change in the visibility of the adaptor is observed:
> 
> > mjg@payens:~$ sudo /lib/udev/hid2hci --evpath=/devices/pci0000:00/0000:00:14.0/usb1/1-3 --method=csr2 || echo fail
> > fail
> > mjg@payens:~$
> 
> Using methods other than csr2 results in hid2hci reporting an error.
> 
> Is there anything I can do to help debug this?

check /sys/kernel/debug/usb/devices for the Bluetooth controller entry.

> Kernel logs:
> 
>> [ 1.869553] usb 1-3: new full-speed USB device number 2 using xhci_hcd
>> ...
>> [ 2.004387] usb 1-3: New USB device found, idVendor=05ac, idProduct=8290
>> [ 2.004388] usb 1-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [ 2.004389] usb 1-3: Product: Bluetooth USB Host Controller
>> [ 2.004390] usb 1-3: Manufacturer: Broadcom Corp.
>> [ 2.004478] usb 1-3: ep 0x85 - rounding interval to 64 microframes, ep desc says 80 microframes
>> [ 2.004480] usb 1-3: ep 0x86 - rounding interval to 64 microframes, ep desc says 80 microframes
>> ...
>> [ 2.425178] hid-generic 0003:05AC:8290.0001: input,hidraw4: USB HID v1.11 Keyboard [Broadcom Corp. Bluetooth USB Host Controller] on usb-0000:00:14.0-3/input0
>> [ 2.425259] input: Broadcom Corp. Bluetooth USB Host Controller as /devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:05AC:8290.0002/input/input7
>> ...
>> [ 10.254634] usbcore: registered new interface driver btusb
>> ...
>> [ 16.642700] usb 1-3: device descriptor read/64, error -110

This might actually be the problem. It seems the Bluetooth controller gets detected correctly and the btusb driver loaded, but then we get some issues with the descriptor reading.

Does the original Ubuntu 15.10 kernel work or any other kernel than 4.2-rc8. If you find a working kernel, you might need to bisect this. However my feeling is that this might be an issue in the USB host controller or somewhere else.

In general all MacBook Bluetooth controllers are suppose to work. If you happen to still have OS X installed, then start it and see if it might runs a firmware upgrade for the controller.

Regards

Marcel

