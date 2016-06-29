Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 29 Jun 2016 14:33:10 +0200
From: Arthur LAMBERT <lambertarthur22@gmail.com>
To: Tobias Svehagen <tobias.svehagen@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: gatt server and reset of hci device
Message-ID: <20160629123310.GA11250@arthur-bzh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> What version of bluez are you using?

5.37 & 5.39 & 5.40. Same result for all these versions.

> Yes you can also look at tools/gatt-service.c for a C example of using
> the GATT dbus API.

Ok thanks. I will check that.

> Can you run 'bluetoothd -nE -d src/gatt-database.c'. Do you see
> something like 'GATT Manager registered for adapter: /org/bluez/hci0'?

[arthur ] sudo ./bluetoothd -nE -d src/gatt-database.
[sudo] password for arthur: 
bluetoothd[9754]: Bluetooth daemon 5.39
bluetoothd[9754]: Unknown key PageTimeout in main.conf
bluetoothd[9754]: Unknown key InitiallyPowered in main.conf
bluetoothd[9754]: Unknown key RememberPowered in main.conf
bluetoothd[9754]: Unknown key EnableGatt in main.conf
bluetoothd[9754]: Starting SDP server
bluetoothd[9754]: Bluetooth management interface 1.4 initialized
bluetoothd[9754]: Failed to obtain handles for "Service Changed" characteristic
bluetoothd[9754]: Failed to read advertising features: Unknown Command (0x01)
bluetoothd[9754]: hci0 Load Connection Parameters failed: Unknown Command (0x01)

I replace the main.conf from source in /etc and retry the test :

[arthur ] sudo ./bluetoothd -nE -d src/gatt-database.
bluetoothd[11131]: Bluetooth daemon 5.39
bluetoothd[11131]: Starting SDP server
bluetoothd[11131]: Bluetooth management interface 1.4 initialized
bluetoothd[11131]: Failed to obtain handles for "Service Changed" characteristic
bluetoothd[11131]: Failed to read advertising features: Unknown Command (0x01)
bluetoothd[11131]: hci0 Load Connection Parameters failed: Unknown Command (0x01)

This test is running on ubuntu 14.04. We stop bluetooth service before starting bluetoothd.
We also run the test on arm target but without trouble this time.

Arthur.
