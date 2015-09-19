Return-Path: <cyrus@holtmann.org>
From: Freek de Kruijf <f.de.kruijf@gmail.com>
To: Maillist Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Regularly command "hcitool scan" hangs
Date: Sat, 19 Sep 2015 10:55:47 +0200
Message-ID: <1940201.hRS2djRnA5@eik132.beelaertsict.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am regularly having trouble that an application is unable to connect to a 
nearby bluetooth device without an obvious reason. The connection is made each 
5 minutes. The distance is only 10 to 20 cm.

In order to make things work, I have a monitoring script that each 15 minutes 
does a "timeout -k 10s 1m hcitool scan". When it times out after 1 minute, 
which occurs a few times per day, the script reloads the driver and things are 
OK again.

The system is a Raspberry Pi 1B, with linux kernel 4.1.6, bluez-5.33-1.1, 
libbluetooth3-5.33-1.1, and bluez-firmware-1.2-148.1.

The bluetooth device is:
Bus 001 Device 004: ID 0cf3:3005 Atheros Communications, Inc. AR3011 Bluetooth

Should I use bluetoothctl? If so, where do I find comprehensive documentation 
on it?

-- 
fr.gr.

Freek de Kruijf

