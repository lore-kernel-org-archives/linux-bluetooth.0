Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: daemon errors during boot
Message-ID: <312a6d3c-0fe4-31f8-2f57-5e98eb580a14@gmail.com>
Date: Mon, 13 Jun 2016 06:10:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
on Debian Jessie running on RPi3 I get these errors during boot:

> daemon.info bluetoothd[583]: Bluetooth management interface 1.10 initialized
> daemon.err bluetoothd[583]: Failed to obtain handles for "Service Changed" characteristic
> daemon.err bluetoothd[583]: Not enough free handles to register service
> daemon.err bluetoothd[583]: Error adding Link Loss service
> daemon.err bluetoothd[583]: Not enough free handles to register service
> daemon.err bluetoothd[583]: Not enough free handles to register service
> daemon.err bluetoothd[583]: Not enough free handles to register service
> daemon.err bluetoothd[583]: Current Time Service could not be registered
> daemon.err bluetoothd[583]: gatt-time-server: Input/output error (5)
> daemon.err bluetoothd[583]: Not enough free handles to register service
> daemon.err bluetoothd[583]: Not enough free handles to register service

Would you help me to understand what's happening?
Of course, feel free to ask anything could be useful to investigate 
further. I don't know what other info you might need.

Thanks!

