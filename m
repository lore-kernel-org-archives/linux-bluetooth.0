Return-Path: <cyrus@holtmann.org>
Subject: omnibook module loads but still can't use bluetooth device
From: Renato Budinich <rennabh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain
Date: Wed, 17 Jun 2009 23:29:54 +0200
Message-Id: <1245274194.3925.13.camel@renato-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello, I hope this is the correct place to ask, otherwise please kindly
point me to a more appropriate place.
I have a Toshiba Satellite A200 with Phoenix Bios and thus can have
bluetooth only thanks to the omnibook module. I am running Ubuntu Jaunty
9.04; all was working fine till I built my own 2.6.30 kernel (needed
some drivers). I recompiled the omnibook module (btw, had to apply this
patch
http://sourceforge.net/tracker/index.php?func=detail&aid=2794118&group_id=174260&atid=868542 to make it compile )
Now the module seams to load correctly, bluetooth appears turned on but
i still get no devices from hcitool. Here are some ouputs



renato@renato-laptop:/proc/omnibook$ cat dmi
BIOS Vendor:   TOSHIBA
BIOS Version:  V1.70
BIOS Release:  09/27/2007
System Vendor: TOSHIBA
Product Name:  Satellite A200
Version:       PSAE6E-05W032IT
Serial Number: X7386950K
Board Vendor:  TOSHIBA
Board Name:    1.00

renato@renato-laptop:/proc/omnibook$ cat bluetooth 
Bluetooth adapter is present and enabled.

renato@renato-laptop:/proc/omnibook$ sudo hcitool dev
Devices:

renato@renato-laptop:/proc/omnibook$ sudo hcitool scan
Device is not available: No such device

renato@renato-laptop:/proc/omnibook$ lsusb
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 002: ID 0930:0508 Toshiba Corp. Integrated Bluetooth HCI
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 04f2:b008 Chicony Electronics Co., Ltd 
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

renato@renato-laptop:/proc/omnibook$ sudo lshw -C communication
  *-usb UNCLAIMED         
       description: Bluetooth wireless interface
       product: Integrated Bluetooth HCI
       vendor: Toshiba Corp.
       physical id: 2
       bus info: usb@3:2
       version: 19.15
       capabilities: bluetooth usb-2.00
       configuration: speed=12.0MB/s

could the above "UNCLAIMED" be part of the problem?
thank you
Renato

