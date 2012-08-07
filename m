Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/4] Remove unsafe batostr
Date: Tue,  7 Aug 2012 18:05:02 +0300
Message-Id: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since the patch "vsprintf: add %pMR for Bluetooth MAC address" in in linux-next and wireless-testing
remove batostr.

http://git.kernel.org/?p=linux/kernel/git/linville/wireless-testing.git;a=commitdiff;h=76597ff989a1fbaa9b9a1e54007cd759bf257ab7

Andrei Emeltchenko (4):
  Bluetooth: Use %pMR BT addr print spec instead of batostr
  Bluetooth: trivial: Shorten variable scope
  Bluetooth: Use %pMR instead of baswap in seq_show
  Bluetooth: trivial: Use preferred method for NULL check

 include/net/bluetooth/bluetooth.h |    1 -
 net/bluetooth/af_bluetooth.c      |   20 ++++++++------------
 net/bluetooth/bnep/core.c         |    3 +--
 net/bluetooth/cmtp/core.c         |    2 +-
 net/bluetooth/hci_conn.c          |    6 +++---
 net/bluetooth/hci_core.c          |   22 +++++++++++-----------
 net/bluetooth/hci_event.c         |   15 +++++++--------
 net/bluetooth/hci_sysfs.c         |   10 +++++-----
 net/bluetooth/hidp/core.c         |    8 ++++++--
 net/bluetooth/l2cap_core.c        |   11 +++++------
 net/bluetooth/lib.c               |   14 --------------
 net/bluetooth/rfcomm/core.c       |   15 +++++++--------
 net/bluetooth/rfcomm/sock.c       |    9 ++++-----
 net/bluetooth/rfcomm/tty.c        |    6 +++---
 net/bluetooth/sco.c               |   12 ++++++------
 15 files changed, 67 insertions(+), 87 deletions(-)

-- 
1.7.9.5

