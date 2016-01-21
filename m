Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <ext.szymon.janc@tieto.com>, Andrey Aleksandrovich <andrey.aleksandrovich@googlemail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: Possibly Bug in recent Bluez
Date: Thu, 21 Jan 2016 23:35:31 +0100
Message-ID: <1884606.eEbWMBAAXP@ix>
In-Reply-To: <88234527-FE7E-44D6-A57F-29927CBF6340@holtmann.org>
References: <CAPGkfYGEjsnkxJS7sM8JjUeZc0nHmsEb42ypx-Mc70+Z4bcvig@mail.gmail.com> <3174796.fSnHrpqxly@leonov> <88234527-FE7E-44D6-A57F-29927CBF6340@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thursday 21 January 2016 12:14:55 Marcel Holtmann wrote:
> Hi Szymon,
> 
> >>> Hi, I have Gentoo Linux, KDE on laptop with Bluetooth.
> >>> And I find out that it doesn't working after some time ago.
> >>> 
> >>> # dmesg | grep 4-1.5
> >>> [  475.204004] usb 4-1.5: New USB device found, idVendor=8086,
> >>> idProduct=0189 [  475.204014] usb 4-1.5: New USB device strings: Mfr=0,
> >>> Product=0, SerialNumber=0
> >>> 
> >>> # lsusb | grep 009
> >>> Bus 004 Device 009: ID 8086:0189 Intel Corp.
> >>> 
> >>> # cat /var/log/everything/current | grep bluetoothd
> >>> Jan 16 18:52:51 [bluetoothd] Bluetooth daemon 5.37
> >>> Jan 16 18:52:51 [bluetoothd] Starting SDP server
> >>> Jan 16 18:52:51 [bluetoothd] Bluetooth management interface 1.9
> >>> initialized
> >>> Jan 16 18:52:51 [bluetoothd] Failed to obtain handles for "Service
> >>> Changed" characteristic
> >>> Jan 16 18:52:51 [bluetoothd] Not enough free handles to register service
> >>> Jan 16 18:52:51 [bluetoothd] Error adding Link Loss service
> >>> Jan 16 18:52:51 [bluetoothd] Not enough free handles to register service
> >>> Jan 16 18:52:51 [bluetoothd] Current Time Service could not be
> >>> registered
> >>> Jan 16 18:52:51 [bluetoothd] gatt-time-server: Input/output error (5)
> >>> Jan 16 18:52:51 [bluetoothd] Not enough free handles to register service
> >>> Jan 16 18:52:51 [bluetoothd] Sap driver initialization failed.
> >>> Jan 16 18:52:51 [bluetoothd] sap-server: Operation not permitted (1)
> >> 
> >> At least sap-server plugin shouldn't be enabled at all (unless you run it
> >> on supported platform ie STE u8500, which you most likely don't). So
> >> this is a (quite common it seems) packaging bug.
> > 
> > Ahh, it looks like this is enabled by common 'experimental flag.
> 
> is anybody using this feature any more? Or can we just get rid of it?

I really have no idea. Only real SAP driver we have is for STE U8500 platform 
which is probably dead HW.  Nobody else ever tried to submit support for any 
other platform. Still SAP profile seems to be in use (there was 1.1.1 updated 
spec adopted on December 2015).


-- 
pozdrawiam
Szymon Janc
