Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Feb 2012 17:35:04 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
To: Vikram Kandukuri <vkandukuri@atheros.com>,
	"Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: ath3k: asus bluetooth dongle won't work
Message-ID: <20120216173504.2571de22@s6510.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Running on Debian Wheezy (3.2.0-1-amd64), my new Asus bluetooth
dongle didn't work. Made sure and get the correct firmware, but
the driver does not load it correctly.

[    8.364186] Bluetooth: Can't change to loading configuration err
[    8.364263] ath3k: probe of 2-4.3:1.0 failed with error -110
[    8.364300] usbcore: registered new interface driver ath3k


This is from a cold (power off) boot, but it happens repeatedly.

Any idea what could be wrong?

lsusb
Bus 002 Device 005: ID 0cf3:3000 Atheros Communications, Inc. AR3011 Bluetooth (no firmware)
