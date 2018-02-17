Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Problem with re-loading hci_uart.ko on RPi3
Message-Id: <E4785C91-043A-4FF5-BFCA-5FADAFF81EE5@holtmann.org>
Date: Sat, 17 Feb 2018 22:09:48 +0100
Cc: mzoran@crowfest.net, Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

so with a 4.15 kernel, the Bluetooth chip on the RPi3 is fully supported via DT and serdev. The only problem still present is that when you rmmod hci_uart and then modprobe hci_uart again it will be stuck.

= New Index: 00:00:00:00:00:00 (Primary,UART,hci0)
= Open Index: 00:00:00:00:00:00
= Index Info: 00:00:00:00:00:00 (Broadcom Corporation)
< HCI Command: Broadcom Update UART Baud Rate (0x3f|0x0018) plen 6
        Encoded baud rate: Not used (0x0000)
        Explicit baud rate: 2000000 Mbps
< HCI Command: Reset (0x03|0x0003) plen 0
= Close Index: 00:00:00:00:00:00
= Delete Index: 00:00:00:00:00:00

Seems like something with the initial baud rate is wrong. When booting the hardware it is suppose to be set to 115200 Mbps, but it seems to be never reset after unloading the module. It stays at 2000000 Mbps. So when sending the Update UART Baud Rate initial command, it gets send at 115200 Mbps, but in reality the Bluetooth chip is still at 2000000 Mbps. So do we have to pull some reset GPIO to get this back into the original setting? Maybe this is just because the GPIOs are not yet exposed on the RPi3 as of now.

Is there any update to get the GPIO expander work upstream?

One option is of course to keep the max-speed in the DT at 115200 Mbps. It would work, but seriously slow down the transport. Maybe this should be done until we get access to the GPIOs.

Regards

Marcel

