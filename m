Return-Path: <cyrus@holtmann.org>
Message-ID: <48D16DA5.4070207@optaros.com>
Date: Wed, 17 Sep 2008 15:50:45 -0500
From: Bobby Beckmann <bobby@optaros.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Getting the driver to recognize my bluetooth device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm trying to get my laptop's bluetooth chip to be recognized by the 
driver. I have a Dell Latitude E6500 running 2.6.27-rc6. From lsusb, I 
get this output:

Bus 003 Device 002: ID 0a5c:4500 Broadcom Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0         8
  idVendor           0x0a5c Broadcom Corp.
  idProduct          0x4500
  bcdDevice            1.00
  iManufacturer           1 Broadcom
  iProduct                2 BCM2046B1



Now, the device is reporting that it's a hub, but the product is most 
certainly a bluetooth chip from Broadcom. I tried adding the 0a5c:4500 
to the btusb driver, but the driver didn't seem to try to initialize the 
device. Does anyone have any ideas on what I could do to debug this?

Thanks for your help,
Bobby
