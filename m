Return-Path: <cyrus@holtmann.org>
From: Freek de Kruijf <f.de.kruijf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Problem with bluetooth device Broadcom Corp. BCM20702A0
Date: Mon, 30 Mar 2015 18:03:13 +0200
Message-ID: <13869276.gxvsrOEmG3@eik132.beelaertsict.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I have a Bluetooth dongle in a Raspberry Pi which identifies itself via lsusb 
as: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0

This device is used in a Rapberry Pi and uses bluez-5.23-1.2

After some days working OK. It suddenly does not work anymore. A command 
"hcitool scan" hangs and produces only lines showing "scanning...". It even 
blocks and hangs the system. Putting "timeout -k 10s 1m" in front of that 
command makes the system to continue. The command "hciconfig hci0 down" seems 
to work. At least the device status is down. However "hciconfig hci0 up" does 
not bring the device up. I tried "modprobe -f btusb" and after that "hciconfig 
hci0 up" and the device status became up and the device did work again.

Any suggestion?

-- 
fr.gr.

Freek de Kruijf

