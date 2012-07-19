Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Bluetooth patches
Date: Thu, 19 Jul 2012 17:03:39 +0300
Message-Id: <1342706627-19129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of patches from my RFCs which are ready to be applied (IMO :)

Andrei Emeltchenko (8):
  Bluetooth: mgmt: Managing only BR/EDR HCI controllers
  Bluetooth: debug: Fix printing A2MP cmd code format
  Bluetooth: debug: Fix printing refcnt for hci_conn
  Bluetooth: smp: Fix possible NULL dereference
  Bluetooth: trivial: Fix mixing spaces and tabs in smp
  Bluetooth: Define AMP controller statuses
  Bluetooth: Do not shadow hdr variable
  Bluetooth: Fix processing A2MP chan in security_cfm

 include/net/bluetooth/hci.h      |    9 +++++++++
 include/net/bluetooth/hci_core.h |    8 +++-----
 include/net/bluetooth/smp.h      |    8 ++++----
 net/bluetooth/a2mp.c             |   14 +++++++++-----
 net/bluetooth/hci_core.c         |    6 ++++--
 net/bluetooth/l2cap_core.c       |    5 +++++
 net/bluetooth/mgmt.c             |   20 ++++++++++++++++++--
 net/bluetooth/smp.c              |    5 ++++-
 8 files changed, 56 insertions(+), 19 deletions(-)

-- 
1.7.9.5

