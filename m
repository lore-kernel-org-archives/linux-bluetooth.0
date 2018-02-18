Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1941091231.91372.1518962068876@email.1und1.de>
Date: Sun, 18 Feb 2018 20:07:37 +0100
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>, mzoran@crowfest.net
Message-Id: <414BD031-1C2F-4E27-BBB4-BEB9F71B099F@holtmann.org>
References: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
 <1941091231.91372.1518962068876@email.1und1.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

>> so with a 4.15 kernel, the Bluetooth chip on the RPi3 is fully supported via DT and serdev. The only problem still present is that when you rmmod hci_uart and then modprobe hci_uart again it will be stuck.
>> 
>> = New Index: 00:00:00:00:00:00 (Primary,UART,hci0)
>> = Open Index: 00:00:00:00:00:00
>> = Index Info: 00:00:00:00:00:00 (Broadcom Corporation)
>> < HCI Command: Broadcom Update UART Baud Rate (0x3f|0x0018) plen 6
>>        Encoded baud rate: Not used (0x0000)
>>        Explicit baud rate: 2000000 Mbps
>> < HCI Command: Reset (0x03|0x0003) plen 0
>> = Close Index: 00:00:00:00:00:00
>> = Delete Index: 00:00:00:00:00:00
>> 
>> Seems like something with the initial baud rate is wrong. When booting the hardware it is suppose to be set to 115200 Mbps, but it seems to be never reset after unloading the module. It stays at 2000000 Mbps. So when sending the Update UART Baud Rate initial command, it gets send at 115200 Mbps, but in reality the Bluetooth chip is still at 2000000 Mbps. So do we have to pull some reset GPIO to get this back into the original setting? Maybe this is just because the GPIOs are not yet exposed on the RPi3 as of now.
> 
> The datasheet says the default baudrate is at 115.200 Kbaud, but it also support automatic baudrate detection. So a reset via GPIO should enforce this baudrate.

the only thing I wonder is if the BT_ON GPIO will full hard reset the device so that it needs the firmware again or just soft reset it. But unless we have that GPIO exposed, it is hard to tell.

>> Is there any update to get the GPIO expander work upstream?
> 
> The latest version of the GPIO expander patch series is here [1]. Unfortunately not merged yet.

Is there any feedback on it. Looks super straight forward to me.

> I plan to provide bluetooth support for RPi Zero W. Is there anything missing from driver side?

I think just the DT part fo the RPi Zero W should be missing. However it seems when adding Apple support, we broke the RPi support. I have a patch for it that will make it work again. Not having the “shutdown” and “device-wakeup” GPIOs makes it fail the resource setup. So when you test the DT changes, test them with a 4.15 kernel and not 4.16-rc1.

>> One option is of course to keep the max-speed in the DT at 115200 Mbps. It would work, but seriously slow down the transport. Maybe this should be done until we get access to the GPIOs.

So I am convinced when we run on hardware that has no GPIO resources exposed (as it is with RPi right now), we should limit the operational speed to the initialization speed. And then my problem actually goes away. It also forces people to get the GPIOs exposed or they have to stick with a slower HCI transport.

Regards

Marcel

