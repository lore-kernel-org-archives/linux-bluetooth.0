Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Some more SMP fixes
Date: Mon, 11 Aug 2014 15:24:51 +0300
Message-Id: <1407759894-24739-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's some more patches to remove some more SMP-specific code from
l2cap_core.c as well as return the old functionality where garbage SMP
data would cause a call to l2cap_conn_del().

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Use L2CAP resume callback to call smp_distribute_keys
      Bluetooth: Add public l2cap_conn_drop() API to request disconnection
      Bluetooth: Call l2cap_conn_drop() when SMP recv callback fails

 include/net/bluetooth/l2cap.h |   4 +
 net/bluetooth/l2cap_core.c    |  31 ++-
 net/bluetooth/smp.c           | 398 ++++++++++++++++++++------------------
 net/bluetooth/smp.h           |   1 -
 4 files changed, 243 insertions(+), 191 deletions(-)

