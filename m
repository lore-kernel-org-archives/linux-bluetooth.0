Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHkwNT=Hoc4xibrtg2zk7K1vwcutcWgUHAN58XpWH0jnqfLXbg@mail.gmail.com>
References: <CAHkwNT=sQQz11YWsxivxb20mW7rh1U=CXTN7uyBqTzkXvNbXgA@mail.gmail.com>
	<37D1ED5D-6FF5-4ABA-BD2A-222261BE1EAA@holtmann.org>
	<CAHkwNT=3m4nU5M_Kk5htfDonqPrKZO5vRR0q_8Mn2O=umGMK5Q@mail.gmail.com>
	<B4AA2825-8C58-46FB-A529-7CC910920500@holtmann.org>
	<CAHkwNT=Hoc4xibrtg2zk7K1vwcutcWgUHAN58XpWH0jnqfLXbg@mail.gmail.com>
Date: Sat, 3 Oct 2015 07:50:18 +0530
Message-ID: <CAHkwNTnSb4nuJ1dY371Zi007wH3_wGUQfKqevZaGkk9xRZUeNg@mail.gmail.com>
Subject: Re: Issues With USB Bluetooth Dongle
From: Anil Nair <anilcoll90@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,


>>>> Then again, you are running a 3.13 kernel, that is a pretty old kernel.
>>>
>>> You want me to try it with the latest stable release?
>>
>> That might actually help. Try to run a 4.2 kernel.

I tried the latest stable kernel 4.2, still the USB Bluetooth Dongle
does not seem to work.

Here is the dmesg output,

[  125.384033] usb 3-1: new full-speed USB device number 3 using uhci_hcd
[  125.624902] usb 3-1: New USB device found, idVendor=0a12, idProduct=0001
[  125.624909] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  125.624914] usb 3-1: Product: Bluetooth V2.0 Dongle
[  125.624919] usb 3-1: Manufacturer: Bluetooth v2.0
[  125.624928] device: '3-1': device_add
[  125.625001] bus: 'usb': add device 3-1
[  125.625019] PM: Adding info for usb:3-1
[  125.625102] bus: 'usb': driver_probe_device: matched device 3-1
with driver usb
[  125.625105] bus: 'usb': really_probe: probing driver usb with device 3-1
[  125.625111] usb 3-1: no default pinctrl state
[  125.627928] device: '3-1:1.0': device_add
[  125.627961] bus: 'usb': add device 3-1:1.0
[  125.627982] PM: Adding info for usb:3-1:1.0
[  125.628054] device: 'ep_81': device_add
[  125.628079] PM: Adding info for No Bus:ep_81
[  125.628082] device: 'ep_82': device_add
[  125.628102] PM: Adding info for No Bus:ep_82
[  125.628108] device: 'ep_02': device_add
[  125.628132] PM: Adding info for No Bus:ep_02
[  125.628135] device: '3-1:1.1': device_add
[  125.628147] bus: 'usb': add device 3-1:1.1
[  125.628157] PM: Adding info for usb:3-1:1.1
[  125.628176] device: 'ep_83': device_add
[  125.628200] PM: Adding info for No Bus:ep_83
[  125.628203] device: 'ep_03': device_add
[  125.628224] PM: Adding info for No Bus:ep_03
[  125.628226] device: '3-1:1.2': device_add
[  125.628240] bus: 'usb': add device 3-1:1.2
[  125.628250] PM: Adding info for usb:3-1:1.2
[  125.628265] device: 'ep_84': device_add
[  125.628287] PM: Adding info for No Bus:ep_84
[  125.628291] device: 'ep_04': device_add
[  125.628310] PM: Adding info for No Bus:ep_04
[  125.628313] device: '3-1:1.3': device_add
[  125.628324] bus: 'usb': add device 3-1:1.3
[  125.628336] PM: Adding info for usb:3-1:1.3
[  125.628352] driver: 'usb': driver_bound: bound to device '3-1'
[  125.628360] bus: 'usb': really_probe: bound device 3-1 to driver usb
[  125.628378] device: 'ep_00': device_add
[  125.628407] PM: Adding info for No Bus:ep_00
[  125.701507] bus: 'usb': add driver btusb
[  125.701535] bus: 'usb': driver_probe_device: matched device 3-1:1.0
with driver btusb
[  125.701538] bus: 'usb': really_probe: probing driver btusb with
device 3-1:1.0
[  125.701546] btusb 3-1:1.0: no default pinctrl state
[  125.701576] driver: 'btusb': driver_bound: bound to device '3-1:1.1'
[  125.701972] device: 'hci0': device_add
[  125.702012] PM: Adding info for No Bus:hci0
[  125.702035] device: 'rfkill0': device_add
[  125.702060] PM: Adding info for No Bus:rfkill0
[  125.702093] driver: 'btusb': driver_bound: bound to device '3-1:1.0'
[  125.702099] bus: 'usb': really_probe: bound device 3-1:1.0 to driver btusb
[  125.702106] bus: 'usb': driver_probe_device: matched device 3-1:1.2
with driver btusb
[  125.702108] bus: 'usb': really_probe: probing driver btusb with
device 3-1:1.2
[  125.702113] btusb 3-1:1.2: no default pinctrl state
[  125.702128] btusb: probe of 3-1:1.2 rejects match -19
[  125.702131] bus: 'usb': driver_probe_device: matched device 3-1:1.3
with driver btusb
[  125.702133] bus: 'usb': really_probe: probing driver btusb with
device 3-1:1.3
[  125.702136] btusb 3-1:1.3: no default pinctrl state
[  125.702143] btusb: probe of 3-1:1.3 rejects match -19
[  125.702170] usbcore: registered new interface driver btusb

--
Regards,
Anil Nair
