Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 0/4] Bluetooth LE 6LoWPAN using CoC
Date: Fri, 13 Jun 2014 15:53:29 +0300
Message-Id: <1402664013-29358-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v6:
- rebased on top of Marcel's "Bluetooth: Provide L2CAP ops callback
  for memcpy_fromiovec" patch
- re-wrote the debugfs psm value handler using DEFINE_SIMPLE_ATTRIBUTE
- renamed and refactored the module init/exit functions, also checked
  that debugfs_remove() will gracefully accept NULL values
- added comment to disconnect_devices() why we have two separate
  lists

v5:
- memory buffer made const in patch 1
- misc changes and refactoring in patch 2

v4:
- renamed l2cap_from_skbuf() to more logical l2cap_copy_into_skbuff()
  in l2cap_core.c (patch 1)
- fixed the module usage count code in patch 4

Usage:

In the slave side do this:

$ modprobe bluetooth_6lowpan
$ echo 62 > /sys/kernel/debug/bluetooth/6lowpan_psm
$ hciconfig hci0 leadv

In the master side do this:

$ modprobe bluetooth_6lowpan
$ echo 62 > /sys/kernel/debug/bluetooth/6lowpan_psm
$ echo 'connect E0:06:E6:B7:2A:73 1' > \
                  /sys/kernel/debug/bluetooth/6lowpan_control


Cheers,
Jukka


Jukka Rissanen (4):
  Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed
    one
  Bluetooth: 6LoWPAN: Create a kernel module
  Bluetooth: 6LoWPAN: Count module usage
  Bluetooth: 6LoWPAN: Remove network devices when unloading

 include/net/bluetooth/hci.h      |   1 -
 include/net/bluetooth/hci_core.h |   1 -
 include/net/bluetooth/l2cap.h    |   1 -
 net/bluetooth/6lowpan.c          | 826 +++++++++++++++++++++++++++++----------
 net/bluetooth/6lowpan.h          |  47 ---
 net/bluetooth/Kconfig            |   6 +-
 net/bluetooth/Makefile           |   4 +-
 net/bluetooth/hci_core.c         |  45 ---
 net/bluetooth/hci_event.c        |   3 -
 net/bluetooth/l2cap_core.c       |  20 +-
 10 files changed, 636 insertions(+), 318 deletions(-)
 delete mode 100644 net/bluetooth/6lowpan.h

-- 
1.8.3.1

