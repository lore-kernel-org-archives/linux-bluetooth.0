Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth LE 6LoWPAN using CoC
Date: Mon,  5 May 2014 12:31:22 +0300
Message-Id: <1399282285-32743-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

here is first version of BT LE 6LoWPAN functionality but using
connection oriented channels instead of fixed channel one.

At the moment, the initial configuration needs to be done manually.
So in the slave device say:
# echo node > /sys/kernel/debug/bluetooth/hci0/6lowpan_role
# echo Y > /sys/kernel/debug/bluetooth/hci0/6lowpan
# hciconfig hci0 leadv

And in the master device say:
# echo Y > /sys/kernel/debug/bluetooth/hci0/6lowpan
# hcitool lecc <slave-addr>


Cheers,
Jukka


Jukka Rissanen (3):
  Bluetooth: Refactor l2cap_sock_sendmsg() to copy user buffer
  Bluetooth: 6LoWPAN: Allow user to set the device role via sysfs
  Bluetooth: 6LoWPAN: Use connected oriented channel instead of fixed
    one

 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |   1 +
 include/net/bluetooth/l2cap.h    |   3 +-
 net/bluetooth/6lowpan.c          | 470 ++++++++++++++++++++++++---------------
 net/bluetooth/6lowpan.h          |  19 +-
 net/bluetooth/hci_core.c         |  53 +++++
 net/bluetooth/hci_event.c        |   3 +
 net/bluetooth/l2cap_core.c       |  44 +++-
 net/bluetooth/l2cap_sock.c       |  25 ++-
 9 files changed, 411 insertions(+), 208 deletions(-)

-- 
1.8.3.1

