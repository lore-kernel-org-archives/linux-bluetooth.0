Return-Path: <cyrus@holtmann.org>
Subject: Re: Renaming hci interfaces with udev
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrej Rosano <andrejro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090728083755.GA3292@stjenka>
References: <20090728083755.GA3292@stjenka>
Content-Type: text/plain
Date: Tue, 28 Jul 2009 13:31:35 +0200
Message-Id: <1248780695.28545.224.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrej,

> I would like to change the default name of bluetooth interfaces (hci0, hci1, ...)
> using udev rules.
> 
> While with wlan usb dongles it works with the line:
>     KERNEL=="wlan*", NAME="foo0"
> the analogous for the bt:
>     KERNEL=="hci*", NAME="foo0"
> doesn't work, while
>     KERNEL=="hci*", RUN+="/usr/bin/touch /tmp/foo"
> works.
> 
> I'm using kernel 2.6.30.1, udev 125 and bluez 4.46.

we don't support renaming HCI devices. However feel free to send a
kernel patch to enable it.

Regards

Marcel


