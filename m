Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jul 2009 10:37:55 +0200
From: Andrej Rosano <andrejro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Renaming hci interfaces with udev
Message-ID: <20090728083755.GA3292@stjenka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I would like to change the default name of bluetooth interfaces (hci0, hci1, ...)
using udev rules.

While with wlan usb dongles it works with the line:
    KERNEL=="wlan*", NAME="foo0"
the analogous for the bt:
    KERNEL=="hci*", NAME="foo0"
doesn't work, while
    KERNEL=="hci*", RUN+="/usr/bin/touch /tmp/foo"
works.

I'm using kernel 2.6.30.1, udev 125 and bluez 4.46.

Regards,
Andrej

-- 
Andrej Rosano                                               <andrejro@gmail.com>
0x7B470744                    E5DF 7810 AD63 A215 2D0E  AF56 53C7 A2CB 7B47 0744
