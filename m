Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: add one more device to fixed Invalid initialization bug for kernel since 3.x
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1588358.UJXQXaaSbI@leonov>
Date: Wed, 13 May 2015 22:59:15 +0200
Cc: Aleksey <info@dv2c.ru>, linux-bluetooth@vger.kernel.org
Message-Id: <B6FB3590-0B82-4112-B1E8-1AA006CC4124@holtmann.org>
References: <1849903.jsc2NzCIHo@vwd-1> <1588358.UJXQXaaSbI@leonov>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>> In "Roper Class 1 Bluetooth Dongle" since 3.x kernel preset bug with invalid
>> device initialization.
>> 
>> In earlyer version
>> $> hciconfig hci0 up
>> Can't init device hci0: Connection timed out (110)
>> 
>> In new kernel
>> $> hciconfig hci0 up
>> Can't init device hci0: Invalid request code (56)
>> 
>> with my device
>> [    3.359071] usb 5-1: New USB device found, idVendor=1310, idProduct=0001
>> [    3.359075] usb 5-1: New USB device strings: Mfr=1, Product=2,
>> SerialNumber=3 [    3.359078] usb 5-1: Product: SiW
>> [    3.359080] usb 5-1: Manufacturer: SiW
>> [    3.359083] usb 5-1: SerialNumber: E7BB050D0B00
>> 
>> 
>> Full diskussion about that problem present in
>> https://bugzilla.kernel.org/show_bug.cgi?id=60901 "- [PATCH]Roper Class 1
>> Bluetooth Dongle / TRENDnet TBW-102UB not working with all kernel 3.x
>> tested"
>> 
>> After "Introducing HCI_QUIRK_BROKEN_LOCAL_COMMANDS constant" from Marcel
>> Holtmann that bug been proper fixed, but my "Silicon Wave based" device not
>> been included in list with BTUSB_SWAVE.
>> 
>> Don't know about other device - i have only one dongle with that problem,
>> but adding BTUSB_SWAVE to driver_info for my 0x1310, 0x0001 dongle full
>> fixed that problem, and now my device can bee in UP state..
>> 
>> More over, i check http://www.linux-usb.org/usb-ids.html and not find 1300
>> device - i find only "1310 Name: Roper"
>> 
>> I think, what used 0x1300 wrong and meant actually 0x1310
> 
> Checking http://www.linux-usb.org/usb.ids confirm that 0x1300 instead of 
> 0x1310 is a typo.

so I made a typo, then we just need a patch correcting this typo that also includes /sys/kernel/debug/usb/devices for this dongle to make sure this does not happen again.

Regards

Marcel

