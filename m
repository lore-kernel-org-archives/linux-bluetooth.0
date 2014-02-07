Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 0/2] Add hci_smd driver
Date: Fri, 7 Feb 2014 12:35:35 +0100
Message-ID: <1391772937-12802-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

This is a try (long shoot) to upstream hci shared memory driver (hci_smd)
which is used on Qualcomm platforms and BT chips.

To make it build with upstream tree I had to introduce some simple SMD API.
The idea here is that since SMD channel is represented by platform device
(as it is done in mach-msm),
then platfrom_data contains smd_data which contains API for that channel.
 
Writing this SMD API I was inspired with MSM-SMD and since I'm not an expert 
in this area I'm asking for comments here.

Maybe instead of SMD API I made, I should expose functions like smd_open(), smd_write()
etc. something similar how sdio does, and  just deliver to upstream dummy device
implementing this SMD API?

Other options I was considering is to implement  module inside mach-msm which
would handle registering SMD BT Channels and when it is done, it would register 
new platform device like "smd-bt". Then I could move smd.h to some bluetooth includes
(althought don't now where at the moment) and hci_smd would register driver for "smd-bt"
In this case I would also could rid of one static variable I have now in hci_smd

Comments on those options are welcome.

Anyway, Hci_smd is based on one of the older version of this driver found in msm kernel
branch, so there are no wakelocks as in new version and also workqueues are used
instead of takslet.

Since SMD expose two channels, one for CMD/EVENT and one for ACL Data I decide to
do separate worqueues for this. This is to make sure that ACL data never blocks EVENT
packages

Lukasz Rymanowski (2):
  Add basic API for shared memory driver
  bluetooth: Add initial support for BT chip over SMD

 drivers/bluetooth/Kconfig   |   9 +
 drivers/bluetooth/Makefile  |   1 +
 drivers/bluetooth/hci_smd.c | 461 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/smd.h         |  68 +++++++
 include/net/bluetooth/hci.h |   1 +
 5 files changed, 540 insertions(+)
 create mode 100644 drivers/bluetooth/hci_smd.c
 create mode 100644 include/linux/smd.h

-- 
1.8.4

