Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/6] Endian bugfixes
Date: Mon, 12 Mar 2012 12:13:05 +0200
Message-Id: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Those patches fix bugs and typos related to endian
conversion reported by sparse.

Changes:
	* v2: Use __constant version with constants.

Andrei Emeltchenko (6):
  Bluetooth: Correct ediv in SMP
  Bluetooth: Correct length calc in L2CAP conf rsp
  Bluetooth: Correct CID endian notation
  Bluetooth: Convert error codes to le16
  Bluetooth: trivial: Fix endian conversion mode
  Bluetooth: mgmt: Add missing endian conversion

 include/net/bluetooth/smp.h |    2 +-
 net/bluetooth/l2cap_core.c  |   18 +++++++++---------
 net/bluetooth/mgmt.c        |   11 ++++++++---
 net/bluetooth/smp.c         |    2 +-
 4 files changed, 19 insertions(+), 14 deletions(-)

-- 
1.7.9

