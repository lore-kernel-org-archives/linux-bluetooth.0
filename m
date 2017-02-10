Return-Path: <haagch@frickel.club>
From: Christoph Haag <haagch@frickel.club>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Subject: Re: [PATCH] Bluetooth: btusb: add support for 0bb4:0306
Date: Fri, 10 Feb 2017 13:02:29 +0100
Message-Id: <20170210120230.17259-1-haagch@frickel.club>
In-Reply-To: <04A5C1B8-16D8-4146-8A3E-7DCBA0FDB7CB@holtmann.org>
References: <04A5C1B8-16D8-4146-8A3E-7DCBA0FDB7CB@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


Thanks,
I wasn't aware of this because I know next to nothing about the bluetooth stack.

Also it didn't work right.
With this new patch I can actually pair and use gatttool,
and lsusb says says BCM920703 now in lsusb.

dmesg says

Bluetooth: hci0: BCM: chip id 102
Bluetooth: hci0: c-l
Bluetooth: hci0: BCM (001.001.005) build 0000
Bluetooth: hci0: BCM (001.001.005) build 0481
Bluetooth: hci0: BCM20703A1 Generic USB 20Mhz fcbga_BU
