Return-Path: <cyrus@holtmann.org>
From: Philipp Claves <claves@budelmann-elektronik.com>
To: linux-bluetooth@vger.kernel.org
Subject: Connecting to Bluetooth Low Energy devices
Date: Thu, 13 Sep 2012 17:34:38 +0200
Message-ID: <67399724.T38U7nJAul@arawn>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

Trying  to get started with Bluetooth Low Energy devices, i used hcitool and 
gatttool to enumerate device attributes, but did not get far:

# hcitool lescan
LE Scan ...
<MAC-Device1> Battery V1.0
<MAC-Device1> (unknown)
<MAC-Device2> Battery V1.0
<MAC-Device2> (unknown)
^C

# gatttool -b <MAC-Device1> -I
[   ][<MAC-Device1>][LE]> connect
Connecting... connect error: connect error: Connection refused (111)
[   ][<MAC-Device1>][LE]>

This is all i get.

The devices are Nordic Semiconductor nRF8001 based and currently run a simple 
BTLE demo application by Nordic Semiconductor. It does not use bind/paring but 
simple connect. Unfornately that doesn't seem to work.

The host uses an of-the-shelf USB Bluetooth 4.0 Stick with a Broadcom 
BCM20702A0 Chip inside.

Am i doing something obviously wrong?
Any tips where to get more information about the error (dmesg shows nothing)?

Regards
Philipp Claves

-- 
Budelmann Elektronik GmbH
Von-Renesse-Weg 60
48163 Münster
Germany

Tel.  +49 (0)2501 9208440
Fax   +49 (0)2501 5887024
claves@budelmann-elektronik.com
www.budelmann-elektronik.com
