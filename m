Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 6 Oct 2014 17:53:04 +0530
Message-ID: <CAG0bkvKYd23+HmHBf+xQOVd9MQ72y1QVysAFbU9A-LoPmnQ2SA@mail.gmail.com>
Subject: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: linux-usb@vger.kernel.org
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using  “3.1.0-7.fc16.x86_64” kernel and testing eight USB
Bluetooth dongles using btusb.ko module.


Once I power-on the system and loading the btusb.ko driver immediately
results the below mentioned errors:

[ 1389.410907] hci3 urb ffff88012954dd80 status -32 count 0

[ 1389.411367] hci4 urb ffff88012954d3c0 status -32 count 0

[ 1389.411845] hci1 urb ffff88012b4b6b40 status -32 count 0

[ 1389.412238] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 1518.647255] hci3 urb ffff88012954dd80 status -32 count 0

[ 1518.647722] hci4 urb ffff88012954d3c0 status -32 count 0

[ 1518.648120] hci1 urb ffff88012b4b6b40 status -32 count 0

[ 1518.648514] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 1518.722033] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 2191.964545] hci4 urb ffff88012954d3c0 status -32 count 0

[ 2191.965001] hci1 urb ffff88012b4b6b40 status -32 count 0

[ 2191.965396] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 2191.966530] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 2191.975514] hci4 urb ffff88012954d3c0 status -32 count 0

[ 2191.975936] hci1 urb ffff88012b4b6b40 status -32 count 0

[ 2191.976330] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 2191.977503] hci4 urb ffff88012954d3c0 status -32 count 0

[ 2191.977929] hci1 urb ffff88012b4b6b40 status -32 count 0

[ 2191.978325] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 2560.132682] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 2569.160895] hci4 urb ffff88012954d3c0 status -32 count 0

[ 2569.161367] hci1 urb ffff88012b4b6b40 status -32 count 0

[ 2569.161827] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 3022.252541] hci2 urb ffff8801347ee0c0 status -32 count 0

[ 3022.254504] hci2 urb ffff8801347ee0c0 status -32 count 0


These errors will repeat until sending a proper HCI command on the USB
bus. Again after some time duration same error will repeats.

The error -32(-EPIPE) says , Endpoint stalled.  For non-control
endpoints, reset this status with usb_clear_halt().

But I don’t see the error(-EPIPE) handling code in btusb module. Does
anyone has the patch for this scenario?

Thanks,
Naveen
