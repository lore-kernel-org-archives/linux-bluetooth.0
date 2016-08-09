Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: btbcm issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANMsd01O4s=g-B3i+Z-w4LY52CzfOKhGPhfHxD29sVn0JR245A@mail.gmail.com>
Date: Tue, 9 Aug 2016 09:37:00 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Message-Id: <D33F5F42-68EC-4DCA-B4DB-E2A9F482629E@holtmann.org>
References: <CANMsd02AgbF75N9tHckym-vBWP5daFqVd363yaFRZM84vX4gQQ@mail.gmail.com> <69551ED2-6F91-4011-9F78-9AB21C27F596@holtmann.org> <CANMsd01O4s=g-B3i+Z-w4LY52CzfOKhGPhfHxD29sVn0JR245A@mail.gmail.com>
To: Ryan <ryanphilips19@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ryan,

> I wanted to check whats the best way of going about adding
> suspend-resume support for bcm bt chip
> 
> Should one have a separate driver
> (https://android.googlesource.com/kernel/bcm/+/3d6d35972004824a9111f13926bed2a4a495b668/drivers/misc/bcm-bt-lpm.c)
> 
> or should i use the existing hci_bcm.c driver & add dt support or use
> a platform device to pass the gpiod_desc for wakeup/sleep?

no separate driver please. As soon as btattach links the UART and we enable the device, everything should be done in background by the driver. The Broadcom LPM driver is just a hack for Android since they still haven't switched to using HCI User Channel for Android (like Intel for example).

In general DT and ACPI are the same. They describe the hardware and there are methods to read these descriptions from them and then use them. The only problem with DT was that Broadcom never got the definition acked by the DT maintainer. Otherwise all the functionality should be already in hci_bcm.c right now.

Regards

Marcel

