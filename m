Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Jerome Leclanche <jerome@leclan.ch>
Date: Mon, 21 Jul 2014 08:01:53 +0100
Message-ID: <CAFd36Bj_SiUoeeu0h7kbEZnUx=6iXExCSTCvht_NLh4MY2-zSw@mail.gmail.com>
Subject: Missing vendor-specific ID for BCM20702A0
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I have a Z97-DELUXE motherboard. This includes a BCM20702A0 bluetooth chip.
In order to be able to use it, I have to do 'echo "0b05 17cf" >>
/sys/bus/usb/drivers/btusb/new_id' every reboot, otherwise I don't
have an hci0 available. Was told this would be the best place to
report this to.

lsusb:
Bus 001 Device 003: ID 0b05:17cf ASUSTek Computer, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         1
  bDeviceProtocol         1
  bMaxPacketSize0        64
  idVendor           0x0b05 ASUSTek Computer, Inc.
  idProduct          0x17cf
  bcdDevice            1.12
  iManufacturer           1 Broadcom Corp
  iProduct                2 BCM20702A0
  iSerial                 3 54271E910064
  bNumConfigurations      1

Note: Not subscribed, please CC.

Thanks!

J. Leclanche
