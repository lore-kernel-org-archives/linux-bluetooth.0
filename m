Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/6] Bluetooth LE 6LoWPAN using CoC
Date: Wed, 28 May 2014 14:43:02 +0300
Message-Id: <1401277388-4611-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this v3 patchset fixes the issues found in v2.

I removed the hci callback patches from v2 as they we no
longer needed after refactoring the code a bit.

The patch that fixes MAC address U/L bit handling was sent earlier
and is required by these patches.

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


Jukka Rissanen (6):
  Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
  Bluetooth: l2cap: Set more channel defaults
  Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed
    one
  Bluetooth: 6LoWPAN: Create a kernel module
  Bluetooth: 6LoWPAN: Count module usage
  Bluetooth: 6LoWPAN: Remove network devices when unloading

 include/net/bluetooth/hci.h      |   1 -
 include/net/bluetooth/hci_core.h |   1 -
 include/net/bluetooth/l2cap.h    |   5 +-
 net/bluetooth/6lowpan.c          | 837 ++++++++++++++++++++++++++++++---------
 net/bluetooth/6lowpan.h          |  47 ---
 net/bluetooth/Kconfig            |   6 +-
 net/bluetooth/Makefile           |   4 +-
 net/bluetooth/a2mp.c             |  12 +-
 net/bluetooth/hci_core.c         |  45 ---
 net/bluetooth/hci_event.c        |   3 -
 net/bluetooth/l2cap_core.c       | 107 ++---
 net/bluetooth/l2cap_sock.c       |  14 +-
 12 files changed, 721 insertions(+), 361 deletions(-)
 delete mode 100644 net/bluetooth/6lowpan.h

-- 
1.8.3.1

