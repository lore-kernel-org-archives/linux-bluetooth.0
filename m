Return-Path: <jt@bougret.hpl.hp.com>
Date: Thu, 12 Aug 2004 17:25:14 -0700
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
Subject: CSR firmware question...
Message-ID: <20040813002514.GA21388@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

	Hi guys,

	A few questions regarding CSR firmware : what's a commonly
available BT USB dongle with a recent CSR firmware.

	Long story :
	I'm hitting various bugs with the CSR firmware in my D-Link
USB dongles (0x1bb), where I can easilly deadlock the dongle. My 3Com
dongle, which has a more recent firmware (0x20e), behave much better,
but not perfect.
	D-Link doesn't provide a firmware updater, but, beeing
fearless, I tried to firmware upgrade a D-Link dongle and ended up
with a dead dongle (can't even put back the original firmware on it).
	From the release notes, the latest CSR firmwares have zillions
of bug fixes. I really wonder how I can enjoy the bug fixes.

	Thanks in advance...

	Jean

P.S. : Marcel, do you have a version of btdfu that can write the
firmware image to the dongle ? Or some documentation ?
