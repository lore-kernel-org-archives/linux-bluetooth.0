Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: Missing vendor-specific ID for BCM20702A0
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAFd36Bj_SiUoeeu0h7kbEZnUx=6iXExCSTCvht_NLh4MY2-zSw@mail.gmail.com>
Date: Mon, 21 Jul 2014 13:03:18 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6DC4CADB-8928-48F8-82F7-662425143FB7@holtmann.org>
References: <CAFd36Bj_SiUoeeu0h7kbEZnUx=6iXExCSTCvht_NLh4MY2-zSw@mail.gmail.com>
To: Jerome Leclanche <jerome@leclan.ch>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerome,

> I have a Z97-DELUXE motherboard. This includes a BCM20702A0 bluetooth chip.
> In order to be able to use it, I have to do 'echo "0b05 17cf" >>
> /sys/bus/usb/drivers/btusb/new_id' every reboot, otherwise I don't
> have an hci0 available. Was told this would be the best place to
> report this to.
> 
> lsusb:
> Bus 001 Device 003: ID 0b05:17cf ASUSTek Computer, Inc.
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               2.00
>  bDeviceClass          255 Vendor Specific Class
>  bDeviceSubClass         1
>  bDeviceProtocol         1
>  bMaxPacketSize0        64
>  idVendor           0x0b05 ASUSTek Computer, Inc.
>  idProduct          0x17cf
>  bcdDevice            1.12
>  iManufacturer           1 Broadcom Corp
>  iProduct                2 BCM20702A0
>  iSerial                 3 54271E910064
>  bNumConfigurations      1
> 
> Note: Not subscribed, please CC.

actually the content of /sys/kernel/debug/usb/devices is a bit more helpful in determine what kind of entry needs to be added to the module list of btusb driver.

Regards

Marcel

