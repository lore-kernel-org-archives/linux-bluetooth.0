Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 0/5] Bluetooth LE 6LoWPAN using CoC
Date: Wed, 18 Jun 2014 16:16:21 +0300
Message-Id: <1403097386-27919-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v7:
- patch 1 is originally from Marcel but with slight modifications
  that avoid the sparse error by using kvec instead of iovec in
  kernel's memcpy path. I tested this with 6lowpan and also using
  L2CAP user sockets.
- avoid chan_ops forward declaration
- this version did not change the GFP_ATOMIC in alloc_skb cb as it
  is needed because the alloc function is called in atomic context
- also no need to ref skb because the caller will wait until we
  are finished
- various chan ref issues fixed

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


Jukka Rissanen (5):
  Bluetooth: Provide L2CAP ops callback for memcpy_fromiovec
  Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed
    one
  Bluetooth: 6LoWPAN: Create a kernel module
  Bluetooth: 6LoWPAN: Count module usage
  Bluetooth: 6LoWPAN: Remove network devices when unloading

 include/net/bluetooth/hci.h      |   1 -
 include/net/bluetooth/hci_core.h |   1 -
 include/net/bluetooth/l2cap.h    |  30 +-
 net/bluetooth/6lowpan.c          | 857 +++++++++++++++++++++++++++++----------
 net/bluetooth/6lowpan.h          |  47 ---
 net/bluetooth/Kconfig            |   6 +-
 net/bluetooth/Makefile           |   4 +-
 net/bluetooth/a2mp.c             |   1 +
 net/bluetooth/hci_core.c         |  45 --
 net/bluetooth/hci_event.c        |   3 -
 net/bluetooth/l2cap_core.c       |  26 +-
 net/bluetooth/l2cap_sock.c       |  34 +-
 12 files changed, 718 insertions(+), 337 deletions(-)
 delete mode 100644 net/bluetooth/6lowpan.h

-- 
1.8.3.1

