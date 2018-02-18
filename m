Return-Path: <stefan.wahren@i2se.com>
Date: Sun, 18 Feb 2018 14:54:28 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc: Eric Anholt <eric@anholt.net>, mzoran@crowfest.net
Message-ID: <1941091231.91372.1518962068876@email.1und1.de>
In-Reply-To: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
References: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
Subject: Re: Problem with re-loading hci_uart.ko on RPi3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Marcel Holtmann <marcel@holtmann.org> hat am 17. Februar 2018 um 22:09 geschrieben:
> 
> 
> Hi,
> 
> so with a 4.15 kernel, the Bluetooth chip on the RPi3 is fully supported via DT and serdev. The only problem still present is that when you rmmod hci_uart and then modprobe hci_uart again it will be stuck.
> 
> = New Index: 00:00:00:00:00:00 (Primary,UART,hci0)
> = Open Index: 00:00:00:00:00:00
> = Index Info: 00:00:00:00:00:00 (Broadcom Corporation)
> < HCI Command: Broadcom Update UART Baud Rate (0x3f|0x0018) plen 6
>         Encoded baud rate: Not used (0x0000)
>         Explicit baud rate: 2000000 Mbps
> < HCI Command: Reset (0x03|0x0003) plen 0
> = Close Index: 00:00:00:00:00:00
> = Delete Index: 00:00:00:00:00:00
> 
> Seems like something with the initial baud rate is wrong. When booting the hardware it is suppose to be set to 115200 Mbps, but it seems to be never reset after unloading the module. It stays at 2000000 Mbps. So when sending the Update UART Baud Rate initial command, it gets send at 115200 Mbps, but in reality the Bluetooth chip is still at 2000000 Mbps. So do we have to pull some reset GPIO to get this back into the original setting? Maybe this is just because the GPIOs are not yet exposed on the RPi3 as of now.

The datasheet says the default baudrate is at 115.200 Kbaud, but it also support automatic baudrate detection. So a reset via GPIO should enforce this baudrate.

> 
> Is there any update to get the GPIO expander work upstream?

The latest version of the GPIO expander patch series is here [1]. Unfortunately not merged yet.

I plan to provide bluetooth support for RPi Zero W. Is there anything missing from driver side?

Stefan

[1] - http://lists.infradead.org/pipermail/linux-rpi-kernel/2018-January/007397.html

> 
> One option is of course to keep the max-speed in the DT at 115200 Mbps. It would work, but seriously slow down the transport. Maybe this should be done until we get access to the GPIOs.
> 
> Regards
> 
> Marcel
>
