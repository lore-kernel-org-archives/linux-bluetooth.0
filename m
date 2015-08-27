Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Aug 2015 00:40:40 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Cc: kbuild-all@01.org, Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: [bluetooth:master 10/10] drivers/bluetooth/hci_intel.c:872:3-8: No
 need to set .owner here. The core will do it.
Message-ID: <201508280038.dKhX3DnU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   660f4b880ed6391e249e118537b2dc22f3ad1e2c
commit: 660f4b880ed6391e249e118537b2dc22f3ad1e2c [10/10] Bluetooth: hci_intel: Add support for platform driver


coccinelle warnings: (new ones prefixed by >>)

>> drivers/bluetooth/hci_intel.c:872:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
