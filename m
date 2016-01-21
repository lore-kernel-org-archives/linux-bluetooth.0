Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: Possibly Bug in recent Bluez
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3174796.fSnHrpqxly@leonov>
Date: Thu, 21 Jan 2016 12:14:55 +0100
Cc: Andrey Aleksandrovich <andrey.aleksandrovich@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <88234527-FE7E-44D6-A57F-29927CBF6340@holtmann.org>
References: <CAPGkfYGEjsnkxJS7sM8JjUeZc0nHmsEb42ypx-Mc70+Z4bcvig@mail.gmail.com> <1557825.6tL2oa3vnP@leonov> <3174796.fSnHrpqxly@leonov>
To: Szymon Janc <ext.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> Hi, I have Gentoo Linux, KDE on laptop with Bluetooth.
>>> And I find out that it doesn't working after some time ago.
>>> 
>>> # dmesg | grep 4-1.5
>>> [  475.204004] usb 4-1.5: New USB device found, idVendor=8086,
>>> idProduct=0189 [  475.204014] usb 4-1.5: New USB device strings: Mfr=0,
>>> Product=0, SerialNumber=0
>>> 
>>> # lsusb | grep 009
>>> Bus 004 Device 009: ID 8086:0189 Intel Corp.
>>> 
>>> # cat /var/log/everything/current | grep bluetoothd
>>> Jan 16 18:52:51 [bluetoothd] Bluetooth daemon 5.37
>>> Jan 16 18:52:51 [bluetoothd] Starting SDP server
>>> Jan 16 18:52:51 [bluetoothd] Bluetooth management interface 1.9
>>> initialized
>>> Jan 16 18:52:51 [bluetoothd] Failed to obtain handles for "Service
>>> Changed" characteristic
>>> Jan 16 18:52:51 [bluetoothd] Not enough free handles to register service
>>> Jan 16 18:52:51 [bluetoothd] Error adding Link Loss service
>>> Jan 16 18:52:51 [bluetoothd] Not enough free handles to register service
>>> Jan 16 18:52:51 [bluetoothd] Current Time Service could not be registered
>>> Jan 16 18:52:51 [bluetoothd] gatt-time-server: Input/output error (5)
>>> Jan 16 18:52:51 [bluetoothd] Not enough free handles to register service
>>> Jan 16 18:52:51 [bluetoothd] Sap driver initialization failed.
>>> Jan 16 18:52:51 [bluetoothd] sap-server: Operation not permitted (1)
>> 
>> At least sap-server plugin shouldn't be enabled at all (unless you run it on
>> supported platform ie STE u8500, which you most likely don't). So this is a
>> (quite common it seems) packaging bug.
> 
> Ahh, it looks like this is enabled by common 'experimental flag.

is anybody using this feature any more? Or can we just get rid of it?

Regards

Marcel

