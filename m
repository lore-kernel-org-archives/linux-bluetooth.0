Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/7] Bluetooth: Correct debug code
Date: Tue, 10 Jul 2012 15:27:44 +0300
Message-Id: <1341923271-14222-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This set of patches helps to parse debug in Bluetooth:
- Add printing refcount for l2cap_chan and amp_mgr
- Correct CID output %d -> 0x%4.4x for chan move functions
- Remove unneded type conversion by using for example types: %u and %zu
- and some other fixes

Andrei Emeltchenko (7):
  Bluetooth: debug: Print l2cap refcount
  Bluetooth: debug: Print amp_mgr refcnt
  Bluetooth: debug: Add printing num of cmds queued
  Bluetooth: debug: Use standard hex object specifier
  Bluetooth: debug: Correct types specifiers for L2CAP
  Bluetooth: debug: Print CID and PSM in hex format
  Bluetooth: debug: Add debug to l2cap_security_cfm

 include/net/bluetooth/l2cap.h |    6 ++
 net/bluetooth/a2mp.c          |    8 +-
 net/bluetooth/hci_core.c      |    3 +-
 net/bluetooth/hci_event.c     |  170 ++++++++++++++++++++---------------------
 net/bluetooth/l2cap_core.c    |   92 +++++++++++-----------
 5 files changed, 148 insertions(+), 131 deletions(-)

-- 
1.7.9.5

