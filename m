Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/5] Bluetooth LE 6LoWPAN using CoC
Date: Mon,  2 Jun 2014 13:08:19 +0300
Message-Id: <1401703704-22451-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

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


Jukka Rissanen (5):
  Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
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
 net/bluetooth/l2cap_core.c       | 101 ++---
 net/bluetooth/l2cap_sock.c       |  14 +-
 12 files changed, 715 insertions(+), 361 deletions(-)
 delete mode 100644 net/bluetooth/6lowpan.h

-- 
1.8.3.1

