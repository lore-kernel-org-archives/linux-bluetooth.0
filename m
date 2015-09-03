Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Kyle Shneider' <shneiderkyle@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <CAMib2GaN7TnW1dJEgzNH7FzGrt2a_39sEzu4cwVzmi85XK5OWA@mail.gmail.com>
In-reply-to: <CAMib2GaN7TnW1dJEgzNH7FzGrt2a_39sEzu4cwVzmi85XK5OWA@mail.gmail.com>
Subject: RE: GattManager1 interface not found
Date: Thu, 03 Sep 2015 11:14:21 +0530
Message-id: <001301d0e60b$9607b2a0$c21717e0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kyle,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Kyle Shneider
> Sent: Wednesday, September 02, 2015 10:05 PM
> To: linux-bluetooth@vger.kernel.org
> Subject: GattManager1 interface not found
> 
> Hello.
> I'm trying to launch bluez v5.33 on Raspbian and Ubuntu 14.
> bluez-5.33/test/example-gatt-server gives me "GattManager1 interface not
> found".
> 
> bluetooth daemon output is:
> 
> root@raspberrypi:/home/pi# bluetoothd -n
> bluetoothd[2531]: Bluetooth daemon 5.33
> bluetoothd[2531]: Starting SDP server
> bluetoothd[2531]: Bluetooth management interface 1.7 initialized
> bluetoothd[2531]: Failed to obtain handles for "Service Changed"
> characteristic
> bluetoothd[2531]: Not enough free handles to register service
> bluetoothd[2531]: Error adding Link Loss service
> bluetoothd[2531]: Not enough free handles to register service
> bluetoothd[2531]: Not enough free handles to register service
> bluetoothd[2531]: Not enough free handles to register service
> bluetoothd[2531]: Current Time Service could not be registered
> bluetoothd[2531]: gatt-time-server: Input/output error (5)
> bluetoothd[2531]: Not enough free handles to register service
> bluetoothd[2531]: Not enough free handles to register service
> bluetoothd[2531]: Sap driver initialization failed.
> bluetoothd[2531]: sap-server: Operation not permitted (1)
> 
> 
> My BLE adapter is Cambridge Silicon Radio, Ltd Bluetooth Dongle.
> 
> I saw the same problem here
> http://marc.info/?l=linux-bluetooth&m=142956894520217&w=2
> but no clear answer. Author adviced to use bluez d-bus api, but (as i
> know) org.bluez can't be registered without daemon.
> Is there any progress on this problem?
> Or should i use earlier version of bluez for creating gatt server/client?
> 
> 

Since this is under experimental, you have to enable the experimental flag as below
root@raspberrypi:/home/pi# bluetoothd -nE

> --
> Kyle Shneider
> --

Regards,
Gowtham Anandha Babu

