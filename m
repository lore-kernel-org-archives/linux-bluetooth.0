Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFCv2 0/4] Advertising reports cache
Date: Thu, 17 Feb 2011 10:39:52 -0300
Message-Id: <4d5d2583.8f7edc0a.5af6.27d7@mx.google.com>
In-Reply-To: <n>
References: <n>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

The following patches implement a list for advertising report events from LE
devices in order to store the bdaddr and bdaddr type.
Next steps include remove all advertising reports cache from userspace and
implement a mechanism to sync kernel advertising cache and userspace adv cache.

Patches are rebased using Vinicius SMP patches, repo:
git://git.infradead.org/users/vcgomes/linux-2.6.git for-next

Anderson Briglia (1):
  Bluetooth: Implement advertising report meta event

Andre Guedes (2):
  Bluetooth: LE advertising info caching
  Bluetooth: check adv_entries in hci_connect() for LE devices

Ville Tervo (1):
  Bluetooth: Use ERR_PTR to return error from hci_connect

 include/net/bluetooth/hci.h      |   18 +++++++++
 include/net/bluetooth/hci_core.h |   17 +++++++++
 net/bluetooth/hci_conn.c         |   24 ++++++++----
 net/bluetooth/hci_core.c         |   75 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   21 +++++++++++
 net/bluetooth/l2cap_core.c       |   10 ++---
 net/bluetooth/sco.c              |    6 ++--
 7 files changed, 154 insertions(+), 17 deletions(-)

