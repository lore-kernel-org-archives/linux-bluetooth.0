Return-Path: <cyrus@holtmann.org>
Message-ID: <4F2A4A8C.1060106@exemail.com.au>
Date: Thu, 02 Feb 2012 19:34:20 +1100
From: Padfoot <padfoot@exemail.com.au>
Reply-To: padfoot@exemail.com.au
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [DEVICE SUPPORT] Atheros 0cf3:e019
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to find out the state of support in the linux bluetooth 
stack for devices reporting as Atheros VID 0cf3 PID e019.

I am using Arch Linux binary kernel 3.2.2 64 bit.

The device is recognised and appropriate modules loaded without error, 
yet trying to access bluetooth I am told no adapter is present.

Output of lsmod | grep ath
$ lsmod | grep ath
ath9k                  87343  0
ath9k_common            2096  1 ath9k
ath9k_hw              347282  2 ath9k_common,ath9k
ath                    14802  3 ath9k_hw,ath9k_common,ath9k
mac80211              228367  1 ath9k
cfg80211              172260  3 mac80211,ath,ath9k

Output of lsmod | grep bt
]$ lsmod | grep bt
btusb                  11385  1
bluetooth             151999  13 btusb,bnep,rfcomm
usbcore               146241  9 
ehci_hcd,ohci_hcd,usbhid,usb_storage,ums_realtek,uvcvideo,uas,btusb

Output of lsusb -v
Bus 005 Device 003: ID 0cf3:e019 Atheros Communications, Inc.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass          224 Wireless
   bDeviceSubClass         1 Radio Frequency
   bDeviceProtocol         1 Bluetooth
   bMaxPacketSize0        64
   idVendor           0x0cf3 Atheros Communications, Inc.
   idProduct          0xe019
   bcdDevice            0.01
   iManufacturer           0
   iProduct                0
   iSerial                 0
   bNumConfigurations      1

Thanks.
Lachlan.
