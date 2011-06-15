Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 15 Jun 2011 17:54:50 -0400
Message-ID: <BANLkTikWPUmqdZK=D-Q3UQqXWUFAo58F7w@mail.gmail.com>
Subject: Strange interference between HCI device and another USB device
From: =?ISO-8859-1?Q?Andr=E9?= <teste@cabine.org>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello.

I have a SCL3711 USB NFC adapter alongside a Broadcom Bluetooth USB
dongle. When I don't have the Bluetooth adapter connected everything
works fine while reading and writing to the SCL3711 USB device. As
soon as I connect the Bluetooth dongle and the HCI device is brought
up (by bluetoothd) I get strange results accessing the other USB
device (the SCL3711). Namely, writes only succeed half the time.

The writes that fail look like this:

ioctl(3, USBDEVFS_REAPURBNDELAY or USBDEVFS_REAPURBNDELAY32,
0xbfdddb8c) = -1 EAGAIN (Resource temporarily unavailable)
select(4, NULL, [3], NULL, {0, 1000})   = 0 (Timeout)
gettimeofday({1308174525, 865478}, NULL) = 0
ioctl(3, USBDEVFS_REAPURBNDELAY or USBDEVFS_REAPURBNDELAY32,
0xbfdddb8c) = -1 EAGAIN (Resource temporarily unavailable)
select(4, NULL, [3], NULL, {0, 1000})   = 0 (Timeout)
gettimeofday({1308174525, 866808}, NULL) = 0
ioctl(3, USBDEVFS_REAPURBNDELAY or USBDEVFS_REAPURBNDELAY32,
0xbfdddb8c) = -1 EAGAIN (Resource temporarily unavailable)
select(4, NULL, [3], NULL, {0, 1000})   = 0 (Timeout)
gettimeofday({1308174525, 868073}, NULL) = 0
ioctl(3, USBDEVFS_REAPURBNDELAY or USBDEVFS_REAPURBNDELAY32,
0xbfdddb8c) = -1 EAGAIN (Resource temporarily unavailable)
select(4, NULL, [3], NULL, {0, 1000})   = 0 (Timeout)

...

Even with 10s timeouts it fails. The strange thing is that if I
execute two bulkWrite()s in a row, with the same params, half of them
succeed:


gettimeofday({1308174626, 976740}, NULL) = 0
ioctl(3, USBDEVFS_REAPURBNDELAY or USBDEVFS_REAPURBNDELAY32,
0xbff3ce7c) = -1 EAGAIN (Resource temporarily unavailable)
select(4, NULL, [3], NULL, {0, 1000})   = 0 (Timeout)
gettimeofday({1308174626, 978439}, NULL) = 0
ioctl(3, USBDEVFS_REAPURBNDELAY or USBDEVFS_REAPURBNDELAY32,
0xbff3ce7c) = -1 EAGAIN (Resource temporarily unavailable)
select(4, NULL, [3], NULL, {0, 1000})   = 1 (out [3], left {0, 0})
gettimeofday({1308174626, 979862}, NULL) = 0
ioctl(3, USBDEVFS_REAPURBNDELAY or USBDEVFS_REAPURBNDELAY32, 0xbff3ce7c) = 0

If I bring down the hci0 interface, with a hciconfig hci0 down, as soon as the
ioctl(ctl, HCIDEVDOWN, hdev)
is executed, everything starts working correctly again...

I don't even know where to start with this. Is this bluez related? Any
help would be appreciated. I can provide further info if requested.

Best regards,
André
