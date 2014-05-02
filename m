Return-Path: <cyrus@holtmann.org>
Message-ID: <1399057367.24457.11.camel@SejoLaptop>
Subject: Re: Getting started with BLE device
From: Sejo Ruiz <sejoruiz@gmail.com>
To: Rick Mann <rmann@latencyzero.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 02 May 2014 21:02:47 +0200
In-Reply-To: <35E2DFE7-B463-4A15-8148-F7E30A201646@latencyzero.com>
References: <35E2DFE7-B463-4A15-8148-F7E30A201646@latencyzero.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rick.
First of all, you should make sure that the device is recognized as a BT
device. Run hciconfig as sudo user to see if it returns something as
hci0. If you can see it, then you can do hciconfig hci0 up to set up the
interface and start playing. If not, then you could try to do lsusb and
see what devices are connected to the USB. If you cannot see your device
there, or something goes wrong, you can always try to check what is
going on by plugging the device off and on again and then type dmesg |
tail. Finally, make sure the bluetooth daemon is running. You can do
that by executing /etc/init.d/bluetoothd status (I'm not sure about this
last one)
NOTE: I suggest to execute all the commands with sudo.

